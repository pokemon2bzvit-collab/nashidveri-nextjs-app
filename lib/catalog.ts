import { importedProducts } from "./imported-catalog";

export type Category = "interior" | "entrance" | "windows";
export type ProductMedia = { kind: "main" | "gallery" | "palette"; label: string | null; image: string; sortOrder: number };
export type ProductOption = { group: "color" | "finish" | "glass" | "edge" | "configuration"; groupLabel: string; label: string; swatch: string | null; image: string | null; sortOrder: number };
export type ProductVariant = { selections: Record<string, string>; image: string; sortOrder: number };
export type ProductSpec = { label: string; value: string; sortOrder: number };
export type Product = { slug: string; category: Category; brand: string; collection: string; name: string; material: string; style: string; color: string; price: string; description: string; features: string[]; image: string; media?: ProductMedia[]; options?: ProductOption[]; variants?: ProductVariant[]; specs?: ProductSpec[] };

export const categories: Record<Category, { title: string; short: string; description: string; image: string }> = {
  interior: { title: "Міжкімнатні двері", short: "Міжкімнатні", description: "Колекції дверей від Papa Carlo, Rodos, Термінус, Grand та StilDoors.", image: "/catalog-assets/products/product-85.jpg" },
  entrance: { title: "Вхідні двері", short: "Вхідні", description: "Вхідні двері Abwehr, Rodos Steel, Страж, Q Doors та Magda.", image: "/catalog-assets/products/product-200.jpg" },
  windows: { title: "Вікна", short: "Вікна", description: "Віконні системи для квартири, будинку й тераси.", image: "" },
};

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
    fetch(`${supabaseUrl}/rest/v1/product_media?select=product_slug,kind,label,image_path,sort_order&is_active=eq.true&${filter}&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
    fetch(`${supabaseUrl}/rest/v1/product_options?select=product_slug,option_group,group_label,label,swatch,image_path,sort_order&is_active=eq.true&${filter}&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
    fetch(`${supabaseUrl}/rest/v1/product_variants?select=product_slug,selections,image_path,sort_order&is_active=eq.true&${filter}&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
    fetch(`${supabaseUrl}/rest/v1/product_specs?select=product_slug,label,value,sort_order&is_active=eq.true&${filter}&order=sort_order.asc`, { headers, next: { revalidate: 300 } }),
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
    const response = await fetch(`${supabaseUrl}/rest/v1/products?select=slug,category,brand,collection,name,material,style,color,price,description,features,image_path&is_available=eq.true&order=sort_order.asc`, {
      headers: { apikey: supabaseKey, Authorization: `Bearer ${supabaseKey}` },
      next: { revalidate: 300 },
    });
    if (!response.ok) throw new Error(`Supabase returned ${response.status}`);
    const rows = await response.json() as ProductRow[];
    return rows.map(mapProduct);
  } catch (error) {
    console.error("Could not load catalog from Supabase", error);
    return products.map((product) => ({ ...product, image: catalogImageUrl(product.image) }));
  }
}

export async function getProduct(slug: string) {
  const catalog = await getProducts();
  const product = catalog.find((item) => item.slug === slug);
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
