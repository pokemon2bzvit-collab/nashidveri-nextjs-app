import { scanMilenium } from "./scan-papa-carlo-milenium.mjs";

const sql = (value) => `'${String(value ?? "").replace(/'/g, "''")}'`;

function description(model) {
  const covering = model.covering?.includes("Renolit")
    ? "з поліпропіленовим покриттям Renolit (Німеччина)"
    : model.covering ? `з покриттям ${model.covering.toLowerCase()}` : "";
  return `${model.code} — міжкімнатні двері колекції Milenium${covering ? ` ${covering}` : ""}. Покриття стійке до повсякденних пошкоджень і допомагає зберігати охайний вигляд дверей. Для моделі доступні різні кольори та варіанти оздоблення. Актуальну комплектацію й ціну уточнюйте у менеджера.`;
}

const first = await scanMilenium({ offset: 0, limit: 8 });
const scans = [first];
for (let offset = 8; offset < first.total; offset += 8) scans.push(await scanMilenium({ offset, limit: 8 }));
const models = scans.flatMap((scan) => scan.models).map((model, index) => ({
  ...model,
  slug: `papa-carlo-${model.code.toLowerCase().replace(/\s+/g, "-")}-official`,
  sortOrder: 700 + index,
}));

const invalidModels = models.filter((model) => model.status !== 200 || !model.code || !model.images.length);
if (models.length !== first.total || invalidModels.length) {
  throw new Error(`Неповні картки Milenium: ${invalidModels.map((model) => `${model.title || model.url} [status=${model.status}, code=${model.code || '-'}, photos=${model.images.length}]`).join('; ')}`);
}

const productRows = models.map((model) => `(${[
  model.slug, "interior", "Papa Carlo", "Milenium", `Papa Carlo ${model.code}`, "Міжкімнатні", "Колекція Milenium", "Варіанти декорів і скла", "Ціна за запитом", description(model),
  JSON.stringify(["Фабрика Papa Carlo", "Колекція Milenium"]), model.images[0], model.sortOrder, true,
].map(sql).join(", ")})`);

const specRows = models.flatMap((model) => [
  ["Розміри полотна", model.width ? `ширина: ${model.width}; висота: ${model.height || "уточнюйте"}` : "", 100],
  ["Товщина полотна", model.thickness, 110],
  ["Матеріал покриття", model.covering, 120],
  ["Наявність скла", model.glass.toLowerCase() === "глухі" ? "" : model.glass, 130],
  ["Стиль", model.style, 140],
  ["Декор", model.colors, 900],
].filter(([, value]) => value).map(([label, value, sortOrder]) => `(${[model.slug, label, value, sortOrder, true].map(sql).join(", ")})`));

const mediaRows = models.flatMap((model) => model.images.map((image, index) => `(${[
  model.slug, index === 0 ? "main" : "gallery", `${model.code} — ${index === 0 ? "головне фото" : `фото ${index + 1}`}`, image, index, true,
].map(sql).join(", ")})`));

console.log("-- Повна офіційна заміна Papa Carlo / Milenium.");
console.log(`-- ${models.length} моделей, ${mediaRows.length} унікальних фото. Конфігуратор декорів не імпортується.`);
console.log("begin;");
console.log("create table if not exists public.catalog_import_backups (id bigint generated always as identity primary key, created_at timestamptz not null default now(), scope text not null, payload jsonb not null);");
console.log("insert into public.catalog_import_backups (scope, payload) select 'Papa Carlo / Milenium before official replacement', jsonb_build_object('products', coalesce((select jsonb_agg(to_jsonb(p)) from public.products p where p.brand = 'Papa Carlo' and p.collection = 'Milenium'), '[]'::jsonb), 'product_specs', coalesce((select jsonb_agg(to_jsonb(s)) from public.product_specs s join public.products p on p.slug = s.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Milenium'), '[]'::jsonb), 'product_options', coalesce((select jsonb_agg(to_jsonb(o)) from public.product_options o join public.products p on p.slug = o.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Milenium'), '[]'::jsonb), 'product_variants', coalesce((select jsonb_agg(to_jsonb(v)) from public.product_variants v join public.products p on p.slug = v.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Milenium'), '[]'::jsonb), 'product_media', coalesce((select jsonb_agg(to_jsonb(m)) from public.product_media m join public.products p on p.slug = m.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Milenium'), '[]'::jsonb), 'product_sources', coalesce((select jsonb_agg(to_jsonb(src)) from public.product_sources src join public.products p on p.slug = src.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Milenium'), '[]'::jsonb));");
console.log("delete from public.products where brand = 'Papa Carlo' and collection = 'Milenium';");
console.log("insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values");
console.log(productRows.join(",\n"));
console.log("on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path, sort_order = excluded.sort_order, is_available = true;");
console.log("insert into public.product_specs (product_slug, label, value, sort_order, is_active) values");
console.log(specRows.join(",\n") + ";");
console.log("insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values");
console.log(mediaRows.join(",\n"));
console.log("on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;");
console.log("insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values");
console.log(models.map((model) => `(${[model.slug, "Papa Carlo", model.url, model.title, "verified", "now()", "Офіційна картка Papa Carlo: фото, галерея, декори й базові технічні параметри."].map((value, index) => index === 5 ? value : sql(value)).join(", ")})`).join(",\n"));
console.log("on conflict (product_slug, source_url) do update set source_product_name = excluded.source_product_name, verification_status = 'verified', verified_at = now(), notes = excluded.notes;");
console.log("commit;");
console.log("select count(*) as моделей_у_milenium, count(*) filter (where is_available) as опубліковано from public.products where brand = 'Papa Carlo' and collection = 'Milenium';");
