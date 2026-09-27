import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const audit = JSON.parse(await readFile(join(outputDir, "rodos-steel-gallery-audit.json"), "utf8"));
const products = audit.records.filter((record) => record.images.length > 10);
const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const clean = (value = "") => value.replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim();
const seriesName = (value) => value.match(/^(Basic|Line(?: Street)?|Standart(?: street)?|Premium|Avenue)\b/iu)?.[1]?.replace(/^Standart(?: street)?$/iu, "Standard") || null;
const records = [];
for (const [index, product] of products.entries()) {
  try {
    const html = await (await fetch(product.sourceUrl, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0)", "Accept-Language": "uk-UA,uk;q=0.9" }, signal: AbortSignal.timeout(20_000) })).text();
    const productId = html.match(/name=["']product_id["']\s+value=["'](\d+)/i)?.[1];
    if (!productId) throw new Error("Не знайдено product_id");
    const selections = [];
    for (const match of html.matchAll(/<div class=["'][^"']*form-group[^"']*["'][\s\S]*?<div class=["']option-name["']>([\s\S]*?)<\/div>([\s\S]*?)(?=<div class=["'][^"']*form-group|<\/form>)/gi)) {
      const series = seriesName(clean(match[1])); if (!series) continue;
      const option = Array.from(match[2].matchAll(/<input[^>]+name=["']([^"']+)["'][^>]+value=["']([^"']+)["'][^>]*>[\s\S]*?<span[^>]+(?:opt=["']([^"']+)["']|class=["'][^"']*radio-name[^"']*["'][^>]*>([^<]+))/gi)).map((row) => ({ name: row[1], value: row[2], label: clean(row[3] || row[4]) })).find((row) => row.label && !/^нет$/iu.test(row.label));
      if (!option) continue;
      const response = await fetch(`https://rodos.ua/index.php?route=product/product/getPImages&product_id=${productId}`, { method: "POST", headers: { "Content-Type": "application/x-www-form-urlencoded", "X-Requested-With": "XMLHttpRequest", "User-Agent": "Mozilla/5.0" }, body: new URLSearchParams({ [option.name]: option.value }), signal: AbortSignal.timeout(20_000) });
      const data = await response.json();
      if (data.images?.[0]?.main_img) selections.push({ series, image: data.images[0].main_img });
      await delay(500);
    }
    records.push({ slug: product.slug, model: product.model, purpose: product.purpose, selections });
  } catch (error) { records.push({ slug: product.slug, model: product.model, purpose: product.purpose, error: error instanceof Error ? error.message : "Помилка" }); }
  await mkdir(outputDir, { recursive: true }); await writeFile(join(outputDir, "rodos-steel-series-photos.json"), JSON.stringify(records, null, 2));
  process.stdout.write(`\rОброблено ${index + 1}/${products.length}`); await delay(900);
}
console.log("\nГотово.");
