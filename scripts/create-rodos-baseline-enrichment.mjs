import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const reportPath = join(outputDir, "rodos-market-match-report.json");
const outputPath = join(outputDir, "rodos-all-baseline-enrichment.sql");

function sql(value) { return "'" + String(value ?? "").replace(/'/g, "''") + "'"; }
function ukrainianTitle(title) {
  return title
    .replace(/^Входные двери/iu, "Вхідні двері")
    .replace(/^Входная дверь/iu, "Вхідні двері")
    .replace(/^Межкомнатные двери/iu, "Міжкімнатні двері")
    .replace(/^Межкомнатная дверь/iu, "Міжкімнатні двері")
    .replace(/для улицы/giu, "для будинку")
    .replace(/для квартиры/giu, "для квартири")
    .replace(/\s*\(В наличии\)/giu, "")
    .replace(/\s+/g, " ")
    .trim();
}
function descriptionFor(product) {
  const title = ukrainianTitle(product.title);
  const purpose = /для квартири/iu.test(title) ? "для квартири" : /для будинку/iu.test(title) ? "для приватного будинку" : product.entrance ? "для квартири або приватного будинку" : "для вашого інтер’єру";
  return `${title} — модель фабрики ${product.entrance ? "Rodos Steel" : "Rodos"} ${purpose}. Детальні характеристики, доступні покриття та актуальну ціну уточнюйте у менеджера.`;
}

const report = JSON.parse(await readFile(reportPath, "utf8"));
// Exact Market matches already have richer descriptions and technical facts.
const products = report.unmatched;
const lines = [
  "-- Rodos / Rodos Steel: базове збагачення решти моделей з офіційного sitemap.",
  "-- Змінює лише український базовий опис та перевірене офіційне URL-джерело.",
  "-- Не додає неперевірених технічних характеристик, цін, фото, декорів або колекцій.",
  "begin;",
];
for (const product of products) {
  const sourceName = product.entrance ? "Rodos Steel" : "Rodos";
  lines.push(`update public.products set description = ${sql(descriptionFor(product))} where slug = ${sql(product.slug)};`);
  lines.push(`delete from public.product_sources where product_slug = ${sql(product.slug)} and source_url = ${sql(product.url)};`);
  lines.push(`insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values (${sql(product.slug)},${sql(sourceName)},${sql(product.url)},${sql(product.title)},'verified',now(),'Офіційна картка Rodos із sitemap. Технічні дані потребують окремої звірки.');`);
}
lines.push("commit;");
await mkdir(outputDir, { recursive: true });
await writeFile(outputPath, lines.join("\n"));
console.log(`Created ${products.length} baseline records: ${outputPath}`);
