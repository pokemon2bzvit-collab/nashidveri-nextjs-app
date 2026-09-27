import { mkdirSync, writeFileSync } from 'node:fs';

const baseUrl = 'https://stildoors.com.ua';
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const models = ['03', '05', '06', '07', '08', '09', '10'];
const outputSql = 'supabase/generated/stildoors-simpli-loft-official-drafts.sql';
const quote = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const clean = (value) => value.replace(/<[^>]*>/g, ' ').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/\s+/g, ' ').trim();

function specifications(html) {
  const result = {};
  for (const match of html.matchAll(/<tr>\s*<td class=['"]specification-title['"]>([\s\S]*?)<\/td>\s*<td class=['"]specification-description['"]>([\s\S]*?)<\/td>\s*<\/tr>/gi)) {
    const label = clean(match[1]);
    const value = clean(match[2]);
    if (label && value) result[label] = value;
  }
  return result;
}

const imported = [];
for (const number of models) {
  const model = `simpli-loft-${number}`;
  const sourceUrl = `${baseUrl}/dveri/simpli-loft/${model}/biliy-supermat/`;
  const response = await fetch(sourceUrl, { headers });
  const html = await response.text();
  if (!response.ok) throw new Error(`${model}: ${response.status}`);
  const image = html.match(/<meta\s+property=['"]og:image['"]\s+content=['"]([^'"]+)['"]/i)?.[1];
  if (!image) throw new Error(`${model}: не знайдено головне фото`);
  const specs = specifications(html);
  const colors = [...new Set((specs['Доступні кольори'] ?? '').split(',').map(clean).filter(Boolean))];
  const slug = `stildoors-simpli-loft-${number}-official`;
  const name = `StilDoors Simpli Loft ${number}`;
  const dimensions = specs['Розміри'];
  const thickness = specs['Товщина полотна'];
  const description = `${name} — міжкімнатні двері колекції Simpli Loft. ${dimensions ? `Доступні стандартні розміри: ${dimensions}. ` : ''}${thickness ? `Товщина полотна ${thickness}. ` : ''}Для моделі передбачені заводські декори; актуальну комплектацію й ціну уточнюйте у менеджера.`;
  imported.push({ slug, name, sourceUrl, image: new URL(image, baseUrl).href, colors, dimensions, thickness, description });
}

const products = imported.map((item, index) => [item.slug, 'interior', 'StilDoors', 'Simpli Loft', item.name, 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів', 'Ціна за запитом', item.description, JSON.stringify(['Фабрика StilDoors', 'Колекція Simpli Loft', 'Офіційна картка виробника']), item.image, 10800 + index, false].map(quote).join(', '));
const specs = imported.flatMap((item) => [['Розміри полотна', item.dimensions], ['Товщина полотна', item.thickness], ['Декори', item.colors.join(', ')]].filter(([, value]) => value).map(([label, value], index) => [item.slug, label, value, 100 + index * 10, true].map(quote).join(', ')));
const media = imported.map((item) => [item.slug, 'main', 'Головне фото', item.image, 0, true].map(quote).join(', '));
const options = imported.flatMap((item) => item.colors.map((color, index) => [item.slug, 'color', 'Колір полотна', color, null, null, index + 1, true].map((value) => value === null ? 'null' : quote(value)).join(', ')));
const sources = imported.map((item) => [item.slug, 'StilDoors', item.sourceUrl, item.name, 'verified', 'now()', 'Офіційна картка StilDoors: назва, головне фото, характеристики та доступні декори.'].map((value, index) => index === 5 ? value : quote(value)).join(', '));

const sql = [
  '-- StilDoors Simpli Loft: 7 офіційних моделей як приховані чернетки.', 'begin;',
  "insert into public.catalog_collections (brand_id,name,category,description,is_active,sort_order) select id,'Simpli Loft','interior','Міжкімнатні двері StilDoors колекції Simpli Loft.',true,75 from public.catalog_brands where name='StilDoors' on conflict (brand_id,name,category) do update set description=excluded.description,is_active=true,updated_at=now();",
  'insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values', `(${products.join('),\n(')})\non conflict (slug) do update set name=excluded.name,description=excluded.description,image_path=excluded.image_path,is_available=false,updated_at=now();`,
  'insert into public.product_specs (product_slug,label,value,sort_order,is_active) values', `(${specs.join('),\n(')})\non conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;`,
  'insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values', `(${media.join('),\n(')})\non conflict (product_slug,kind,image_path) do update set label=excluded.label,sort_order=excluded.sort_order,is_active=true;`,
  'insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order,is_active) values', `(${options.join('),\n(')})\non conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;`,
  'insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values', `(${sources.join('),\n(')})\non conflict (product_slug,source_url) do update set verification_status='verified',verified_at=now(),notes=excluded.notes;`,
  'commit;', "select count(*) as офіційних_чернеток from public.products where brand='StilDoors' and collection='Simpli Loft' and slug like 'stildoors-simpli-loft-%-official' and not is_available;"
].join('\n');

mkdirSync('supabase/generated', { recursive: true });
writeFileSync(outputSql, `${sql}\n`);
console.log(`Створено ${outputSql}: ${imported.length} прихованих моделей Simpli Loft.`);
