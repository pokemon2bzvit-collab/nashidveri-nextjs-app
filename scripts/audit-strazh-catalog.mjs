import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const root = process.cwd();
const outputDir = join(root, "supabase", "generated");
const source = await readFile(join(root, "supabase", "seed-products.sql"), "utf8");

// The seed keeps product records as a single VALUES list.  We intentionally
// inspect only the Страж rows here: this is a read-only audit, not a migration.
const rows = [...source.matchAll(/\('([^']+)',\s*'entrance',\s*'Страж',\s*'([^']+)',\s*'([^']+)'/g)].map((match) => ({
  slug: match[1],
  collection: match[2],
  name: match[3],
}));

function keyFor(name) {
  return name
    .toLocaleLowerCase("uk-UA")
    .replace(/^страж\s+/u, "")
    .replace(/\b(?:proof|straj|roof)\b/gu, "")
    .replace(/\b(?:prestige|standart|standard)\b/gu, "")
    .replace(/\(.*?\)/gu, "")
    .replace(/\b1200\b/gu, "")
    .replace(/[\s._-]+/gu, " ")
    .trim();
}

const grouped = new Map();
for (const row of rows) {
  const key = `${row.collection}::${keyFor(row.name)}`;
  grouped.set(key, [...(grouped.get(key) || []), row]);
}

const knownDuplicateGroups = [...grouped.values()].filter((group) => group.length > 1);
const likelyVariants = rows.filter((row) => /\b1200\b|prestige|standart|standard|berez|florence|party/iu.test(row.name));
const canonical = rows.filter((row) => !knownDuplicateGroups.some((group) => group.slice(1).some((item) => item.slug === row.slug)));

const payload = {
  generatedAt: new Date().toISOString(),
  totals: {
    records: rows.length,
    street: rows.filter((row) => row.collection === "Вулиця").length,
    apartment: rows.filter((row) => row.collection === "Квартира").length,
    clearDuplicateGroups: knownDuplicateGroups.length,
    duplicateRecordsBeyondCanonical: knownDuplicateGroups.reduce((total, group) => total + group.length - 1, 0),
    variantsOrReview: likelyVariants.length,
  },
  canonical,
  duplicateGroups: knownDuplicateGroups,
  variantsOrReview: likelyVariants,
};

const lines = [
  "# Аудит каталогу «Страж» — без змін у базі",
  "",
  `- Усього записів: **${payload.totals.records}**`,
  `- Вулиця: **${payload.totals.street}**`,
  `- Квартира: **${payload.totals.apartment}**`,
  `- Явних груп-дублів: **${payload.totals.clearDuplicateGroups}**`,
  `- Повторних записів понад основні: **${payload.totals.duplicateRecordsBeyondCanonical}**`,
  `- Окремо звірити як виконання/складські варіанти: **${payload.totals.variantsOrReview}**`,
  "",
  "## Явні дублікати",
  "",
  "Ці записи мають одну основу моделі. Нічого не слід прибирати автоматично: варіант може відрізнятися комплектацією або шириною.",
  "",
  "| Колекція | Записи для звірки |",
  "| --- | --- |",
  ...knownDuplicateGroups.map((group) => `| ${group[0].collection} | ${group.map((row) => `\`${row.slug}\` — ${row.name}`).join("<br>")} |`),
  "",
  "## Виконання, які не варто вважати дублями без перевірки",
  "",
  "| Slug | Модель | Колекція | Причина |",
  "| --- | --- | --- | --- |",
  ...likelyVariants.map((row) => `| \`${row.slug}\` | ${row.name} | ${row.collection} | Може відрізнятися шириною, серією або складською комплектацією |`),
  "",
  "## Рекомендований порядок роботи",
  "",
  "1. Спочатку підчистити назви й окремо підтвердити явні дублікати.",
  "2. Потім брати офіційні картки Стража для фото, характеристик та декорів невеликими пакетами.",
  "3. Не переносити списки декорів серії на всі моделі: вони мають показуватися лише там, де виробник підтверджує конкретне виконання.",
];

await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, "strazh-catalog-audit.json"), JSON.stringify(payload, null, 2));
await writeFile(join(outputDir, "strazh-catalog-audit.md"), lines.join("\n"));
console.log(`Готово: ${rows.length} записів; явних груп-дублів: ${knownDuplicateGroups.length}; на ручну звірку: ${likelyVariants.length}.`);
