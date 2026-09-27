import { mkdirSync, writeFileSync } from 'node:fs';

const baseUrl = 'https://stildoors.com.ua';
const outputSql = 'supabase/generated/stildoors-presto-official-variants.sql';
const outputJson = 'supabase/generated/stildoors-presto-official-variants.json';
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const sleep = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
const sql = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const jsonSql = (value) => `'${JSON.stringify(value).replaceAll("'", "''")}'::jsonb`;

const models = [
  ['aura', 'stildoors-presto-aura-official'],
  ['avanti', 'stildoors-presto-avanti-official'],
  ['diamond', 'stildoors-presto-diamond-official'],
  ['elegante', 'stildoors-presto-elegante-official'],
  ['fargo', 'stildoors-presto-fargo-official'],
  ['grazia', 'stildoors-presto-grazia-official'],
  ['grazia-glass', 'stildoors-presto-grazia-glass-official'],
  ['karyon', 'stildoors-presto-karyon-official'],
  ['palladio', 'stildoors-presto-palladio-official'],
  ['toledo', 'stildoors-presto-toledo-official'],
  ['wilton', 'stildoors-presto-wilton-official'],
];

const cleanText = (value) => value.replace(/<[^>]*>/g, ' ').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/\s+/g, ' ').trim();
function specsFrom(html) {
  const specs = {};
  for (const row of html.matchAll(/<tr>\s*<td class=['"]specification-title['"]>([\s\S]*?)<\/td>\s*<td class=['"]specification-description['"]>([\s\S]*?)<\/td>\s*<\/tr>/gi)) {
    const label = cleanText(row[1]);
    const value = cleanText(row[2]);
    if (label && value) specs[label] = value;
  }
  return specs;
}

const variants = [];
for (const [modelSlug, productSlug] of models) {
  const listUrl = `${baseUrl}/dveri/presto/${modelSlug}/`;
  const listResponse = await fetch(listUrl, { headers });
  const listHtml = await listResponse.text();
  if (!listResponse.ok) throw new Error(`${modelSlug}: список варіантів повернув ${listResponse.status}`);

  const candidateUrls = [...listHtml.matchAll(/href=["'](https:\/\/stildoors\.com\.ua\/dveri\/presto\/[^"'#?]+)["']/gi)]
    .map((match) => match[1].replace(/\/$/, ''))
    .filter((url) => url.startsWith(`${baseUrl}/dveri/presto/${modelSlug}/`));
  const urls = [...new Set(candidateUrls)];
  if (!urls.length) throw new Error(`${modelSlug}: варіанти не знайдені`);

  for (const sourceUrl of urls) {
    const response = await fetch(sourceUrl, { headers });
    const html = await response.text();
    if (!response.ok) throw new Error(`${sourceUrl}: ${response.status}`);
    const imageMatch = html.match(/<meta\s+property=['"]og:image['"]\s+content=['"]([^'"]+)['"]/i);
    const imagePath = imageMatch?.[1] ? new URL(imageMatch[1], baseUrl).href : null;
    const specs = specsFrom(html);
    const color = specs['Колір'];
    const glass = specs['Скло'];
    if (!color || !imagePath) throw new Error(`${sourceUrl}: бракує кольору або фото`);
    const selections = { color };
    if (glass && !/^без скла$/iu.test(glass)) selections.glass = glass;
    variants.push({ productSlug, modelSlug, sourceUrl, imagePath, color, glass: glass || null, selections });
    await sleep(250);
  }
  await sleep(350);
}

const uniqueBy = (items, key) => [...new Map(items.map((item) => [key(item), item])).values()];
const optionRows = [];
for (const [modelSlug, productSlug] of models) {
  const own = variants.filter((variant) => variant.productSlug === productSlug);
  for (const [index, option] of uniqueBy(own, (variant) => variant.color).entries()) {
    optionRows.push(`(${[sql(productSlug), sql('color'), sql('Колір полотна'), sql(option.color), 'null', sql(option.imagePath), sql(index + 1), sql(true)].join(', ')})`);
  }
  const glassVariants = own.filter((variant) => variant.glass && !/^без скла$/iu.test(variant.glass));
  for (const [index, option] of uniqueBy(glassVariants, (variant) => variant.glass).entries()) {
    optionRows.push(`(${[sql(productSlug), sql('glass'), sql('Варіант скла'), sql(option.glass), 'null', sql(option.imagePath), sql(index + 1), sql(true)].join(', ')})`);
  }
}

const variantRows = variants.map((variant, index) => `(${[
  sql(variant.productSlug), jsonSql(variant.selections), sql(variant.imagePath), sql(index + 1), sql(true),
].join(', ')})`);

const lines = [
  '-- StilDoors Presto: точні фото варіантів кольору й скла з офіційного каталогу.',
  '-- Оновлює лише 11 нових офіційних моделей Presto.',
  'begin;',
  'insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order, is_active) values',
  `${optionRows.join(',\n')}\non conflict (product_slug, option_group, label) do update set group_label=excluded.group_label, image_path=excluded.image_path, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active) values',
  `${variantRows.join(',\n')}\non conflict (product_slug, selections) do update set image_path=excluded.image_path, sort_order=excluded.sort_order, is_active=true;`,
  'commit;',
  "select count(*) as точних_фото_варіантів from public.product_variants where product_slug like 'stildoors-presto-%-official' and is_active;",
];

mkdirSync('supabase/generated', { recursive: true });
writeFileSync(outputSql, `${lines.join('\n')}\n`);
writeFileSync(outputJson, `${JSON.stringify({ variants, count: variants.length }, null, 2)}\n`);
console.log(`Створено ${outputSql}: ${variants.length} точних варіантів.`);
