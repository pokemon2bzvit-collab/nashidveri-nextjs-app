const url = process.argv[2] || "https://straj.ua/product/alfa_rio_double";
const clean = (value = "") => value.replace(/<[^>]+>/gu, " ").replace(/&nbsp;/giu, " ").replace(/\s+/gu, " ").trim();
const response = await fetch(url, {
  headers: { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalogAudit/1.0)" },
});
if (!response.ok) throw new Error(`${url}: ${response.status}`);

const html = await response.text();
const title = html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/iu)?.[1]?.replace(/<[^>]*>/gu, " ").replace(/\s+/gu, " ").trim();
const jsonLd = [...html.matchAll(/<script[^>]+type=["']application\/ld\+json["'][^>]*>([\s\S]*?)<\/script>/giu)]
  .map((match) => match[1].trim());
const images = [...html.matchAll(/(?:src|href)=["']([^"']+\.(?:jpe?g|png|webp)[^"']*)["']/giu)]
  .map((match) => new URL(match[1].replace(/&amp;/gu, "&"), url).href)
  .filter((value, index, list) => list.indexOf(value) === index);
const text = html
  .replace(/<script[\s\S]*?<\/script>/giu, " ")
  .replace(/<style[\s\S]*?<\/style>/giu, " ")
  .replace(/<[^>]+>/gu, " ")
  .replace(/&nbsp;/giu, " ")
  .replace(/&amp;/giu, "&")
  .replace(/\s+/gu, " ")
  .trim();
const snippets = ["Характерист", "Товщина", "Замок", "Колір", "Декор"]
  .map((needle) => {
    const index = text.toLocaleLowerCase("uk-UA").indexOf(needle.toLocaleLowerCase("uk-UA"));
    return index >= 0 ? text.slice(Math.max(0, index - 80), index + 420) : null;
  })
  .filter(Boolean);
const categoryMarkers = [...html.matchAll(/.{0,100}(?:type_door|purpose|category|collection|квартир|вулич|приватного будинку).{0,180}/giu)]
  .map((match) => clean(match[0]))
  .filter((value, index, list) => list.indexOf(value) === index)
  .slice(0, 25);
const coverContexts = [...html.matchAll(/.{0,240}assets\/cover\/245x245\/.{0,240}/giu)]
  .map((match) => clean(match[0]))
  .slice(0, 8);
const configurationHtml = (() => {
  const index = html.indexOf("PF Securemme");
  return index >= 0 ? html.slice(Math.max(0, index - 1400), index + 2400) : null;
})();

console.log(JSON.stringify({
  url,
  status: response.status,
  title,
  htmlLength: html.length,
  jsonLd,
  images: images.slice(0, 30),
  imageCount: images.length,
  hasSpecsWords: /характерист|товщина|замок|полотно|короб/iu.test(html),
  snippets,
  categoryMarkers,
  coverContexts,
  configurationHtml,
}, null, 2));
