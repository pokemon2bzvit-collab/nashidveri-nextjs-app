const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const decode = (value = "") => value
  .replace(/&nbsp;/g, " ")
  .replace(/&amp;/g, "&")
  .replace(/&#(\d+);/g, (_, number) => String.fromCodePoint(Number(number)))
  .replace(/<[^>]+>/g, " ")
  .replace(/\s+/g, " ")
  .trim();

const firstMatch = (html, expression) => (html.match(expression) || [])[1] || "";

function jsonArrayAfter(html, marker) {
  const markerIndex = html.indexOf(marker);
  const start = markerIndex < 0 ? -1 : html.indexOf("[", markerIndex + marker.length - 2);
  if (start < 0) return "";
  let depth = 0;
  let quoted = false;
  let escaped = false;
  for (let index = start; index < html.length; index += 1) {
    const character = html[index];
    if (quoted) {
      if (escaped) escaped = false;
      else if (character === "\\") escaped = true;
      else if (character === '"') quoted = false;
      continue;
    }
    if (character === '"') quoted = true;
    else if (character === "[") depth += 1;
    else if (character === "]") {
      depth -= 1;
      if (depth === 0) return html.slice(start, index + 1);
    }
  }
  return "";
}

function officialGallery(html, root) {
  const paths = [...html.matchAll(/(?:src|data-src|data-image|data-zoom|href)=["']([^"']+)["']/gi)]
    .map((match) => match[1].replace(/&amp;/g, "&"))
    .filter((path) => /\/content\/images\//.test(path))
    .map((path) => path.startsWith("http") ? path : path.startsWith("/") ? `${root}${path}` : `${root}/${path}`)
    // Ignore small thumbnails and site assets. Product gallery files use 357px+
    // wide source images, while thumbnails use widths such as 35px or 174px.
    .filter((path) => /\/([3-9]\d{2}|[1-9]\d{3,})x\d+/i.test(path));

  const uniqueByFile = new Map();
  for (const path of paths) {
    const filename = path.split("/").at(-1);
    if (!uniqueByFile.has(filename)) uniqueByFile.set(filename, path);
  }
  return [...uniqueByFile.values()];
}

async function fetchWithChallenge(url, headers, cookie = "") {
  const response = await fetch(url, { headers: cookie ? { ...headers, cookie } : headers });
  return { response, html: await response.text() };
}

async function scanPlato({ offset = 0, limit = 8 } = {}) {
  const root = "https://papa-karlo.com.ua";
  const headers = { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalogAudit/1.0)" };
  const initial = await fetchWithChallenge(`${root}/plato/`, headers);
  const challengeHash = firstMatch(initial.html, /defaultHash = "([^"]+)/);
  const rawCookies = initial.response.headers.getSetCookie
    ? initial.response.headers.getSetCookie()
    : [initial.response.headers.get("set-cookie") || ""];
  const cookies = rawCookies
    .flatMap((value) => value ? value.split(/,(?=\s*[^;]+=)/) : [])
    .map((value) => value.split(";")[0])
    .join("; ");
  const sessionCookie = `${cookies}; challenge_passed=${challengeHash}`;
  const listing = challengeHash
    ? await fetchWithChallenge(`${root}/plato/`, headers, sessionCookie)
    : initial;
  const productsJson = jsonArrayAfter(listing.html, "var products = [{");
  const products = productsJson ? JSON.parse(productsJson) : [];
  const urls = products.slice(offset, offset + limit);
  const models = [];

  for (const [index, product] of urls.entries()) {
    if (index) await sleep(1250);
    const page = await fetchWithChallenge(product.url, headers, sessionCookie);
    const rows = [...page.html.matchAll(/<tr[^>]*>[\s\S]*?<th[^>]*>[\s\S]*?<span[^>]*>([\s\S]*?)<\/span>[\s\S]*?<td[^>]*>([\s\S]*?)<\/td>[\s\S]*?<\/tr>/gi)]
      .map((match) => [decode(match[1]), decode(match[2])])
      .filter(([label, value]) => label && value);
    const facts = Object.fromEntries(rows);
    models.push({
      url: product.url,
      status: page.response.status,
      title: decode(firstMatch(page.html, /<h1[^>]*>([\s\S]*?)<\/h1>/i)) || product.title,
      article: decode(firstMatch(page.html, /product-header__code">\s*Артикул:\s*([^<\s]+)/i)) || product.article || "",
      covering: facts["Матеріал покриття"] || "",
      width: facts["Ширина полотна"] || "",
      height: facts["Висота полотна"] || "",
      thickness: facts["Товщина полотна"] || "",
      glass: facts["Наявність скла"] || "",
      colors: facts["Колір"] || "",
      style: facts["Стиль"] || "",
      images: officialGallery(page.html, root),
    });
  }

  return { total: products.length, models };
}

export { scanPlato };
