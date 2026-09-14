import { scanPlato } from "./scan-papa-carlo-plato.mjs";

function sql(value) {
  return `'${String(value ?? "").replace(/'/g, "''")}'`;
}

function codeFrom(title) {
  const match = title.match(/\bPL\s*-?\s*(\d+[a-z]?)/i);
  if (!match) throw new Error(`Не вдалося визначити код Plato: ${title}`);
  return `PL-${match[1].toUpperCase()}`;
}

const first = await scanPlato({ offset: 0, limit: 8 });
const scans = [first];
for (let offset = 8; offset < first.total; offset += 8) {
  scans.push(await scanPlato({ offset, limit: 8 }));
}

const models = scans.flatMap((scan) => scan.models).map((model) => ({
  ...model,
  code: codeFrom(model.title),
  slug: `papa-carlo-${codeFrom(model.title).toLowerCase()}-official`,
}));

if (models.length !== first.total || models.some((model) => model.status !== 200 || !model.images.length)) {
  throw new Error("Не всі картки Plato віддали коректний статус або хоча б одне фото.");
}

const rows = models.flatMap((model) => model.images.map((image, index) => [
  model.slug,
  index === 0 ? "main" : "gallery",
  `${model.code} — ${index === 0 ? "головне фото" : `фото ${index + 1}`}`,
  image,
  index,
  true,
]));

console.log(`-- Автоматично згенеровано з офіційних карток Papa Carlo Plato.`);
console.log(`-- ${models.length} моделей, ${rows.length} унікальних фото для галереї.`);
console.log("");
console.log("begin;");
console.log("");
console.log("delete from public.product_media");
console.log("where product_slug in (");
console.log("  select slug from public.products where brand = 'Papa Carlo' and collection = 'Plato'");
console.log(");");
console.log("");
console.log("insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values");
console.log(rows.map((row) => `(${row.map(sql).join(", ")})`).join(",\n"));
console.log("on conflict (product_slug, kind, image_path) do update");
console.log("set label = excluded.label, sort_order = excluded.sort_order, is_active = true;");
console.log("");
console.log("commit;");
console.log("");
console.log("select count(distinct product_slug) as моделей_з_галереєю, count(*) as усіх_фото");
console.log("from public.product_media");
console.log("where product_slug in (");
console.log("  select slug from public.products where brand = 'Papa Carlo' and collection = 'Plato'");
console.log(");");
