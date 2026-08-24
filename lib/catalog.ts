import { importedProducts } from "./imported-catalog";

export type Category = "interior" | "entrance" | "windows";
export type Product = { slug: string; category: Category; brand: string; collection: string; name: string; material: string; style: string; color: string; price: string; description: string; features: string[]; image: string };

export const categories: Record<Category, { title: string; short: string; description: string; image: string }> = {
  interior: { title: "Міжкімнатні двері", short: "Міжкімнатні", description: "Колекції дверей від Papa Carlo, Rodos, Термінус, Grand та StilDoors.", image: "/catalog-assets/products/product-85.jpg" },
  entrance: { title: "Вхідні двері", short: "Вхідні", description: "Вхідні двері Abwehr, Rodos Steel, Страж, Q Doors та Magda.", image: "/catalog-assets/products/product-200.jpg" },
  windows: { title: "Вікна", short: "Вікна", description: "Віконні системи для квартири, будинку й тераси.", image: "" },
};

export const products: Product[] = importedProducts;
export const getProduct = (slug: string) => products.find((product) => product.slug === slug);
