const root = "https://papa-karlo.com.ua";
const headers = { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalogAudit/1.0)" };
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const decode = (value = "") => value
  .replace(/&nbsp;/g, " ")
  .replace(/&amp;/g, "&")
  .replace(/&#(\d+);/g, (_, number) => String.fromCodePoint(Number(number)))
  .replace(/<[^>]+>/g, " ")
  .replace(/\s+/g, " ")
  .trim();

const firstMatch = (html, expression) => (html.match(expression) || [])[1] || "";
const sql = (value) => `'${String(value ?? "").replace(/'/g, "''")}'`;

function gallery(html) {
  const paths = [...html.matchAll(/(?:src|data-src|data-image|data-zoom|href)=["']([^"']+)["']/gi)]
    .map((match) => match[1].replace(/&amp;/g, "&"))
    .filter((path) => /\/content\/images\//.test(path))
    .map((path) => path.startsWith("http") ? path : path.startsWith("/") ? `${root}${path}` : `${root}/${path}`)
    .filter((path) => /\/([3-9]\d{2}|[1-9]\d{3,})x\d+/i.test(path));
  const unique = new Map();
  for (const path of paths) {
    const filename = path.split("/").at(-1);
    if (!unique.has(filename)) unique.set(filename, path);
  }
  return [...unique.values()];
}

async function getPage(url, cookie = "") {
  const response = await fetch(url, { headers: cookie ? { ...headers, cookie } : headers });
  return { response, html: await response.text() };
}

async function pageTwoSession() {
  const url = `${root}/plato/filter/page=2/`;
  const first = await getPage(url);
  const catHash = firstMatch(first.html, /defaultHash = "([^"]+)/);
  const second = await getPage(url, `challenge_passed_cat=${catHash}`);
  const regularHash = firstMatch(second.html, /defaultHash = "([^"]+)/);
  const final = await getPage(url, `challenge_passed_cat=${catHash}; challenge_passed=${regularHash}`);
  if (final.response.status !== 200 || !final.html.includes("pl-50")) throw new Error("Не вдалося відкрити другу сторінку Plato.");
  return { html: final.html, cookie: `challenge_passed_cat=${catHash}; challenge_passed=${regularHash}` };
}

function productRows(html) {
  return [...html.matchAll(/<tr[^>]*>[\s\S]*?<th[^>]*>[\s\S]*?<span[^>]*>([\s\S]*?)<\/span>[\s\S]*?<td[^>]*>([\s\S]*?)<\/td>[\s\S]*?<\/tr>/gi)]
    .map((match) => [decode(match[1]), decode(match[2])])
    .filter(([label, value]) => label && value);
}

function description(code, facts) {
  const parts = [facts["Матеріал покриття"], facts["Товщина полотна"], facts["Ширина полотна"]].filter(Boolean);
  return `Papa Carlo ${code} — міжкімнатні двері колекції Plato${parts.length ? `: ${parts.join("; ")}` : ""}. Двері мають стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні. Актуальну комплектацію й ціну уточнюйте у менеджера.`;
}

const { html: listing, cookie } = await pageTwoSession();
const urls = [...new Set([...listing.matchAll(/href=["'](\/mizhkimnatni-dveri-papa-karlo-pl-(?:50|51|52|53|54|55)\/?)["']/gi)].map((match) => match[1]))];
if (urls.length !== 6) throw new Error(`Очікувалося 6 моделей на сторінці 2, знайдено ${urls.length}.`);

const models = [];
for (const [index, path] of urls.entries()) {
  if (index) await sleep(1250);
  const page = await getPage(`${root}${path}`, cookie);
  const facts = Object.fromEntries(productRows(page.html));
  const title = decode(firstMatch(page.html, /<h1[^>]*>([\s\S]*?)<\/h1>/i));
  const code = (title.match(/\bPL\s*-?\s*(\d+[a-z]?)/i)?.[1] || "").toUpperCase();
  const images = gallery(page.html);
  if (page.response.status !== 200 || !code || !images.length) throw new Error(`Неповна картка ${path}.`);
  models.push({
    code: `PL-${code}`,
    slug: `papa-carlo-pl-${code.toLowerCase()}-official`,
    url: `${root}${path}`,
    title,
    article: decode(firstMatch(page.html, /product-header__code">\s*Артикул:\s*([^<\s]+)/i)),
    facts,
    images,
  });
}

const productValues = models.map((model, index) => {
  const facts = model.facts;
  return `(${[
    model.slug, "interior", "Papa Carlo", "Plato", `Papa Carlo ${model.code}`, "Міжкімнатні", "Колекція Plato", "Варіанти декорів і скла", "Ціна за запитом", description(model.code, facts),
    JSON.stringify(["Фабрика Papa Carlo", "Колекція Plato", "Офіційна картка виробника"]), model.images[0], 600 + index, true,
  ].map(sql).join(", ")})`;
});

const specs = models.flatMap((model) => {
  const f = model.facts;
  return [
    ["Код виробника", model.article, 90],
    ["Розміри полотна", f["Ширина полотна"] ? `ширина: ${f["Ширина полотна"]}; висота: ${f["Висота полотна"] || "уточнюйте"}` : "", 100],
    ["Товщина полотна", f["Товщина полотна"], 110],
    ["Матеріал покриття", f["Матеріал покриття"], 120],
    ["Наявність скла", f["Наявність скла"], 130],
    ["Доступні декори", f["Колір"], 900],
  ].filter(([, value]) => value).map(([label, value, sortOrder]) => `(${[model.slug, label, value, sortOrder, true].map(sql).join(", ")})`);
});

const media = models.flatMap((model) => model.images.map((image, index) => `(${[
  model.slug, index === 0 ? "main" : "gallery", `${model.code} — ${index === 0 ? "головне фото" : `фото ${index + 1}`}`, image, index, true,
].map(sql).join(", ")})`));

console.log("-- Офіційний імпорт Papa Carlo Plato, сторінка 2: PL-50…PL-55.");
console.log("begin;");
console.log("insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values");
console.log(productValues.join(",\n"));
console.log("on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path, sort_order = excluded.sort_order, is_available = true;");
console.log("delete from public.product_specs where product_slug in (" + models.map((model) => sql(model.slug)).join(", ") + ");");
console.log("insert into public.product_specs (product_slug, label, value, sort_order, is_active) values");
console.log(specs.join(",\n") + ";");
console.log("delete from public.product_media where product_slug in (" + models.map((model) => sql(model.slug)).join(", ") + ");");
console.log("insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values");
console.log(media.join(",\n"));
console.log("on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;");
console.log("insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values");
console.log(models.map((model) => `(${[model.slug, "Papa Carlo", model.url, model.title, "verified", "now()", "Офіційна картка Papa Carlo: фото, кольори й базові технічні параметри."].map((value, index) => index === 5 ? value : sql(value)).join(", ")})`).join(",\n"));
console.log("on conflict (product_slug, source_url) do update set source_product_name = excluded.source_product_name, verification_status = 'verified', verified_at = now(), notes = excluded.notes;");
console.log("commit;");
console.log("select count(*) as додано_моделей, count(*) filter (where is_available) as опубліковано from public.products where slug in (" + models.map((model) => sql(model.slug)).join(", ") + ");");
