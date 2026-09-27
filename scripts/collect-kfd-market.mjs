import { existsSync } from "node:fs";
import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const shouldCollect = process.argv.includes("--collect");
const shouldWriteSql = process.argv.includes("--write-sql");
const shouldRefreshImages = process.argv.includes("--refresh-images");
const delayMs = Number(process.argv.find((value) => value.startsWith("--delay="))?.split("=")[1] || "1100");
const start = Number(process.argv.find((value) => value.startsWith("--start="))?.split("=")[1] || "0");
const end = Number(process.argv.find((value) => value.startsWith("--end="))?.split("=")[1] || "9999");
const headers = {
  "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0; +https://nashidveri-uzhhorod.com.ua)",
  "Accept-Language": "uk-UA,uk;q=0.9",
};
const catalogUrl = "https://market-dveri.ua/uk/kfd/";

function decode(value = "") {
  return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#039;|&#39;/gi, "'").replace(/&lt;/gi, "<").replace(/&gt;/gi, ">");
}
function clean(value = "") {
  return decode(value).replace(/<script[\s\S]*?<\/script>/gi, " ").replace(/<style[\s\S]*?<\/style>/gi, " ").replace(/<(?:br|\/p|\/div|\/li|\/h[1-6]|\/tr|\/td)[^>]*>/gi, " ").replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim();
}
function sql(value) { return "'" + String(value ?? "").replace(/'/g, "''") + "'"; }
function hash(value) {
  let result = 2166136261;
  for (let index = 0; index < value.length; index += 1) result = Math.imul(result ^ value.charCodeAt(index), 16777619);
  return (result >>> 0).toString(36);
}
function imageFrom(html, url) {
  const productImage = [...html.matchAll(/(?:https?:)?\/\/[^"'\s<]*?\/image\/catalog\/[^"'\s<]+|\/image\/catalog\/[^"'\s<]+/gi)]
    .map((match) => match[0])
    .find((value) => /\.(?:jpe?g|png|webp)(?:\?|$)/iu.test(value) && !/\/(?:logo|logotip|ico|stranici|our_works)\//iu.test(value));
  const meta = html.match(/<meta[^>]+(?:property|name)=["'](?:og:image|twitter:image)["'][^>]+content=["']([^"']+)["']/i)
    || html.match(/<meta[^>]+content=["']([^"']+)["'][^>]+(?:property|name)=["'](?:og:image|twitter:image)["']/i);
  const raw = productImage || meta?.[1] || html.match(/<img[^>]+(?:data-src|data-original|src)=["']([^"']+)["'][^>]*>/i)?.[1];
  if (!raw) return null;
  try { return new URL(decode(raw), url).toString(); } catch { return null; }
}
function factsFrom(html) {
  const start = html.search(/id=["']tab-specification["']/iu);
  const end = start >= 0 ? html.slice(start + 1).search(/id=["']tab-(?:review|description)["']/iu) : -1;
  if (start < 0) return [];
  const section = end < 0 ? html.slice(start) : html.slice(start, start + end + 1);
  const rows = [];
  for (const row of section.matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)) {
    const cells = Array.from(row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi), (cell) => clean(cell[1]));
    if (cells[0] && cells[1] && cells[0].length < 90 && cells[1].length < 500) rows.push({ label: cells[0].replace(/:$/u, ""), value: cells[1] });
  }
  return Array.from(new Map(rows.map((fact) => [fact.label.toLocaleLowerCase("uk-UA"), fact])).values()).slice(0, 30);
}
function productName(title) {
  const result = title.replace(/^міжкімнатні\s+двері\s*/iu, "").replace(/^двері\s*/iu, "").trim();
  return /^kfd\b/iu.test(result) ? result : `KFD ${result}`;
}
function description(title, facts) {
  const value = (expression) => facts.find((fact) => expression.test(fact.label))?.value;
  const finish = value(/матеріал покриття/iu);
  const core = value(/матеріал наповнення/iu);
  const size = value(/ширина полотна|розмір/iu);
  const details = [finish ? `покриття: ${finish}` : "", core ? `наповнення: ${core}` : "", size ? `розміри: ${size}` : ""].filter(Boolean);
  return `${productName(title)} — міжкімнатні двері фабрики KFD для вашого інтер’єру.${details.length ? ` Основні параметри: ${details.join("; ")}.` : ""} Доступні виконання та актуальну ціну уточнюйте у менеджера.`;
}
function productLinks(html) {
  const items = new Map();
  for (const match of html.matchAll(/<a[^>]+href=["']([^"']+)["'][^>]*>([\s\S]*?)<\/a>/gi)) {
    const url = new URL(match[1], catalogUrl);
    const title = clean(match[2]);
    if (url.hostname !== "market-dveri.ua" || !url.pathname.startsWith("/uk/") || url.pathname === "/uk/kfd/" || !/двері\s+kfd|kfd\s+\S/iu.test(title)) continue;
    items.set(url.toString(), { url: url.toString(), title });
  }
  return [...items.values()];
}
function makeSql(records) {
  const lines = [
    "-- KFD: моделі, фото, технічні характеристики й джерела з українських карток Market Dveri.",
    "-- Моделі створюються прихованими. Ціни, відгуки та рекламні тексти не імпортуються.",
    "begin;",
  ];
  for (const record of records) {
    lines.push(`insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values (${sql(record.slug)},'interior','KFD','KFD',${sql(record.name)},${sql(record.material)},'Колекція KFD','Варіанти покриттів','Ціна за запитом',${sql(record.description)},${sql(JSON.stringify(['Фабрика KFD','Колекція KFD']))}::jsonb,${sql(record.image)},99999,false) on conflict (slug) do update set name=excluded.name,material=excluded.material,description=excluded.description,image_path=excluded.image_path;`);
    for (let index = 0; index < record.facts.length; index += 1) {
      const fact = record.facts[index];
      lines.push(`insert into public.product_specs (product_slug,label,value,sort_order,is_active) values (${sql(record.slug)},${sql(fact.label)},${sql(fact.value)},${100 + index * 10},true) on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;`);
    }
    lines.push(`delete from public.product_sources where product_slug=${sql(record.slug)} and source_url=${sql(record.url)};`);
    lines.push(`insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values (${sql(record.slug)},'Market Dveri',${sql(record.url)},${sql(record.title)},'verified',now(),'Імпортовано з української картки Market Dveri: опис, характеристики та головне фото.');`);
    if (record.image) lines.push(`insert into public.product_media (product_slug,kind,label,image_path,sort_order) select ${sql(record.slug)},'main','Головне фото',${sql(record.image)},0 where not exists (select 1 from public.product_media where product_slug=${sql(record.slug)} and kind='main' and image_path=${sql(record.image)});`);
  }
  lines.push("commit;");
  return lines.join("\n");
}
function groupKey(name) {
  return name
    .replace(/^KFD\s+в зборі з коробкою і фурнітурою\s+/iu, "KFD ")
    .replace(/\s+Чорне скло/giu, "")
    .replace(/\s+NanoFlex/giu, "")
    .replace(/\s+ПГ(?=\s|$)/giu, "")
    .replace(/\s+(?:Ламінатин|ПВХ плівка)/giu, "")
    .replace(/\s+/g, " ").trim();
}
function fact(record, label) { return record.facts.find((item) => item.label.toLocaleLowerCase("uk-UA") === label.toLocaleLowerCase("uk-UA"))?.value || ""; }
function groupedSql(records) {
  const groups = new Map();
  for (const record of records) {
    // "В зборі з коробкою і фурнітурою" is a ready-made bundle, not a separate door model.
    // It would otherwise duplicate the same leaf in the public catalog.
    if (/^KFD\s+в зборі з коробкою і фурнітурою(?=\s|$)/iu.test(record.name)) continue;
    const key = groupKey(record.name);
    const list = groups.get(key) || [];
    list.push(record);
    groups.set(key, list);
  }
  const lines = [
    "-- KFD: моделі об’єднані за полотном; покриття, скло й колір доступні як варіанти з точними фото.",
    "-- Моделі створюються прихованими. Ціни, відгуки та рекламні тексти не імпортуються.",
    "begin;",
  ];
  for (const [name, variants] of [...groups.entries()].sort(([left], [right]) => left.localeCompare(right, "uk"))) {
    const base = [...variants].sort((left, right) => {
      const score = (item) => (/(?:в зборі|чорне скло|nanoflex|пг(?=\s|$))/iu.test(item.name) ? 1 : 0);
      return score(left) - score(right) || left.name.length - right.name.length;
    })[0];
    const slug = `kfd-${hash(name)}`;
    const specifications = base.facts.filter((item) => !/^(?:Матеріал покриття|Колір|Наявність скла)$/iu.test(item.label));
    lines.push(`insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values (${sql(slug)},'interior','KFD','KFD',${sql(name)},${sql(fact(base, "Матеріал покриття") || "Міжкімнатні" )},'Колекція KFD','Варіанти покриттів і скла','Ціна за запитом',${sql(base.description)},${sql(JSON.stringify(['Фабрика KFD','Колекція KFD']))}::jsonb,${sql(base.image)},99999,false) on conflict (slug) do update set name=excluded.name,material=excluded.material,description=excluded.description,image_path=excluded.image_path;`);
    for (let index = 0; index < specifications.length; index += 1) {
      const item = specifications[index];
      lines.push(`insert into public.product_specs (product_slug,label,value,sort_order,is_active) values (${sql(slug)},${sql(item.label)},${sql(item.value)},${100 + index * 10},true) on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;`);
    }
    const options = new Map();
    for (const variant of variants) {
      const finish = fact(variant, "Матеріал покриття");
      const glass = fact(variant, "Наявність скла");
      const color = fact(variant, "Колір");
      if (finish) options.set(`finish:${finish}`, { group: "finish", label: "Покриття", value: finish });
      if (glass) options.set(`glass:${glass}`, { group: "glass", label: "Скло", value: glass });
      if (color) options.set(`color:${color}`, { group: "color", label: "Колір", value: color });
    }
    let optionOrder = 10;
    for (const option of options.values()) {
      lines.push(`insert into public.product_options (product_slug,option_group,group_label,label,sort_order,is_active) values (${sql(slug)},${sql(option.group)},${sql(option.label)},${sql(option.value)},${optionOrder},true) on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;`);
      optionOrder += 10;
    }
    for (let index = 0; index < variants.length; index += 1) {
      const variant = variants[index];
      const selections = Object.fromEntries([["finish", fact(variant, "Матеріал покриття")], ["glass", fact(variant, "Наявність скла")], ["color", fact(variant, "Колір")]].filter(([, value]) => value));
      if (variant.image && Object.keys(selections).length) lines.push(`insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values (${sql(slug)},${sql(JSON.stringify(selections))}::jsonb,${sql(variant.image)},${index + 1},true) on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;`);
      lines.push(`delete from public.product_sources where product_slug=${sql(slug)} and source_url=${sql(variant.url)};`);
      lines.push(`insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values (${sql(slug)},'Market Dveri',${sql(variant.url)},${sql(variant.title)},'verified',now(),'Імпортовано з української картки Market Dveri: модель, варіант, характеристики та фото.');`);
    }
    if (base.image) lines.push(`insert into public.product_media (product_slug,kind,label,image_path,sort_order) select ${sql(slug)},'main','Головне фото',${sql(base.image)},0 where not exists (select 1 from public.product_media where product_slug=${sql(slug)} and kind='main' and image_path=${sql(base.image)});`);
  }
  lines.push("commit;");
  return { sql: lines.join("\n"), groups: groups.size };
}
function pause() { return new Promise((resolve) => setTimeout(resolve, delayMs)); }

await mkdir(outputDir, { recursive: true });
const listingResponses = await Promise.all(Array.from({ length: 4 }, async (_, index) => {
  const url = index ? `${catalogUrl}?page=${index + 1}` : catalogUrl;
  const response = await fetch(url, { headers, signal: AbortSignal.timeout(25_000) });
  if (!response.ok) throw new Error(`Market Dveri returned ${response.status} for ${url}`);
  return response.text();
}));
const items = [...new Map(listingResponses.flatMap(productLinks).map((item) => [item.url, item])).values()];
await writeFile(join(outputDir, "kfd-market-catalog.json"), JSON.stringify({ generatedAt: new Date().toISOString(), total: items.length, items }, null, 2));
console.log(`Found ${items.length} KFD cards.`);
if (!shouldCollect) process.exit(0);

const dataPath = join(outputDir, "kfd-market-data.json");
const existing = existsSync(dataPath) ? JSON.parse(await readFile(dataPath, "utf8")) : { records: [] };
const records = existing.records || [];
const completed = new Set(records.map((record) => record.url));
const batch = items.slice(start, Math.min(end, items.length));
for (let index = 0; index < batch.length; index += 1) {
  const item = batch[index];
  const originalIndex = start + index;
  if (completed.has(item.url) && !shouldRefreshImages) { console.log(`[${originalIndex + 1}/${items.length}] вже зібрано ${item.title}`); continue; }
  try {
    const response = await fetch(item.url, { headers, signal: AbortSignal.timeout(25_000) });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const html = await response.text();
    const title = clean(html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i)?.[1] || item.title);
    const facts = factsFrom(html);
    if (!facts.length) throw new Error("характеристик не знайдено");
    const material = facts.find((fact) => /матеріал покриття/iu.test(fact.label))?.value || "Міжкімнатні";
    const next = { slug: `kfd-${hash(item.url)}`, url: item.url, title, name: productName(title), image: imageFrom(html, item.url), facts, material, description: description(title, facts) };
    const previous = records.findIndex((record) => record.url === item.url);
    if (previous >= 0) records[previous] = next;
    else records.push(next);
    console.log(`[${originalIndex + 1}/${items.length}] ${title}: ${facts.length} характеристик`);
  } catch (error) {
    console.log(`[${originalIndex + 1}/${items.length}] пропущено ${item.title}: ${error instanceof Error ? error.message : "невідома помилка"}`);
  }
  await writeFile(dataPath, JSON.stringify({ generatedAt: new Date().toISOString(), total: items.length, collected: records.length, records }, null, 2));
  await pause();
}
await writeFile(dataPath, JSON.stringify({ generatedAt: new Date().toISOString(), total: items.length, collected: records.length, records }, null, 2));
if (shouldWriteSql) {
  const grouped = groupedSql(records);
  await writeFile(join(outputDir, "kfd-market-import-grouped.sql"), grouped.sql);
  console.log(`Done. ${records.length} verified KFD cards grouped into ${grouped.groups} models. SQL: supabase/generated/kfd-market-import-grouped.sql`);
} else {
  console.log(`Done. ${records.length} verified KFD records. Data saved; run with --write-sql after the last batch.`);
}
