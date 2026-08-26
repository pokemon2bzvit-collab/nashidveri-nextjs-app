import { importedProducts } from "./imported-catalog";

export type Category = "interior" | "entrance" | "windows";
export type ProductMedia = { kind: "main" | "gallery" | "palette"; label: string | null; image: string; sortOrder: number };
export type Product = { slug: string; category: Category; brand: string; collection: string; name: string; material: string; style: string; color: string; price: string; description: string; features: string[]; image: string; media?: ProductMedia[] };

export const categories: Record<Category, { title: string; short: string; description: string; image: string }> = {
  interior: { title: "Міжкімнатні двері", short: "Міжкімнатні", description: "Колекції дверей від Papa Carlo, Rodos, Термінус, Grand та StilDoors.", image: "/catalog-assets/products/product-85.jpg" },
  entrance: { title: "Вхідні двері", short: "Вхідні", description: "Вхідні двері Abwehr, Rodos Steel, Страж, Q Doors та Magda.", image: "/catalog-assets/products/product-200.jpg" },
  windows: { title: "Вікна", short: "Вікна", description: "Віконні системи для квартири, будинку й тераси.", image: "" },
};

export const products: Product[] = importedProducts;

type ProductRow = Omit<Product, "image" | "features"> & { features: string[] | null; image_path: string };
type ProductMediaRow = { product_slug: string; kind: ProductMedia["kind"]; label: string | null; image_path: string; sort_order: number };
const supabaseUrl = (process.env.NEXT_PUBLIC_SUPABASE_URL || "https://vfdfvqlvxkwgizauxusm.supabase.co").replace(/\/$/, "");
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

export const catalogImageUrl = (image: string) => {
  if (!supabaseUrl) return image;
  const encodedPath = image.split("/").filter(Boolean).map(encodeURIComponent).join("/");
  return encodedPath ? `${supabaseUrl}/storage/v1/object/public/catalog-images/${encodedPath}` : image;
};

const mapProduct = (product: ProductRow): Product => ({ ...product, features: product.features || [], image: catalogImageUrl(product.image_path) });
const mapMedia = (media: ProductMediaRow): ProductMedia => ({ kind: media.kind, label: media.label, image: catalogImageUrl(media.image_path), sortOrder: media.sort_order });

export async function getProducts(): Promise<Product[]> {
  if (!supabaseKey) return products.map((product) => ({ ...product, image: catalogImageUrl(product.image) }));
  try {
    const response = await fetch(`${supabaseUrl}/rest/v1/products?select=slug,category,brand,collection,name,material,style,color,price,description,features,image_path&is_available=eq.true&order=sort_order.asc`, {
      headers: { apikey: supabaseKey, Authorization: `Bearer ${supabaseKey}` },
      next: { revalidate: 300 },
    });
    if (!response.ok) throw new Error(`Supabase returned ${response.status}`);
    const rows = await response.json() as ProductRow[];
    const mediaResponse = await fetch(`${supabaseUrl}/rest/v1/product_media?select=product_slug,kind,label,image_path,sort_order&is_active=eq.true&order=sort_order.asc`, {
      headers: { apikey: supabaseKey, Authorization: `Bearer ${supabaseKey}` },
      next: { revalidate: 300 },
    });
    const mediaByProduct = new Map<string, ProductMedia[]>();
    if (mediaResponse.ok) {
      (await mediaResponse.json() as ProductMediaRow[]).forEach((media) => {
        const current = mediaByProduct.get(media.product_slug) || [];
        current.push(mapMedia(media));
        mediaByProduct.set(media.product_slug, current);
      });
    }
    return rows.map((row) => {
      const product = mapProduct(row);
      const media = mediaByProduct.get(product.slug) || [];
      const mainImage = media.find((item) => item.kind === "main");
      return { ...product, image: mainImage?.image || product.image, media };
    });
  } catch (error) {
    console.error("Could not load catalog from Supabase", error);
    return products.map((product) => ({ ...product, image: catalogImageUrl(product.image) }));
  }
}

export async function getProduct(slug: string) {
  const catalog = await getProducts();
  return catalog.find((product) => product.slug === slug);
}
