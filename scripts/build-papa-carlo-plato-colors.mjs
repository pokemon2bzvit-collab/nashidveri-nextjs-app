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
for (let offset = 8; offset < first.total; offset += 8) scans.push(await scanPlato({ offset, limit: 8 }));

const models = scans.flatMap((scan) => scan.models).filter((model) => model.colors).map((model) => ({
  slug: `papa-carlo-${codeFrom(model.title).toLowerCase()}-official`,
  colors: model.colors,
}));

if (models.length !== first.total) throw new Error(`Кольори знайдені лише для ${models.length} з ${first.total} моделей.`);

console.log("-- Офіційні доступні кольори Papa Carlo Plato.");
console.log("begin;");
console.log("delete from public.product_specs");
console.log("where label = 'Доступні декори' and product_slug in (");
console.log("  select slug from public.products where brand = 'Papa Carlo' and collection = 'Plato'");
console.log(");");
console.log("insert into public.product_specs (product_slug, label, value, sort_order, is_visible) values");
console.log(models.map((model) => `(${sql(model.slug)}, 'Доступні декори', ${sql(model.colors)}, 900, true)`).join(",\n"));
console.log(";");
console.log("commit;");
console.log("select count(*) as моделей_з_кольорами from public.product_specs");
console.log("where label = 'Доступні декори' and product_slug in (");
console.log("  select slug from public.products where brand = 'Papa Carlo' and collection = 'Plato'");
console.log(");");
