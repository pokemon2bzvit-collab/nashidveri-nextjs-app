import { mkdirSync, writeFileSync } from 'node:fs';

const baseUrl = 'https://stildoors.com.ua';
const productSlug = 'stildoors-classic-carolina-official';
const catalogUrl = `${baseUrl}/dveri/classic/carolina/`;
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const quote = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const json = (value) => `'${JSON.stringify(value).replaceAll("'", "''")}'::jsonb`;
const clean = (value) => value.replace(/<[^>]*>/g, ' ').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/\s+/g, ' ').trim();
const groups = { 'Колір': ['color', 'Колір полотна'], 'Скло': ['glass', 'Варіант скла'], 'Молдинг': ['finish', 'Варіант виконання'], 'Кромка': ['edge', 'Кромка'] };

function specifications(html) {
  const result = {};
  for (const match of html.matchAll(/<tr>\s*<td class=['"]specification-title['"]>([\s\S]*?)<\/td>\s*<td class=['"]specification-description['"]>([\s\S]*?)<\/td>\s*<\/tr>/gi)) {
    const label = clean(match[1]); const value = clean(match[2]);
    if (label && value) result[label] = value;
  }
  return result;
}

const catalog = await fetch(catalogUrl, { headers });
const catalogHtml = await catalog.text();
if (!catalog.ok) throw new Error(`Classic Carolina: ${catalog.status}`);
const urls = [...new Set([...catalogHtml.matchAll(/href=["'](https:\/\/stildoors\.com\.ua\/dveri\/classic\/carolina\/[^"'#?]+)["']/gi)].map((match) => match[1].replace(/\/$/, '')))];
if (!urls.length) throw new Error('Classic Carolina: варіанти не знайдені');
const found = [];
for (const sourceUrl of urls) {
  const response = await fetch(sourceUrl, { headers }); const html = await response.text();
  if (!response.ok) throw new Error(`${sourceUrl}: ${response.status}`);
  const image = html.match(/<meta\s+property=['"]og:image['"]\s+content=['"]([^'"]+)['"]/i)?.[1];
  const specs = specifications(html); const selections = {};
  for (const [label, [group]] of Object.entries(groups)) if (specs[label] && !/^без скла$/iu.test(specs[label])) selections[group] = specs[label];
  if (!image || !selections.color) throw new Error(`${sourceUrl}: бракує кольору або фото`);
  found.push({ selections, imagePath: new URL(image, baseUrl).href }); await sleep(250);
}
const variants = [...new Map(found.map((item) => [JSON.stringify(item.selections), item])).values()];
const options = [];
for (const group of Object.values(groups).map(([key]) => key)) {
  const label = Object.values(groups).find(([key]) => key === group)?.[1] ?? group;
  [...new Map(variants.filter((item) => item.selections[group]).map((item) => [item.selections[group], item])).values()].forEach((item, index) => options.push([productSlug, group, label, item.selections[group], null, item.imagePath, index + 1, true]));
}
const rows = (items, variant = false) => items.map((item) => `(${item.map((value, index) => variant && index === 1 ? json(value) : value === null ? 'null' : quote(value)).join(', ')})`).join(',\n');
const sql = ['-- StilDoors Classic Carolina: точні фото офіційних варіантів.', 'begin;', 'insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order,is_active) values', `${rows(options)}\non conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;`, 'insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values', `${rows(variants.map((item,index)=>[productSlug,item.selections,item.imagePath,index+1,true]), true)}\non conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;`, 'commit;', `select count(*) as точних_фото_варіантів from public.product_variants where product_slug='${productSlug}' and is_active;`].join('\n');
mkdirSync('supabase/generated', { recursive: true }); writeFileSync('supabase/generated/stildoors-classic-official-variants.sql', `${sql}\n`);
console.log(`Створено supabase/generated/stildoors-classic-official-variants.sql: ${variants.length} точних варіантів.`);
