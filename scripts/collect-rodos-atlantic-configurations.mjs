import { mkdir, readFile, writeFile } from "node:fs/promises";
import { existsSync } from "node:fs";
import { join } from "node:path";

const outputDir = join(process.cwd(), "supabase", "generated");
const delayMs = Number(process.argv.find((value) => value.startsWith("--delay="))?.split("=")[1] || 650);
const only = new Set((process.argv.find((value) => value.startsWith("--only="))?.split("=")[1] || "").split(",").filter(Boolean));
const append = process.argv.includes("--append");
const catalog = process.argv.find((value) => value.startsWith("--catalog="))?.split("=")[1] || "atlantic";
const atlanticModels = [
  { code: "A001", slug: "rodos-official-1osu0nf", url: "https://rodos.ua/mezhkomnatnaya-dver-atlantic-a001" },
  { code: "A002", slug: "rodos-official-1osu0nc", url: "https://rodos.ua/mezhkomnatnaya-dver-atlantic-a002" },
  { code: "A003", slug: "rodos-official-16d044a", url: "https://rodos.ua/mzhkmnatn-dver-atlantic-a003" },
  { code: "A004", slug: "rodos-official-bf2ks0", url: "https://rodos.ua/mezhkomnatnaya-dver-atlantic-a006-1" },
  { code: "A005", slug: "rodos-official-1osu0nj", url: "https://rodos.ua/mezhkomnatnaya-dver-atlantic-a005" },
  // У sitemap Rodos є зайвий пробіл наприкінці URL A006; %2520 зберігає його під час HTTP-запиту.
  { code: "A006", slug: "rodos-official-lnsyln", url: "https://rodos.ua/mezhkomnatnaya-dver-atlantic-a006%2520" },
];
const cortesModels = [
  ["Galliano", "rodos-official-7qvf8g", "https://rodos.ua/mezhkomnatnaya-dver-cortes-galliano"],
  ["Gaudi", "rodos-official-1bivutt", "https://rodos.ua/mezhkomnatnaya-dver-cortes-gaudi"],
  ["Prima", "rodos-official-1c011jc", "https://rodos.ua/mezhkomnatnaya-dver-cortes-prima"],
  ["Prima-1G", "rodos-official-jcjjmb", "https://rodos.ua/mezhkomnatnaya-dver-cortes-prima-1g"],
  ["Prima-3G", "rodos-official-jcjjrl", "https://rodos.ua/mezhkomnatnaya-dver-cortes-prima-3g"],
  ["Prima-3V", "rodos-official-jcjjr4", "https://rodos.ua/mezhkomnatnaya-dver-cortes-prima-3v"],
  ["Prima-3V1", "rodos-official-2ixklp", "https://rodos.ua/mezhkomnatnaya-dver-cortes-prima-3v1-1"],
  ["Roma", "rodos-official-18i6cbi", "https://rodos.ua/mezhkomnatnaya-dver-cortes-roma"],
  ["Venezia", "rodos-official-w4wg3p", "https://rodos.ua/mezhkomnatnaya-dver-cortes-venezia"],
  ["Dolce", "rodos-official-14xcf9e", "https://rodos.ua/mezhkomnatnye-dveri-cortes-dolce"],
  ["Dolce-3", "rodos-official-wb79oc", "https://rodos.ua/mezhkomnatnye-dveri-cortes-dolce-3"],
  ["Dolce-4", "rodos-official-wb79ob", "https://rodos.ua/mezhkomnatnye-dveri-cortes-dolce-4"],
  ["Galant", "rodos-official-1wtedpu", "https://rodos.ua/mezhkomnatnye-dveri-cortes-galant"],
  ["Jazz", "rodos-official-3e3gw8", "https://rodos.ua/mezhkomnatnye-dveri-cortes-jazz"],
  ["Salsa", "rodos-official-152c7f3", "https://rodos.ua/mezhkomnatnye-dveri-cortes-salsa"],
  ["Selena", "rodos-official-5mprw3", "https://rodos.ua/mezhkomnatnye-dveri-cortes-selena"],
  ["Tango", "rodos-official-158om4w", "https://rodos.ua/mezhkomnatnye-dveri-cortes-tango"],
].map(([code, slug, url]) => ({ code, slug, url }));
const sitemapReport = JSON.parse(await readFile(join(outputDir, "rodos-market-match-report.json"), "utf8"));
const cortesMillingModels = [...(sitemapReport.matched || []), ...(sitemapReport.unmatched || [])]
  .filter((item) => /^Межкомнатная дверь Cortes Prima Фрезеровка \d+$/u.test(item.title) && item.url !== "https://rodos.ua/-1")
  .map((item) => ({ code: `F${item.title.match(/\d+$/u)?.[0]}`, slug: item.slug, url: item.url }))
  .sort((left, right) => Number(left.code.slice(1)) - Number(right.code.slice(1)));
