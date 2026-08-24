import { importedProducts } from "./imported-catalog";

export type Category = "interior" | "entrance" | "windows";
export type Product = { slug: string; category: Category; brand: string; collection: string; name: string; material: string; style: string; color: string; price: string; description: string; features: string[]; image: string };

export const categories: Record<Category, { title: string; short: string; description: string; image: string }> = {
  interior: { title: "Міжкімнатні двері", short: "Міжкімнатні", description: "Колекції дверей від Papa Carlo, Rodos, Термінус, Grand та StilDoors.", image: "/catalog-assets/products/product-85.jpg" },
  entrance: { title: "Вхідні двері", short: "Вхідні", description: "Вхідні двері Abwehr, Rodos Steel, Страж, Q Doors та Magda.", image: "/catalog-assets/products/product-200.jpg" },
  windows: { title: "Вікна", short: "Вікна", description: "Віконні системи для квартири, будинку й тераси.", image: "" },
};

export const products: Product[] = importedProducts;

type ProductRow = Omit<Product, "image" | "features"> & { features: string[] | null; image_path: string };
const supabaseUrl = (process.env.NEXT_PUBLIC_SUPABASE_URL || "https://vfdfvqlvxkwgizauxusm.supabase.co").replace(/\/$/, "");
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

export const catalogImageUrl = (image: string) => {
  if (!supabaseUrl) return image;
  const fileName = image.split("/").pop();
  return fileName ? `${supabaseUrl}/storage/v1/object/public/catalog-images/${encodeURIComponent(fileName)}` : image;
};

const mapProduct = (product: ProductRow): Product => ({ ...product, features: product.features || [], image: catalogImageUrl(product.image_path) });

export async function getProducts(): Promise<Product[]> {
  if (!supabaseKey) return products.map((product) => ({ ...product, image: catalogImageUrl(product.image) }));
  try {
    const response = await fetch(`${supabaseUrl}/rest/v1/products?select=slug,category,brand,collection,name,material,style,color,price,description,features,image_path&is_available=eq.true&order=sort_order.asc`, {
      headers: { apikey: supabaseKey, Authorization: `Bearer ${supabaseKey}` },
      next: { revalidate: 3600 },
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
  return catalog.find((product) => product.slug === slug);
}
