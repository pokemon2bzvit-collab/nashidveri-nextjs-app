import { readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const specs = JSON.parse(await readFile(join(outputDir, "rodos-steel-safe-specs.json"), "utf8"));
const names = new Map();
for (const file of ["rodos-steel-apartment-enrichment.json", "rodos-steel-street-enrichment.json"]) {
  const source = JSON.parse(await readFile(join(outputDir, file), "utf8"));
  for (const item of source.collected || []) names.set(item.slug, item.name);
}
function sql(value) { return `'${String(value).replace(/'/g, "''")}'`; }
function description(record) {
  const name = names.get(record.slug) || `Вхідні двері ${record.model}`;
  const purpose = record.purpose === "Вулиця" ? "для приватного будинку" : "для квартири";
  const sizes = record.dimensions.length ? ` Доступні розміри дверного блоку: ${record.dimensions.join(" або ")}.` : "";
  const series = record.series.length ? ` Можна обрати комплектацію ${record.series.join(", ")}.` : "";
  return `${name} — вхідні двері Rodos Steel ${purpose}.${sizes}${series} Допоможемо підібрати декор, напрямок відкривання та оптимальне виконання для вашого приміщення. Актуальну ціну уточнюйте у менеджера.`.replace(/\s+/g, " ").trim();
}
const rows = specs.records.map((record) => ({ ...record, name: names.get(record.slug) || `Вхідні двері ${record.model}`, description: description(record) }));
const sqlText = [
  "-- Rodos Steel: оновлені українські описи з офіційно підтвердженими розмірами та серіями.",
  "begin;",
  ...rows.map((row) => `update public.products set description = ${sql(row.description)}, updated_at = now() where slug = ${sql(row.slug)} and brand = 'Rodos Steel';`),
  "commit;",
  "",
].join("\n");
const markdown = ["# Rodos Steel — оновлені описи", "", `- Оновлюється: **${rows.length}** картки.`, "", ...rows.slice(0, 5).map((row) => `## ${row.name}\n\n${row.description}`), ""].join("\n");
await writeFile(join(outputDir, "rodos-steel-rich-descriptions.sql"), sqlText);
await writeFile(join(outputDir, "rodos-steel-rich-descriptions-preview.md"), markdown);
console.log(`Готово: ${rows.length} описів.`);
