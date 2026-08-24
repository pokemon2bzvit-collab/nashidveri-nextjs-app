import type { Product } from "./catalog";

const collections = {
  Milenium: ["ML-00", "ML-00F", "ML-01", "ML-02", "ML-06", "ML-08", "ML-10", "ML-11", "ML-12", "ML-14", "ML-16", "ML-20", "ML-36", "ML-62", "ML-64", "ML-714", "ML-718"],
  Plato: ["PL-01", "PL-02", "PL-04", "PL-06", "PL-07", "PL-14", "PL-22", "PL-30", "PL-32"],
  Style: ["ST-01", "ST-02", "ST-04", "ST-25", "ST-26", "ST-33", "ST-34", "ST-35"],
  Tetra: ["T-04", "T-05", "T-06", "T-07", "T-08", "T-09", "T-10", "T-11 (BLK)", "T-13", "T-14", "T-15", "T-16", "T-17", "T-00F", "T-01", "T-02", "T-03", "T-12", "T-18 (BLK)"],
  "Склад": ["ML-62c", "PLATO-01", "PLATO-04", "PLATO-07", "PLATO-21", "PLATO-24", "Prime-AL INSIDE", "Prime-AL", "T-01", "T-02", "T-03", "T-04", "T-12", "T-14"],
} as const;

const folders: Record<keyof typeof collections, string> = { Milenium: "milenium", Plato: "plato", Style: "style", Tetra: "tetra", "Склад": "stock" };
const fileName = (model: string) => model.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "");

export const papaCarloProducts: Product[] = Object.entries(collections).flatMap(([collection, models]) => models.map((model) => ({
  slug: `papa-carlo-${folders[collection as keyof typeof collections]}-${fileName(model)}`,
  category: "interior" as const,
  name: `Papa Carlo ${model}`,
  material: "Екошпон",
  style: `Колекція ${collection}`,
  color: "Варіанти декорів",
  price: "Ціна за запитом",
  description: `Міжкімнатні двері фабрики Papa Carlo, колекція ${collection}.`,
  features: ["Papa Carlo", `Колекція ${collection}`, "Екошпон"],
  image: `/catalog-assets/papa-carlo/${folders[collection as keyof typeof collections]}/${fileName(model)}.jpg`,
})));
