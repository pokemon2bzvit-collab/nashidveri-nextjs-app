import { readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const audit = JSON.parse(await readFile(join(outputDir, "rodos-steel-catalog-audit.json"), "utf8"));
const rows = audit.needsReview;
function sql(value) { return `'${String(value).replace(/'/g, "''")}'`; }
const slugs = rows.map((row) => sql(row.slug)).join(", ");
const sqlText = [
  "-- Rodos Steel: приховує лише 17 складських або неоднозначних сторінок.",
  "-- Дані не видаляються: моделі можна повернути в каталог, встановивши is_available = true.",
  "begin;",
  `do $$ declare expected_count integer := ${rows.length}; actual_count integer; begin`,
  `  select count(*) into actual_count from public.products where slug in (${slugs}) and brand = 'Rodos Steel';`,
  "  if actual_count <> expected_count then raise exception 'Очікувалось % неоднозначних моделей Rodos Steel, знайдено % — каталог не змінено', expected_count, actual_count; end if;",
  "end $$;",
  `update public.products set is_available = false, updated_at = now() where slug in (${slugs}) and brand = 'Rodos Steel';`,
  `select slug, name, is_available from public.products where slug in (${slugs}) order by name;`,
  "commit;",
  "",
].join("\n");
const markdown = [
  "# Rodos Steel — приховані неоднозначні картки",
  "",
  `Усього: **${rows.length}**. Вони не видаляться з бази, лише перестануть відображатися покупцям.`,
  "",
  ...rows.map((row) => `- ${row.model}: ${row.title}`),
  "",
].join("\n");
await writeFile(join(outputDir, "rodos-steel-hide-review-models.sql"), sqlText);
await writeFile(join(outputDir, "rodos-steel-hide-review-models.md"), markdown);
console.log(`Готово: ${rows.length} карток для приховування.`);
