import { mkdirSync, writeFileSync } from 'node:fs';

const baseUrl = 'https://stildoors.com.ua';
const outputSql = 'supabase/generated/stildoors-deluxe-official-drafts.sql';
const outputJson = 'supabase/generated/stildoors-deluxe-official-drafts.json';
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const sleep = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
const sql = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const nullableSql = (value) => value == null ? 'null' : sql(value);
const officialModels = [
  ['Antalya', 'antalya', 'dub-popelyastiy/sklo-chorne'],
  ['Barcelona', 'barcelona', 'biliy-mat/sklo-chorne'],
  ['Sofia', 'sofia', 'dub-sriblyastiy/sklo-satin'],
  ['Tokyo', 'tokyo', 'dub-popelyastiy/sklo-chorne'],
];
const cleanText = (value) => value.replace(/<[^>]*>/g, ' ').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/\s+/g, ' ').trim();
function parseSpecs(html) { const specs = {}; for (const row of html.matchAll(/<tr>\s*<td class=['"]specification-title['"]>([\s\S]*?)<\/td>\s*<td class=['"]specification-description['"]>([\s\S]*?)<\/td>\s*<\/tr>/gi)) { const label = cleanText(row[1]); const value = cleanText(row[2]); if (label && value) specs[label] = value; } return specs; }
const labelMap = new Map([['Розміри', 'Розміри полотна'], ['Товщина полотна', 'Товщина полотна'], ['Доступні кольори', 'Декори']]);
const models = [];
for (const [name, modelSlug, path] of officialModels) {
  const sourceUrl = `${baseUrl}/dveri/deluxe/${modelSlug}/${path}/`;
  const response = await fetch(sourceUrl, { headers }); const html = await response.text();
  if (!response.ok) throw new Error(`${name}: ${response.status}`);
  const relativeImage = html.match(/<meta\s+property=['"]og:image['"]\s+content=['"]([^'"]+)['"]/i)?.[1];
  if (!relativeImage) throw new Error(`${name}: не знайдено головне фото`);
  const sourceSpecs = parseSpecs(html);
  const colors = [...new Set(sourceSpecs['Доступні кольори']?.split(',').map((value) => value.trim()).filter(Boolean) ?? [])];
  const specs = Object.entries(sourceSpecs).filter(([label]) => labelMap.has(label)).map(([label, value], index) => ({ label: labelMap.get(label), value: label === 'Доступні кольори' ? colors.join(', ') : value, sortOrder: 100 + index * 10 }));
  const dimensions = sourceSpecs['Розміри']; const thickness = sourceSpecs['Товщина полотна'];
  models.push({ slug: `stildoors-deluxe-${modelSlug}-official`, name: `StilDoors ${name}`, sourceUrl, imagePath: new URL(relativeImage, baseUrl).href, colors, specs, description: `StilDoors ${name} — міжкімнатні двері колекції DELUXE. ${dimensions ? `Доступні стандартні розміри: ${dimensions}. ` : ''}${thickness ? `Товщина полотна ${thickness}. ` : ''}Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.` });
  await sleep(300);
}
const products = models.map((item, index) => `(${[item.slug, 'interior', 'StilDoors', 'DELUXE', item.name, 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів і скла', 'Ціна за запитом', item.description, JSON.stringify(['Фабрика StilDoors', 'Колекція DELUXE', 'Офіційна картка виробника']), item.imagePath, 9900 + index, false].map(sql).join(', ')})`);
const specs = models.flatMap((item) => item.specs.map((spec) => `(${[item.slug, spec.label, spec.value, spec.sortOrder, true].map(sql).join(', ')})`));
const media = models.map((item) => `(${[item.slug, 'main', 'Головне фото', item.imagePath, 0, true].map(sql).join(', ')})`);
const options = models.flatMap((item) => item.colors.map((color, index) => `(${[sql(item.slug), sql('color'), sql('Колір полотна'), sql(color), nullableSql(null), nullableSql(null), sql(index + 1), sql(true)].join(', ')})`));
const sources = models.map((item) => `(${[item.slug, 'StilDoors', item.sourceUrl, item.name, 'verified', 'now()', 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.'].map((value, index) => index === 5 ? value : sql(value)).join(', ')})`);
const lines = [
  '-- StilDoors DELUXE: 4 офіційні моделі як приховані чернетки.', 'begin;',
  "insert into public.catalog_collections (brand_id, name, category, description, is_active, sort_order) select id, 'DELUXE', 'interior', 'Міжкімнатні двері StilDoors колекції DELUXE.', true, 72 from public.catalog_brands where name='StilDoors' on conflict (brand_id, name, category) do update set description=excluded.description, is_active=true, updated_at=now();",
  'insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values', `${products.join(',\n')}\non conflict (slug) do update set name=excluded.name, material=excluded.material, style=excluded.style, color=excluded.color, description=excluded.description, features=excluded.features, image_path=excluded.image_path, sort_order=excluded.sort_order, is_available=false, updated_at=now();`,
  'insert into public.product_specs (product_slug, label, value, sort_order, is_active) values', `${specs.join(',\n')}\non conflict (product_slug, label) do update set value=excluded.value, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values', `${media.join(',\n')}\non conflict (product_slug, kind, image_path) do update set label=excluded.label, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order, is_active) values', `${options.join(',\n')}\non conflict (product_slug, option_group, label) do update set group_label=excluded.group_label, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values', `${sources.join(',\n')}\non conflict (product_slug, source_url) do update set source_product_name=excluded.source_product_name, verification_status='verified', verified_at=now(), notes=excluded.notes;`,
  'commit;', "select count(*) as офіційних_чернеток from public.products where brand='StilDoors' and collection='DELUXE' and slug like 'stildoors-deluxe-%-official' and not is_available;",
];
mkdirSync('supabase/generated', { recursive: true }); writeFileSync(outputSql, `${lines.join('\n')}\n`); writeFileSync(outputJson, `${JSON.stringify(models, null, 2)}\n`); console.log(`Створено ${outputSql}: ${models.length} приховані моделі DELUXE.`);
