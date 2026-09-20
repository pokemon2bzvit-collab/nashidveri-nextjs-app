import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const payload = JSON.parse(await readFile(join(outputDir, "rodos-steel-safe-specs.json"), "utf8"));
const records = payload.records.filter((record) => record.dimensions.length || record.series.length);
function sql(value) { return `'${String(value ?? "").replace(/'/g, "''")}'`; }
const slugs = records.map((record) => sql(record.slug)).join(", ");
const rows = records.flatMap((record) => [
  ...record.series.map((label, index) => [record.slug, "series", "Серія комплектації", label, index + 1]),
  ...record.dimensions.map((label, index) => [record.slug, "size", "Розмір дверного блоку", label, index + 1]),
]);
const sqlLines = [
  "-- Rodos Steel: простий вибір серії комплектації та розміру для заявки.",
  "-- Фото не змінюється: виробник не підтверджує точне зображення кожної комбінації.",
  "begin;",
  `delete from public.product_options where product_slug in (${slugs}) and option_group in ('series','size');`,
  "insert into public.product_options (product_slug,option_group,group_label,label,sort_order,is_active) values",
  rows.map((row) => `(${sql(row[0])},${sql(row[1])},${sql(row[2])},${sql(row[3])},${row[4]},true)`).join(",\n"),
  "on conflict (product_slug,option_group,label) do update set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;",
  "commit;",
  "",
];
const markdown = [
  "# Rodos Steel — простий вибір комплектації",
  "",
  `- Моделей з доступним вибором: **${records.length}**.`,
  `- Опцій серії та розміру: **${rows.length}**.`,
  "- Вибрані серія та розмір зберігатимуться у кошику й заявці, без зміни головного фото.",
  "",
];
await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, "rodos-steel-configuration-options.sql"), sqlLines.join("\n"));
await writeFile(join(outputDir, "rodos-steel-configuration-options.md"), markdown.join("\n"));
console.log(`Готово: ${records.length} моделей, ${rows.length} опцій.`);
