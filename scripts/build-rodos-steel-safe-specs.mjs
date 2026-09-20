import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const audit = JSON.parse(await readFile(join(outputDir, "rodos-steel-catalog-audit.json"), "utf8"));
const products = audit.primaryModels;
function sql(value) { return `'${String(value ?? "").replace(/'/g, "''")}'`; }
function decode(value = "") { return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#039;|&#39;/gi, "'"); }
function clean(value = "") { return decode(value.replace(/<[^>]+>/g, " ")).replace(/\s+/g, " ").trim(); }
function delay(ms) { return new Promise((resolve) => setTimeout(resolve, ms)); }
function valuesFromGroup(html, labelPart) {
  const match = Array.from(html.matchAll(/<div class=["'][^"']*form-group[^"']*["'][\s\S]*?<div class=["']option-name["']>([\s\S]*?)<\/div>([\s\S]*?)(?=<div class=["'][^"']*form-group|<\/form>)/gi)).find((group) => labelPart.test(clean(group[1])));
  if (!match) return [];
  return Array.from(match[2].matchAll(/(?:radio-name2|radio-name)[^>]*(?:opt=["']([^"']+)["']|>([^<]+))/gi)).map((option) => clean(option[1] || option[2])).filter((value) => value && !/^нет$/iu.test(value) && !/^\+?[\d\s]+грн$/iu.test(value));
}
const records = [];
const failed = [];
for (const [index, product] of products.entries()) {
  try {
    const response = await fetch(product.url, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0)", "Accept-Language": "uk-UA,uk;q=0.9" }, signal: AbortSignal.timeout(20_000) });
    if (!response.ok) throw new Error(`Rodos повернув ${response.status}`);
    const html = await response.text();
    const dimensions = valuesFromGroup(html, /габарит.*короб/iu).map((value) => value.replace(/\s*[xх]\s*/iu, " × ")).filter((value) => /^\d+/u.test(value));
    const groupNames = Array.from(html.matchAll(/<div class=["']option-name["']>([\s\S]*?)<\/div>/gi)).map((group) => clean(group[1]));
    const series = Array.from(new Set(groupNames.map((name) => name.match(/^(Basic|Line(?: Street)?|Standart|Premium|Avenue)\b/iu)?.[1]).filter(Boolean))).map((name) => name.replace(/^Standart$/iu, "Standard"));
    records.push({ slug: product.slug, model: product.model, purpose: product.purpose, dimensions: Array.from(new Set(dimensions)), series });
  } catch (error) { failed.push({ ...product, error: error instanceof Error ? error.message : "Невідома помилка" }); }
  process.stdout.write(`\rПеревірено ${index + 1}/${products.length}`);
  if (index < products.length - 1) await delay(800);
}
process.stdout.write("\n");
const rows = records.flatMap((record) => [
  [record.slug, "Призначення", record.purpose === "Квартира" ? "Для квартири" : "Для приватного будинку", 110],
  ...(record.dimensions.length ? [[record.slug, "Розміри дверного блоку", record.dimensions.join(", "), 120]] : []),
  ...(record.series.length ? [[record.slug, "Доступні серії комплектації", record.series.join(", "), 130]] : []),
]);
const slugs = records.map((record) => sql(record.slug)).join(", ");
const lines = [
  "-- Rodos Steel: лише безпечні характеристики з офіційних карток.",
  "-- Замки, метал, утеплення та інші параметри не додаються: вони залежать від вибраної серії.",
  "begin;",
  `delete from public.product_specs where product_slug in (${slugs}) and label in ('Призначення','Розміри дверного блоку','Доступні серії комплектації');`,
  "insert into public.product_specs (product_slug,label,value,sort_order,is_active) values",
  rows.map((row) => `(${row.map(sql).join(",")},true)`).join(",\n"),
  "on conflict (product_slug,label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;",
  "commit;",
  "",
];
const markdown = [
  "# Rodos Steel — безпечні характеристики",
  "",
  `- У пакеті: **${records.length}** моделей із **${products.length}**.` ,
  `- Не прочитано: **${failed.length}**.`,
  "- Додаються лише призначення, розміри блока та доступні серії комплектації.",
  "",
  ...records.map((record) => `- ${record.model}: ${record.purpose}; ${record.dimensions.join(", ") || "розміри не знайдені"}; ${record.series.join(", ") || "серію не знайдено"}`),
  "",
];
await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, "rodos-steel-safe-specs.sql"), lines.join("\n"));
await writeFile(join(outputDir, "rodos-steel-safe-specs.json"), JSON.stringify({ records, failed }, null, 2));
await writeFile(join(outputDir, "rodos-steel-safe-specs.md"), markdown.join("\n"));
console.log(`Готово: ${records.length} моделей, помилок: ${failed.length}.`);