const cortesAlumModels = [{ code: "Alum", slug: "rodos-official-1989q5s", url: "https://rodos.ua/mezhkomnatnaya-dver-cortes-prima-alum" }];
const cortesInsideModels = [
  ["Prima INSIDE", "rodos-official-zqeak9", "https://rodos.ua/mezhkomnatnaya-dver-cortes-prima-inside"],
  ["Venezia INSIDE", "rodos-official-1mr5ck", "https://rodos.ua/mezhkomnatnaya-dver-cortes-venezia-inside"],
  ["Galant INSIDE", "rodos-official-730thf", "https://rodos.ua/mezhkomnatnye-dveri-cortes-galant-inside"],
].map(([code, slug, url]) => ({ code, slug, url }));
const loftModels = [...(sitemapReport.matched || []), ...(sitemapReport.unmatched || [])]
  .filter((item) => /\bLoft\b/iu.test(item.title) && !/\bINSIDE\b/iu.test(item.title))
  .map((item, index) => ({ code: `L${index + 1}`, slug: item.slug, url: item.url }));
const loftInsideModels = [
  ["Surf Alum INSIDE", "rodos-official-1po8ng4", "https://rodos.ua/mezhkomnatnaya-dver-loft-surf-alum-1"],
  ["Porto 2 INSIDE", "rodos-official-5e5nh2", "https://rodos.ua/mezhkomnatnye-dveri-loft-porto-2-inside"],
].map(([code, slug, url]) => ({ code, slug, url }));
const sienaModels = [
  ["Asti", "rodos-official-59qgkd", "https://rodos.ua/mezhkomnatnye-dveri-siena-siena-asti"],
  ["Laura", "rodos-official-13h8iec", "https://rodos.ua/mezhkomnatnye-dveri-siena-laura"],
  ["Rossi", "rodos-official-13wj8rf", "https://rodos.ua/mezhkomnatnye-dveri-siena-rossi"],
].map(([code, slug, url]) => ({ code, slug, url }));
const styleModels = [...(sitemapReport.matched || []), ...(sitemapReport.unmatched || [])]
  .filter((item) => /^Межкомнатная дверь Style \d+(?: BLK)?$/u.test(item.title))
  .map((item, index) => ({ code: `S${index + 1}`, slug: item.slug, url: item.url }));
const royalModels = [{ code: "Avalon", slug: "rodos-official-1mt8i9p", url: "https://rodos.ua/mezhkomnatnaya-dver-royal-avalon-1" }];
const libertaModels = [...(sitemapReport.matched || []), ...(sitemapReport.unmatched || [])]
  .filter((item) => /\bLIBERTA\b|\bLiberta\b/u.test(item.title))
  .map((item, index) => ({ code: `L${index + 1}`, slug: item.slug, url: item.url }));
const modernModels = [...(sitemapReport.matched || []), ...(sitemapReport.unmatched || [])]
  .filter((item) => /^Межкомнатная дверь Modern/u.test(item.title) && !/\bINSIDE\b/iu.test(item.title))
  .map((item, index) => ({ code: `M${index + 1}`, slug: item.slug, url: item.url }));
const modernInsideModels = [...(sitemapReport.matched || []), ...(sitemapReport.unmatched || [])]
  .filter((item) => /^Межкомнатная дверь Modern/u.test(item.title) && /\bINSIDE\b/iu.test(item.title))
  .map((item, index) => ({ code: `MI${index + 1}`, slug: item.slug, url: item.url }));
