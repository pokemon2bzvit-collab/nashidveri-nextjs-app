import { importedProducts } from "./imported-catalog";

export type Category = "interior" | "entrance" | "windows";
export type ProductMedia = { kind: "main" | "gallery" | "palette"; label: string | null; image: string; sortOrder: number };
export type ProductOption = { group: "color" | "finish" | "glass" | "edge" | "configuration"; groupLabel: string; label: string; swatch: string | null; image: string | null; sortOrder: number };
export type ProductVariant = { selections: Record<string, string>; image: string; sortOrder: number };
export type ProductSpec = { label: string; value: string; sortOrder: number };
export type Product = { slug: string; category: Category; brand: string; collection: string; name: string; material: string; style: string; color: string; price: string; description: string; features: string[]; image: string; media?: ProductMedia[]; options?: ProductOption[]; variants?: ProductVariant[]; specs?: ProductSpec[] };
export type CatalogDecorOption = Pick<ProductOption, "group" | "label" | "swatch" | "image">;
export type CatalogCardProduct = Pick<Product, "slug" | "category" | "brand" | "collection" | "name" | "material" | "style" | "color" | "price" | "description" | "image"> & { highlights: string[]; decorOptions: CatalogDecorOption[]; keySpecs: ProductSpec[]; searchText: string };

export const categories: Record<Category, { title: string; short: string; description: string; image: string }> = {
  interior: { title: "Міжкімнатні двері", short: "Міжкімнатні", description: "Колекції дверей від Papa Carlo, Rodos, Термінус, Grand та StilDoors.", image: "/catalog-assets/products/product-85.jpg" },
  entrance: { title: "Вхідні двері", short: "Вхідні", description: "Вхідні двері Abwehr, Rodos Steel, Страж, Q Doors та Magda.", image: "/catalog-assets/products/product-200.jpg" },
  windows: { title: "Вікна", short: "Вікна", description: "Віконні системи для квартири, будинку й тераси.", image: "" },
};

const catalogHighlights = (product: Product) => {
  const source = `${product.description} ${product.features.join(" ")}`.toLowerCase();
  const highlights: string[] = [];
  if (/терморозрив/.test(source)) highlights.push("Терморозрив");
  if (/дзеркал/.test(source)) highlights.push("Дзеркало");
  if (/шпон/.test(source)) highlights.push("Шпон");
  if (/екошпон/.test(source)) highlights.push("Екошпон");
  if (/пвх/.test(source)) highlights.push("ПВХ");
  if (/фарб/.test(source) && !highlights.includes("ПВХ")) highlights.push("Фарба");
  if (!highlights.length && product.category === "entrance" && product.collection === "Квартира") highlights.push("Для квартири");
  if (!highlights.length && product.category === "entrance" && product.collection === "Вулиця") highlights.push("Для будинку");
  if (!highlights.length && product.category === "interior") highlights.push("Міжкімнатні");
  return highlights.slice(0, 2);
};

const catalogSpecPriority = (label: string) => {
  const normalized = label.toLowerCase();
  if (/розмір|габарит/.test(normalized)) return 0;
  if (/товщина.*(полот|сталі|метал)|товщина/.test(normalized)) return 1;
  if (/покрит|оздоблен|матеріал/.test(normalized)) return 2;
  if (/утеплен|терморозрив|ущільнен/.test(normalized)) return 3;
  if (/скло|замок/.test(normalized)) return 4;
  return 10;
};

