import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const batch = Number(process.argv.find((value) => value.startsWith("--batch="))?.split("=")[1] || "1");
const outputDir = join(process.cwd(), "supabase", "generated");
const imported = JSON.parse(await readFile(join(outputDir, `strazh-official-drafts-batch-${String(batch).padStart(2, "0")}.json`), "utf8"));

function sql(value = "") { return `'${String(value).replaceAll("'", "''")}'`; }
function hash(value) { let output = 2166136261; for (const character of value) output = Math.imul(output ^ character.charCodeAt(0), 16777619); return (output >>> 0).toString(36); }
function text(html = "") {
  return html.replace(/<script[\s\S]*?<\/script>/giu, " ").replace(/<style[\s\S]*?<\/style>/giu, " ")
    .replace(/<[^>]+>/gu, " ").replace(/&nbsp;/giu, " ").replace(/&amp;/giu, "&").replace(/\s+/gu, " ").trim();
}
function dimensions(value) {
  const raw = value.match(/Стандартний розмір дверного блоку\s*:\s*([^.!]{4,140})/iu)?.[1]
    ?.split(/Рекомендовано|Максимально|Наличие|В наличии|Вартість|Колекці|Товщина полотна/iu)[0]?.trim();
  return raw && /^[\dхx×\s/–-]+$/iu.test(raw) ? raw : null;
}
function facts(html) {
  const value = text(html);
  const find = (pattern) => value.match(pattern)?.[1]?.replace(/\s+/gu, " ").trim() || null;
  const facts = [];
  const size = dimensions(value);
  const leaf = find(/Товщина полотна\s*-?\s*(\d+(?:[,.]\d+)?\s*мм)/iu);
  const metal = find(/(?:лист метал(?:у|лу)|товщина металу)\s*(?:[-–:]\s*)?(\d+(?:[,.]\d+)?\s*мм)/iu);
  const box = find(/(?:короб [^.!]{0,70}?глибиною|глибина короб[ау])\s*(\d+(?:[,.]\d+)?\s*мм)/iu);
  const contours = find(/(\d\s*контур[аи]?\s+ущільнювач[а-яіїєґ]*)/iu);
  if (size) facts.push(["Розміри дверного блоку", size]);
  if (leaf) facts.push(["Товщина полотна", leaf]);
  if (metal) facts.push(["Товщина металу", metal]);
  if (box) facts.push(["Глибина коробки", box]);
  if (contours) facts.push(["Контури ущільнення", contours]);
  if (/утеплен[а-яіїєґ ]{0,40}мінеральн(?:ою|а) ват/iu.test(value)) facts.push(["Утеплення", "Мінеральна вата"]);
  if (/для багатоквартирних.{0,80}приватних будин/iu.test(value)) facts.push(["Призначення", "Для квартири й приватного будинку"]);
  return facts;
}

const records = [];
for (let index = 0; index < imported.records.length; index += 1) {
  const item = imported.records[index];
  try {
    const response = await fetch(item.url, { headers: { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalog/1.0)" }, signal: AbortSignal.timeout(25_000) });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const specs = facts(await response.text());
    records.push({ ...item, specs });
    console.log(`[${index + 1}/${imported.records.length}] ${item.name}: ${specs.length} параметрів`);
  } catch (error) {
    console.log(`[${index + 1}/${imported.records.length}] пропущено ${item.name}: ${error instanceof Error ? error.message : "помилка"}`);
  }
  await new Promise((resolve) => setTimeout(resolve, 350));
}

const lines = [
  `-- Страж: офіційні характеристики, пакет ${batch}.`,
  "-- Оновлює тільки підтверджені на картці виробника параметри.",
  "begin;",
];
for (const record of records) {
  const slug = `strazh-official-${hash(record.url)}`;
  const values = Object.fromEntries(record.specs);
  const phrases = [values["Товщина полотна"] && `полотно ${values["Товщина полотна"]}`, values["Товщина металу"] && `метал ${values["Товщина металу"]}`, values["Глибина коробки"] && `короб ${values["Глибина коробки"]}`].filter(Boolean);
  const description = `Вхідні двері Страж ${record.name} — модель з офіційного каталогу виробника.${phrases.length ? ` Основні параметри: ${phrases.join(", ")}.` : ""}${values["Утеплення"] ? " Утеплення мінеральною ватою допомагає підтримувати комфорт у приміщенні." : ""} Допоможемо підібрати декори, комплектацію та розмір дверного блоку; актуальну ціну уточнюйте у менеджера.`;
  lines.push(`update public.products set description=${sql(description)},updated_at=now() where slug=${sql(slug)} and brand='Страж';`);
  let order = 100;
  for (const [label, value] of record.specs) {
    lines.push(`insert into public.product_specs (product_slug,label,value,sort_order,is_active) values (${sql(slug)},${sql(label)},${sql(value)},${order},true) on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;`);
    order += 10;
  }
}
lines.push("commit;", `-- Підсумок: ${records.length} моделей; параметрів: ${records.reduce((sum, record) => sum + record.specs.length, 0)}.`);
await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, `strazh-official-specs-batch-${String(batch).padStart(2, "0")}.sql`), lines.join("\n"));
await writeFile(join(outputDir, `strazh-official-specs-batch-${String(batch).padStart(2, "0")}.json`), JSON.stringify({ batch, records }, null, 2));
console.log(`Готово: ${records.length} моделей; ${records.reduce((sum, record) => sum + record.specs.length, 0)} параметрів.`);