const woodmixModels = [
  ["Master", "rodos-official-xhloa4", "https://rodos.ua/mezhkomnatnye-dveri-woodmix-master"],
  ["Praktic", "rodos-official-zps1ju", "https://rodos.ua/mezhkomnatnye-dveri-woodmix-praktic-1"],
].map(([code, slug, url]) => ({ code, slug, url }));
if (!["atlantic", "cortes", "cortes-milling", "cortes-alum", "cortes-inside", "loft", "loft-inside", "siena", "style", "royal", "liberta", "modern", "modern-inside", "woodmix"].includes(catalog)) throw new Error("Невідомий каталог Rodos");
const outputStem = catalog === "cortes" ? "rodos-cortes-official-configurations" : catalog === "cortes-milling" ? "rodos-cortes-milling-configurations" : catalog === "cortes-alum" ? "rodos-cortes-alum-configurations" : catalog === "cortes-inside" ? "rodos-cortes-inside-configurations" : catalog === "loft" ? "rodos-loft-configurations" : catalog === "loft-inside" ? "rodos-loft-inside-configurations" : catalog === "siena" ? "rodos-siena-configurations" : catalog === "style" ? "rodos-style-configurations" : catalog === "royal" ? "rodos-royal-configurations" : catalog === "liberta" ? "rodos-liberta-configurations" : catalog === "modern" ? "rodos-modern-configurations" : catalog === "modern-inside" ? "rodos-modern-inside-configurations" : catalog === "woodmix" ? "rodos-woodmix-configurations" : "rodos-atlantic-official-configurations";
const collectionLabel = catalog === "cortes" ? "Rodos Cortes" : catalog === "cortes-milling" ? "Rodos Cortes Prima фрезерування" : catalog === "cortes-alum" ? "Rodos Cortes Prima Alum" : catalog === "cortes-inside" ? "Rodos Cortes INSIDE" : catalog === "loft" ? "Rodos Loft" : catalog === "loft-inside" ? "Rodos Loft INSIDE" : catalog === "siena" ? "Rodos Siena" : catalog === "style" ? "Rodos Style" : catalog === "royal" ? "Rodos Royal шпон" : catalog === "liberta" ? "Rodos Liberta" : catalog === "modern" ? "Rodos Modern" : catalog === "modern-inside" ? "Rodos Modern INSIDE" : catalog === "woodmix" ? "Rodos Woodmix" : "Rodos Atlantic";
const sourceModels = catalog === "cortes" ? cortesModels : catalog === "cortes-milling" ? cortesMillingModels : catalog === "cortes-alum" ? cortesAlumModels : catalog === "cortes-inside" ? cortesInsideModels : catalog === "loft" ? loftModels : catalog === "loft-inside" ? loftInsideModels : catalog === "siena" ? sienaModels : catalog === "style" ? styleModels : catalog === "royal" ? royalModels : catalog === "liberta" ? libertaModels : catalog === "modern" ? modernModels : catalog === "modern-inside" ? modernInsideModels : catalog === "woodmix" ? woodmixModels : atlanticModels;
const models = sourceModels.filter((model) => !only.size || only.has(model.code));
const headers = { "user-agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0)", "accept-language": "uk-UA,uk;q=0.9" };
const htmlDecode = (value = "") => value.replace(/&quot;/g, '"').replace(/&amp;/g, "&").replace(/&#039;|&#39;/g, "'").replace(/&nbsp;/g, " ").trim();
const clean = (value = "") => htmlDecode(value).replace(/\s+/g, " ").trim();
const sql = (value) => `'${String(value ?? "").replace(/'/g, "''")}'`;
const pause = () => new Promise((resolve) => setTimeout(resolve, delayMs));
const uniqueByLabel = (items) => [...new Map(items.map((item) => [item.label, item])).values()];
const translateColor = (value) => clean(value)
  .replace(/^Белый мат$/iu, "Білий мат")
  .replace(/^Светло серый$/iu, "Світло-сірий")
  .replace(/^Бежевый$/iu, "Бежевий")
  .replace(/^Крем$/iu, "Крем")
  .replace(/^Мрамор серый$/iu, "Мрамор сірий")
  .replace(/^Каштан белый$/iu, "Каштан білий")
  .replace(/^Каштан серый$/iu, "Каштан сірий")
  .replace(/^Каштан беж$/iu, "Каштан беж")
  .replace(/^Сосна крем$/iu, "Сосна крем")
  .replace(/^Сосна браш браун$/iu, "Сосна браш браун")
  .replace(/^Сосна браш кобальт$/iu, "Сосна браш кобальт")
  .replace(/^Сосна браш минт$/iu, "Сосна браш мінт")
  .replace(/^Дуб сонома$/iu, "Дуб сонома")
  .replace(/^Венге шоколадный$/iu, "Венге шоколадний")
  .replace(/^Акация темная$/iu, "Акація темна")
  .replace(/^Дуб шале графит$/iu, "Дуб шале графіт")
  .replace(/^Кедр софт графит$/iu, "Кедр софт графіт")
  .replace(/^Кедр софт белый$/iu, "Кедр софт білий")
  .replace(/^Канадский дуб$/iu, "Канадський дуб");
const translateConfiguration = (value) => clean(value)
  .replace(/^Глухое$/iu, "Глухе")
  .replace(/^Полустекло$/iu, "Напівскло")
  .replace(/^Со стеклом$/iu, "Зі склом")
  .replace(/^Глухое с вставкой из стекла$/iu, "Глухе зі скляною вставкою");

async function fetchWithRetry(url, options = {}) {
  let lastError;
  for (let attempt = 1; attempt <= 3; attempt += 1) {
    try {
      const response = await fetch(url, { ...options, headers: { ...headers, ...options.headers }, signal: AbortSignal.timeout(30_000) });
      if (response.status === 429 && attempt < 3) { await new Promise((resolve) => setTimeout(resolve, attempt * 2500)); continue; }
      if (!response.ok) throw new Error(`${response.status} ${response.statusText}`);
      return response;
    } catch (error) { lastError = error; if (attempt < 3) await new Promise((resolve) => setTimeout(resolve, attempt * 1500)); }
  }
  throw lastError;
}

function parsePage(html, model) {
  const productId = html.match(/getPImages&product_id=(\d+)/)?.[1];
  if (!productId) throw new Error(`${model.code}: не знайдено product_id`);
  const colorStart = html.search(/<div class="option-name">Цвет\s*<\/div>/iu);
  const colorEnd = html.indexOf("</script>", colorStart);
  const colorHtml = html.slice(colorStart, colorEnd);
  const colors = uniqueByLabel(Array.from(colorHtml.matchAll(/<label[^>]*title="([^"]+)"[^>]*>[\s\S]*?<input[^>]*name="option\[(\d+)\]"[^>]*value="([^"]+)"[\s\S]*?<img[^>]*src="([^"]+)"/giu), (match) => ({ label: translateColor(match[1]), optionId: match[2], value: match[3], swatch: htmlDecode(match[4]) })));
  const typeStart = html.search(/<div class="option-name">Вид полотна<\/div>/iu);
  const typeEnd = html.indexOf("</script>", typeStart);
  const typeHtml = html.slice(typeStart, typeEnd);
  const configurations = uniqueByLabel(Array.from(typeHtml.matchAll(/<input[^>]*name="option\[(\d+)\]"[^>]*value="([^"]+)"[^>]*[\s\S]*?<span class="radio-name2">([^<]+)<\/span>/giu), (match) => ({ label: translateConfiguration(match[3]), optionId: match[1], value: match[2] })));
  if (!colors.length || !configurations.length) throw new Error(`${model.code}: не знайдено кольори або види полотна`);
  return { productId, colors, configurations };
}

async function imagesForColor(model, productId, color, initialConfiguration) {
  const params = new URLSearchParams({ [`option[${color.optionId}]`]: color.value, [`option[${initialConfiguration.optionId}]`]: initialConfiguration.value, product_id: productId });
  const response = await fetchWithRetry(`https://rodos.ua/index.php?route=product/product/getPImages&product_id=${productId}`, {
    method: "POST",
    headers: { "content-type": "application/x-www-form-urlencoded", "x-requested-with": "XMLHttpRequest", referer: model.url },
    body: params,
  });
  const payload = await response.json();
  return [...new Set((payload.images || []).map((image) => image.main_img).filter(Boolean))];
}

function imageFor(images, configuration, allowFirstImageFallback = false) {
  const patterns = configuration.label === "Глухе"
    ? [/-gluhoe-|gluhoe/iu]
    : configuration.label === "Напівскло"
      ? [/-polusteklo-|polusteklo|semiglass/iu]
      : [/-sosteklom-|sosteklom/iu];
  const image = patterns.map((pattern) => images.find((candidate) => pattern.test(candidate))).find(Boolean)
    || (configuration.label === "Зі склом" ? images.find((candidate) => /glass/iu.test(candidate) && !/(?:semiglass|polusteklo)/iu.test(candidate)) : null)
    || (configuration.label === "Глухе" ? images.find((candidate) => !/(?:polusteklo|semiglass|sosteklom|glass)/iu.test(candidate)) : null);
  return image || (allowFirstImageFallback ? images[0] || null : null);
}

const collected = [];
for (const model of models) {
  console.log(`${model.code}: читаю офіційну картку…`);
  const html = await (await fetchWithRetry(model.url)).text();
  const page = parsePage(html, model);
  const variants = [];
  for (const color of page.colors) {
    const images = await imagesForColor(model, page.productId, color, page.configurations[0]);
    for (const configuration of page.configurations) {
      const image = imageFor(images, configuration, page.configurations.length === 1);
      if (image) variants.push({ color: color.label, configuration: configuration.label, image });
    }
    await pause();
  }
  const confirmedConfigurations = page.configurations.map(({ label }) => label).filter((label) => variants.some((variant) => variant.configuration === label));
  if (!confirmedConfigurations.length) console.warn(`${model.code}: Rodos не віддав точних фото для видів: ${page.configurations.map(({ label }) => label).join(", ")}`);
  collected.push({ ...model, colors: page.colors.map(({ label, swatch }) => ({ label, swatch })), configurations: confirmedConfigurations, variants });
  console.log(`${model.code}: ${page.colors.length} кольорів × ${confirmedConfigurations.length} підтверджені види = ${variants.length} варіантів.`);
}

const lines = [
  "-- Rodos Atlantic A001–A006: точні кольори, види полотна й фото з офіційних карток Rodos.",
  "-- Скрипт не змінює інші колекції або бренди. Кожна модель очищається тільки перед повторним наповненням її конфігуратора.",
  "begin;",
];
for (const model of collected) {
  lines.push(`delete from public.product_options where product_slug = ${sql(model.slug)};`);
  lines.push(`delete from public.product_variants where product_slug = ${sql(model.slug)};`);
  lines.push(`delete from public.product_media where product_slug = ${sql(model.slug)} and label like 'config:%';`);
  for (let index = 0; index < model.colors.length; index += 1) {
    const color = model.colors[index];
    lines.push(`insert into public.product_options (product_slug,option_group,group_label,label,image_path,sort_order,is_active) values (${sql(model.slug)},'color','Колір полотна',${sql(color.label)},${sql(color.swatch)},${index + 1},true);`);
  }
  for (let index = 0; index < model.configurations.length; index += 1) {
    lines.push(`insert into public.product_options (product_slug,option_group,group_label,label,sort_order,is_active) values (${sql(model.slug)},'configuration','Вид полотна',${sql(model.configurations[index])},${index + 1},true);`);
  }
  for (let index = 0; index < model.variants.length; index += 1) {
    const variant = model.variants[index];
    const selection = { color: variant.color, configuration: variant.configuration };
    lines.push(`insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values (${sql(model.slug)},${sql(JSON.stringify(selection))}::jsonb,${sql(variant.image)},${index + 1},true);`);
    const key = `config:color=${encodeURIComponent(variant.color)}&configuration=${encodeURIComponent(variant.configuration)}:Фото`;
    lines.push(`insert into public.product_media (product_slug,kind,label,image_path,sort_order) values (${sql(model.slug)},'gallery',${sql(key)},${sql(variant.image)},${1000 + index}) on conflict (product_slug,kind,image_path) do update set label = excluded.label, sort_order = excluded.sort_order;`);
  }
}
lines.push("commit;");
lines.push("select product_slug, count(*) filter (where option_group = 'color') as кольорів, count(*) filter (where option_group = 'configuration') as видів_полотна from public.product_options where product_slug in ('rodos-official-1osu0nf','rodos-official-1osu0nc','rodos-official-16d044a','rodos-official-bf2ks0','rodos-official-1osu0nj','rodos-official-lnsyln') group by product_slug order by product_slug;");

await mkdir(outputDir, { recursive: true });
const reportPath = join(outputDir, `${outputStem}.json`);
const previous = append && existsSync(reportPath) ? JSON.parse(await readFile(reportPath, "utf8")) : [];
const modelOrder = (model) => Number(model.code.match(/\d+/u)?.[0] || 0);
const allCollected = [...new Map([...previous, ...collected].map((model) => [model.code, model])).values()].sort((left, right) => modelOrder(left) - modelOrder(right));
await writeFile(reportPath, JSON.stringify(allCollected, null, 2));
const allLines = [
  `-- ${collectionLabel}: точні кольори, види полотна й фото з офіційних карток Rodos.`,
  "-- Скрипт не змінює інші колекції або бренди. Кожна модель очищається тільки перед повторним наповненням її конфігуратора.",
  `do $$ begin if (select count(*) from public.products where slug in (${allCollected.map((model) => sql(model.slug)).join(",")})) <> ${allCollected.length} then raise exception 'Не знайдено всі моделі ${collectionLabel} для пакета — каталог не змінено'; end if; end $$;`,
  "begin;",
];
for (const model of allCollected) {
  allLines.push(`delete from public.product_options where product_slug = ${sql(model.slug)};`);
  allLines.push(`delete from public.product_variants where product_slug = ${sql(model.slug)};`);
  allLines.push(`delete from public.product_media where product_slug = ${sql(model.slug)} and label like 'config:%';`);
  for (let index = 0; index < model.colors.length; index += 1) allLines.push(`insert into public.product_options (product_slug,option_group,group_label,label,image_path,sort_order,is_active) values (${sql(model.slug)},'color','Колір полотна',${sql(model.colors[index].label)},${sql(model.colors[index].swatch)},${index + 1},true);`);
  for (let index = 0; index < model.configurations.length; index += 1) allLines.push(`insert into public.product_options (product_slug,option_group,group_label,label,sort_order,is_active) values (${sql(model.slug)},'configuration','Вид полотна',${sql(model.configurations[index])},${index + 1},true);`);
  for (let index = 0; index < model.variants.length; index += 1) {
    const variant = model.variants[index];
    const selection = { color: variant.color, configuration: variant.configuration };
    allLines.push(`insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values (${sql(model.slug)},${sql(JSON.stringify(selection))}::jsonb,${sql(variant.image)},${index + 1},true);`);
    const key = `config:color=${encodeURIComponent(variant.color)}&configuration=${encodeURIComponent(variant.configuration)}:Фото`;
    allLines.push(`insert into public.product_media (product_slug,kind,label,image_path,sort_order) values (${sql(model.slug)},'gallery',${sql(key)},${sql(variant.image)},${1000 + index}) on conflict (product_slug,kind,image_path) do update set label = excluded.label, sort_order = excluded.sort_order;`);
  }
}
allLines.push("commit;");
allLines.push(`select product_slug, count(*) filter (where option_group = 'color') as кольорів, count(*) filter (where option_group = 'configuration') as видів_полотна from public.product_options where product_slug in (${allCollected.map((model) => sql(model.slug)).join(",")}) group by product_slug order by product_slug;`);
await writeFile(join(outputDir, `${outputStem}.sql`), allLines.join("\n"));
console.log(`Готово: ${collected.length} моделей у цьому пакеті, ${allCollected.length} у підсумковому SQL. SQL: supabase/generated/${outputStem}.sql`);