// Список каталогу отримує тільки дані, потрібні для картки та фільтрів.
// Повні варіанти, палітри й характеристики лишаються на сторінці товару.
export const toCatalogCardProduct = (product: Product): CatalogCardProduct => {
  const visibleVariantKeys = new Set((product.variants || []).flatMap((variant) => Object.entries(variant.selections)
    .filter(([group, label]) => Boolean(variant.image) && (group === "color" || group === "finish") && Boolean(label))
    .map(([group, label]) => `${group}:${label}`)));
  const decorOptions = (product.options || [])
    .filter((option) => (option.group === "color" || option.group === "finish") && visibleVariantKeys.has(`${option.group}:${option.label}`))
    .map(({ group, label, swatch, image }) => ({ group, label, swatch, image }));
  const description = product.description.replace(/\s+/g, " ").trim().slice(0, 280);
  return {
    slug: product.slug, category: product.category, brand: product.brand, collection: product.collection, name: product.name,
    material: product.material, style: product.style, color: product.color, price: product.price, image: product.image, description,
    highlights: catalogHighlights(product), decorOptions,
    keySpecs: [...(product.specs || [])].sort((left, right) => catalogSpecPriority(left.label) - catalogSpecPriority(right.label) || left.sortOrder - right.sortOrder).slice(0, 3),
    searchText: `${product.name} ${product.brand} ${product.collection} ${product.material} ${product.style} ${product.color} ${product.features.join(" ")} ${product.description.slice(0, 320)}`.toLowerCase(),
  };
};

export type CatalogBrowseQuery = { category?: string; brand?: string; collection?: string; material?: string; style?: string; color?: string; priceRange?: string; search?: string; offset?: number; limit?: number };
export type CatalogBrowseData = { products: CatalogCardProduct[]; total: number; catalogTotal: number; facets: { categories: string[]; brands: string[]; collections: string[]; materials: string[]; styles: string[]; colors: string[]; hasPrices: boolean } };

export async function getCatalogBrowseData(query: CatalogBrowseQuery = {}): Promise<CatalogBrowseData> {
  const all = await getProducts();
  const category = query.category || "all";
  const brand = query.brand || "all";
  const collection = query.collection || "all";
  const material = query.material || "all";
  const style = query.style || "all";
  const color = query.color || "all";
  const priceRange = query.priceRange || "all";
  const search = (query.search || "").toLowerCase();
  const categoryProducts = all.filter((product) => category === "all" || product.category === category);
  const brandProducts = categoryProducts.filter((product) => brand === "all" || product.brand === brand);
  const priceValue = (price: string) => Number(price.replace(/[^\d]/g, "")) || null;
  const filtered = brandProducts.filter((product) => {
    const price = priceValue(product.price);
    const matchesPrice = priceRange === "all" || (price !== null && ((priceRange !== "under-10000" || price < 10000) && (priceRange !== "10000-25000" || (price >= 10000 && price < 25000)) && (priceRange !== "over-25000" || price >= 25000)));
    const searchable = `${product.name} ${product.brand} ${product.collection} ${product.material} ${product.style} ${product.color} ${product.features.join(" ")} ${product.description}`.toLowerCase();
    return (collection === "all" || product.collection === collection) && (material === "all" || product.material === material) && (style === "all" || product.style === style) && (color === "all" || product.color === color) && matchesPrice && searchable.includes(search);
  });
  const offset = Math.max(0, query.offset || 0);
  const limit = Math.min(48, Math.max(1, query.limit || 24));
  const unique = (items: string[]) => [...new Set(items)].filter(Boolean);
  return {
    products: filtered.slice(offset, offset + limit).map(toCatalogCardProduct), total: filtered.length, catalogTotal: all.length,
    facets: { categories: unique(all.map((product) => product.category)), brands: unique(categoryProducts.map((product) => product.brand)), collections: unique(brandProducts.map((product) => product.collection)), materials: unique(brandProducts.map((product) => product.material)), styles: unique(brandProducts.map((product) => product.style)), colors: unique(brandProducts.map((product) => product.color)), hasPrices: all.some((product) => priceValue(product.price) !== null) },
  };
}

export const products: Product[] = importedProducts;

type ProductRow = Omit<Product, "image" | "features"> & { features: string[] | null; image_path: string };
type ProductMediaRow = { product_slug: string; kind: ProductMedia["kind"]; label: string | null; image_path: string; sort_order: number };
type ProductOptionRow = { product_slug: string; option_group: ProductOption["group"]; group_label: string; label: string; swatch: string | null; image_path: string | null; sort_order: number };
type ProductVariantRow = { product_slug: string; selections: Record<string, string>; image_path: string; sort_order: number };
type ProductSpecRow = { product_slug: string; label: string; value: string; sort_order: number };
const supabaseUrl = (process.env.NEXT_PUBLIC_SUPABASE_URL || "https://vfdfvqlvxkwgizauxusm.supabase.co").replace(/\/$/, "");
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

