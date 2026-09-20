import { mkdirSync, writeFileSync } from 'node:fs';

const baseUrl = 'https://stildoors.com.ua';
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const models = ['03', '05', '06', '07', '08', '09', '10'];
const outputSql = 'supabase/generated/stildoors-simpli-loft-official-variants.sql';
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const quote = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const json = (value) => `'${JSON.stringify(value).replaceAll("'", "''")}'::jsonb`;
const clean = (value) => value.replace(/<[^>]*>/g, ' ').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/\s+/g, ' ').trim();

function specifications(html) {
  const result = {};
  for (const match of html.matchAll(/<tr>\s*<td class=['"]specification-title['"]>([\s\S]*?)<\/td>\s*<td class=['"]specification-description['"]>([\s\S]*?)<\/td>\s*<\/tr>/gi)) {
    const label = clean(match[1]); const value = clean(match[2]);
    if (label && value) result[label] = value;
  }
  return result;
}

const variants = [];
for (const number of models) {
  const model = `simpli-loft-${number}`;
  const catalogUrl = `${baseUrl}/dveri/simpli-loft/${model}/`;
  const catalog = await fetch(catalogUrl, { headers });
  const catalogHtml = await catalog.text();
  if (!catalog.ok) throw new Error(`${model}: ${catalog.status}`);
  const urls = [...new Set([...catalogHtml.matchAll(/href=["'](https:\/\/stildoors\.com\.ua\/dveri\/simpli-loft\/[^"'#?]+)["']/gi)].map((match) => match[1].replace(/\/$/, '')).filter((url) => url.startsWith(catalogUrl) && url.split('/').filter(Boolean).length >= 5))];
  if (!urls.length) throw new Error(`${model}: варіанти не знайдені`);
  for (const sourceUrl of urls) {
    const card = await fetch(sourceUrl, { headers });
    const html = await card.text();
    if (!card.ok) throw new Error(`${sourceUrl}: ${card.status}`);
    const image = html.match(/<meta\s+property=['"]og:image['"]\s+content=['"]([^'"]+)['"]/i)?.[1];
    const color = specifications(html)['Колір'];
    if (!image || !color) throw new Error(`${sourceUrl}: бракує кольору або фото`);
    variants.push({ productSlug: `stildoors-simpli-loft-${number}-official`, selections: { color }, imagePath: new URL(image, baseUrl).href });
    await sleep(300);
  }
}

const unique = [...new Map(variants.map((item) => [`${item.productSlug}:${JSON.stringify(item.selections)}`, item])).values()];
const options = [];
for (const number of models) {
  const productSlug = `stildoors-simpli-loft-${number}-official`;
  const own = unique.filter((item) => item.productSlug === productSlug);
  [...new Map(own.map((item) => [item.selections.color, item])).values()].forEach((item, index) => options.push([productSlug, 'color', 'Колір полотна', item.selections.color, null, item.imagePath, index + 1, true]));
}
const rows = unique.map((item, index) => [item.productSlug, json(item.selections), item.imagePath, index + 1, true]);
const asRows = (rows) => rows.map((row) => `(${row.map((value) => typeof value === 'string' && value.endsWith('::jsonb') ? value : value === null ? 'null' : quote(value)).join(', ')})`).join(',\n');
const sql = ['-- StilDoors Simpli Loft: точні фото офіційних варіантів.', 'begin;', 'insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order,is_active) values', `${asRows(options)}\non conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;`, 'insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values', `${asRows(rows)}\non conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;`, 'commit;', "select count(*) as точних_фото_варіантів from public.product_variants where product_slug like 'stildoors-simpli-loft-%-official' and is_active;"].join('\n');
mkdirSync('supabase/generated', { recursive: true }); writeFileSync(outputSql, `${sql}\n`);
console.log(`Створено ${outputSql}: ${unique.length} точних варіантів.`);
