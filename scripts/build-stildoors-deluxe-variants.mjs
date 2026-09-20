import { mkdirSync, writeFileSync } from 'node:fs';

const baseUrl = 'https://stildoors.com.ua';
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const outputSql = 'supabase/generated/stildoors-deluxe-official-variants.sql';
const outputJson = 'supabase/generated/stildoors-deluxe-official-variants.json';
const sleep = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
async function fetchWithRetry(url) {
  let lastError;
  for (let attempt = 0; attempt < 3; attempt += 1) {
    try { return await fetch(url, { headers }); }
    catch (error) { lastError = error; await sleep(1200 * (attempt + 1)); }
  }
  throw lastError;
}
const sql = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const jsonSql = (value) => `'${JSON.stringify(value).replaceAll("'", "''")}'::jsonb`;
const models = [['antalya', 'stildoors-deluxe-antalya-official'], ['barcelona', 'stildoors-deluxe-barcelona-official'], ['sofia', 'stildoors-deluxe-sofia-official'], ['tokyo', 'stildoors-deluxe-tokyo-official']];
const cleanText = (value) => value.replace(/<[^>]*>/g, ' ').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/\s+/g, ' ').trim();
function specsFrom(html) { const specs = {}; for (const row of html.matchAll(/<tr>\s*<td class=['"]specification-title['"]>([\s\S]*?)<\/td>\s*<td class=['"]specification-description['"]>([\s\S]*?)<\/td>\s*<\/tr>/gi)) { const label = cleanText(row[1]); const value = cleanText(row[2]); if (label && value) specs[label] = value; } return specs; }
const variants = [];
for (const [modelSlug, productSlug] of models) {
  const listUrl = `${baseUrl}/dveri/deluxe/${modelSlug}/`; const response = await fetchWithRetry(listUrl); const html = await response.text();
  if (!response.ok) throw new Error(`${modelSlug}: ${response.status}`);
  const urls = [...new Set([...html.matchAll(/href=["'](https:\/\/stildoors\.com\.ua\/dveri\/deluxe\/[^"'#?]+)["']/gi)].map((match) => match[1].replace(/\/$/, '')).filter((url) => url.startsWith(`${baseUrl}/dveri/deluxe/${modelSlug}/`)))];
  if (!urls.length) throw new Error(`${modelSlug}: варіанти не знайдені`);
  for (const sourceUrl of urls) {
    const card = await fetchWithRetry(sourceUrl); const cardHtml = await card.text(); if (!card.ok) throw new Error(`${sourceUrl}: ${card.status}`);
    const relativeImage = cardHtml.match(/<meta\s+property=['"]og:image['"]\s+content=['"]([^'"]+)['"]/i)?.[1]; const specs = specsFrom(cardHtml); const color = specs['Колір']; const glass = specs['Скло'];
    if (!color || !relativeImage) throw new Error(`${sourceUrl}: бракує кольору або фото`);
    const selections = { color }; if (glass && !/^без скла$/iu.test(glass)) selections.glass = glass;
    variants.push({ productSlug, modelSlug, sourceUrl, imagePath: new URL(relativeImage, baseUrl).href, color, glass: glass || null, selections }); await sleep(500);
  }
  await sleep(350);
}
const uniqueBy = (items, key) => [...new Map(items.map((item) => [key(item), item])).values()];
const optionRows = [];
for (const [, productSlug] of models) {
  const own = variants.filter((variant) => variant.productSlug === productSlug);
  for (const [index, option] of uniqueBy(own, (variant) => variant.color).entries()) optionRows.push(`(${[sql(productSlug), sql('color'), sql('Колір полотна'), sql(option.color), 'null', sql(option.imagePath), sql(index + 1), sql(true)].join(', ')})`);
  for (const [index, option] of uniqueBy(own.filter((variant) => variant.glass && !/^без скла$/iu.test(variant.glass)), (variant) => variant.glass).entries()) optionRows.push(`(${[sql(productSlug), sql('glass'), sql('Варіант скла'), sql(option.glass), 'null', sql(option.imagePath), sql(index + 1), sql(true)].join(', ')})`);
}
const rows = variants.map((variant, index) => `(${[sql(variant.productSlug), jsonSql(variant.selections), sql(variant.imagePath), sql(index + 1), sql(true)].join(', ')})`);
const lines = ['-- StilDoors DELUXE: точні фото кожного офіційного варіанта.', 'begin;', 'insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order, is_active) values', `${optionRows.join(',\n')}\non conflict (product_slug, option_group, label) do update set group_label=excluded.group_label, image_path=excluded.image_path, sort_order=excluded.sort_order, is_active=true;`, 'insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active) values', `${rows.join(',\n')}\non conflict (product_slug, selections) do update set image_path=excluded.image_path, sort_order=excluded.sort_order, is_active=true;`, 'commit;', "select count(*) as точних_фото_варіантів from public.product_variants where product_slug like 'stildoors-deluxe-%-official' and is_active;"];
mkdirSync('supabase/generated', { recursive: true }); writeFileSync(outputSql, `${lines.join('\n')}\n`); writeFileSync(outputJson, `${JSON.stringify({ variants, count: variants.length }, null, 2)}\n`); console.log(`Створено ${outputSql}: ${variants.length} точних варіантів.`);
