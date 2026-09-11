import { mkdir, readFile, writeFile } from "node:fs/promises";
import { existsSync } from "node:fs";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const delayMs = Number(process.argv.find((value) => value.startsWith("--delay="))?.split("=")[1] || "1400");
const collect = process.argv.includes("--collect");
const headers = {
  "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0; +https://nashidveri-uzhhorod.com.ua)",
  "Accept-Language": "uk-UA,uk;q=0.9",
};

const cyrillic = {
  а: "a", б: "b", в: "v", г: "h", ґ: "g", д: "d", е: "e", ё: "e", є: "ye", ж: "zh", з: "z", и: "y", і: "i", ї: "yi", й: "y", к: "k", л: "l", м: "m", н: "n", о: "o", п: "p", р: "r", с: "s", т: "t", у: "u", ф: "f", х: "kh", ц: "ts", ч: "ch", ш: "sh", щ: "shch", ь: "", ы: "y", ъ: "", э: "e", ю: "yu", я: "ya",
};
const stopWords = new Set(["https", "http", "www", "rodos", "steel", "dveri", "vkhidni", "vhodnye", "mezhkomnatnye", "mizhkimnatni", "door", "doors", "kupit", "katalog", "model", "modeli", "ua", "uk"]);

function decode(value = "") {
  return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#039;|&#39;/gi, "'").replace(/&lt;/gi, "<").replace(/&gt;/gi, ">");
}
function text(value = "") {
  return decode(value).replace(/<script[\s\S]*?<\/script>/gi, " ").replace(/<style[\s\S]*?<\/style>/gi, " ").replace(/<(?:br|\/p|\/div|\/li|\/h[1-6]|\/tr|\/td)[^>]*>/gi, " ").replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim();
}
function normalize(value = "") {
  return text(value).toLocaleLowerCase("uk-UA").split("").map((character) => cyrillic[character] ?? character).join("").normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/[^a-z0-9]+/g, " ").trim();
}
function tokens(value) {
  return new Set(normalize(value).split(" ").filter((token) => token.length > 1 && !stopWords.has(token)));
}
function codes(value) {
  return new Set(Array.from(normalize(value).matchAll(/\b(?:a|f|prz|m|c|s|d|p|t)[ -]?\d{1,4}[a-z]?\b/g), (match) => match[0].replace(/[ -]/g, "")));
}
function hash(value) {
  let result = 5381;
  for (const character of value) result = (result * 33) ^ character.charCodeAt(0);
  return (result >>> 0).toString(36);
}
function sql(value) { return "'" + String(value ?? "").replace(/'/g, "''") + "'"; }
function translate(value) {
  return text(value)
    .replace(/^Глубина рами$/iu, "Глибина коробки")
    .replace(/^Коллекція$/iu, "Колекція")
    .replace(/^Матеріал фасону$/iu, "Матеріал накладок")
    .replace(/^Тип фасону$/iu, "Тип накладок")
    .replace(/^Колір фасону$/iu, "Колір накладок")
    .replace(/^Стиль МДФ накладок$/iu, "Стиль МДФ-накладок")
    .replace(/^Контур примикання$/iu, "Контури ущільнення")
    .replace(/^В квартиру$/iu, "Для квартири")
    .replace(/^На заказ$/iu, "На замовлення")
    .replace(/^Левое, Правое$/iu, "Ліве, праве")
    .trim();
}
function specificationFacts(html) {
  const start = html.search(/id=["']tab-specification["']/iu);
  const end = start >= 0 ? html.slice(start + 1).search(/id=["']tab-(?:review|description)["']/iu) : -1;
  if (start < 0) return [];
  const section = end < 0 ? html.slice(start) : html.slice(start, start + end + 1);
  const result = [];
  for (const row of section.matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)) {
    const cells = Array.from(row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi), (cell) => translate(cell[1]));
    if (cells[0] && cells[1] && cells[0].length < 80 && cells[1].length < 500) result.push({ label: cells[0].replace(/:$/u, ""), value: cells[1] });
  }
  return Array.from(new Map(result.map((fact) => [fact.label.toLocaleLowerCase("uk-UA"), fact])).values()).slice(0, 30);
}
function description(title, facts, entrance) {
  const byLabel = (label) => facts.find((fact) => fact.label === label)?.value;
  const purpose = byLabel("Призначення")?.toLocaleLowerCase("uk-UA");
  const location = purpose?.includes("квартир") ? "для квартири" : purpose?.includes("будин") || purpose?.includes("вулиц") ? "для приватного будинку" : entrance ? "для квартири або будинку" : "для вашого інтер’єру";
  const details = [["Товщина полотна", byLabel("Товщина полотна")], ["Товщина металу", byLabel("Товщина металу")], ["Глибина коробки", byLabel("Глибина коробки")], ["Розмір", byLabel("Розмір")]].filter(([, value]) => value).slice(0, 3).map(([label, value]) => `${label.toLocaleLowerCase("uk-UA")}: ${value}`);
  const ukrainianTitle = title
    .replace(/^Входные двери/iu, "Вхідні двері")
    .replace(/^Входная дверь/iu, "Вхідні двері")
    .replace(/^Межкомнатные двери/iu, "Міжкімнатні двері")
    .replace(/^Межкомнатная дверь/iu, "Міжкімнатні двері");
  return `${ukrainianTitle} — ${entrance ? "вхідні" : "міжкімнатні"} двері ${location}${details.length ? `. Основні параметри: ${details.join("; ")}` : ""}. Комплектацію, доступні покриття та актуальну ціну уточнюйте у менеджера.`;
}
function rodosItems(xml) {
  const ignored = /(?:furnitur|фурнітур|plintus|плінтус|ustanov|монтаж|dostav|достав|contact|контакт|news|новин|akci|акці|review|відгук|faq|vopros|питан|руч(?:к|ек)|ruchk|handle|замок|lock|петл|hinge|стопор|упор)/iu;
  const seen = new Set();
  return Array.from(xml.matchAll(/<url>([\s\S]*?)<\/url>/gi)).flatMap((match) => {
    const block = match[1];
    const url = decode(block.match(/<loc>([\s\S]*?)<\/loc>/i)?.[1] || "").trim();
    const title = text(block.match(/<image:title>([\s\S]*?)<\/image:title>/i)?.[1] || block.match(/<image:caption>([\s\S]*?)<\/image:caption>/i)?.[1] || "");
    const source = `${url} ${title}`;
    if (!url || !title || seen.has(url) || ignored.test(source) || !/(?:двер|dver|door)/iu.test(source)) return [];
    seen.add(url);
    return [{ url, title, slug: `rodos-official-${hash(url)}`, entrance: /вхідн|vhodn|входn|rodos steel/iu.test(source) }];
  });
}
function candidateScore(product, candidate) {
  const productCodes = codes(`${product.title} ${product.url}`);
  const candidateCodes = codes(candidate.url);
  const codeMatches = [...productCodes].filter((code) => candidateCodes.has(code)).length;
  const productTokens = tokens(`${product.title} ${product.url}`);
  const candidateTokens = tokens(candidate.url);
  const shared = [...productTokens].filter((token) => candidateTokens.has(token));
  return { score: codeMatches * 100 + shared.length * 10, codeMatches, shared };
}
function matchProducts(products, candidates) {
  return products.map((product) => {
    const titleCodes = codes(product.title);
    const urlCodes = codes(product.url);
    // A conflicting sitemap caption (for example F102 at the official F100 URL)
    // is not safe enough for an automatic technical-data import.
    if (titleCodes.size && urlCodes.size && ![...titleCodes].some((code) => urlCodes.has(code))) {
      return { ...product, conflict: "Код у назві sitemap не збігається з кодом офіційного URL." };
    }
    const ranked = candidates.map((candidate) => ({ candidate, ...candidateScore(product, candidate) })).filter((item) => item.score > 0).sort((a, b) => b.score - a.score);
    const top = ranked[0];
    const next = ranked[1];
    const accepted = Boolean(top && ((top.codeMatches === 1 && (!next || next.codeMatches === 0 || top.score > next.score)) || (top.codeMatches === 0 && top.shared.length >= 3 && (!next || top.score >= next.score + 10))));
    return { ...product, ...(accepted ? { marketUrl: top.candidate.url, match: { score: top.score, codes: top.codeMatches, shared: top.shared } } : { candidates: ranked.slice(0, 3).map(({ candidate, score, codeMatches, shared }) => ({ url: candidate.url, score, codeMatches, shared })) }) };
  });
}
function makeSql(records) {
  const lines = ["-- Rodos / Rodos Steel: перевірені технічні дані з карток Market Dveri.", "-- Не містить цін, фото, відгуків або рекламного тексту. Згенеровано: " + new Date().toISOString(), "begin;"];
  for (const record of records) {
    if (!record.facts?.length) continue;
    lines.push(`update public.products set description = ${sql(record.description)} where slug = ${sql(record.slug)};`);
    for (let index = 0; index < record.facts.length; index += 1) {
      const fact = record.facts[index];
      lines.push(`insert into public.product_specs (product_slug,label,value,sort_order,is_active) values (${sql(record.slug)},${sql(fact.label)},${sql(fact.value)},${100 + index * 10},true) on conflict (product_slug,label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;`);
    }
    lines.push(`delete from public.product_sources where product_slug = ${sql(record.slug)} and source_url = ${sql(record.marketUrl)};`);
    lines.push(`insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values (${sql(record.slug)},'Market Dveri',${sql(record.marketUrl)},${sql(record.marketTitle)},'verified',now(),'Технічні дані звірено з українською карткою товару Market Dveri.');`);
  }
  lines.push("commit;");
  return lines.join("\n");
}
function pause() { return new Promise((resolve) => setTimeout(resolve, delayMs)); }
async function readJson(path, fallback) { return existsSync(path) ? JSON.parse(await readFile(path, "utf8")) : fallback; }

await mkdir(outputDir, { recursive: true });
const [rodosResponse, marketResponse] = await Promise.all([
  fetch("https://rodos.ua/index.php?route=extension/feed/google_sitemap", { headers, signal: AbortSignal.timeout(30_000) }),
  fetch("https://market-dveri.ua/uk/fx-sitemap-uk-ua/", { headers, signal: AbortSignal.timeout(30_000) }),
]);
if (!rodosResponse.ok) throw new Error(`Rodos sitemap returned ${rodosResponse.status}`);
if (!marketResponse.ok) throw new Error(`Market Dveri sitemap returned ${marketResponse.status}`);
const products = rodosItems(await rodosResponse.text());
const marketUrls = Array.from((await marketResponse.text()).matchAll(/<loc>([^<]+)<\/loc>/gi), (match) => decode(match[1]).trim()).filter((url) => /\/uk\//u.test(url) && /rodos/iu.test(url));
const matches = matchProducts(products, marketUrls.map((url) => ({ url })));
const matched = matches.filter((item) => item.marketUrl);
const unmatched = matches.filter((item) => !item.marketUrl);
await writeFile(join(outputDir, "rodos-market-match-report.json"), JSON.stringify({ generatedAt: new Date().toISOString(), total: products.length, matched: matched.length, unmatched: unmatched.length, matched, unmatched }, null, 2));
console.log(`Found ${products.length} Rodos models. Safely matched ${matched.length} Market Dveri cards; ${unmatched.length} require manual verification.`);
if (!collect) {
  console.log("Preview saved. Run again with --collect only after checking the match report.");
  process.exit(0);
}

const dataPath = join(outputDir, "rodos-market-enrichment-data.json");
const sqlPath = join(outputDir, "rodos-market-enrichment.sql");
const records = await readJson(dataPath, []);
for (const record of records) record.description = description(record.title, record.facts, record.entrance);
const completed = new Set(records.map((record) => record.slug));
const pending = matched.filter((item) => !completed.has(item.slug));
console.log(`${records.length} records already saved; ${pending.length} queued.`);
for (let index = 0; index < pending.length; index += 1) {
  const item = pending[index];
  try {
    const response = await fetch(item.marketUrl, { headers, signal: AbortSignal.timeout(20_000) });
    if (!response.ok) { console.log(`[${index + 1}/${matched.length}] ${response.status}: ${item.marketUrl}`); continue; }
    const html = await response.text();
    const marketTitle = text(html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i)?.[1] || "");
    const facts = specificationFacts(html);
    if (!marketTitle || !facts.length) { console.log(`[${index + 1}/${matched.length}] no specification: ${item.title}`); continue; }
    records.push({ ...item, marketTitle, facts, description: description(item.title, facts, item.entrance) });
    console.log(`[${index + 1}/${pending.length}] ${item.title}: ${facts.length} facts`);
    await writeFile(dataPath, JSON.stringify(records, null, 2));
    await writeFile(sqlPath, makeSql(records));
  } catch (error) { console.log(`[${index + 1}/${pending.length}] failed ${item.title}: ${error instanceof Error ? error.message : "unknown error"}`); }
  await pause();
}
await writeFile(dataPath, JSON.stringify(records, null, 2));
await writeFile(sqlPath, makeSql(records));
console.log(`Done. ${records.length} verified records. SQL: ${sqlPath}`);
