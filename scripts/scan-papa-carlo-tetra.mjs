const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const decode = (value) => value
  .replace(/&nbsp;/g, " ")
  .replace(/&amp;/g, "&")
  .replace(/&#(\d+);/g, (_, number) => String.fromCodePoint(Number(number)))
  .replace(/<[^>]+>/g, " ")
  .replace(/\s+/g, " ")
  .trim();
const firstMatch = (html, expression) => (html.match(expression) || [])[1] || "";

async function scanTetra({ offset = 0, limit = 10 } = {}) {
  const root = "https://papa-karlo.com.ua";
  const headers = { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalogAudit/1.0)" };
  const sitemap = await (await fetch(`${root}/content/export/papa-karlo.com.ua/catalog-sitemap.xml`, { headers })).text();
  const allUrls = [...new Set([...sitemap.matchAll(/<loc>(https:\/\/papa-karlo\.com\.ua\/[^<]+)<\/loc>/g)]
    .map((match) => match[1])
    .filter((url) => /mizhkimnatni-dveri-papa-karlo-t-(?:0?\d|1\d)(?:-blk)?\/$/i.test(url) && !/\/ru\//.test(url)))];
  const urls = allUrls.slice(offset, offset + limit);
  if (!urls.length) return [];

  const challenge = await fetch(urls[0], { headers });
  const challengeHtml = await challenge.text();
  const hash = firstMatch(challengeHtml, /defaultHash = "([^"]+)/);
  const rawCookies = challenge.headers.getSetCookie ? challenge.headers.getSetCookie() : [challenge.headers.get("set-cookie") || ""];
  const cookies = rawCookies.flatMap((value) => value ? value.split(/,(?=\s*[^;]+=)/) : []).map((value) => value.split(";")[0]).join("; ");
  const sessionHeaders = { ...headers, cookie: `${cookies}; challenge_passed=${hash}` };
  const models = [];

  for (const [index, url] of urls.entries()) {
    if (index) await sleep(1250);
    const response = await fetch(url, { headers: sessionHeaders });
    const html = await response.text();
    const rows = [...html.matchAll(/<tr[^>]*>[\s\S]*?<th[^>]*>[\s\S]*?<span[^>]*>([\s\S]*?)<\/span>[\s\S]*?<td[^>]*>([\s\S]*?)<\/td>[\s\S]*?<\/tr>/gi)]
      .map((match) => [decode(match[1]), decode(match[2])])
      .filter(([label, value]) => label && value);
    const featureMap = Object.fromEntries(rows);
    models.push({
      url,
      status: response.status,
      title: decode(firstMatch(html, /<h1[^>]*>([\s\S]*?)<\/h1>/i)),
      article: decode(firstMatch(html, /product-header__code">\s*Артикул:\s*([^<\s]+)/i)),
      covering: featureMap["Матеріал покриття"] || "",
      width: featureMap["Ширина полотна"] || "",
      height: featureMap["Висота полотна"] || "",
      thickness: featureMap["Товщина полотна"] || "",
      glass: featureMap["Наявність скла"] || "",
      images: [...new Set([...html.matchAll(/https:\/\/papa-karlo\.com\.ua\/content\/images\/[^"'\\]+/g)].map((match) => match[0]))].slice(0, 8),
    });
  }

  return models;
}

export { scanTetra };
