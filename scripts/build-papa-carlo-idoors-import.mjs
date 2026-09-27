import { writeFileSync } from "node:fs";
import { scanIDoors } from "./scan-papa-carlo-idoors.mjs";

const outputPath = process.argv[2];
const lines = [];
const emit = (line = "") => lines.push(String(line));
const sql = (value) => `'${String(value ?? "").replace(/'/g, "''")}'`;
const slugify = (value) => value.toLowerCase().replace(/[^a-zа-яіїє0-9]+/gi, "-").replace(/^-|-$/g, "");
function description(model) {
  const opening = /inside|внутріш/i.test(model.title) ? "внутрішнього" : "зовнішнього";
  const construction = /\(ч\)/i.test(model.title) ? "зі склом" : "глуха модель";
  return `${model.name} — приховані міжкімнатні двері: ${construction}, для ${opening} відкривання. Алюмінієвий прихований короб і поліпропіленове покриття Renolit (Німеччина) допомагають створити лаконічний інтер'єр. Актуальну комплектацію й ціну уточнюйте у менеджера.`;
}
const scan = await scanIDoors();
const models = scan.models.map((model, index) => ({ ...model, slug: `papa-carlo-idoors-${slugify(model.url.split("/").at(-1))}`, name: model.title.replace(/^Двері прихованого монтажу Папа Карло\s+/i, "Papa Carlo ").replace(/\s*-\s*Двері прихованого монтажу iDoors$/i, ""), sortOrder: 950 + index }));
const invalid = models.filter((model) => model.status !== 200 || !model.images.length);
if (models.length !== 4 || invalid.length) throw new Error(`Неповні картки iDoors: ${invalid.map((m) => m.url).join(", ") || `знайдено ${models.length}`}`);
const products = models.map((m) => `(${[m.slug, "interior", "Papa Carlo", "iDoors", m.name, "Міжкімнатні", "Прихований монтаж", "Варіанти виконання", "Ціна за запитом", description(m), JSON.stringify(["Фабрика Papa Carlo", "Колекція iDoors"]), m.images[0], m.sortOrder, true].map(sql).join(", ")})`);
const specs = models.flatMap((m) => [["Розміри полотна", m.width ? `ширина: ${m.width}; висота: ${m.height}` : "", 100], ["Товщина полотна", m.thickness, 110], ["Матеріал покриття", m.covering, 120], ["Каркас", m.frame, 130], ["Внутрішнє наповнення", m.filling, 140], ["Шумоізоляція", m.sound, 150], ["Гарантія виробника", m.warranty, 900]].filter(([, value]) => value).map(([label, value, order]) => `(${[m.slug, label, value, order, true].map(sql).join(", ")})`));
const media = models.flatMap((m) => m.images.map((image, index) => `(${[m.slug, index ? "gallery" : "main", `${m.name} — ${index ? `фото ${index + 1}` : "головне фото"}`, image, index, true].map(sql).join(", ")})`));
emit("-- Офіційний імпорт Papa Carlo / iDoors: 4 моделі.");
emit("begin;");
emit("insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values"); emit(products.join(",\n"));
emit("on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path, sort_order = excluded.sort_order, is_available = true;");
emit("insert into public.product_specs (product_slug, label, value, sort_order, is_active) values"); emit(specs.join(",\n") + ";");
emit("insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values"); emit(media.join(",\n"));
emit("on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;");
emit("insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values"); emit(models.map((m) => `(${[m.slug, "Papa Carlo", m.url, m.title, "verified", "now()", "Офіційна картка Papa Carlo: фото та технічні параметри iDoors."].map((v, i) => i === 5 ? v : sql(v)).join(", ")})`).join(",\n"));
emit("on conflict (product_slug, source_url) do update set source_product_name = excluded.source_product_name, verification_status = 'verified', verified_at = now(), notes = excluded.notes;");
emit("commit;");
if (outputPath) writeFileSync(outputPath, `${lines.join("\n")}\n`); else console.log(lines.join("\n"));
