export type Category = "interior" | "entrance" | "windows";
export type Product = { slug: string; category: Category; name: string; material: string; style: string; color: string; price: string; description: string; features: string[]; image: string };

export const categories: Record<Category, { title: string; short: string; description: string; image: string }> = {
  interior: { title: "Міжкімнатні двері", short: "Міжкімнатні", description: "Сучасні та класичні моделі з МДФ, екошпону, шпону й масиву.", image: "https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?auto=format&fit=crop&w=1200&q=80" },
  entrance: { title: "Вхідні двері", short: "Вхідні", description: "Захищають дім, зберігають тепло й тишу в будь-яку пору року.", image: "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=1200&q=80" },
  windows: { title: "Вікна", short: "Вікна", description: "Металопластикові та алюмінієві системи для квартир, будинків і терас.", image: "https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?auto=format&fit=crop&w=1200&q=80" },
};

export const products: Product[] = [
  { slug: "linea-02", category: "interior", name: "Linea 02", material: "Екошпон", style: "Сучасний", color: "Білий дуб", price: "від 6 450 грн", description: "Лаконічна модель для світлих сучасних інтер’єрів.", features: ["МДФ", "Екошпон", "Білий дуб"], image: "https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?auto=format&fit=crop&w=900&q=80" },
  { slug: "classic-4", category: "interior", name: "Classic 4", material: "Шпон", style: "Класичний", color: "Горіх", price: "від 9 800 грн", description: "Виразна класика з теплою текстурою натурального дерева.", features: ["Масив", "Шпон", "Горіх"], image: "https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&w=900&q=80" },
  { slug: "loft-glass", category: "interior", name: "Loft Glass", material: "МДФ", style: "Лофт", color: "Антрацит", price: "від 8 250 грн", description: "Графічна дверна конструкція зі скляною вставкою.", features: ["МДФ", "Скло", "Антрацит"], image: "https://images.unsplash.com/photo-1600210491369-e753d80a41f3?auto=format&fit=crop&w=900&q=80" },
  { slug: "fortis-thermo", category: "entrance", name: "Fortis Thermo", material: "Сталь", style: "Сучасний", color: "Антрацит", price: "від 22 900 грн", description: "Надійні двері для квартири чи приватного будинку.", features: ["Сталь", "86 мм", "3 контури ущільнення"], image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=900&q=80" },
  { slug: "safe-house", category: "entrance", name: "Safe House", material: "Сталь", style: "Класичний", color: "Горіх", price: "від 27 500 грн", description: "Посилена конструкція, продумана для безпеки та тиші.", features: ["Сталь", "МДФ накладка", "2 замки"], image: "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=900&q=80" },
  { slug: "guardian-100", category: "entrance", name: "Guardian 100", material: "Терморозрив", style: "Сучасний", color: "Чорний", price: "від 31 800 грн", description: "Модель із терморозривом для максимально теплого входу.", features: ["Терморозрив", "Шумоізоляція", "100 мм"], image: "https://images.unsplash.com/photo-1600607688960-e095ff83135c?auto=format&fit=crop&w=900&q=80" },
  { slug: "comfort-70", category: "windows", name: "Comfort 70", material: "ПВХ", style: "Енергоефективні", color: "Білий", price: "від 4 600 грн/м²", description: "Практична віконна система для міської квартири.", features: ["5 камер", "Склопакет 40 мм", "ПВХ"], image: "https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?auto=format&fit=crop&w=900&q=80" },
  { slug: "alu-slide", category: "windows", name: "Alu Slide", material: "Алюміній", style: "Панорамні", color: "Антрацит", price: "від 12 400 грн/м²", description: "Розсувна алюмінієва система для просторих отворів.", features: ["Алюміній", "Панорамна система", "Розсувна"], image: "https://images.unsplash.com/photo-1600573472550-8090b5e0745e?auto=format&fit=crop&w=900&q=80" },
  { slug: "energy-pro", category: "windows", name: "Energy Pro", material: "ПВХ", style: "Енергоефективні", color: "Білий", price: "від 6 200 грн/м²", description: "Теплий профіль для приватних будинків та холодних фасадів.", features: ["7 камер", "Енергозбереження", "Теплий монтаж"], image: "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=900&q=80" },
  ...Array.from({ length: 35 }, (_, index): Product => {
    const model = String(index + 1).padStart(2, "0");
    return {
      slug: `papa-carlo-style-st-${model}`,
      category: "interior",
      name: `Papa Carlo STYLE ST-${model}`,
      material: "Екошпон",
      style: "Сучасний",
      color: "Варіанти декорів",
      price: "Ціна за запитом",
      description: "Міжкімнатні двері фабрики Papa Carlo, колекція STYLE.",
      features: ["Papa Carlo", "Колекція STYLE", "Екошпон", "Кромка ABC / алюмінієва", "Декори: білий ясен, дуб, бетон, емаліт"],
      image: "https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?auto=format&fit=crop&w=900&q=80",
    };
  }),
];

export const getProduct = (slug: string) => products.find((product) => product.slug === slug);
