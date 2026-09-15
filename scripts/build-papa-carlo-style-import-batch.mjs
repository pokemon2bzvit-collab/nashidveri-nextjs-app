import { scanStyle } from "./scan-papa-carlo-style.mjs";
import { writeFileSync } from "node:fs";

const offset = Number(process.argv[2] || 0);
const limit = Number(process.argv[3] || 20);
const outputPath = process.argv[4] || process.env.SQL_OUTPUT_FILE;
const outputLines = [];
if (outputPath) console.log = (line = "") => outputLines.push(String(line));
const sql = (value) => `'${String(value ?? "").replace(/'/g, "''")}'`;

function description(model) {
  const covering = model.covering?.includes("Renolit")
    ? "з поліпропіленовим покриттям Renolit (Німеччина)"
    : model.covering ? `з покриттям ${model.covering.toLowerCase()}` : "";
  return `${model.code} — міжкімнатні двері колекції Style${covering ? ` ${covering}` : ""}. Покриття стійке до повсякденних пошкоджень і допомагає зберігати охайний вигляд дверей. Для моделі доступні різні кольори та варіанти оздоблення. Актуальну комплектацію й ціну уточнюйте у менеджера.`;
}

const scan = await scanStyle({ offset, limit });
const models = scan.models.map((model, index) => ({ ...model, slug: `papa-carlo-${model.code.toLowerCase().replace(/\s+/g, "-")}-official`, sortOrder: 850 + offset + index }));
const invalid = models.filter((model) => model.status !== 200 || !model.code || !model.images.length);
if (!models.length || invalid.length) throw new Error(`Неповні картки: ${invalid.map((model) => model.url).join(", ") || "порожній пакет"}`);

const products = models.map((model) => `(${[
  model.slug, "interior", "Papa Carlo", "Style", `Papa Carlo ${model.code}`, "Міжкімнатні", "Колекція Style", "Варіанти декорів і скла", "Ціна за запитом", description(model), JSON.stringify(["Фабрика Papa Carlo", "Колекція Style"]), model.images[0], model.sortOrder, true,
].map(sql).join(", ")})`);
const specs = models.flatMap((model) => [
  ["Розміри полотна", model.width ? `ширина: ${model.width}; висота: ${model.height || "уточнюйте"}` : "", 100],
  ["Товщина полотна", model.thickness, 110],
  ["Матеріал покриття", model.covering, 120],
  ["Наявність скла", model.glass.toLowerCase() === "глухі" ? "" : model.glass, 130],
  ["Стиль", model.style, 140],
  ["Декор", model.colors, 900],
].filter(([, value]) => value).map(([label, value, order]) => `(${[model.slug, label, value, order, true].map(sql).join(", ")})`));
const media = models.flatMap((model) => model.images.map((image, index) => `(${[
  model.slug, index === 0 ? "main" : "gallery", `${model.code} — ${index === 0 ? "головне фото" : `фото ${index + 1}`}`, image, index, true,
].map(sql).join(", ")})`));

console.log(`-- Papa Carlo Style: пакет ${offset + 1}–${offset + models.length} з ${scan.total}.`);
console.log("begin;");
console.log("insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values");
console.log(products.join(",\n"));
console.log("on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path, sort_order = excluded.sort_order, is_available = true;");
console.log("insert into public.product_specs (product_slug, label, value, sort_order, is_active) values");
console.log(specs.join(",\n") + ";");
console.log("insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values");
console.log(media.join(",\n"));
console.log("on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;");
console.log("insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values");
console.log(models.map((model) => `(${[model.slug, "Papa Carlo", model.url, model.title, "verified", "now()", "Офіційна картка Papa Carlo: фото, галерея, декори й базові технічні параметри."].map((value, index) => index === 5 ? value : sql(value)).join(", ")})`).join(",\n"));
console.log("on conflict (product_slug, source_url) do update set source_product_name = excluded.source_product_name, verification_status = 'verified', verified_at = now(), notes = excluded.notes;");
console.log("commit;");
if (outputPath) writeFileSync(outputPath, `${outputLines.join("\n")}\n`);
