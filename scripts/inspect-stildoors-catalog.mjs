const baseUrl = 'https://stildoors.com.ua';
const collectionSlugs = ['loft', 'deluxe', 'presto', 'solara', 'simpli-loft', 'classic', 'stil', 'rondo', 'riko'];
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const result = [];
for (const collectionSlug of collectionSlugs) {
  // The official catalog shows only the first 10 variants by default.
  // `items=100` exposes the whole collection without submitting an order form.
  const url = `${baseUrl}/dveri/${collectionSlug}/?items=100&filter=1`;
  const response = await fetch(url, { headers });
  const html = await response.text();
  const productUrls = [...html.matchAll(/href=["'](https:\/\/stildoors\.com\.ua\/dveri\/[^"'#?]+)["']/gi)]
    .map((match) => match[1].replace(/\/$/, ''))
    .filter((href) => href.split('/').filter(Boolean).length >= 6);

  for (const href of new Set(productUrls)) {
    const parts = new URL(href).pathname.split('/').filter(Boolean);
    const [, collection, model] = parts;
    if (collection !== collectionSlug || !model) continue;
    result.push({ collection, model, example_url: href });
  }
  await sleep(350);
}

const models = Object.values(result.reduce((byKey, item) => {
  byKey[`${item.collection}/${item.model}`] ??= item;
  return byKey;
}, {})).sort((a, b) => `${a.collection}/${a.model}`.localeCompare(`${b.collection}/${b.model}`, 'uk'));

console.log(JSON.stringify({ collections: collectionSlugs.length, card_variants: result.length, unique_models: models.length, models }, null, 2));
