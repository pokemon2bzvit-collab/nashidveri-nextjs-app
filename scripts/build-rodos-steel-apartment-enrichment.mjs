import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const audit = JSON.parse(await readFile(join(outputDir, "rodos-steel-catalog-audit.json"), "utf8"));
const products = audit.primaryModels.filter((item) => item.purpose === "Квартира");

function sql(value) { return `'${String(value ?? "").replace(/'/g, "''")}'`; }
function decode(value = "") { return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#039;|&#39;/gi, "'"); }
function text(html = "") { return decode(html.replace(/<script[\s\S]*?<\/script>/gi, " ").replace(/<style[\s\S]*?<\/style>/gi, " ").replace(/<(?:br|\/p|\/div|\/li|\/tr|\/td|\/h[1-6])[^>]*>/gi, "\n").replace(/<[^>]+>/g, " ").replace(/[ \t]+/g, " ").replace(/\n\s*\n+/g, "\n").trim()); }
function clean(value = "") { return value.replace(/\s+/g, " ").trim(); }
function ukrainianTitle(title) { return title.replace(/^Входные двери/iu, "Вхідні двері").replace(/^Входная дверь/iu, "Вхідні двері").replace(/\s+для\s+квартиры/iu, "").replace(/\s+/g, " ").trim(); }
function description(title) { return `${ukrainianTitle(title)} — вхідні двері Rodos Steel для квартири. Допоможемо підібрати комплектацію, декори, напрямок відкривання та розмір дверного блоку. Актуальну ціну уточнюйте у менеджера.`; }
function delay(ms) { return new Promise((resolve) => setTimeout(resolve, ms)); }

const collected = [];
const failed = [];
for (const [index, product] of products.entries()) {
  try {
    const response = await fetch(product.url, {
      headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0; +https://nashidveri-uzhhorod.com.ua)", "Accept-Language": "uk-UA,uk;q=0.9" },
      signal: AbortSignal.timeout(20_000),
    });
    if (!response.ok) throw new Error(`Rodos повернув ${response.status}`);
    const html = await response.text();
    const officialTitle = clean(text(html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i)?.[1] || product.title));
    const rawImage = html.match(/property=["']og:image["'][^>]*content=["']([^"']+)["']/i)?.[1];
    const imagePath = rawImage ? new URL(decode(rawImage), product.url).toString() : null;
    if (!officialTitle || !imagePath) throw new Error("Не знайдено назву або головне фото");
    collected.push({ ...product, officialTitle, name: ukrainianTitle(officialTitle), imagePath, description: description(officialTitle) });
  } catch (error) {
    failed.push({ ...product, error: error instanceof Error ? error.message : "Невідома помилка" });
  }
  process.stdout.write(`\rПеревірено ${index + 1}/${products.length}`);
  if (index < products.length - 1) await delay(850);
}
process.stdout.write("\n");

const slugs = collected.map((product) => sql(product.slug)).join(", ");
const lines = [
  "-- Rodos Steel: збагачення квартирних моделей із офіційних карток rodos.ua.",
  `-- Підготовлено: ${new Date().toISOString()}. У пакеті ${collected.length} з ${products.length} перевірених моделей.`,
  "-- Оновлює лише назву, колекцію, опис, головне фото та посилання на першоджерело.",
  "begin;",
  "do $$ declare expected_count integer := " + collected.length + "; actual_count integer; begin",
  `  select count(*) into actual_count from public.products where slug in (${slugs});`,
  "  if actual_count <> expected_count then raise exception 'Очікувалось % моделей Rodos Steel для квартири, знайдено % — каталог не змінено', expected_count, actual_count; end if;",
  "end $$;",
  ...collected.flatMap((product) => [
    `update public.products set brand = 'Rodos Steel', category = 'entrance', collection = 'Квартира', name = ${sql(product.name)}, description = ${sql(product.description)}, image_path = ${sql(product.imagePath)}, updated_at = now() where slug = ${sql(product.slug)};`,
    `delete from public.product_sources where product_slug = ${sql(product.slug)} and source_url = ${sql(product.url)};`,
    `insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values (${sql(product.slug)},'Rodos Steel',${sql(product.url)},${sql(product.officialTitle)},'verified',now(),'Офіційна картка Rodos Steel: назва, головне фото та базовий опис перевірені.');`,
  ]),
  "commit;",
  "",
];
const markdown = [
  "# Rodos Steel — квартири: пакет збагачення",
  "",
  `- У пакеті: **${collected.length}** моделей із **${products.length}** звірених.` ,
  `- Не додано через помилки читання: **${failed.length}**.`,
  "- SQL не зачіпає комплектації, характеристики, декори, доступність або моделі для будинку.",
  "",
  "## Моделі у пакеті",
  "",
  ...collected.map((product) => `- ${product.name} — ${product.slug}`),
  ...(failed.length ? ["", "## Не увійшли до пакета", "", ...failed.map((product) => `- ${product.model}: ${product.error}`)] : []),
  "",
];
await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, "rodos-steel-apartment-enrichment.sql"), lines.join("\n"));
await writeFile(join(outputDir, "rodos-steel-apartment-enrichment.json"), JSON.stringify({ collected, failed }, null, 2));
await writeFile(join(outputDir, "rodos-steel-apartment-enrichment.md"), markdown.join("\n"));
console.log(`Готово: SQL для ${collected.length} моделей; помилок читання: ${failed.length}.`);
