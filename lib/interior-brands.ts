export type InteriorBrand = {
  slug: string;
  name: string;
  description: string;
  collections: string[];
  image: string;
};

export const interiorBrands: InteriorBrand[] = [
  { slug: "papa-carlo", name: "Papa Carlo", description: "Сучасні міжкімнатні двері з екошпону та продуманими декоративними рішеннями.", collections: ["Tetra", "Plato", "Milenium", "Style", "iDoors"], image: "/catalog-assets/products/product-85.jpg" },
  { slug: "rodos", name: "Rodos", description: "Міжкімнатні двері з акцентом на дизайн, покриття та практичність, зокрема лінійки RODOS Grand.", collections: ["Atlantic ПВХ", "Cortes фарба", "Loft фарба", "Loft шпон", "Royal шпон", "Siena фарба", "Style ПВХ", "DELUX", "LUX", "Paint"], image: "/catalog-assets/products/product-180.jpg" },
  { slug: "still-doors", name: "StilDoors", description: "Колекції Presto та Stil для актуальних інтер’єрів.", collections: ["Presto", "Stil"], image: "/catalog-assets/products/product-68.jpg" },
  { slug: "terminus", name: "Термінус", description: "Фабрика міжкімнатних дверей із різними стилями та видами оздоблення.", collections: ["Caro", "Elit plus", "Frezato", "Light", "Neoclassico", "Solid"], image: "/catalog-assets/products/product-295.webp" },
  { slug: "darumi", name: "Darumi", description: "Міжкімнатні двері української фабрики з Корюківки: заводські декори, скло та варіанти комплектації.", collections: ["Darumi Авант", "Darumi Аннеси", "Darumi Арни", "Darumi Бордо", "Darumi Вела", "Darumi Версаль", "Darumi Виолета", "Darumi Галант", "Darumi Гелиос", "Darumi Дарина", "Darumi Каскад", "Darumi Колумбия", "Darumi Кристи", "Darumi Леона", "Darumi Мадрид", "Darumi Марсель", "Darumi Мери", "Darumi Надин", "Darumi Некст", "Darumi Плато", "Darumi Плато Line PTL-03", "Darumi Плато Line PTL-04", "Darumi Плато Line PTL-05", "Darumi Плато Line PTL-06", "Darumi Плато Лайн PTL-03", "Darumi Рамона", "Darumi Розалия", "Darumi Сабрина", "Darumi Селеста", "Darumi Сенатор", "Darumi Старк", "Darumi Стелла", "Darumi Тина", "Darumi Флориана", "Darumi Эдмонд", "Darumi Эспер"], image: "https://darumi.in.ua/images/dveri/biliy-mat/ramona-sklo-chorne/dveri-biliy-mat-ramona-sklo-chorne.jpg" },
];

export const getInteriorBrand = (slug: string) => interiorBrands.find((brand) => brand.slug === slug);
