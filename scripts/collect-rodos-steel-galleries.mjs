import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const audit = JSON.parse(await readFile(join(outputDir, "rodos-steel-catalog-audit.json"), "utf8"));
const cachePath = join(outputDir, "rodos-steel-gallery-audit.json");
const previous = await readFile(cachePath, "utf8").then(JSON.parse).catch(() => ({ records: [], failed: [] }));
// Нульовий результат старого формату не вважаємо кешем: у Rodos порядок
// HTML-атрибутів посилання може відрізнятися між картками.
const cached = new Map(previous.records.filter((record) => record.images?.length).map((record) => [record.slug, record]));
const failed = previous.failed || [];
function decode(value = "") { return value.replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#039;|&#39;/gi, "'"); }
function clean(value = "") { return value.replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim(); }
function delay(ms) { return new Promise((resolve) => setTimeout(resolve, ms)); }
async function persist() { await mkdir(outputDir, { recursive: true }); await writeFile(cachePath, JSON.stringify({ records: [...cached.values()], failed }, null, 2)); }

for (const [index, product] of audit.primaryModels.entries()) {
  if (cached.has(product.slug)) continue;
  try {
    const response = await fetch(product.url, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0)", "Accept-Language": "uk-UA,uk;q=0.9" }, signal: AbortSignal.timeout(20_000) });
    if (!response.ok) throw new Error(`Rodos повернув ${response.status}`);
    const html = await response.text();
    const name = clean(html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i)?.[1] || product.title);
    const images = Array.from(new Set(Array.from(html.matchAll(/<a\b([^>]*)>/gi)).flatMap((anchor) => {
      const attributes = anchor[1];
      if (!/class=["'][^"']*cloud-zoom-gallery[^"']*["']/i.test(attributes)) return [];
      const href = attributes.match(/href=["']([^"']+\.(?:jpe?g|png|webp)[^"']*)/i)?.[1];
      return href ? [new URL(decode(href), product.url).toString()] : [];
    })));
    cached.set(product.slug, { slug: product.slug, model: product.model, purpose: product.purpose, name, sourceUrl: product.url, images, additionalImages: images.slice(1) });
  } catch (error) { failed.push({ ...product, error: error instanceof Error ? error.message : "Невідома помилка" }); }
  await persist();
  process.stdout.write(`\rПеревірено ${index + 1}/${audit.primaryModels.length}`);
  await delay(800);
}
process.stdout.write("\n");
const records = [...cached.values()].sort((a, b) => a.model.localeCompare(b.model, "uk", { numeric: true }));
const cleanGalleries = records.filter((record) => record.additionalImages.length > 0 && record.images.length <= 10);
const configurationPhotos = records.filter((record) => record.images.length > 10);
const noExtras = records.filter((record) => record.additionalImages.length === 0);
function sql(value) { return `'${String(value).replace(/'/g, "''")}'`; }
const slugs = cleanGalleries.map((record) => sql(record.slug)).join(", ");
const mediaRows = cleanGalleries.flatMap((record) => record.additionalImages.map((image, index) => [record.slug, "gallery", `Офіційне фото Rodos Steel ${index + 1}`, image, index + 1]));
const sqlLines = [
  "-- Rodos Steel: додаткові офіційні ракурси лише для компактних галерей (до 10 фото на картці виробника).",
  "-- Великі галереї з різними серіями й декорами тут не змішуються.",
  "begin;",
  `delete from public.product_media where product_slug in (${slugs || "''"}) and kind = 'gallery';`,
  ...(mediaRows.length ? ["insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values", mediaRows.map((row) => `(${sql(row[0])},${sql(row[1])},${sql(row[2])},${sql(row[3])},${row[4]},true)`).join(",\n"), "on conflict (product_slug,kind,image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;"] : []),
  "commit;",
  "",
];
const markdown = [
  "# Rodos Steel — аудит додаткових фото",
  "",
  `- Компактні галереї для додавання: **${cleanGalleries.length}** моделей, **${mediaRows.length}** додаткових фото.`,
  `- Великі галереї для окремого конфігуратора: **${configurationPhotos.length}** моделей.`,
  `- Без додаткових фото: **${noExtras.length}** моделей.`,
  "",
  "## Великі галереї — не змішано в один ряд",
  "",
  ...configurationPhotos.map((record) => `- ${record.model} · ${record.purpose}: ${record.images.length} фото`),
  "",
];
await writeFile(join(outputDir, "rodos-steel-gallery-audit.md"), markdown.join("\n"));
await writeFile(join(outputDir, "rodos-steel-compact-galleries.sql"), sqlLines.join("\n"));
console.log(`Готово: компактних галерей ${cleanGalleries.length}, фото ${mediaRows.length}; великих конфігурацій ${configurationPhotos.length}.`);
