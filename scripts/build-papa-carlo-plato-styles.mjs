import { scanPlato } from "./scan-papa-carlo-plato.mjs";

const root = "https://papa-karlo.com.ua";
const headers = { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalogAudit/1.0)" };
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const decode = (value = "") => value.replace(/&nbsp;/g, " ").replace(/&amp;/g, "&").replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim();
const sql = (value) => `'${String(value ?? "").replace(/'/g, "''")}'`;

function codeFrom(title) {
  const match = title.match(/\bPL\s*-?\s*(\d+[a-z]?)/i);
  if (!match) throw new Error(`Не вдалося визначити код Plato: ${title}`);
  return `PL-${match[1].toUpperCase()}`;
}

async function getPage(url, cookie = "") {
  const response = await fetch(url, { headers: cookie ? { ...headers, cookie } : headers });
  return { response, html: await response.text() };
}

async function scanPageTwoStyles() {
  const url = `${root}/plato/filter/page=2/`;
  const first = await getPage(url);
  const catHash = first.html.match(/defaultHash = "([^"]+)/)?.[1] || "";
  const second = await getPage(url, `challenge_passed_cat=${catHash}`);
  const normalHash = second.html.match(/defaultHash = "([^"]+)/)?.[1] || "";
  const cookie = `challenge_passed_cat=${catHash}; challenge_passed=${normalHash}`;
  const listing = await getPage(url, cookie);
  const paths = [...new Set([...listing.html.matchAll(/href=["'](\/mizhkimnatni-dveri-papa-karlo-pl-(?:50|51|52|53|54|55)\/?)["']/gi)].map((match) => match[1]))];
  if (paths.length !== 6) throw new Error(`Не вдалося знайти всі моделі Plato сторінки 2: ${paths.length}.`);
  const models = [];
  for (const [index, path] of paths.entries()) {
    if (index) await sleep(1250);
    const page = await getPage(`${root}${path}`, cookie);
    const rows = [...page.html.matchAll(/<tr[^>]*>[\s\S]*?<th[^>]*>[\s\S]*?<span[^>]*>([\s\S]*?)<\/span>[\s\S]*?<td[^>]*>([\s\S]*?)<\/td>[\s\S]*?<\/tr>/gi)]
      .map((match) => [decode(match[1]), decode(match[2])]);
    const facts = Object.fromEntries(rows);
    const title = decode((page.html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i) || [])[1] || "");
    if (page.response.status !== 200 || !title) throw new Error(`Не вдалося прочитати ${path}.`);
    models.push({ title, style: facts["Стиль"] || "" });
  }
  return models;
}

const first = await scanPlato({ offset: 0, limit: 8 });
const pages = [first];
for (let offset = 8; offset < first.total; offset += 8) pages.push(await scanPlato({ offset, limit: 8 }));
const models = [...pages.flatMap((page) => page.models), ...await scanPageTwoStyles()]
  .filter((model) => model.style)
  .map((model) => ({ slug: `papa-carlo-${codeFrom(model.title).toLowerCase()}-official`, style: model.style }));

if (models.length < first.total) throw new Error(`Стиль знайдено лише для ${models.length} моделей.`);

console.log("-- Офіційні стилі моделей Papa Carlo Plato.");
console.log("begin;");
console.log("delete from public.product_specs where label = 'Стиль' and product_slug in (select slug from public.products where brand = 'Papa Carlo' and collection = 'Plato');");
console.log("insert into public.product_specs (product_slug, label, value, sort_order, is_active)");
console.log("select p.slug, 'Стиль', source.style, 140, true");
console.log("from (values");
console.log(models.map((model) => `(${sql(model.slug)}, ${sql(model.style)})`).join(",\n"));
console.log(") as source(slug, style)");
console.log("join public.products p on p.slug = source.slug");
console.log("where p.brand = 'Papa Carlo' and p.collection = 'Plato';");
console.log("update public.product_specs set value = regexp_replace(value, '\\s*,\\s*', ', ', 'g') where label = 'Стиль' and product_slug in (select slug from public.products where brand = 'Papa Carlo' and collection = 'Plato');");
console.log("commit;");
console.log("select value as стиль, count(*) as моделей from public.product_specs where label = 'Стиль' and product_slug in (select slug from public.products where brand = 'Papa Carlo' and collection = 'Plato') group by value order by value;");
