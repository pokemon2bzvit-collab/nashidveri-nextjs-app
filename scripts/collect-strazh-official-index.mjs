import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const origin = "https://straj.ua";
const outputDir = join(process.cwd(), "supabase", "generated");
const seed = await readFile(join(process.cwd(), "supabase", "seed-products.sql"), "utf8");
const ourProducts = [...seed.matchAll(/\('([^']+)',\s*'entrance',\s*'Страж',\s*'([^']+)',\s*'([^']+)'/g)]
  .map((match) => ({ slug: match[1], collection: match[2], name: match[3] }));

function normalize(value = "") {
  return value
    .toLocaleLowerCase("uk-UA")
    .replace(/&(?:nbsp|amp);/giu, " ")
    .replace(/[«»"'()_.,/\\-]+/gu, " ")
    .replace(/\b(?:страж|straj|proof|roof|street|вхідні|двері|door)\b/giu, " ")
    .replace(/\s+/gu, " ")
    .trim();
}

function modelKey(value = "") {
  return normalize(value)
    .split(" ")
    .filter((token) => token && !/^\d+$/u.test(token))
    .join(" ");
}

async function fetchPage(page) {
  const url = page === 1 ? `${origin}/shop` : `${origin}/shop?page=${page}`;
  const response = await fetch(url, { headers: { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalogAudit/1.0)" } });
  if (!response.ok) throw new Error(`${url}: ${response.status}`);
  return { url, html: await response.text() };
}

const cards = new Map();
const errors = [];
for (let page = 1; page <= 51; page += 1) {
  try {
    const { html } = await fetchPage(page);
    for (const match of html.matchAll(/<a\b[^>]*href=["']([^"']*\/product\/[^"']+)["'][^>]*>([\s\S]*?)<\/a>/giu)) {
      const url = new URL(match[1].replace(/&amp;/gu, "&"), origin).href;
      const title = match[2].replace(/<[^>]+>/gu, " ").replace(/\s+/gu, " ").trim();
      if (!title) continue;
      cards.set(url, { url, title, pages: [...(cards.get(url)?.pages || []), page] });
    }
  } catch (error) {
    errors.push({ page, error: String(error) });
  }
  // A small interval respects the factory's server and avoids accidental bursts.
  await new Promise((resolve) => setTimeout(resolve, 180));
}

const official = [...cards.values()];
const uniqueTitles = new Map();
for (const card of official) {
  const key = modelKey(card.title);
  uniqueTitles.set(key, [...(uniqueTitles.get(key) || []), card]);
}
const matched = ourProducts.map((product) => {
  const productName = normalize(product.name);
  const productKey = modelKey(product.name);
  const productTokens = productName.split(" ").filter((token) => token.length > 2);
  const candidates = official.map((card) => {
    const cardName = normalize(card.title);
    const cardKey = modelKey(card.title);
    const hits = productTokens.filter((token) => cardName.includes(token)).length;
    return { ...card, hits, exact: cardKey === productKey };
  }).filter((card) => card.exact || card.hits >= Math.min(2, productTokens.length));
    
  candidates.sort((a, b) => Number(b.exact) - Number(a.exact) || b.hits - a.hits || a.title.localeCompare(b.title, "uk"));
  return { ...product, candidates: candidates.slice(0, 5) };
});

const payload = {
  generatedAt: new Date().toISOString(),
  totals: {
    officialCards: official.length,
    uniqueOfficialNames: uniqueTitles.size,
    ourModels: ourProducts.length,
    exactMatches: matched.filter((item) => item.candidates[0]?.exact).length,
    probableMatches: matched.filter((item) => !item.candidates[0]?.exact && item.candidates.length).length,
    noMatch: matched.filter((item) => !item.candidates.length).length,
    pageErrors: errors.length,
  },
  errors,
  official,
  duplicateOfficialNames: [...uniqueTitles.entries()]
    .filter(([, cardsForName]) => cardsForName.length > 1)
    .map(([name, cardsForName]) => ({ name, cards: cardsForName })),
  matched,
};

const lines = [
  "# Страж — звірка з офіційним каталогом",
  "",
  `- Офіційних карток знайдено: **${payload.totals.officialCards}**`,
  `- Унікальних назв у каталозі: **${payload.totals.uniqueOfficialNames}**`,
  `- Наших моделей: **${payload.totals.ourModels}**`,
  `- Точних збігів: **${payload.totals.exactMatches}**`,
  `- Імовірних збігів: **${payload.totals.probableMatches}**`,
  `- Без збігу: **${payload.totals.noMatch}**`,
  `- Помилок сканування: **${payload.totals.pageErrors}**`,
  "",
  "| Наша модель | Колекція | Найкраща офіційна картка | Статус |",
  "| --- | --- | --- | --- |",
  ...matched.map((item) => {
    const match = item.candidates[0];
    const status = match?.exact ? "Точний" : match ? "Перевірити" : "Не знайдено";
    return `| ${item.name} | ${item.collection} | ${match ? `[${match.title}](${match.url})` : "—"} | ${status} |`;
  }),
];

await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, "strazh-official-index.json"), JSON.stringify(payload, null, 2));
await writeFile(join(outputDir, "strazh-official-index.md"), lines.join("\n"));
console.log(`Готово: ${official.length} офіційних карток; точних: ${payload.totals.exactMatches}; імовірних: ${payload.totals.probableMatches}; без збігу: ${payload.totals.noMatch}.`);
