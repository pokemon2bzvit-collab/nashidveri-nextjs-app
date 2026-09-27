/**
 * Darumi official catalog -> a reviewable Supabase SQL package.
 *
 * Usage:
 *   node scripts/collect-darumi-official.mjs --collect --write-sql
 *
 * The package imports only official Darumi card data. Products stay hidden
 * (`is_available = false`) until they are reviewed in the admin panel.
 */
import { mkdir, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const delayMs = Number(process.argv.find((value) => value.startsWith("--delay="))?.split("=")[1] || "650");
const maxPages = Number(process.argv.find((value) => value.startsWith("--pages="))?.split("=")[1] || "30");
const headers = {
  "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0; +https://nashidveri-uzhhorod.com.ua)",
  "Accept-Language": "uk-UA,uk;q=0.9",
};
const catalogUrl = "https://darumi.in.ua/dveri/";

function pause() { return new Promise((resolve) => setTimeout(resolve, delayMs)); }
function sql(value) { return `'${String(value ?? "").replaceAll("'", "''")}'`; }
function decode(value = "") {
  return value.replace(/&nbsp;/giu, " ").replace(/&amp;/giu, "&").replace(/&quot;/giu, '"').replace(/&reg;/giu, "®").replace(/&#(?:039|39);/giu, "'").replace(/&lt;/giu, "<").replace(/&gt;/giu, ">");
}
function text(value = "") {
  return decode(value)
    .replace(/<script[\s\S]*?<\/script>/giu, " ")
    .replace(/<style[\s\S]*?<\/style>/giu, " ")
    .replace(/<\/?(?:br|p|div|li|h[1-6]|tr|td|th|section)[^>]*>/giu, "\n")
    .replace(/<[^>]+>/gu, " ")
    .replace(/\r/g, "")
    .replace(/[ \t]+/g, " ")
    .replace(/\n\s*\n+/g, "\n")
    .trim();
}
function hash(value) {
  let result = 2166136261;
  for (let index = 0; index < value.length; index += 1) result = Math.imul(result ^ value.charCodeAt(index), 16777619);
  return (result >>> 0).toString(36);
}
function productLinks(html) {
  const links = new Map();
  for (const match of html.matchAll(/<a[^>]+href=["']([^"']+)["'][^>]*>([\s\S]*?)<\/a>/giu)) {
    // On the first catalog page the name is link text; the AJAX "show more"
    // response uses an image-only link, where the product name is in alt/title.
    const title = text(match[2]) || decode(match[2].match(/<(?:img)[^>]+(?:alt|title)=["']([^"']+)["']/iu)?.[1] || "");
    let url;
    try { url = new URL(decode(match[1]), catalogUrl); } catch { continue; }
    if (url.hostname !== "darumi.in.ua" || !url.pathname.startsWith("/dveri/") || url.pathname === "/dveri/" || !/(?:^двері\s+дарумі|дарумі\s+)/iu.test(title)) continue;
    links.set(url.toString(), { url: url.toString(), title });
  }
  return [...links.values()];
}
function metaImage(html, url) {
  const match = html.match(/<meta[^>]+(?:property|name)=["'](?:og:image|twitter:image)["'][^>]+content=["']([^"']+)["']/iu)
    || html.match(/<meta[^>]+content=["']([^"']+)["'][^>]+(?:property|name)=["'](?:og:image|twitter:image)["']/iu);
  if (!match?.[1]) return null;
  try { return new URL(decode(match[1]), url).toString(); } catch { return null; }
}
function factsFrom(html) {
  const lines = text(html).split("\n").map((line) => line.trim()).filter(Boolean);
  const labels = ["Фабрика", "Модель", "Колір", "Фактура", "Скло", "Колекція", "Вид", "Матеріал", "Покриття", "Інші кольори", "Інші варіанти скла", "Товщина полотна", "Стиль", "Розміри", "Термін виготовлення", "Виробник"];
  const facts = [];
  for (let index = 0; index < lines.length - 1; index += 1) {
    const label = labels.find((item) => lines[index].toLocaleLowerCase("uk-UA") === item.toLocaleLowerCase("uk-UA"));
    const value = lines[index + 1];
    if (label && value && value.length < 600 && !labels.includes(value)) facts.push({ label, value });
  }
  return [...new Map(facts.map((fact) => [fact.label, fact])).values()];
}
function fact(record, label) { return record.facts.find((item) => item.label === label)?.value || ""; }
function modelName(record) {
  const official = fact(record, "Модель").replace(/\s*\([^)]*\)\s*/gu, " ").trim();
  if (official) return official;
  return record.title.replace(/^двері\s+дарумі\s*/iu, "").replace(/\s+(?:білий|сірий|антрацит|дуб)\b.*$/iu, "").trim();
}
function collectionName(record) { return fact(record, "Колекція") || `Darumi ${modelName(record)}`; }
function description(record, name) {
  const coating = fact(record, "Покриття");
  const thickness = fact(record, "Товщина полотна");
  const dimensions = fact(record, "Розміри");
  const clauses = [coating && `покриття ${coating}`, thickness && `полотно ${thickness}`, dimensions && `розміри ${dimensions}`].filter(Boolean);
  return `Darumi ${name} — міжкімнатні двері фабрики Дарумі (Корюківка).${clauses.length ? ` Основні параметри: ${clauses.join(", ")}.` : ""} Доступні заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.`;
}
function makeSql(records) {
  const grouped = new Map();
  for (const record of records) {
    const name = modelName(record);
    if (!name) continue;
    const list = grouped.get(name) || [];
    list.push(record);
    grouped.set(name, list);
  }
  const lines = [
    "-- Darumi: офіційні картки виробника. Створено автоматично; перед публікацією перевірте чернетки в адмінці.",
    "-- Фото залишаються зовнішніми офіційними URL; товари приховані від покупців.",
    "begin;",
    "insert into public.catalog_brands (name,description,is_active,sort_order) values ('Darumi','Міжкімнатні двері Darumi (Дарумі), фабрика в Корюківці.',true,95) on conflict (name) do update set description=excluded.description,is_active=true,updated_at=now();",
  ];
  const collections = new Set([...grouped.values()].flatMap((variants) => variants.map(collectionName)));
  for (const collection of [...collections].sort((a, b) => a.localeCompare(b, "uk"))) {
    lines.push(`insert into public.catalog_collections (brand_id,name,category,description,is_active,sort_order) select id,${sql(collection)},'interior',${sql(`Міжкімнатні двері Darumi — колекція ${collection.replace(/^Darumi\s*/iu, "")}.`)},true,95 from public.catalog_brands where name='Darumi' on conflict (brand_id,name,category) do update set description=excluded.description,is_active=true,updated_at=now();`);
  }
  for (const [name, variants] of [...grouped.entries()].sort(([a], [b]) => a.localeCompare(b, "uk"))) {
    const base = [...variants].sort((a, b) => (!fact(a, "Скло") ? -1 : 1) - (!fact(b, "Скло") ? -1 : 1))[0];
    const slug = `darumi-${hash(name.toLocaleLowerCase("uk-UA"))}`;
    const collection = collectionName(base);
    const material = fact(base, "Матеріал") || "Міжкімнатні";
    const style = fact(base, "Стиль") || "Сучасний";
    const colors = [...new Set(variants.map((record) => fact(record, "Колір")).filter(Boolean))];
    lines.push(`insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values (${sql(slug)},'interior','Darumi',${sql(collection)},${sql(`Darumi ${name}`)},${sql(material)},${sql(style)},${sql(colors.join(" · ") || "Варіанти декорів")},'Ціна за запитом',${sql(description(base, name))},${sql(JSON.stringify(["Фабрика Darumi", `Колекція ${collection}`, "Варіанти декорів і скла"]))}::jsonb,${sql(base.image || "https://darumi.in.ua/img/logo_white.svg")},99999,false) on conflict (slug) do update set collection=excluded.collection,name=excluded.name,material=excluded.material,style=excluded.style,color=excluded.color,description=excluded.description,image_path=excluded.image_path,updated_at=now();`);
    const specLabels = ["Фабрика", "Покриття", "Товщина полотна", "Стиль", "Розміри", "Термін виготовлення", "Виробник"];
    let specOrder = 100;
    for (const label of specLabels) {
      const value = fact(base, label);
      if (!value) continue;
      lines.push(`insert into public.product_specs (product_slug,label,value,sort_order,is_active) values (${sql(slug)},${sql(label)},${sql(value)},${specOrder},true) on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;`);
      specOrder += 10;
    }
    const options = new Map();
    for (const variant of variants) {
      const color = fact(variant, "Колір");
      const glass = fact(variant, "Скло");
      if (color) options.set(`color:${color}`, { group: "color", label: "Колір", value: color });
      if (glass) options.set(`glass:${glass}`, { group: "glass", label: "Скло", value: glass });
    }
    let optionOrder = 10;
    for (const option of options.values()) {
      lines.push(`insert into public.product_options (product_slug,option_group,group_label,label,sort_order,is_active) values (${sql(slug)},${sql(option.group)},${sql(option.label)},${sql(option.value)},${optionOrder},true) on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;`);
      optionOrder += 10;
    }
    for (let index = 0; index < variants.length; index += 1) {
      const variant = variants[index];
      const selections = Object.fromEntries([["color", fact(variant, "Колір")], ["glass", fact(variant, "Скло")]].filter(([, value]) => value));
      if (variant.image && Object.keys(selections).length) lines.push(`insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values (${sql(slug)},${sql(JSON.stringify(selections))}::jsonb,${sql(variant.image)},${index + 1},true) on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;`);
      lines.push(`delete from public.product_sources where product_slug=${sql(slug)} and source_url=${sql(variant.url)};`);
      lines.push(`insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values (${sql(slug)},'Darumi',${sql(variant.url)},${sql(variant.title)},'verified',now(),'Офіційна картка Darumi: фото, параметри та варіант моделі.');`);
    }
    if (base.image) lines.push(`insert into public.product_media (product_slug,kind,label,image_path,sort_order) select ${sql(slug)},'main','Головне фото',${sql(base.image)},0 where not exists (select 1 from public.product_media where product_slug=${sql(slug)} and kind='main' and image_path=${sql(base.image)});`);
  }
  lines.push("commit;", `-- Підсумок: ${grouped.size} моделей Darumi, ${records.length} офіційних виконань.`);
  return { sql: lines.join("\n"), groups: grouped.size };
}

await mkdir(outputDir, { recursive: true });
const items = new Map();
for (let page = 1; page <= maxPages; page += 1) {
  // The visible "show more" button uses this endpoint rather than a URL query.
  // Fetching ?page=2 returns page one again, so use the site's own request format.
  const url = page === 1 ? catalogUrl : "https://darumi.in.ua/ajax/products.php";
  const request = page === 1
    ? { headers, signal: AbortSignal.timeout(25_000) }
    : {
      method: "POST",
      headers: { ...headers, "X-Requested-With": "XMLHttpRequest" },
      body: new URLSearchParams({ page: String(page), tovar_papka: "dveri" }),
      signal: AbortSignal.timeout(25_000),
    };
  const response = await fetch(url, request);
  if (!response.ok) throw new Error(`Darumi returned ${response.status} for ${url}`);
  const pageItems = productLinks(await response.text());
  for (const item of pageItems) items.set(item.url, item);
  console.log(`Catalog page ${page}: ${pageItems.length} cards (${items.size} unique)`);
  if (!pageItems.length && page > 2) break;
  await pause();
}
const catalog = [...items.values()];
await writeFile(join(outputDir, "darumi-official-catalog.json"), JSON.stringify({ generatedAt: new Date().toISOString(), total: catalog.length, items: catalog }, null, 2));
console.log(`Found ${catalog.length} Darumi cards. Collecting official details…`);

const records = [];
for (let index = 0; index < catalog.length; index += 1) {
  const item = catalog[index];
  try {
    const response = await fetch(item.url, { headers, signal: AbortSignal.timeout(25_000) });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const html = await response.text();
    const title = text(html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/iu)?.[1] || item.title);
    const facts = factsFrom(html);
    if (!facts.length) throw new Error("характеристики не знайдено");
    records.push({ url: item.url, title, facts, image: metaImage(html, item.url) });
    console.log(`[${index + 1}/${catalog.length}] ${title}: ${facts.length} параметрів`);
  } catch (error) {
    console.log(`[${index + 1}/${catalog.length}] пропущено ${item.title}: ${error instanceof Error ? error.message : "невідома помилка"}`);
  }
  if ((index + 1) % 10 === 0) await writeFile(join(outputDir, "darumi-official-data.json"), JSON.stringify({ generatedAt: new Date().toISOString(), total: catalog.length, collected: records.length, records }, null, 2));
  await pause();
}
await writeFile(join(outputDir, "darumi-official-data.json"), JSON.stringify({ generatedAt: new Date().toISOString(), total: catalog.length, collected: records.length, records }, null, 2));
const result = makeSql(records);
await writeFile(join(outputDir, "darumi-official-import.sql"), result.sql);
console.log(`Done: ${records.length} cards -> ${result.groups} product models. SQL: supabase/generated/darumi-official-import.sql`);
