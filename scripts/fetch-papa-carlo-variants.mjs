import { mkdir, writeFile } from "node:fs/promises";
import { join } from "node:path";

const [productSlug, productUrl] = process.argv.slice(2);
if (!productSlug || !productUrl) {
  throw new Error("Usage: node scripts/fetch-papa-carlo-variants.mjs <catalog-slug> <official-product-url>");
}

const origin = "https://papa-carlo.com.ua";
const outputDirectory = join("tmp", "papa-carlo-variants", productSlug);
const storageDirectory = "";
const page = await fetch(productUrl).then(async (response) => {
  if (!response.ok) throw new Error(`Papa Carlo returned ${response.status} for ${productUrl}`);
  return response.text();
});

const jsonMatch = page.match(/const variants = (\{.+?\});<\/script>/s);
if (!jsonMatch) throw new Error("Could not find the variants data on the official product page.");
const variants = Object.values(JSON.parse(jsonMatch[1]));

const normaliseLabel = (label) => label.replace(/\s+/g, " ").trim();
const readOptions = (group) => [...page.matchAll(new RegExp(`<input[^>]*id="${group}-(\\d+)"[^>]*name="${group}"[^>]*value="(\\d+)"[^>]*>[\\s\\S]{0,500}?<img[^>]*alt="([^"]+)"`, "g"))]
  .map((match) => ({ id: match[2], label: normaliseLabel(match[3]) }));
const colors = new Map(readOptions("color").map((item) => [item.id, item.label]));
const edges = new Map(readOptions("edge").map((item) => [item.id, item.label]));
const glass = new Map(readOptions("glass").map((item) => [item.id, item.label]));

await mkdir(outputDirectory, { recursive: true });
const rows = [];
for (const variant of variants) {
  const relativeImage = variant.image_cover.replaceAll("\\/", "/");
  const extension = relativeImage.match(/\.(jpg|jpeg|png|webp)$/i)?.[1] || "jpg";
  const filename = `papa-carlo-${productSlug}-${variant.variant_id}.${extension}`;
  const response = await fetch(`${origin}${relativeImage}`);
  if (!response.ok) throw new Error(`Could not download variant ${variant.variant_id}: ${response.status}`);
  await writeFile(join(outputDirectory, filename), Buffer.from(await response.arrayBuffer()));
  const selections = {};
  if (colors.has(variant.material_id)) selections.color = colors.get(variant.material_id);
  if (edges.has(variant.edge_id)) selections.edge = edges.get(variant.edge_id);
  if (glass.has(variant.glass_id)) selections.glass = glass.get(variant.glass_id);
  rows.push({ selections, imagePath: storageDirectory ? `${storageDirectory}/${filename}` : filename, sortOrder: Number(variant.variant_id) });
}

// The manufacturer's feed can contain the same set of options more than once
// (for example, distinct internal identifiers for the same finish). The site
// stores one image per selectable combination, so retain the first match.
const uniqueRows = [...new Map(rows.map((row) => [JSON.stringify(row.selections), row])).values()];
const sqlString = (value) => String(value).replaceAll("'", "''");
const values = uniqueRows.map((row) => `('${sqlString(productSlug)}', '${sqlString(JSON.stringify(row.selections))}'::jsonb, '${sqlString(row.imagePath)}', ${row.sortOrder})`).join(",\n");
const sql = `-- Фото з офіційної сторінки Papa Carlo: ${productUrl}\n-- Завантажте вміст папки ${outputDirectory.replaceAll("\\\\", "/")} у корінь bucket catalog-images.\n\ninsert into public.product_variants (product_slug, selections, image_path, sort_order)\nvalues\n${values}\non conflict (product_slug, selections) do update\nset image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;\n`;
await writeFile(join("supabase", `${productSlug}-variants-seed.sql`), sql);

const optionMetadata = {
  color: { label: "Колір полотна", source: colors },
  edge: { label: "Кромка / торець", source: edges },
  glass: { label: "Скло", source: glass },
};
const optionValues = Object.entries(optionMetadata).flatMap(([group, meta]) => {
  const usedLabels = new Set(rows.map((row) => row.selections[group]).filter(Boolean));
  return [...meta.source.values()]
    .filter((label) => usedLabels.has(label))
    .map((label, sortOrder) => `('${sqlString(productSlug)}', '${group}', '${sqlString(meta.label)}', '${sqlString(label)}', null, null, ${sortOrder})`);
});
const optionsSql = `-- Варіанти, підтверджені офіційною сторінкою Papa Carlo: ${productUrl}
-- Потрібна таблиця product_options (див. product-options-migration.sql).

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
values
${optionValues.join(",\n")}
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
`;
await writeFile(join("supabase", `${productSlug}-options-seed.sql`), optionsSql);
console.log(`Downloaded ${rows.length} official variants into ${outputDirectory} and generated option data.`);
