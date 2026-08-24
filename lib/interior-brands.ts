export type InteriorBrand = {
  slug: string;
  name: string;
  description: string;
  collections: string[];
  image: string;
};

export const interiorBrands: InteriorBrand[] = [
  { slug: "papa-carlo", name: "Папа Карло", description: "Сучасні міжкімнатні двері з екошпону та продуманими декоративними рішеннями.", collections: ["Tetra", "Plato", "Milenium", "STYLE", "Склад"], image: "https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?auto=format&fit=crop&w=1200&q=80" },
  { slug: "korfad", name: "Korfad", description: "Фабрика міжкімнатних дверей для сучасних і класичних інтер’єрів.", collections: ["Korfad"], image: "https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&w=1200&q=80" },
  { slug: "rodos", name: "Rodos", description: "Дверні рішення з акцентом на дизайн, покриття та практичність.", collections: ["Versal"], image: "https://images.unsplash.com/photo-1600210491369-e753d80a41f3?auto=format&fit=crop&w=1200&q=80" },
  { slug: "still-doors", name: "Still Doors", description: "Колекції міжкімнатних дверей для актуальних інтер’єрів.", collections: [], image: "https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?auto=format&fit=crop&w=1200&q=80" },
  { slug: "terminus", name: "Термінус", description: "Фабрика міжкімнатних дверей із різними стилями та видами оздоблення.", collections: ["Sweet Doors"], image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80" },
];

export const getInteriorBrand = (slug: string) => interiorBrands.find((brand) => brand.slug === slug);
