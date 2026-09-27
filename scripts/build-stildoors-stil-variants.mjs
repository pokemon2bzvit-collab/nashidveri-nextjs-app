import { mkdirSync, writeFileSync } from 'node:fs';

const baseUrl = 'https://stildoors.com.ua';
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const outputSql = 'supabase/generated/stildoors-stil-official-variants.sql';
const outputJson = 'supabase/generated/stildoors-stil-official-variants.json';
const sleep = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
const sql = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const jsonSql = (value) => `'${JSON.stringify(value).replaceAll("'", "''")}'::jsonb`;
const models = [
  ['arizona', 'stildoors-stil-arizona-official'], ['cuba', 'stildoors-stil-cuba-official'], ['florida', 'stildoors-stil-florida-official'], ['hamlet', 'stildoors-stil-hamlet-official'],
  ['london', 'stildoors-stil-london-official'], ['mexico', 'stildoors-stil-mexico-official'], ['slovenia', 'stildoors-stil-slovenia-official'], ['tanzania', 'stildoors-stil-tanzania-official'],
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
  const listUrl = `${baseUrl}/dveri/stil/${modelSlug}/`;
  const response = await fetch(listUrl, { headers });
  const html = await response.text();
  if (!response.ok) throw new Error(`${modelSlug}: ${response.status}`);
  const candidateUrls = [...html.matchAll(/href=["'](https:\/\/stildoors\.com\.ua\/dveri\/stil\/[^"'#?]+)["']/gi)]
    .map((match) => match[1].replace(/\/$/, ''))
    .filter((url) => url.startsWith(`${baseUrl}/dveri/stil/${modelSlug}/`));
  const urls = [...new Set(candidateUrls)];
  if (!urls.length) throw new Error(`${modelSlug}: варіанти не знайдені`);
  for (const sourceUrl of urls) {
    const card = await fetch(sourceUrl, { headers });
    const cardHtml = await card.text();
    if (!card.ok) throw new Error(`${sourceUrl}: ${card.status}`);
    const image = cardHtml.match(/<meta\s+property=['"]og:image['"]\s+content=['"]([^'"]+)['"]/i)?.[1];
    const specs = specsFrom(cardHtml);
    const color = specs['Колір'];
    const glass = specs['Скло'];
    if (!color || !image) throw new Error(`${sourceUrl}: бракує кольору або фото`);
    const selections = { color };
    if (glass && !/^без скла$/iu.test(glass)) selections.glass = glass;
    variants.push({ productSlug, modelSlug, sourceUrl, imagePath: new URL(image, baseUrl).href, color, glass: glass || null, selections });
    await sleep(250);
  }
  await sleep(350);
}

const uniqueBy = (items, key) => [...new Map(items.map((item) => [key(item), item])).values()];
const optionRows = [];
for (const [, productSlug] of models) {
  const own = variants.filter((variant) => variant.productSlug === productSlug);
  for (const [index, option] of uniqueBy(own, (variant) => variant.color).entries()) optionRows.push(`(${[sql(productSlug), sql('color'), sql('Колір полотна'), sql(option.color), 'null', sql(option.imagePath), sql(index + 1), sql(true)].join(', ')})`);
  const glassOptions = own.filter((variant) => variant.glass && !/^без скла$/iu.test(variant.glass));
  for (const [index, option] of uniqueBy(glassOptions, (variant) => variant.glass).entries()) optionRows.push(`(${[sql(productSlug), sql('glass'), sql('Варіант скла'), sql(option.glass), 'null', sql(option.imagePath), sql(index + 1), sql(true)].join(', ')})`);
}
const variantRows = variants.map((variant, index) => `(${[sql(variant.productSlug), jsonSql(variant.selections), sql(variant.imagePath), sql(index + 1), sql(true)].join(', ')})`);
const lines = [
  '-- StilDoors Stil: точні фото кожного офіційного варіанта кольору та скла.', 'begin;',
  'insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order, is_active) values', `${optionRows.join(',\n')}\non conflict (product_slug, option_group, label) do update set group_label=excluded.group_label, image_path=excluded.image_path, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active) values', `${variantRows.join(',\n')}\non conflict (product_slug, selections) do update set image_path=excluded.image_path, sort_order=excluded.sort_order, is_active=true;`,
  'commit;', "select count(*) as точних_фото_варіантів from public.product_variants where product_slug like 'stildoors-stil-%-official' and is_active;",
];
mkdirSync('supabase/generated', { recursive: true });
writeFileSync(outputSql, `${lines.join('\n')}\n`);
writeFileSync(outputJson, `${JSON.stringify({ variants, count: variants.length }, null, 2)}\n`);
console.log(`Створено ${outputSql}: ${variants.length} точних варіантів.`);
