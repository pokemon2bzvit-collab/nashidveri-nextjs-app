import { mkdirSync, writeFileSync } from 'node:fs';

const baseUrl = 'https://stildoors.com.ua';
const outputSql = 'supabase/generated/stildoors-presto-official-drafts.sql';
const outputJson = 'supabase/generated/stildoors-presto-official-drafts.json';
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const sleep = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
const sql = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const nullableSql = (value) => value == null ? 'null' : sql(value);

const officialModels = [
  ['Aura', 'aura', 'bila-emal-ral-9003'],
  ['Avanti', 'avanti', 'bila-emal-ral-9003'],
  ['Diamond', 'diamond', 'bila-emal-ral-9003'],
  ['Elegante', 'elegante', 'bila-emal-ral-9003'],
  ['Fargo', 'fargo', 'bila-emal-ral-9003'],
  ['Grazia', 'grazia', 'bila-emal-ral-9003/bez-skla'],
  ['Grazia Glass', 'grazia-glass', 'bila-emal-ral-9003/sklo-satin'],
  ['Karyon', 'karyon', 'ral-7047-svitlo-siriy'],
  ['Palladio', 'palladio', 'bila-emal-ral-9003'],
  ['Toledo', 'toledo', 'bila-emal-ral-9003'],
  ['Wilton', 'wilton', 'bila-emal-ral-9003/sklo-chorne'],
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

const translations = new Map([
  ['Розміри', 'Розміри полотна'],
  ['Товщина полотна', 'Товщина полотна'],
  ['Доступні кольори', 'Декори'],
]);

const fetchedModels = [];
for (const [name, modelSlug, variantPath] of officialModels) {
  const sourceUrl = `${baseUrl}/dveri/presto/${modelSlug}/${variantPath}/`;
  const response = await fetch(sourceUrl, { headers });
  const html = await response.text();
  if (!response.ok) throw new Error(`${name}: офіційна картка повернула ${response.status}`);

  const imageMatch = html.match(/<meta\s+property=['"]og:image['"]\s+content=['"]([^'"]+)['"]/i);
  const imagePath = imageMatch?.[1] ? new URL(imageMatch[1], baseUrl).href : null;
  if (!imagePath) throw new Error(`${name}: не знайдено головне фото`);

  const specs = parseSpecs(html);
  const selectedSpecs = Object.entries(specs)
    .filter(([label]) => translations.has(label))
    .map(([label, value], index) => ({ label: translations.get(label), value, sortOrder: 100 + index * 10 }));
  const colors = [...new Set(specs['Доступні кольори']?.split(',').map((color) => color.trim()).filter(Boolean) ?? [])];
  const dimensions = specs['Розміри'];
  const thickness = specs['Товщина полотна'];
  const description = `StilDoors ${name} — фарбовані міжкімнатні двері колекції Presto. ${dimensions ? `Доступні стандартні розміри: ${dimensions}. ` : ''}${thickness ? `Товщина полотна ${thickness}. ` : ''}Для моделі передбачені заводські декори; актуальну комплектацію й ціну уточнюйте у менеджера.`;

  fetchedModels.push({
    slug: `stildoors-presto-${modelSlug}-official`, name: `StilDoors ${name}`, modelSlug, sourceUrl,
    imagePath, specs: selectedSpecs, colors, description,
  });
  await sleep(350);
}

const productRows = fetchedModels.map((model, index) => `(${[
  model.slug, 'interior', 'StilDoors', 'Presto', model.name, 'Міжкімнатні', 'Фарбовані двері', 'Варіанти заводських декорів', 'Ціна за запитом', model.description,
  JSON.stringify(['Фабрика StilDoors', 'Колекція Presto', 'Офіційна картка виробника']), model.imagePath, 9800 + index, false,
].map(sql).join(', ')})`);

const specRows = fetchedModels.flatMap((model) => model.specs.map((spec) => `(${[
  model.slug, spec.label, spec.value, spec.sortOrder, true,
].map(sql).join(', ')})`));

const mediaRows = fetchedModels.map((model) => `(${[
  model.slug, 'main', 'Головне фото', model.imagePath, 0, true,
].map(sql).join(', ')})`);

const optionRows = fetchedModels.flatMap((model) => model.colors.map((color, index) => `(${[
  sql(model.slug), sql('color'), sql('Колір полотна'), sql(color), nullableSql(null), nullableSql(null), sql(index + 1), sql(true),
].join(', ')})`));

const sourceRows = fetchedModels.map((model) => `(${[
  model.slug, 'StilDoors', model.sourceUrl, model.name, 'verified', 'now()', 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.',
].map((value, index) => index === 5 ? value : sql(value)).join(', ')})`);

const lines = [
  '-- StilDoors Presto: 11 офіційних моделей як приховані чернетки.',
  '-- Старі картки ще не змінюються. Після перевірки запускається окремий файл заміни.',
  'begin;',
  "insert into public.catalog_brands (name, description, is_active, sort_order) values ('StilDoors', 'Міжкімнатні двері StilDoors з офіційного каталогу виробника.', true, 70) on conflict (name) do update set description=excluded.description, is_active=true, updated_at=now();",
  "insert into public.catalog_collections (brand_id, name, category, description, is_active, sort_order) select id, 'Presto', 'interior', 'Фарбовані міжкімнатні двері StilDoors колекції Presto.', true, 70 from public.catalog_brands where name='StilDoors' on conflict (brand_id, name, category) do update set description=excluded.description, is_active=true, updated_at=now();",
  'insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values',
  `${productRows.join(',\n')}\non conflict (slug) do update set name=excluded.name, material=excluded.material, style=excluded.style, color=excluded.color, description=excluded.description, features=excluded.features, image_path=excluded.image_path, sort_order=excluded.sort_order, is_available=false, updated_at=now();`,
  'insert into public.product_specs (product_slug, label, value, sort_order, is_active) values',
  `${specRows.join(',\n')}\non conflict (product_slug, label) do update set value=excluded.value, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values',
  `${mediaRows.join(',\n')}\non conflict (product_slug, kind, image_path) do update set label=excluded.label, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order, is_active) values',
  `${optionRows.join(',\n')}\non conflict (product_slug, option_group, label) do update set group_label=excluded.group_label, sort_order=excluded.sort_order, is_active=true;`,
  'insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values',
  `${sourceRows.join(',\n')}\non conflict (product_slug, source_url) do update set source_product_name=excluded.source_product_name, verification_status='verified', verified_at=now(), notes=excluded.notes;`,
  'commit;',
  "select count(*) as офіційних_чернеток from public.products where brand='StilDoors' and collection='Presto' and slug like 'stildoors-presto-%-official' and not is_available;",
];

mkdirSync('supabase/generated', { recursive: true });
writeFileSync(outputSql, `${lines.join('\n')}\n`);
writeFileSync(outputJson, `${JSON.stringify(fetchedModels, null, 2)}\n`);
console.log(`Створено ${outputSql}: ${fetchedModels.length} прихованих моделей Presto.`);
