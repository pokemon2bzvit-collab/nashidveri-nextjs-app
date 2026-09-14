import { scanPlato } from "./scan-papa-carlo-plato.mjs";

const sql = (value) => `'${String(value ?? "").replaceAll("'", "''")}'`;
const modelCode = (title) => {
  const match = title.replace(/\s+/g, " ").match(/PL-\s*(\d+[a-z]?)/i);
  if (!match) throw new Error(`Не вдалося визначити код Plato: ${title}`);
  return `PL-${match[1]}`;
};
const sizeValue = (model) => `ширина: ${model.width || "уточнюється"}; висота: ${model.height || "уточнюється"}`;
const description = (code, model) => `Papa Carlo ${code} — міжкімнатні двері колекції Plato з покриттям ${model.covering || "Renolit"}. Полотно товщиною ${model.thickness || "уточнюється"}; ${sizeValue(model)}. Двері мають стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні. Актуальну комплектацію й ціну уточнюйте у менеджера.`;

const batches = [];
for (let offset = 0; offset < 40; offset += 8) batches.push(await scanPlato({ offset, limit: 8 }));
const models = batches.flatMap((batch) => batch.models);
if (models.length !== 40 || models.some((model) => model.status !== 200 || !model.images[0])) {
  throw new Error(`Очікували 40 повних карток Plato, отримано ${models.length}.`);
}

const rows = models.map((model, index) => {
  const code = modelCode(model.title);
  const slug = `papa-carlo-${code.toLowerCase()}-official`;
  const image = model.images[0];
  const specs = [
    ["Код виробника", model.article, 90],
    ["Розміри полотна", sizeValue(model), 100],
    ["Товщина полотна", model.thickness, 110],
    ["Матеріал покриття", model.covering, 120],
    ...(model.glass ? [["Наявність скла", model.glass, 130]] : []),
  ].filter(([, value]) => value);
  return { code, slug, image, specs, model, index };
});

const productValues = rows.map(({ code, slug, image, model, index }) => `(${[
  sql(slug), sql("interior"), sql("Papa Carlo"), sql("Plato"), sql(`Papa Carlo ${code}`),
  sql("Міжкімнатні"), sql("Колекція Plato"), sql("Варіанти декорів і скла"),
  sql("Ціна за запитом"), sql(description(code, model)),
  `'["Фабрика Papa Carlo", "Колекція Plato", "Офіційна картка виробника"]'::jsonb`,
  sql(image), String(500 + index), "true",
].join(", ")})`).join(",\n");

const specValues = rows.flatMap(({ slug, specs }) => specs.map(([label, value, sortOrder]) => `(${sql(slug)}, ${sql(label)}, ${sql(value)}, ${sortOrder}, true)`)).join(",\n");
const mediaValues = rows.map(({ code, slug, image }) => `(${sql(slug)}, 'main', ${sql(`Papa Carlo ${code} — головне фото`)}, ${sql(image)}, 0, true)`).join(",\n");
const sourceValues = rows.map(({ code, slug, model }) => `(${sql(slug)}, 'Papa Carlo', ${sql(model.url)}, ${sql(`${model.title}, артикул ${model.article}`)}, 'verified', now(), 'Офіційна картка Papa Carlo: фото та базові технічні параметри.')`).join(",\n");

process.stdout.write(`-- Автоматично згенеровано з офіційного каталогу Papa Carlo Plato.\n-- ${rows.length} моделей, кожна з офіційним головним фото.\n\nbegin;\n\ncreate table if not exists public.catalog_import_backups (\n  id bigint generated always as identity primary key,\n  created_at timestamptz not null default now(),\n  scope text not null,\n  payload jsonb not null\n);\n\ninsert into public.catalog_import_backups (scope, payload)\nselect 'Papa Carlo / Plato', jsonb_build_object(\n  'products', coalesce((select jsonb_agg(to_jsonb(p)) from public.products p where p.brand = 'Papa Carlo' and p.collection = 'Plato'), '[]'::jsonb),\n  'specs', coalesce((select jsonb_agg(to_jsonb(s)) from public.product_specs s join public.products p on p.slug = s.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Plato'), '[]'::jsonb),\n  'options', coalesce((select jsonb_agg(to_jsonb(o)) from public.product_options o join public.products p on p.slug = o.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Plato'), '[]'::jsonb),\n  'variants', coalesce((select jsonb_agg(to_jsonb(v)) from public.product_variants v join public.products p on p.slug = v.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Plato'), '[]'::jsonb),\n  'media', coalesce((select jsonb_agg(to_jsonb(m)) from public.product_media m join public.products p on p.slug = m.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Plato'), '[]'::jsonb),\n  'sources', coalesce((select jsonb_agg(to_jsonb(src)) from public.product_sources src join public.products p on p.slug = src.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Plato'), '[]'::jsonb)\n);\n\n-- Дочірні записи прибираються зовнішніми ключами каскадно; файли у Storage не видаляються.\ndelete from public.products where brand = 'Papa Carlo' and collection = 'Plato';\n\ninsert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values\n${productValues}\non conflict (slug) do update set\n  name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color,\n  description = excluded.description, features = excluded.features, image_path = excluded.image_path,\n  sort_order = excluded.sort_order, is_available = true, updated_at = now();\n\ninsert into public.product_specs (product_slug, label, value, sort_order, is_active) values\n${specValues}\non conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;\n\ninsert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values\n${mediaValues}\non conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;\n\ninsert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values\n${sourceValues}\non conflict (product_slug, source_url) do update set source_product_name = excluded.source_product_name, verification_status = 'verified', verified_at = now(), notes = excluded.notes;\n\ncommit;\n\nselect count(*) as моделей_у_plato, count(*) filter (where is_available) as опубліковано\nfrom public.products\nwhere brand = 'Papa Carlo' and collection = 'Plato';\n`);
