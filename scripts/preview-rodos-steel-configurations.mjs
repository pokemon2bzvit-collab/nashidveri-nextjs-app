import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const audit = JSON.parse(await readFile(join(outputDir, "rodos-steel-catalog-audit.json"), "utf8"));
const wanted = new Set(["F101::Квартира", "F123::Квартира", "F101::Вулиця", "F155::Вулиця"]);
const samples = audit.primaryModels.filter((product) => wanted.has(product.group));
function decode(value = "") { return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#039;|&#39;/gi, "'"); }
function clean(value = "") { return decode(value.replace(/<[^>]+>/g, " ")).replace(/\s+/g, " ").trim(); }

const records = [];
for (const product of samples) {
  const response = await fetch(product.url, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0)", "Accept-Language": "uk-UA,uk;q=0.9" }, signal: AbortSignal.timeout(20_000) });
  if (!response.ok) { records.push({ ...product, error: `Rodos повернув ${response.status}` }); continue; }
  const html = await response.text();
  const groups = [];
  for (const match of html.matchAll(/<div class=["'][^"']*form-group[^"']*["'][\s\S]*?<div class=["']option-name["']>([\s\S]*?)<\/div>([\s\S]*?)(?=<div class=["'][^"']*form-group|<\/form>)/gi)) {
    const label = clean(match[1]);
    const values = Array.from(match[2].matchAll(/(?:radio-name2|radio-name)[^>]*(?:opt=["']([^"']+)["']|>([^<]+))/gi)).map((option) => clean(option[1] || option[2])).filter(Boolean);
    if (label) groups.push({ label, values: Array.from(new Set(values)).slice(0, 12) });
  }
  const tabs = Array.from(html.matchAll(/<li><a href=["']#(tab-extra-\d+)["'][^>]*>([\s\S]*?)<\/a><\/li>/gi)).map((tab) => ({ id: tab[1], title: clean(tab[2]) }));
  records.push({ ...product, optionGroups: groups, constructionTabs: tabs });
}
const markdown = [
  "# Rodos Steel — як виробник задає комплектації",
  "",
  "Перегляд без змін у базі. Виробник визначає технічні параметри через серію й опції, тому одна назва моделі не дорівнює одній постійній комплектації.",
  ...records.flatMap((record) => [
    "",
    `## ${record.model} · ${record.purpose}`,
    "",
    record.error ? `**Помилка:** ${record.error}` : [
      `- Джерело: ${record.url}`,
      `- Сторінки з конструкціями: ${record.constructionTabs.map((tab) => tab.title).join(", ") || "не знайдено"}`,
      "- Групи вибору:",
      ...record.optionGroups.map((group) => `  - **${group.label}:** ${group.values.join(", ") || "значення читаються скриптом виробника"}`),
    ].join("\n"),
  ]),
  "",
];
await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, "rodos-steel-configurations-preview.json"), JSON.stringify(records, null, 2));
await writeFile(join(outputDir, "rodos-steel-configurations-preview.md"), markdown.join("\n"));
console.log(`Готово: ${records.length} зразки комплектацій.`);
