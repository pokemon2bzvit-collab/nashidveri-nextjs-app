import { mkdirSync, writeFileSync } from 'node:fs';

const baseUrl = 'https://stildoors.com.ua';
const outputSql = 'supabase/generated/stildoors-stil-official-drafts.sql';
const outputJson = 'supabase/generated/stildoors-stil-official-drafts.json';
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const sleep = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
const sql = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const nullableSql = (value) => value == null ? 'null' : sql(value);

const officialModels = [
  ['Arizona', 'arizona', 'drim-vud/sklo-chorne'],
  ['Cuba', 'cuba', 'biliy-kristal/sklo-satin'],
  ['Florida', 'florida', 'kremove-derevo/sklo-satin'],
  ['Hamlet', 'hamlet', 'biliy-kristal/sklo-satin'],
  ['London', 'london', 'bile-derevo/sklo-satin'],
  ['Mexico', 'mexico', 'bile-derevo/sklo-chorne'],
  ['Slovenia', 'slovenia', 'biliy-kristal/sklo-chorne'],
  ['Tanzania', 'tanzania', 'kremove-derevo/sklo-satin'],
];

const cleanText = (value) => value.replace(/<[^>]*>/g, ' ').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/\s+/g, ' ').trim();
function parseSpecs(html) {
  const specs = {};
  for (const row of html.matchAll(/<tr>\s*<td class=['"]specification-title['"]>([\s\S]*?)<\/td>\s*<td class=['"]specification-description['"]>([\s\S]*?)<\/td>\s*<\/tr>/gi)) {
    const label = cleanText(row[1]);
    const value = cleanText(row[2]);
    if (label && value) specs[label] = value;
  }
  return specs;
}

const translations = new Map([['Розміри', 'Розміри полотна'], ['Товщина полотна', 'Товщина полотна'], ['Доступні кольори', 'Декори']]);
const fetched = [];
for (const [name, modelSlug, variantPath] of officialModels) {
  const sourceUrl = `${baseUrl}/dveri/stil/${modelSlug}/${variantPath}/`;
  const response = await fetch(sourceUrl, { headers });
  const html = await response.text();
  if (!response.ok) throw new Error(`${name}: офіційна картка повернула ${response.status}`);
  const image = html.match(/<meta\s+property=['"]og:image['"]\s+content=['"]([^'"]+)['"]/i)?.[1];
  if (!image) throw new Error(`${name}: не знайдено головне фото`);
  const specs = parseSpecs(html);
  const colors = [...new Set(specs['Доступні кольори']?.split(',').map((item) => item.trim()).filter(Boolean) ?? [])];
  const selectedSpecs = Object.entries(specs).filter(([label]) => translations.has(label)).map(([label, value], index) => ({
    label: translations.get(label),
    value: label === 'Доступні кольори' ? colors.join(', ') : value,
    sortOrder: 100 + index * 10,
  }));
  const dimensions = specs['Розміри'];
  const thickness = specs['Товщина полотна'];
  fetched.push({
    slug: `stildoors-stil-${modelSlug}-official`, name: `StilDoors ${name}`, sourceUrl, imagePath: new URL(image, baseUrl).href, colors, specs: selectedSpecs,
    description: `StilDoors ${name} — міжкімнатні двері колекції Stil. ${dimensions ? `Доступні стандартні розміри: ${dimensions}. ` : ''}${thickness ? `Товщина полотна ${thickness}. ` : ''}Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.`,
  });
  await sleep(300);
}

const products = fetched.map((item, index) => `(${[item.slug, 'interior', 'StilDoors', 'Stil', item.name, 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів і скла', 'Ціна за запитом', item.description, JSON.stringify(['Фабрика StilDoors', 'Колекція Stil', 'Офіційна картка виробника']), item.imagePath, 9850 + index, false].map(sql).join(', ')})`);
const specs = fetched.flatMap((item) => item.specs.map((spec) => `(${[item.slug, spec.label, spec.value, spec.sortOrder, true].map(sql).join(', ')})`));
const media = fetched.map((item) => `(${[item.slug, 'main', 'Головне фото', item.imagePath, 0, true].map(sql).join(', ')})`);
const options = fetched.flatMap((item) => item.colors.map((color, index) => `(${[sql(item.slug), sql('color'), sql('Колір полотна'), sql(color), nullableSql(null), nullableSql(null), sql(index + 1), sql(true)].join(', ')})`));
const sources = fetched.map((item) => `(${[item.slug, 'StilDoors', item.sourceUrl, item.name, 'verified', 'now()', 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.'].map((value, index) => index === 5 ? value : sql(value)).join(', ')})`);

const lines = [
  '-- StilDoors Stil: 8 офіційних моделей як приховані чернетки.',
  '-- Старі картки поки не змінюються. Після перевірки запускається окремий файл заміни.',
  'begin;',
  "insert into public.catalog_collections (brand_id, name, category, description, is_active, sort_order) select id, 'Stil', 'interior', 'Ламіновані міжкімнатні двері StilDoors колекції Stil.', true, 71 from public.catalog_brands where name='StilDoors' on conflict (brand_id, name, category) do update set description=excluded.description, is_active=true, updated_at=now();",
  'insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values', `${products.join(',\n')}\non conflict (slug) do update set name=excluded.name, material=excluded.material, style=excluded.style, color=excluded.color, description=excluded.description, features=excluded.features, image_path=excluded.image_path, sort_order=excluded.sort_order, is_available=false, updated_at=now();`,
  'insert into public.product_specs (product_slug, label, value, sort_order, is_active) values', `${specs.join(',\n')}\non conflict (product_slug, label) do update set value=excluded.value, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values', `${media.join(',\n')}\non conflict (product_slug, kind, image_path) do update set label=excluded.label, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order, is_active) values', `${options.join(',\n')}\non conflict (product_slug, option_group, label) do update set group_label=excluded.group_label, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values', `${sources.join(',\n')}\non conflict (product_slug, source_url) do update set source_product_name=excluded.source_product_name, verification_status='verified', verified_at=now(), notes=excluded.notes;`,
  'commit;',
  "select count(*) as офіційних_чернеток from public.products where brand='StilDoors' and collection='Stil' and slug like 'stildoors-stil-%-official' and not is_available;",
];
mkdirSync('supabase/generated', { recursive: true });
writeFileSync(outputSql, `${lines.join('\n')}\n`);
writeFileSync(outputJson, `${JSON.stringify(fetched, null, 2)}\n`);
console.log(`Створено ${outputSql}: ${fetched.length} прихованих моделей Stil.`);