export const catalogImageUrl = (image: string) => {
  if (/^https?:\/\//i.test(image)) return image;
  if (!supabaseUrl) return image;
  const storagePath = image.startsWith("/catalog-assets/products/") ? image.split("/").pop() || image : image;
  const encodedPath = storagePath.split("/").filter(Boolean).map(encodeURIComponent).join("/");
  return encodedPath ? `${supabaseUrl}/storage/v1/object/public/catalog-images/${encodedPath}` : image;
};

const mapProduct = (product: ProductRow): Product => ({ ...product, features: product.features || [], image: catalogImageUrl(product.image_path) });
const mapMedia = (media: ProductMediaRow): ProductMedia => ({ kind: media.kind, label: media.label, image: catalogImageUrl(media.image_path), sortOrder: media.sort_order });
const mapOption = (option: ProductOptionRow): ProductOption => ({ group: option.option_group, groupLabel: option.group_label, label: option.label, swatch: option.swatch, image: option.image_path ? catalogImageUrl(option.image_path) : null, sortOrder: option.sort_order });
const mapVariant = (variant: ProductVariantRow): ProductVariant => ({ selections: variant.selections, image: catalogImageUrl(variant.image_path), sortOrder: variant.sort_order });
const mapSpec = (spec: ProductSpecRow): ProductSpec => ({ label: spec.label, value: spec.value, sortOrder: spec.sort_order });

async function getProductExtras(slug: string) {
  if (!supabaseKey) return { media: [] as ProductMedia[], options: [] as ProductOption[], variants: [] as ProductVariant[], specs: [] as ProductSpec[] };
  const filter = `product_slug=eq.${encodeURIComponent(slug)}`;
  const headers = { apikey: supabaseKey, Authorization: `Bearer ${supabaseKey}` };
  const [mediaResponse, optionsResponse, variantsResponse, specsResponse] = await Promise.all([
    // Кеш на хвилину помітно прискорює перше відкриття картки. Зміни з адмінки
    // потрапляють на сайт максимум через 60 секунд.
    fetch(`${supabaseUrl}/rest/v1/product_media?select=product_slug,kind,label,image_path,sort_order&is_active=eq.true&${filter}&order=sort_order.asc`, { headers, next: { revalidate: 60 } }),
    fetch(`${supabaseUrl}/rest/v1/product_options?select=product_slug,option_group,group_label,label,swatch,image_path,sort_order&is_active=eq.true&${filter}&order=sort_order.asc`, { headers, next: { revalidate: 60 } }),
    fetch(`${supabaseUrl}/rest/v1/product_variants?select=product_slug,selections,image_path,sort_order&is_active=eq.true&${filter}&order=sort_order.asc`, { headers, next: { revalidate: 60 } }),
    fetch(`${supabaseUrl}/rest/v1/product_specs?select=product_slug,label,value,sort_order&is_active=eq.true&${filter}&order=sort_order.asc`, { headers, next: { revalidate: 60 } }),
  ]);
  const media = mediaResponse.ok ? (await mediaResponse.json() as ProductMediaRow[]).map(mapMedia) : [];
  const options = optionsResponse.ok ? (await optionsResponse.json() as ProductOptionRow[]).map(mapOption) : [];
  const variants = variantsResponse.ok ? (await variantsResponse.json() as ProductVariantRow[]).map(mapVariant) : [];
  const specs = specsResponse.ok ? (await specsResponse.json() as ProductSpecRow[]).map(mapSpec) : [];
  return { media, options, variants, specs };
}

export async function getProducts(): Promise<Product[]> {
  if (!supabaseKey) return products.map((product) => ({ ...product, image: catalogImageUrl(product.image) }));
  try {
    const headers = { apikey: supabaseKey, Authorization: `Bearer ${supabaseKey}` };
    // Дані для карток отримуємо пакетними запитами, а не окремим
    // запитом до кожної моделі. Так каталог лишається швидким, але картки
    // можуть чесно показати лише декори з підтвердженим фото.
    const [productsResponse, optionsResponse, variantsResponse, specsResponse] = await Promise.all([
      fetch(`${supabaseUrl}/rest/v1/products?select=slug,category,brand,collection,name,material,style,color,price,description,features,image_path&is_available=eq.true&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
      fetch(`${supabaseUrl}/rest/v1/product_options?select=product_slug,option_group,group_label,label,swatch,image_path,sort_order&is_active=eq.true&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
      fetch(`${supabaseUrl}/rest/v1/product_variants?select=product_slug,selections,image_path,sort_order&is_active=eq.true&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
      fetch(`${supabaseUrl}/rest/v1/product_specs?select=product_slug,label,value,sort_order&is_active=eq.true&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
    ]);
    if (!productsResponse.ok) throw new Error(`Supabase returned ${productsResponse.status}`);
    const rows = await productsResponse.json() as ProductRow[];
    const optionRows = optionsResponse.ok ? await optionsResponse.json() as ProductOptionRow[] : [];
    const variantRows = variantsResponse.ok ? await variantsResponse.json() as ProductVariantRow[] : [];
    const specRows = specsResponse.ok ? await specsResponse.json() as ProductSpecRow[] : [];
    const optionsByProduct = new Map<string, ProductOption[]>();
    const variantsByProduct = new Map<string, ProductVariant[]>();
    const specsByProduct = new Map<string, ProductSpec[]>();
    optionRows.forEach((option) => optionsByProduct.set(option.product_slug, [...(optionsByProduct.get(option.product_slug) || []), mapOption(option)]));
    variantRows.forEach((variant) => variantsByProduct.set(variant.product_slug, [...(variantsByProduct.get(variant.product_slug) || []), mapVariant(variant)]));
    specRows.forEach((spec) => specsByProduct.set(spec.product_slug, [...(specsByProduct.get(spec.product_slug) || []), mapSpec(spec)]));
    return rows.map((row) => ({ ...mapProduct(row), options: optionsByProduct.get(row.slug) || [], variants: variantsByProduct.get(row.slug) || [], specs: specsByProduct.get(row.slug) || [] }));
  } catch (error) {
    console.error("Could not load catalog from Supabase", error);
    return products.map((product) => ({ ...product, image: catalogImageUrl(product.image) }));
  }
}

export async function getRelatedProducts(product: Pick<Product, "slug" | "brand" | "collection">, limit = 3): Promise<Product[]> {
  const fallback = () => products
    .filter((item) => item.brand === product.brand && item.collection === product.collection && item.slug !== product.slug)
    .concat(products.filter((item) => item.brand === product.brand && item.collection !== product.collection && item.slug !== product.slug))
    .slice(0, limit)
    .map((item) => ({ ...item, image: catalogImageUrl(item.image) }));

  if (!supabaseKey) return fallback();
  const headers = { apikey: supabaseKey, Authorization: `Bearer ${supabaseKey}` };
  const select = "slug,category,brand,collection,name,material,style,color,price,description,features,image_path";
  const common = `select=${select}&is_available=eq.true&brand=eq.${encodeURIComponent(product.brand)}&slug=neq.${encodeURIComponent(product.slug)}&order=sort_order.asc&limit=${limit}`;

  try {
    const fromCollection = await fetch(`${supabaseUrl}/rest/v1/products?${common}&collection=eq.${encodeURIComponent(product.collection)}`, { headers, next: { revalidate: 300 } });
    if (!fromCollection.ok) throw new Error(`Supabase returned ${fromCollection.status}`);
    let rows = await fromCollection.json() as ProductRow[];
    if (!rows.length) {
      const fromBrand = await fetch(`${supabaseUrl}/rest/v1/products?${common}`, { headers, next: { revalidate: 300 } });
      if (!fromBrand.ok) throw new Error(`Supabase returned ${fromBrand.status}`);
      rows = await fromBrand.json() as ProductRow[];
    }
    if (!rows.length) return [];

    // Для трьох рекомендацій підвантажуємо лише їхні декори й параметри,
    // зберігаючи вигляд карток без завантаження даних усіх моделей.
    const productFilter = `product_slug=in.(${rows.map((row) => encodeURIComponent(row.slug)).join(",")})`;
    const [optionsResponse, variantsResponse, specsResponse] = await Promise.all([
      fetch(`${supabaseUrl}/rest/v1/product_options?select=product_slug,option_group,group_label,label,swatch,image_path,sort_order&is_active=eq.true&${productFilter}&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
      fetch(`${supabaseUrl}/rest/v1/product_variants?select=product_slug,selections,image_path,sort_order&is_active=eq.true&${productFilter}&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
      fetch(`${supabaseUrl}/rest/v1/product_specs?select=product_slug,label,value,sort_order&is_active=eq.true&${productFilter}&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
    ]);
    const optionRows = optionsResponse.ok ? await optionsResponse.json() as ProductOptionRow[] : [];
    const variantRows = variantsResponse.ok ? await variantsResponse.json() as ProductVariantRow[] : [];
    const specRows = specsResponse.ok ? await specsResponse.json() as ProductSpecRow[] : [];
    const optionsByProduct = new Map<string, ProductOption[]>();
    const variantsByProduct = new Map<string, ProductVariant[]>();
    const specsByProduct = new Map<string, ProductSpec[]>();
    optionRows.forEach((option) => optionsByProduct.set(option.product_slug, [...(optionsByProduct.get(option.product_slug) || []), mapOption(option)]));
    variantRows.forEach((variant) => variantsByProduct.set(variant.product_slug, [...(variantsByProduct.get(variant.product_slug) || []), mapVariant(variant)]));
    specRows.forEach((spec) => specsByProduct.set(spec.product_slug, [...(specsByProduct.get(spec.product_slug) || []), mapSpec(spec)]));
    return rows.map((row) => ({ ...mapProduct(row), options: optionsByProduct.get(row.slug) || [], variants: variantsByProduct.get(row.slug) || [], specs: specsByProduct.get(row.slug) || [] }));
  } catch (error) {
    console.error(`Could not load related products for ${product.slug}`, error);
    return fallback();
  }
}

export async function getProduct(slug: string) {
  let product: Product | undefined;
  let directLookupCompleted = false;

  if (supabaseKey) {
    try {
      const headers = { apikey: supabaseKey, Authorization: `Bearer ${supabaseKey}` };
      const response = await fetch(`${supabaseUrl}/rest/v1/products?select=slug,category,brand,collection,name,material,style,color,price,description,features,image_path&slug=eq.${encodeURIComponent(slug)}&is_available=eq.true&limit=1`, { headers, next: { revalidate: 60 } });
      if (!response.ok) throw new Error(`Supabase returned ${response.status}`);
      directLookupCompleted = true;
      const rows = await response.json() as ProductRow[];
      product = rows[0] ? mapProduct(rows[0]) : undefined;
    } catch (error) {
      // Якщо Supabase тимчасово недоступний, сайт збереже резервний каталог.
      console.error(`Could not load product ${slug} from Supabase`, error);
    }
  }

  // Порожня успішна відповідь означає, що товар прихований або не існує.
  if (directLookupCompleted && !product) return undefined;
  if (!product) product = products.find((item) => item.slug === slug);
  if (!product) return undefined;
  try {
    const { media, options, variants, specs } = await getProductExtras(slug);
    const mainImage = media.find((item) => item.kind === "main");
    return { ...product, image: mainImage?.image || product.image, media, options, variants, specs };
  } catch (error) {
    console.error(`Could not load product configuration for ${slug}`, error);
    return product;
  }
}
