const origin = "https://straj.ua";
const response = await fetch(`${origin}/shop`, {
  headers: { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalogAudit/1.0)" },
});

if (!response.ok) throw new Error(`Страж повернув ${response.status}`);

const html = await response.text();
const links = [...html.matchAll(/href=["']([^"']+)["']/giu)]
  .map((match) => match[1].replace(/&amp;/gu, "&"))
  .filter((href) => /door|dver|catalog|shop|proof|vhod|kvart|vul|street/iu.test(href))
  .map((href) => href.startsWith("http") ? href : new URL(href, origin).href)
  .filter((href, index, list) => list.indexOf(href) === index);

console.log(`Офіційний каталог: ${response.status}; релевантних посилань: ${links.length}`);
console.log(links.join("\n"));
