const url = process.argv[2] || "https://straj.ua/product/alfa_rio_double";
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
}, null, 2));
