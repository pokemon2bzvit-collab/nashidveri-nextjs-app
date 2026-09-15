const root = "https://papa-karlo.com.ua";
const headers = { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalogAudit/1.0)" };
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const decode = (value = "") => value.replace(/&nbsp;/g, " ").replace(/&amp;/g, "&").replace(/&#(\d+);/g, (_, n) => String.fromCodePoint(Number(n))).replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").replace(/\s*,\s*/g, ", ").trim();

async function getPage(url, cookie = "") {
  const response = await fetch(url, { headers: cookie ? { ...headers, cookie } : headers });
  return { response, html: await response.text() };
}

function gallery(html) {
  const all = [...html.matchAll(/(?:src|data-src|data-image|data-zoom|href)=["']([^"']+)["']/gi)]
    .map((match) => match[1].replace(/&amp;/g, "&"))
    .filter((path) => /\/content\/images\//.test(path))
    .map((path) => path.startsWith("http") ? path : `${root}${path.startsWith("/") ? "" : "/"}${path}`)
    .filter((path) => {
      const size = path.match(/\/(\d+)x(\d+)/i);
      return size && Number(size[1]) >= 250 && Number(size[1]) / Number(size[2]) <= 0.85;
    });
  return [...new Map(all.map((url) => [url.split("/").at(-1), url])).values()];
}

function facts(html) {
  return Object.fromEntries([...html.matchAll(/<tr[^>]*>[\s\S]*?<th[^>]*>[\s\S]*?<span[^>]*>([\s\S]*?)<\/span>[\s\S]*?<td[^>]*>([\s\S]*?)<\/td>[\s\S]*?<\/tr>/gi)].map((match) => [decode(match[1]), decode(match[2])]).filter(([label, value]) => label && value));
}

async function session() {
  const url = `${root}/prykhovani/`;
  const first = await getPage(url);
  const cat = first.html.match(/defaultHash = "([^"]+)/)?.[1] || "";
  const second = await getPage(url, `challenge_passed_cat=${cat}`);
  const normal = second.html.match(/defaultHash = "([^"]+)/)?.[1] || "";
  const final = await getPage(url, `challenge_passed_cat=${cat}; challenge_passed=${normal}`);
  if (final.response.status !== 200 || !/prime-al/i.test(final.html)) throw new Error("Не вдалося відкрити каталог iDoors.");
  return { listing: final.html, cookie: `challenge_passed_cat=${cat}; challenge_passed=${normal}` };
}

async function scanIDoors() {
  const { listing, cookie } = await session();
  const paths = [...new Set([...listing.matchAll(/href=["'](\/dveri-prykhovanoho-montazhu-papa-karlo-prime-[^"'?#/]+\/?)["']/gi)].map((match) => match[1].replace(/\/$/, "")))];
  const models = [];
  for (const [index, path] of paths.entries()) {
    if (index) await sleep(1000);
    const page = await getPage(`${root}${path}`, cookie);
    const title = decode((page.html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i) || [])[1] || "");
    const data = facts(page.html);
    models.push({ url: `${root}${path}`, title, status: page.response.status, images: gallery(page.html), width: data["Ширина полотна"] || "", height: data["Висота полотна"] || "", thickness: data["Товщина полотна"] || "", covering: data["Матеріал покриття"] || "", frame: data["Каркас"] || "", filling: data["Внутрішнє наповнення"] || "", sound: data["Шумоізоляція"] || "", warranty: data["Гарантія"] || "", glass: data["Наявність скла"] || "" });
  }
  return { total: paths.length, models };
}

export { scanIDoors };
