import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const audit = JSON.parse(await readFile(join(outputDir, "rodos-steel-catalog-audit.json"), "utf8"));
const sampleCodes = new Set(["A100", "A101", "A102"]);
const models = audit.primaryModels.filter((item) => item.purpose === "Квартира" && sampleCodes.has(item.model));

function decode(value = "") { return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#039;|&#39;/gi, "'"); }
function text(html = "") { return decode(html.replace(/<script[\s\S]*?<\/script>/gi, " ").replace(/<style[\s\S]*?<\/style>/gi, " ").replace(/<(?:br|\/p|\/div|\/li|\/tr|\/td|\/h[1-6])[^>]*>/gi, "\n").replace(/<[^>]+>/g, " ").replace(/[ \t]+/g, " ").replace(/\n\s*\n+/g, "\n").trim()); }
function clean(value = "") { return value.replace(/\s+/g, " ").trim(); }
function facts(html) {
  const section = html.match(/id=["']tab-specification["'][^>]*>([\s\S]*?)(?=<div[^>]+id=["']tab-|$)/i)?.[1] || "";
  const parsed = [];
  for (const row of section.matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)) {
    const cells = Array.from(row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)).map((cell) => clean(text(cell[1])));
    if (cells.length > 1 && cells[0] && cells[1]) parsed.push({ label: cells[0].replace(/:$/u, ""), value: cells[1] });
  }
  return Array.from(new Map(parsed.map((fact) => [fact.label.toLocaleLowerCase("uk-UA"), fact])).values()).slice(0, 12);
}
function ukrainianTitle(title) { return title.replace(/^Входные двери/iu, "Вхідні двері").replace(/^Входная дверь/iu, "Вхідні двері").replace(/\s+/g, " ").trim(); }
function description(title, facts) {
  const useful = facts.filter((item) => /товщин|короб|контур|замок|тепло|шумо|метал/iu.test(item.label)).slice(0, 3).map((item) => `${item.label.toLocaleLowerCase("uk-UA")}: ${item.value}`).join("; ");
  return `${ukrainianTitle(title)} — вхідні двері Rodos Steel для квартири. ${useful ? `Основні параметри: ${useful}. ` : ""}Доступну комплектацію, напрямок відкривання та актуальну ціну уточнюйте у менеджера.`;
}

const preview = [];
for (const model of models) {
  const response = await fetch(model.url, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0)", "Accept-Language": "uk-UA,uk;q=0.9" }, signal: AbortSignal.timeout(20_000) });
  if (!response.ok) { preview.push({ ...model, error: `Rodos повернув ${response.status}` }); continue; }
  const html = await response.text();
  const title = clean(text(html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i)?.[1] || model.title));
  const ogImage = html.match(/property=["']og:image["'][^>]*content=["']([^"']+)["']/i)?.[1] || null;
  const parsedFacts = facts(html);
  const optionLabels = Array.from(new Set(Array.from(html.matchAll(/class=["'][^"']*option-name[^"']*["'][^>]*>([\s\S]*?)<\//gi)).map((match) => clean(text(match[1]))).filter(Boolean)));
  preview.push({ slug: model.slug, sourceUrl: model.url, officialTitle: title, proposedName: ukrainianTitle(title), mainImage: ogImage, facts: parsedFacts, optionGroups: optionLabels, proposedDescription: description(title, parsedFacts) });
}

const markdown = [
  "# Rodos Steel — попередній перегляд: квартири",
  "",
  "Жодних змін у Supabase. Це зразок того, які дані братимемо з офіційних карток перед масовим пакетом.",
  ...preview.flatMap((item) => [
    "",
    `## ${item.proposedName || item.model}`,
    "",
    item.error ? `**Помилка:** ${item.error}` : `- Офіційна картка: ${item.sourceUrl}\n- Головне фото: ${item.mainImage || "не знайдено"}\n- Групи опцій: ${item.optionGroups.join(", ") || "не знайдено"}\n- Запропонований опис: ${item.proposedDescription}\n- Характеристики:\n${item.facts.map((fact) => `  - ${fact.label}: ${fact.value}`).join("\n") || "  - не знайдено"}`,
  ]),
  "",
];
await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, "rodos-steel-apartment-preview.json"), JSON.stringify(preview, null, 2));
await writeFile(join(outputDir, "rodos-steel-apartment-preview.md"), markdown.join("\n"));
console.log(`Готово: ${preview.length} офіційні картки у попередньому перегляді.`);
