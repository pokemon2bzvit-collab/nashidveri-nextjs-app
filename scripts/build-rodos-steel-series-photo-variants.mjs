import { readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const records = JSON.parse(await readFile(join(outputDir, "rodos-steel-series-photos.json"), "utf8"));
const unique = new Map();
for (const record of records) for (const selection of record.selections || []) {
  const key = `${record.slug}::${selection.series}`;
  if (!unique.has(key)) unique.set(key, { ...record, ...selection });
}
const rows = [...unique.values()].map((row, index) => ({ ...row, sortOrder: index + 1 }));
const mediaRows = [...new Map(rows.map((row) => [`${row.slug}::${row.image}`, row])).values()];
function sql(value) { return `'${String(value).replace(/'/g, "''")}'`; }
const sqlText = [
  "-- Rodos Steel: точні фото для обраної серії комплектації.",
  "-- Не видаляє інші варіанти та не змінює головні фото моделей.",
  "begin;",
  "insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values",
  rows.map((row) => `(${sql(row.slug)},${sql(JSON.stringify({ series: row.series }))}::jsonb,${sql(row.image)},${row.sortOrder},true)`).join(",\n"),
  "on conflict (product_slug,selections) do update set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;",
  "insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values",
  mediaRows.map((row) => `(${sql(row.slug)},'gallery',${sql(`config:series=${encodeURIComponent(row.series)}:Фото серії`)},${sql(row.image)},${row.sortOrder},true)`).join(",\n"),
  "on conflict (product_slug,kind,image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;",
  "commit;",
  "",
].join("\n");
const markdown = ["# Rodos Steel — фото за серіями", "", `- Точних прив’язок: **${rows.length}**.`, `- Моделей із хоча б одним фото серії: **${new Set(rows.map((row) => row.slug)).size}**.`, "", ...rows.map((row) => `- ${row.model} · ${row.purpose}: ${row.series}`), ""].join("\n");
await writeFile(join(outputDir, "rodos-steel-series-photo-variants.sql"), sqlText);
await writeFile(join(outputDir, "rodos-steel-series-photo-variants.md"), markdown);
console.log(`Готово: ${rows.length} варіантів для ${new Set(rows.map((row) => row.slug)).size} моделей.`);
