export type EntranceBrand = { slug: string; name: string; description: string; collections: string[]; image: string };

export const entranceBrands: EntranceBrand[] = [
  { slug: "abwehr", name: "Abwehr", description: "Вхідні двері для квартири та приватного будинку.", collections: ["Для квартири", "Для будинку"], image: "/catalog-assets/products/product-1.webp" },
  { slug: "strazh", name: "Страж", description: "Серії вхідних дверей для квартири та вулиці.", collections: ["Для квартири", "Для будинку"], image: "/catalog-assets/products/product-256.webp" },
  { slug: "q-doors", name: "Q Doors", description: "Сучасні вхідні двері з дизайнерськими рішеннями.", collections: ["Для квартири", "Для будинку"], image: "/catalog-assets/products/product-54.webp" },
  { slug: "rodos-steel", name: "Rodos Steel", description: "Вхідні двері зі сталевою конструкцією та захисними властивостями.", collections: ["Для квартири", "Для будинку"], image: "/catalog-assets/products/product-152.jpg" },
  { slug: "magda", name: "Magda", description: "Вхідні двері для приватного будинку.", collections: ["Для будинку"], image: "/catalog-assets/products/product-52.png" },
];

export const getEntranceBrand = (slug: string) => entranceBrands.find((brand) => brand.slug === slug);
