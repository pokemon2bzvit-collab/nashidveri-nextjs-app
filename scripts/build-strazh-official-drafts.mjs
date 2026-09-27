import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const batch = Number(process.argv.find((value) => value.startsWith("--batch="))?.split("=")[1] || "1");
const size = Number(process.argv.find((value) => value.startsWith("--size="))?.split("=")[1] || "25");
const outputDir = join(process.cwd(), "supabase", "generated");
const index = JSON.parse(await readFile(join(outputDir, "strazh-official-index.json"), "utf8"));

function clean(value = "") {
  return value.replace(/<[^>]+>/gu, " ").replace(/&nbsp;/giu, " ").replace(/&amp;/giu, "&").replace(/\s+/gu, " ").trim();
}
function sql(value = "") { return `'${String(value).replaceAll("'", "''")}'`; }
function hash(value) {
  let output = 2166136261;
  for (const character of value) output = Math.imul(output ^ character.charCodeAt(0), 16777619);
  return (output >>> 0).toString(36);
}
function modelKey(value = "") {
  return value.toLocaleLowerCase("uk-UA").replace(/[«»"'()_.,/\\-]+/gu, " ")
    .replace(/\b(?:страж|straj|proof|roof|street|вхідні|двері|door)\b/giu, " ")
    .split(/\s+/u).filter((token) => token && !/^\d+$/u.test(token)).join(" ");
}
function primaryImage(html, url) {
  const found = [...html.matchAll(/(?:src|href)=["']([^"']*assets\/product\/0x500\/[^"']+)["']/giu)]
    .map((match) => new URL(match[1].replace(/&amp;/gu, "&"), url).href);
  return found[0] || null;
}
function details(html) {
  const text = clean(html.replace(/<script[\s\S]*?<\/script>/giu, " ").replace(/<style[\s\S]*?<\/style>/giu, " "));
  const rawDimensions = text.match(/Стандартний розмір дверного блоку\s*:\s*([^.!]{4,140})/iu)?.[1]
    ?.split(/Рекомендовано|Максимально|Наличие|В наличии|Вартість|Колекці|Товщина полотна/iu)[0]
    ?.trim();
  const dimensions = rawDimensions && /^[\dхx×\s/–-]+$/iu.test(rawDimensions) ? rawDimensions : null;
  const thickness = text.match(/Товщина полотна\s*-?\s*(\d+(?:[,.]\d+)?\s*мм)/iu)?.[1]?.replace(/\s+/gu, " ");
  // The site-wide navigation repeats both "квартира" and "вулиця" on every
  // card, so it cannot safely determine a model's purpose. Keep new records
  // in a hidden review collection until the exact series is confirmed.
  return { dimensions, thickness, collection: "Офіційний каталог — перевірити" };
}

const grouped = new Map();
for (const card of index.official) {
  const key = modelKey(card.title);
  if (!grouped.has(key)) grouped.set(key, card);
}
const catalog = [...grouped.values()].sort((a, b) => a.title.localeCompare(b.title, "uk"));
const selected = catalog.slice((batch - 1) * size, batch * size);
if (!selected.length) throw new Error(`Пакет ${batch} порожній. Усього унікальних моделей: ${catalog.length}.`);

const records = [];
for (let indexInBatch = 0; indexInBatch < selected.length; indexInBatch += 1) {
  const item = selected[indexInBatch];
  try {
    const response = await fetch(item.url, { headers: { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalog/1.0)" }, signal: AbortSignal.timeout(25_000) });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const html = await response.text();
    const name = clean(html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/iu)?.[1] || item.title);
    const image = primaryImage(html, item.url);
    if (!name || !image) throw new Error("не знайдено назву або головне фото");
    records.push({ url: item.url, name, image, ...details(html) });
    console.log(`[${indexInBatch + 1}/${selected.length}] ${name}`);
  } catch (error) {
    console.log(`[${indexInBatch + 1}/${selected.length}] пропущено ${item.title}: ${error instanceof Error ? error.message : "помилка"}`);
  }
  await new Promise((resolve) => setTimeout(resolve, 350));
}

const lines = [
  `-- Страж: офіційний каталог, пакет ${batch}.`,
  "-- Усі товари є прихованими чернетками. Існуючі товари Страж не змінюються.",
  "begin;",
  "insert into public.catalog_brands (name,description,is_active,sort_order) values ('Страж','Вхідні двері Страж: офіційний каталог виробника.',true,80) on conflict (name) do update set description=excluded.description,is_active=true,updated_at=now();",
];
for (const collection of ["Офіційний каталог — перевірити"]) {
  lines.push(`insert into public.catalog_collections (brand_id,name,category,description,is_active,sort_order) select id,${sql(collection)},'entrance',${sql(`Вхідні двері Страж — ${collection.toLocaleLowerCase("uk-UA")}.`)},true,80 from public.catalog_brands where name='Страж' on conflict (brand_id,name,category) do update set description=excluded.description,is_active=true,updated_at=now();`);
}
for (const record of records) {
  const slug = `strazh-official-${hash(record.url)}`;
  const description = `Вхідні двері Страж ${record.name} — модель з офіційного каталогу виробника. Допоможемо підібрати доступні декори, комплектацію та розмір дверного блоку; актуальну ціну уточнюйте у менеджера.`;
  lines.push(`insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values (${sql(slug)},'entrance','Страж',${sql(record.collection)},${sql(`Страж ${record.name}`)},'Вхідні','Офіційний каталог','Варіанти декорів','Ціна за запитом',${sql(description)},${sql(JSON.stringify(["Фабрика Страж", `Колекція ${record.collection}`, "Офіційна картка виробника"]))}::jsonb,${sql(record.image)},99999,false) on conflict (slug) do update set collection=excluded.collection,name=excluded.name,description=excluded.description,image_path=excluded.image_path,updated_at=now();`);
  lines.push(`insert into public.product_media (product_slug,kind,label,image_path,sort_order) select ${sql(slug)},'main','Головне фото',${sql(record.image)},0 where not exists (select 1 from public.product_media where product_slug=${sql(slug)} and kind='main' and image_path=${sql(record.image)});`);
  if (record.dimensions) lines.push(`insert into public.product_specs (product_slug,label,value,sort_order,is_active) values (${sql(slug)},'Розміри дверного блоку',${sql(record.dimensions)},100,true) on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;`);
  if (record.thickness) lines.push(`insert into public.product_specs (product_slug,label,value,sort_order,is_active) values (${sql(slug)},'Товщина полотна',${sql(record.thickness)},110,true) on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;`);
  lines.push(`insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values (${sql(slug)},'Страж',${sql(record.url)},${sql(record.name)},'verified',now(),'Офіційна картка Страж: назва, головне фото та базові параметри.') on conflict (product_slug,source_url) do update set source_product_name=excluded.source_product_name,verification_status='verified',verified_at=now(),notes=excluded.notes;`);
}
lines.push("commit;", `-- Підсумок: ${records.length} із ${selected.length} моделей. Усі залишаються прихованими.`);
await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, `strazh-official-drafts-batch-${String(batch).padStart(2, "0")}.sql`), lines.join("\n"));
await writeFile(join(outputDir, `strazh-official-drafts-batch-${String(batch).padStart(2, "0")}.json`), JSON.stringify({ batch, size, totalUnique: catalog.length, records }, null, 2));
console.log(`Готово: ${records.length}/${selected.length}. Наступний пакет: --batch=${batch + 1}.`);
