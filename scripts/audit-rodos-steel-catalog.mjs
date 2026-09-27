import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const report = JSON.parse(await readFile(join(outputDir, "rodos-market-match-report.json"), "utf8"));
const rawItems = [...(report.matched || []), ...(report.unmatched || [])]
  .filter((item) => item.entrance || /^Входн/iu.test(item.title));

function clean(value = "") {
  return value.replace(/\s+/g, " ").trim();
}

function modelCode(item) {
  const match = clean(item.title).match(/\b(A\d{3}|F\s?\d{3}|Bas\s?\d{3})\b/iu);
  return match ? match[1].replace(/\s+/g, "").toUpperCase() : null;
}

function purpose(item, code) {
  // У sitemap назва часом лишається від старої картки, тоді як URL уже точно
  // містить призначення (`dlya-kvartiry` або `dlya-ulicy`). URL має пріоритет.
  const path = new URL(item.url).pathname.toLocaleLowerCase("uk-UA");
  if (/улиц|ulic/.test(path)) return "Вулиця";
  if (/квартир|kvartir/.test(path)) return "Квартира";
  const title = item.title.toLocaleLowerCase("uk-UA");
  if (/квартир|kvartir/.test(title)) return "Квартира";
  if (/улиц|ulic/.test(title)) return "Вулиця";
  if (code?.startsWith("A")) return "Квартира";
  if (code?.startsWith("BAS")) return "Вулиця";
  return "Перевірити";
}

const rows = rawItems.map((item) => {
  const code = modelCode(item);
  const urlCode = new URL(item.url).pathname.match(/\bf(\d{3})\b/i)?.[0]?.toUpperCase() || null;
  const hasStockSuffix = /в наличии|в наявності/iu.test(item.title);
  const category = purpose(item, code);
  return {
    title: clean(item.title),
    slug: item.slug,
    url: item.url,
    model: code || "Без коду",
    purpose: category,
    sourceCodeMismatch: Boolean(urlCode && code && urlCode !== code),
    isStockListing: hasStockSuffix,
    group: `${code || item.slug}::${category}`,
  };
});

// Складська сторінка — це не нова модель. Спочатку формуємо каталог тільки
// з нормальних карток, а потім намагаємося прив’язати складські позиції до них.
const catalogRows = rows.filter((row) => !row.isStockListing);
const stockRows = rows.filter((row) => row.isStockListing);
const groups = new Map();
for (const row of catalogRows) groups.set(row.group, [...(groups.get(row.group) || []), row]);

const canonical = [];
const duplicates = [];
for (const groupRows of groups.values()) {
  const sorted = [...groupRows].sort((a, b) => Number(a.isStockListing) - Number(b.isStockListing) || a.title.localeCompare(b.title, "uk"));
  const preferred = sorted[0];
  canonical.push({ ...preferred, duplicates: sorted.slice(1).map((item) => ({ title: item.title, slug: item.slug, url: item.url, isStockListing: item.isStockListing })) });
  for (const duplicate of sorted.slice(1)) duplicates.push({ canonicalSlug: preferred.slug, ...duplicate });
}

for (const stock of stockRows) {
  const sameModel = canonical.filter((item) => item.model === stock.model && item.purpose !== "Перевірити");
  if (sameModel.length === 1) duplicates.push({ canonicalSlug: sameModel[0].slug, ...stock });
  else canonical.push({ ...stock, purpose: "Перевірити", duplicates: [] });
}

canonical.sort((a, b) => a.purpose.localeCompare(b.purpose, "uk") || a.model.localeCompare(b.model, "uk", { numeric: true }));
const review = canonical.filter((item) => item.purpose === "Перевірити" || item.model === "Без коду" || item.sourceCodeMismatch);
const primaryModels = canonical.filter((item) => !review.includes(item));

const payload = {
  generatedAt: new Date().toISOString(),
  totals: { rawLinks: rows.length, primaryModels: primaryModels.length, duplicateLinks: duplicates.length, needsReview: review.length },
  primaryModels,
  duplicates,
  needsReview: review,
};

const lines = [
  "# Аудит Rodos Steel — без змін у каталозі",
  "",
  `- Посилань у sitemap: **${rows.length}**`,
  `- Основних моделей після звірки: **${primaryModels.length}**`,
  `- Повторних або складських сторінок: **${duplicates.length}**`,
  `- Потрібно перевірити вручну: **${review.length}**`,
  "",
  "## Основні моделі",
  "",
  "| Модель | Призначення | Джерело | Повтори |",
  "| --- | --- | --- | ---: |",
  ...primaryModels.map((item) => `| ${item.model} | ${item.purpose} | [${item.title}](${item.url}) | ${item.duplicates.length} |`),
  "",
  "## Повторні сторінки",
  "",
  "Ці посилання не слід створювати як окремі товари: вони повторюють модель або позначені виробником як складська позиція.",
  "",
  "| Основна модель | Повтор | Причина |",
  "| --- | --- | --- |",
  ...duplicates.map((item) => `| ${item.canonicalSlug} | [${item.title}](${item.url}) | ${item.isStockListing ? "В наявності" : "Дублікат виконання"} |`),
];

await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, "rodos-steel-catalog-audit.json"), JSON.stringify(payload, null, 2));
await writeFile(join(outputDir, "rodos-steel-catalog-audit.md"), lines.join("\n"));
console.log(`Готово: ${rows.length} посилань → ${primaryModels.length} основних моделей; повторів: ${duplicates.length}; перевірити: ${review.length}.`);
