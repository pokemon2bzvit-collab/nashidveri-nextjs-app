export type EntranceBrand = { slug: string; name: string; description: string; collections: string[]; image: string };

export const entranceBrands: EntranceBrand[] = [
  { slug: "portala", name: "Портала", description: "Фабрика вхідних дверей. У старому каталозі представлена колекція Stilguard.", collections: ["Stilguard"], image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80" },
  { slug: "vikna-styl", name: "Вікна Стиль", description: "Вхідні алюмінієві системи та рішення для сучасних просторів.", collections: ["Алюмінієві"], image: "https://images.unsplash.com/photo-1600607688960-e095ff83135c?auto=format&fit=crop&w=1200&q=80" },
  { slug: "rodos-steel", name: "Rodos Steel", description: "Вхідні двері зі сталевою конструкцією та захисними властивостями.", collections: ["Престиж"], image: "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=1200&q=80" },
];

export const getEntranceBrand = (slug: string) => entranceBrands.find((brand) => brand.slug === slug);
