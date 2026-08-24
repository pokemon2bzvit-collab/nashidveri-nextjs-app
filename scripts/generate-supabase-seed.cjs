const fs = require("node:fs");
const path = require("node:path");
const { importedProducts } = require("../lib/imported-catalog.ts");

const sql = (value) => `'${String(value).replaceAll("'", "''")}'`;
const rows = importedProducts.map((product, index) => {
  const values = [
    product.slug,
    product.category,
    product.brand,
    product.collection,
    product.name,
    product.material,
    product.style,
    product.color,
    product.price,
    product.description,
    JSON.stringify(product.features),
    path.basename(product.image),
    index + 1,
  ].map(sql).join(", ");
  return `(${values})`;
});

const content = `-- Автоматично сформовано з чинного каталогу.\n-- Містить ${importedProducts.length} моделей.\n\ninsert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order)\nvalues\n${rows.join(",\n")}\non conflict (slug) do update set\n  category = excluded.category,\n  brand = excluded.brand,\n  collection = excluded.collection,\n  name = excluded.name,\n  material = excluded.material,\n  style = excluded.style,\n  color = excluded.color,\n  price = excluded.price,\n  description = excluded.description,\n  features = excluded.features,\n  image_path = excluded.image_path,\n  sort_order = excluded.sort_order,\n  updated_at = now();\n`;

fs.writeFileSync(path.join(__dirname, "..", "supabase", "seed-products.sql"), content, "utf8");
