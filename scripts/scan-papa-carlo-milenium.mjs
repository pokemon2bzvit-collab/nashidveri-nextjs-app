const root = "https://papa-karlo.com.ua";
const headers = { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalogAudit/1.0)" };
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const decode = (value = "") => value
  .replace(/&nbsp;/g, " ")
  .replace(/&amp;/g, "&")
  .replace(/&#(\d+);/g, (_, number) => String.fromCodePoint(Number(number)))
  .replace(/<[^>]+>/g, " ")
  .replace(/\s+/g, " ")
  .replace(/\s*,\s*/g, ", ")
  .trim();

async function getPage(url, cookie = "") {
  const response = await fetch(url, { headers: cookie ? { ...headers, cookie } : headers });
  return { response, html: await response.text() };
}

function officialGallery(html) {
  const paths = [...html.matchAll(/(?:src|data-src|data-image|data-zoom|href)=["']([^"']+)["']/gi)]
    .map((match) => match[1].replace(/&amp;/g, "&"))
    .filter((path) => /\/content\/images\//.test(path))
    .map((path) => path.startsWith("http") ? path : path.startsWith("/") ? `${root}${path}` : `${root}/${path}`)
    .filter((path) => {
      const dimensions = path.match(/\/(\d+)x(\d+)/i);
      return dimensions
        && Number(dimensions[1]) >= 250
        && Number(dimensions[1]) / Number(dimensions[2]) <= 0.85;
    });
  const unique = new Map();
  for (const path of paths) {
    const filename = path.split("/").at(-1);
    if (!unique.has(filename)) unique.set(filename, path);
  }
  return [...unique.values()];
}

function productFacts(html) {
  return Object.fromEntries(
    [...html.matchAll(/<tr[^>]*>[\s\S]*?<th[^>]*>[\s\S]*?<span[^>]*>([\s\S]*?)<\/span>[\s\S]*?<td[^>]*>([\s\S]*?)<\/td>[\s\S]*?<\/tr>/gi)]
      .map((match) => [decode(match[1]), decode(match[2])])
      .filter(([label, value]) => label && value),
  );
}

async function milleniumSession() {
  const url = `${root}/millenium/filter/page=all/`;
  const first = await getPage(url);
  const catHash = first.html.match(/defaultHash = "([^"]+)/)?.[1] || "";
  const second = await getPage(url, `challenge_passed_cat=${catHash}`);
  const normalHash = second.html.match(/defaultHash = "([^"]+)/)?.[1] || "";
  const final = await getPage(url, `challenge_passed_cat=${catHash}; challenge_passed=${normalHash}`);
  if (final.response.status !== 200 || !final.html.includes("ml-00")) throw new Error("Не вдалося відкрити повний каталог Milenium.");
  return { listing: final.html, cookie: `challenge_passed_cat=${catHash}; challenge_passed=${normalHash}` };
}

async function scanMilenium({ offset = 0, limit = 8 } = {}) {
  const { listing, cookie } = await milleniumSession();
  const paths = [...new Set([...listing.matchAll(/href=["'](\/mizhkimnatni-dveri-papa-karlo-ml-[^"'?#/]+\/?)["']/gi)]
    .map((match) => match[1].replace(/\/$/, "")))];
  const selected = paths.slice(offset, offset + limit);
  const models = [];

  for (const [index, path] of selected.entries()) {
    if (index) await sleep(1000);
    const page = await getPage(`${root}${path}`, cookie);
    const facts = productFacts(page.html);
    const title = decode((page.html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i) || [])[1] || "");
    const code = (title.match(/\bML\s*-?\s*(\d+(?:[a-z]+|\s+blk)?)/i)?.[1] || "").toUpperCase().replace(/\s+/g, " ");
    const images = officialGallery(page.html);
    models.push({
      url: `${root}${path}`,
      status: page.response.status,
      title,
      code: code ? `ML-${code}` : "",
      article: decode((page.html.match(/product-header__code">\s*Артикул:\s*([^<\s]+)/i) || [])[1] || ""),
      covering: facts["Матеріал покриття"] || "",
      width: facts["Ширина полотна"] || "",
      height: facts["Висота полотна"] || "",
      thickness: facts["Товщина полотна"] || "",
      glass: facts["Наявність скла"] || "",
      colors: facts["Колір"] || "",
      style: facts["Стиль"] || "",
      images,
    });
  }
  return { total: paths.length, models };
}

export { scanMilenium };
