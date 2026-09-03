import type { Product } from './catalog';

const rawImportedProducts: Product[] = [
  {
    "slug": "catalog-1",
    "category": "entrance",
    "name": "Abwehr Harmonia",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-1.webp",
    "brand": "Abwehr",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-2",
    "category": "entrance",
    "name": "Abwehr Limana",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-2.webp",
    "brand": "Abwehr",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-3",
    "category": "entrance",
    "name": "Abwehr Melany",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-3.webp",
    "brand": "Abwehr",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-4",
    "category": "entrance",
    "name": "Abwehr Mira",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-4.webp",
    "brand": "Abwehr",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-5",
    "category": "entrance",
    "name": "Abwehr Rain",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-5.webp",
    "brand": "Abwehr",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-6",
    "category": "entrance",
    "name": "Abwehr Riviera",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-6.webp",
    "brand": "Abwehr",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-7",
    "category": "entrance",
    "name": "Abwehr Selena",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-7.webp",
    "brand": "Abwehr",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-8",
    "category": "entrance",
    "name": "Abwehr Stella",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-8.webp",
    "brand": "Abwehr",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-9",
    "category": "entrance",
    "name": "Abwehr Avenue",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-9.jpg",
    "brand": "Abwehr",
    "collection": "Склад"
  },
  {
    "slug": "catalog-10",
    "category": "entrance",
    "name": "Abwehr Carat",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-10.jpg",
    "brand": "Abwehr",
    "collection": "Склад"
  },
  {
    "slug": "catalog-11",
    "category": "entrance",
    "name": "Abwehr Queen",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-11.jpg",
    "brand": "Abwehr",
    "collection": "Склад"
  },
  {
    "slug": "catalog-12",
    "category": "entrance",
    "name": "Abwehr Revolution",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-12.jpg",
    "brand": "Abwehr",
    "collection": "Склад"
  },
  {
    "slug": "catalog-13",
    "category": "entrance",
    "name": "Abwehr Tower 1200",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-13.jpg",
    "brand": "Abwehr",
    "collection": "Склад"
  },
  {
    "slug": "catalog-14",
    "category": "entrance",
    "name": "Abwehr Tower",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Abwehr, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Abwehr",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-14.jpg",
    "brand": "Abwehr",
    "collection": "Склад"
  },
  {
    "slug": "catalog-15",
    "category": "interior",
    "name": "Grand Delux 11",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-15.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-16",
    "category": "interior",
    "name": "Grand Delux 12",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-16.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-17",
    "category": "interior",
    "name": "Grand Delux 13",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-17.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-18",
    "category": "interior",
    "name": "Grand Delux 14 BLK",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-18.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-19",
    "category": "interior",
    "name": "Grand Delux ​​1",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-19.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-20",
    "category": "interior",
    "name": "Grand Delux ​​10",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-20.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-21",
    "category": "interior",
    "name": "Grand Delux ​​2",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-21.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-22",
    "category": "interior",
    "name": "Grand Delux ​​3",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-22.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-23",
    "category": "interior",
    "name": "Grand Delux ​​4 BLK",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-23.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-24",
    "category": "interior",
    "name": "Grand Delux ​​4",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-24.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-25",
    "category": "interior",
    "name": "Grand Delux ​​5",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-25.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-26",
    "category": "interior",
    "name": "Grand Delux ​​6",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-26.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-27",
    "category": "interior",
    "name": "Grand Delux ​​7",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-27.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-28",
    "category": "interior",
    "name": "Grand Delux ​​8",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-28.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-29",
    "category": "interior",
    "name": "Grand Delux ​​9",
    "material": "Міжкімнатні",
    "style": "Колекція DELUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція DELUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція DELUX"
    ],
    "image": "/catalog-assets/products/product-29.jpg",
    "brand": "Grand",
    "collection": "DELUX"
  },
  {
    "slug": "catalog-30",
    "category": "interior",
    "name": "Grand Lux ​​1",
    "material": "Міжкімнатні",
    "style": "Колекція LUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція LUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція LUX"
    ],
    "image": "/catalog-assets/products/product-30.jpg",
    "brand": "Grand",
    "collection": "LUX"
  },
  {
    "slug": "catalog-31",
    "category": "interior",
    "name": "Grand Lux ​​11",
    "material": "Міжкімнатні",
    "style": "Колекція LUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція LUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція LUX"
    ],
    "image": "/catalog-assets/products/product-31.jpg",
    "brand": "Grand",
    "collection": "LUX"
  },
  {
    "slug": "catalog-32",
    "category": "interior",
    "name": "Grand Lux ​​13",
    "material": "Міжкімнатні",
    "style": "Колекція LUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція LUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція LUX"
    ],
    "image": "/catalog-assets/products/product-32.jpg",
    "brand": "Grand",
    "collection": "LUX"
  },
  {
    "slug": "catalog-33",
    "category": "interior",
    "name": "Grand Lux ​​14",
    "material": "Міжкімнатні",
    "style": "Колекція LUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція LUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція LUX"
    ],
    "image": "/catalog-assets/products/product-33.jpg",
    "brand": "Grand",
    "collection": "LUX"
  },
  {
    "slug": "catalog-34",
    "category": "interior",
    "name": "Grand Lux ​​2",
    "material": "Міжкімнатні",
    "style": "Колекція LUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція LUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція LUX"
    ],
    "image": "/catalog-assets/products/product-34.jpg",
    "brand": "Grand",
    "collection": "LUX"
  },
  {
    "slug": "catalog-35",
    "category": "interior",
    "name": "Grand Lux ​​3",
    "material": "Міжкімнатні",
    "style": "Колекція LUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція LUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція LUX"
    ],
    "image": "/catalog-assets/products/product-35.jpg",
    "brand": "Grand",
    "collection": "LUX"
  },
  {
    "slug": "catalog-36",
    "category": "interior",
    "name": "Grand Lux ​​4 BLK",
    "material": "Міжкімнатні",
    "style": "Колекція LUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція LUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція LUX"
    ],
    "image": "/catalog-assets/products/product-36.jpg",
    "brand": "Grand",
    "collection": "LUX"
  },
  {
    "slug": "catalog-37",
    "category": "interior",
    "name": "Grand Lux ​​5",
    "material": "Міжкімнатні",
    "style": "Колекція LUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція LUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція LUX"
    ],
    "image": "/catalog-assets/products/product-37.jpg",
    "brand": "Grand",
    "collection": "LUX"
  },
  {
    "slug": "catalog-38",
    "category": "interior",
    "name": "Grand Lux ​​6",
    "material": "Міжкімнатні",
    "style": "Колекція LUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція LUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція LUX"
    ],
    "image": "/catalog-assets/products/product-38.jpg",
    "brand": "Grand",
    "collection": "LUX"
  },
  {
    "slug": "catalog-39",
    "category": "interior",
    "name": "Grand Lux ​​8",
    "material": "Міжкімнатні",
    "style": "Колекція LUX",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція LUX. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція LUX"
    ],
    "image": "/catalog-assets/products/product-39.jpg",
    "brand": "Grand",
    "collection": "LUX"
  },
  {
    "slug": "catalog-40",
    "category": "interior",
    "name": "Grand Paint 1",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-40.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-41",
    "category": "interior",
    "name": "Grand Paint 10",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-41.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-42",
    "category": "interior",
    "name": "Grand Paint 11",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-42.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-43",
    "category": "interior",
    "name": "Grand Paint 12",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-43.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-44",
    "category": "interior",
    "name": "Grand Paint 2",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-44.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-45",
    "category": "interior",
    "name": "Grand Paint 3",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-45.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-46",
    "category": "interior",
    "name": "Grand Paint 4",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-46.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-47",
    "category": "interior",
    "name": "Grand Paint 5",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-47.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-48",
    "category": "interior",
    "name": "Grand Paint 6",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-48.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-49",
    "category": "interior",
    "name": "Grand Paint 7",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-49.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-50",
    "category": "interior",
    "name": "Grand Paint 8",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-50.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-51",
    "category": "interior",
    "name": "Grand Paint 9",
    "material": "Міжкімнатні",
    "style": "Колекція Paint",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Grand, колекція Paint. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Grand",
      "Колекція Paint"
    ],
    "image": "/catalog-assets/products/product-51.jpg",
    "brand": "Grand",
    "collection": "Paint"
  },
  {
    "slug": "catalog-52",
    "category": "entrance",
    "name": "Magda Модель №711.1",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Magda, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Magda",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-52.png",
    "brand": "Magda",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-53",
    "category": "entrance",
    "name": "Magda Модель №945",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Magda, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Magda",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-53.webp",
    "brand": "Magda",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-54",
    "category": "entrance",
    "name": "Q Doors Стріт Арт",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-54.webp",
    "brand": "Q Doors",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-55",
    "category": "entrance",
    "name": "Q Doors Стріт Горизонталь",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-55.webp",
    "brand": "Q Doors",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-56",
    "category": "entrance",
    "name": "Q Doors Стріт Елегант",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-56.webp",
    "brand": "Q Doors",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-57",
    "category": "entrance",
    "name": "Q Doors Стріт Лайт",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-57.webp",
    "brand": "Q Doors",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-58",
    "category": "entrance",
    "name": "Q Doors Стріт Спейс",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-58.webp",
    "brand": "Q Doors",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-59",
    "category": "entrance",
    "name": "Q Doors Стріт Флай",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-59.webp",
    "brand": "Q Doors",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-60",
    "category": "entrance",
    "name": "Q Doors Аккорд AK",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-60.webp",
    "brand": "Q Doors",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-61",
    "category": "entrance",
    "name": "Q Doors Бостон M",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-61.webp",
    "brand": "Q Doors",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-62",
    "category": "entrance",
    "name": "Q Doors Босфор AK",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-62.webp",
    "brand": "Q Doors",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-63",
    "category": "entrance",
    "name": "Q Doors Лаунж",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-63.webp",
    "brand": "Q Doors",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-64",
    "category": "entrance",
    "name": "Q Doors Люксор",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-64.webp",
    "brand": "Q Doors",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-65",
    "category": "entrance",
    "name": "Q Doors Міроу",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-65.webp",
    "brand": "Q Doors",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-66",
    "category": "entrance",
    "name": "Q Doors Стиль M",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-66.webp",
    "brand": "Q Doors",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-67",
    "category": "entrance",
    "name": "Q Doors Тріоні",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Q Doors, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Q Doors",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-67.webp",
    "brand": "Q Doors",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-68",
    "category": "interior",
    "name": "StilDoors Aura",
    "material": "Міжкімнатні",
    "style": "Колекція Presto",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Presto. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Presto"
    ],
    "image": "/catalog-assets/products/product-68.jpg",
    "brand": "StilDoors",
    "collection": "Presto"
  },
  {
    "slug": "catalog-69",
    "category": "interior",
    "name": "StilDoors Avanti",
    "material": "Міжкімнатні",
    "style": "Колекція Presto",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Presto. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Presto"
    ],
    "image": "/catalog-assets/products/product-69.jpg",
    "brand": "StilDoors",
    "collection": "Presto"
  },
  {
    "slug": "catalog-70",
    "category": "interior",
    "name": "StilDoors Diamond",
    "material": "Міжкімнатні",
    "style": "Колекція Presto",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Presto. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Presto"
    ],
    "image": "/catalog-assets/products/product-70.jpg",
    "brand": "StilDoors",
    "collection": "Presto"
  },
  {
    "slug": "catalog-71",
    "category": "interior",
    "name": "StilDoors Elegante",
    "material": "Міжкімнатні",
    "style": "Колекція Presto",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Presto. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Presto"
    ],
    "image": "/catalog-assets/products/product-71.jpg",
    "brand": "StilDoors",
    "collection": "Presto"
  },
  {
    "slug": "catalog-72",
    "category": "interior",
    "name": "StilDoors Fargo",
    "material": "Міжкімнатні",
    "style": "Колекція Presto",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Presto. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Presto"
    ],
    "image": "/catalog-assets/products/product-72.jpg",
    "brand": "StilDoors",
    "collection": "Presto"
  },
  {
    "slug": "catalog-73",
    "category": "interior",
    "name": "StilDoors Grazia",
    "material": "Міжкімнатні",
    "style": "Колекція Presto",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Presto. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Presto"
    ],
    "image": "/catalog-assets/products/product-73.jpg",
    "brand": "StilDoors",
    "collection": "Presto"
  },
  {
    "slug": "catalog-74",
    "category": "interior",
    "name": "StilDoors Karyon",
    "material": "Міжкімнатні",
    "style": "Колекція Presto",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Presto. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Presto"
    ],
    "image": "/catalog-assets/products/product-74.jpg",
    "brand": "StilDoors",
    "collection": "Presto"
  },
  {
    "slug": "catalog-75",
    "category": "interior",
    "name": "StilDoors Palladio",
    "material": "Міжкімнатні",
    "style": "Колекція Presto",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Presto. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Presto"
    ],
    "image": "/catalog-assets/products/product-75.jpg",
    "brand": "StilDoors",
    "collection": "Presto"
  },
  {
    "slug": "catalog-76",
    "category": "interior",
    "name": "StilDoors Toledo",
    "material": "Міжкімнатні",
    "style": "Колекція Presto",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Presto. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Presto"
    ],
    "image": "/catalog-assets/products/product-76.jpg",
    "brand": "StilDoors",
    "collection": "Presto"
  },
  {
    "slug": "catalog-77",
    "category": "interior",
    "name": "StilDoors Wilton",
    "material": "Міжкімнатні",
    "style": "Колекція Presto",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Presto. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Presto"
    ],
    "image": "/catalog-assets/products/product-77.jpg",
    "brand": "StilDoors",
    "collection": "Presto"
  },
  {
    "slug": "catalog-78",
    "category": "interior",
    "name": "StilDoors Arizona",
    "material": "Міжкімнатні",
    "style": "Колекція Stil",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Stil. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Stil"
    ],
    "image": "/catalog-assets/products/product-78.jpg",
    "brand": "StilDoors",
    "collection": "Stil"
  },
  {
    "slug": "catalog-79",
    "category": "interior",
    "name": "StilDoors Barcelona",
    "material": "Міжкімнатні",
    "style": "Колекція Stil",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Stil. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Stil"
    ],
    "image": "/catalog-assets/products/product-79.jpg",
    "brand": "StilDoors",
    "collection": "Stil"
  },
  {
    "slug": "catalog-80",
    "category": "interior",
    "name": "StilDoors Cuba",
    "material": "Міжкімнатні",
    "style": "Колекція Stil",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Stil. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Stil"
    ],
    "image": "/catalog-assets/products/product-80.jpg",
    "brand": "StilDoors",
    "collection": "Stil"
  },
  {
    "slug": "catalog-81",
    "category": "interior",
    "name": "StilDoors Florida",
    "material": "Міжкімнатні",
    "style": "Колекція Stil",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Stil. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Stil"
    ],
    "image": "/catalog-assets/products/product-81.jpg",
    "brand": "StilDoors",
    "collection": "Stil"
  },
  {
    "slug": "catalog-82",
    "category": "interior",
    "name": "StilDoors London",
    "material": "Міжкімнатні",
    "style": "Колекція Stil",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Stil. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Stil"
    ],
    "image": "/catalog-assets/products/product-82.jpg",
    "brand": "StilDoors",
    "collection": "Stil"
  },
  {
    "slug": "catalog-83",
    "category": "interior",
    "name": "StilDoors Mexico",
    "material": "Міжкімнатні",
    "style": "Колекція Stil",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Stil. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Stil"
    ],
    "image": "/catalog-assets/products/product-83.jpg",
    "brand": "StilDoors",
    "collection": "Stil"
  },
  {
    "slug": "catalog-84",
    "category": "interior",
    "name": "StilDoors Slovenia",
    "material": "Міжкімнатні",
    "style": "Колекція Stil",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "StilDoors, колекція Stil. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика StilDoors",
      "Колекція Stil"
    ],
    "image": "/catalog-assets/products/product-84.jpg",
    "brand": "StilDoors",
    "collection": "Stil"
  },
  {
    "slug": "catalog-85",
    "category": "interior",
    "name": "Papa Carlo ML-00",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-85.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-86",
    "category": "interior",
    "name": "Papa Carlo ML-00F",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-86.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-87",
    "category": "interior",
    "name": "Papa Carlo ML-01",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-87.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-88",
    "category": "interior",
    "name": "Papa Carlo ML-02",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-88.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-89",
    "category": "interior",
    "name": "Papa Carlo ML-06",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-89.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-90",
    "category": "interior",
    "name": "Papa Carlo ML-08",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-90.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-91",
    "category": "interior",
    "name": "Papa Carlo ML-10",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-91.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-92",
    "category": "interior",
    "name": "Papa Carlo ML-11",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-92.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-93",
    "category": "interior",
    "name": "Papa Carlo ML-12",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-93.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-94",
    "category": "interior",
    "name": "Papa Carlo ML-14",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-94.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-95",
    "category": "interior",
    "name": "Papa Carlo ML-16",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-95.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-96",
    "category": "interior",
    "name": "Papa Carlo ML-20",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-96.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-97",
    "category": "interior",
    "name": "Papa Carlo ML-36",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-97.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-98",
    "category": "interior",
    "name": "Papa Carlo ML-62",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-98.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-99",
    "category": "interior",
    "name": "Papa Carlo ML-64",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-99.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-100",
    "category": "interior",
    "name": "Papa Carlo ML-714",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-100.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-101",
    "category": "interior",
    "name": "Papa Carlo ML-718",
    "material": "Міжкімнатні",
    "style": "Колекція Milenium",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Milenium. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Milenium"
    ],
    "image": "/catalog-assets/products/product-101.jpg",
    "brand": "Papa Carlo",
    "collection": "Milenium"
  },
  {
    "slug": "catalog-102",
    "category": "interior",
    "name": "Papa Carlo PL-01",
    "material": "Міжкімнатні",
    "style": "Колекція Plato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Plato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Plato"
    ],
    "image": "/catalog-assets/products/product-102.jpg",
    "brand": "Papa Carlo",
    "collection": "Plato"
  },
  {
    "slug": "catalog-103",
    "category": "interior",
    "name": "Papa Carlo PL-02",
    "material": "Міжкімнатні",
    "style": "Колекція Plato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Plato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Plato"
    ],
    "image": "/catalog-assets/products/product-103.jpg",
    "brand": "Papa Carlo",
    "collection": "Plato"
  },
  {
    "slug": "catalog-104",
    "category": "interior",
    "name": "Papa Carlo PL-04",
    "material": "Міжкімнатні",
    "style": "Колекція Plato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Plato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Plato"
    ],
    "image": "/catalog-assets/products/product-104.jpg",
    "brand": "Papa Carlo",
    "collection": "Plato"
  },
  {
    "slug": "catalog-105",
    "category": "interior",
    "name": "Papa Carlo PL-06",
    "material": "Міжкімнатні",
    "style": "Колекція Plato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Plato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Plato"
    ],
    "image": "/catalog-assets/products/product-105.jpg",
    "brand": "Papa Carlo",
    "collection": "Plato"
  },
  {
    "slug": "catalog-106",
    "category": "interior",
    "name": "Papa Carlo PL-07",
    "material": "Міжкімнатні",
    "style": "Колекція Plato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Plato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Plato"
    ],
    "image": "/catalog-assets/products/product-106.jpg",
    "brand": "Papa Carlo",
    "collection": "Plato"
  },
  {
    "slug": "catalog-107",
    "category": "interior",
    "name": "Papa Carlo PL-14",
    "material": "Міжкімнатні",
    "style": "Колекція Plato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Plato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Plato"
    ],
    "image": "/catalog-assets/products/product-107.jpg",
    "brand": "Papa Carlo",
    "collection": "Plato"
  },
  {
    "slug": "catalog-108",
    "category": "interior",
    "name": "Papa Carlo PL-22",
    "material": "Міжкімнатні",
    "style": "Колекція Plato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Plato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Plato"
    ],
    "image": "/catalog-assets/products/product-108.jpg",
    "brand": "Papa Carlo",
    "collection": "Plato"
  },
  {
    "slug": "catalog-109",
    "category": "interior",
    "name": "Papa Carlo PL-30",
    "material": "Міжкімнатні",
    "style": "Колекція Plato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Plato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Plato"
    ],
    "image": "/catalog-assets/products/product-109.jpg",
    "brand": "Papa Carlo",
    "collection": "Plato"
  },
  {
    "slug": "catalog-110",
    "category": "interior",
    "name": "Papa Carlo PL-32",
    "material": "Міжкімнатні",
    "style": "Колекція Plato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Plato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Plato"
    ],
    "image": "/catalog-assets/products/product-110.jpg",
    "brand": "Papa Carlo",
    "collection": "Plato"
  },
  {
    "slug": "catalog-111",
    "category": "interior",
    "name": "Papa Carlo ST-01",
    "material": "Міжкімнатні",
    "style": "Колекція Style",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Style. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Style"
    ],
    "image": "/catalog-assets/products/product-111.jpg",
    "brand": "Papa Carlo",
    "collection": "Style"
  },
  {
    "slug": "catalog-112",
    "category": "interior",
    "name": "Papa Carlo ST-02",
    "material": "Міжкімнатні",
    "style": "Колекція Style",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Style. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Style"
    ],
    "image": "/catalog-assets/products/product-112.jpg",
    "brand": "Papa Carlo",
    "collection": "Style"
  },
  {
    "slug": "catalog-113",
    "category": "interior",
    "name": "Papa Carlo ST-04",
    "material": "Міжкімнатні",
    "style": "Колекція Style",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Style. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Style"
    ],
    "image": "/catalog-assets/products/product-113.jpg",
    "brand": "Papa Carlo",
    "collection": "Style"
  },
  {
    "slug": "catalog-114",
    "category": "interior",
    "name": "Papa Carlo ST-25",
    "material": "Міжкімнатні",
    "style": "Колекція Style",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Style. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Style"
    ],
    "image": "/catalog-assets/products/product-114.jpg",
    "brand": "Papa Carlo",
    "collection": "Style"
  },
  {
    "slug": "catalog-115",
    "category": "interior",
    "name": "Papa Carlo ST-26",
    "material": "Міжкімнатні",
    "style": "Колекція Style",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Style. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Style"
    ],
    "image": "/catalog-assets/products/product-115.jpg",
    "brand": "Papa Carlo",
    "collection": "Style"
  },
  {
    "slug": "catalog-116",
    "category": "interior",
    "name": "Papa Carlo ST-33",
    "material": "Міжкімнатні",
    "style": "Колекція Style",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Style. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Style"
    ],
    "image": "/catalog-assets/products/product-116.jpg",
    "brand": "Papa Carlo",
    "collection": "Style"
  },
  {
    "slug": "catalog-117",
    "category": "interior",
    "name": "Papa Carlo ST-34",
    "material": "Міжкімнатні",
    "style": "Колекція Style",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Style. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Style"
    ],
    "image": "/catalog-assets/products/product-117.jpg",
    "brand": "Papa Carlo",
    "collection": "Style"
  },
  {
    "slug": "catalog-118",
    "category": "interior",
    "name": "Papa Carlo ST-35",
    "material": "Міжкімнатні",
    "style": "Колекція Style",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Style. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Style"
    ],
    "image": "/catalog-assets/products/product-118.jpg",
    "brand": "Papa Carlo",
    "collection": "Style"
  },
  {
    "slug": "catalog-119",
    "category": "interior",
    "name": "Papa Carlo T-04",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-119.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-120",
    "category": "interior",
    "name": "Papa Carlo T-05",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-120.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-121",
    "category": "interior",
    "name": "Papa Carlo T-06",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-121.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-122",
    "category": "interior",
    "name": "Papa Carlo T-07",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-122.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-123",
    "category": "interior",
    "name": "Papa Carlo T-08",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-123.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-124",
    "category": "interior",
    "name": "Papa Carlo T-09",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-124.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-125",
    "category": "interior",
    "name": "Papa Carlo T-10",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-125.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-126",
    "category": "interior",
    "name": "Papa Carlo T-11 (BLK)",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-126.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-127",
    "category": "interior",
    "name": "Papa Carlo T-13",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-127.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-128",
    "category": "interior",
    "name": "Papa Carlo T-14",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-128.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-129",
    "category": "interior",
    "name": "Papa Carlo T-15",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-129.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-130",
    "category": "interior",
    "name": "Papa Carlo T-16",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-130.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-131",
    "category": "interior",
    "name": "Papa Carlo T-17",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-131.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-132",
    "category": "interior",
    "name": "Papa Carlo Т-00F",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-132.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-133",
    "category": "interior",
    "name": "Papa Carlo Т-01",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-133.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-134",
    "category": "interior",
    "name": "Papa Carlo Т-02",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-134.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-135",
    "category": "interior",
    "name": "Papa Carlo Т-03",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-135.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-136",
    "category": "interior",
    "name": "Papa Carlo Т-12",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-136.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-137",
    "category": "interior",
    "name": "Papa Carlo Т-18 (BLK)",
    "material": "Міжкімнатні",
    "style": "Колекція Tetra",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Tetra. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Tetra"
    ],
    "image": "/catalog-assets/products/product-137.jpg",
    "brand": "Papa Carlo",
    "collection": "Tetra"
  },
  {
    "slug": "catalog-138",
    "category": "interior",
    "name": "Papa Carlo ML-62c",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-138.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-139",
    "category": "interior",
    "name": "Papa Carlo PLATO-01",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-139.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-140",
    "category": "interior",
    "name": "Papa Carlo PLATO-04",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-140.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-141",
    "category": "interior",
    "name": "Papa Carlo PLATO-07",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-141.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-142",
    "category": "interior",
    "name": "Papa Carlo PLATO-21",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-142.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-143",
    "category": "interior",
    "name": "Papa Carlo PLATO-24",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-143.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-144",
    "category": "interior",
    "name": "Papa Carlo Prime-AL INSIDE(С)",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-144.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-145",
    "category": "interior",
    "name": "Papa Carlo Prime-AL(С)",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-145.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-146",
    "category": "interior",
    "name": "Papa Carlo T-01",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-146.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-147",
    "category": "interior",
    "name": "Papa Carlo T-02",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-147.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-148",
    "category": "interior",
    "name": "Papa Carlo T-03",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-148.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-149",
    "category": "interior",
    "name": "Papa Carlo Т-04",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-149.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-150",
    "category": "interior",
    "name": "Papa Carlo Т-12",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-150.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-151",
    "category": "interior",
    "name": "Papa Carlo Т-14",
    "material": "Міжкімнатні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Papa Carlo, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Papa Carlo",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-151.jpg",
    "brand": "Papa Carlo",
    "collection": "Склад"
  },
  {
    "slug": "catalog-152",
    "category": "entrance",
    "name": "Rodos Steel F 120",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-152.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-153",
    "category": "entrance",
    "name": "Rodos Steel F 124",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-153.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-154",
    "category": "entrance",
    "name": "Rodos Steel F 130",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-154.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-155",
    "category": "entrance",
    "name": "Rodos Steel F 131",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-155.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-156",
    "category": "entrance",
    "name": "Rodos Steel F 135",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-156.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-157",
    "category": "entrance",
    "name": "Rodos Steel F 145",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-157.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-158",
    "category": "entrance",
    "name": "Rodos Steel F 147",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-158.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-159",
    "category": "entrance",
    "name": "Rodos Steel F 150",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-159.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-160",
    "category": "entrance",
    "name": "Rodos Steel F 160",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-160.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-161",
    "category": "entrance",
    "name": "Rodos Steel F 163",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-161.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-162",
    "category": "entrance",
    "name": "Rodos Steel F 167",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-162.jpg",
    "brand": "Rodos Steel",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-163",
    "category": "entrance",
    "name": "Rodos Steel F 106",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-163.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-164",
    "category": "entrance",
    "name": "Rodos Steel F 108",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-164.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-165",
    "category": "entrance",
    "name": "Rodos Steel F 110",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-165.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-166",
    "category": "entrance",
    "name": "Rodos Steel F 113",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-166.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-167",
    "category": "entrance",
    "name": "Rodos Steel F 115",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-167.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-168",
    "category": "entrance",
    "name": "Rodos Steel F 116",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-168.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-169",
    "category": "entrance",
    "name": "Rodos Steel F 120",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-169.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-170",
    "category": "entrance",
    "name": "Rodos Steel F 121",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-170.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-171",
    "category": "entrance",
    "name": "Rodos Steel F 122",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-171.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-172",
    "category": "entrance",
    "name": "Rodos Steel F 124",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-172.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-173",
    "category": "entrance",
    "name": "Rodos Steel F 125",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-173.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-174",
    "category": "entrance",
    "name": "Rodos Steel F 132",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-174.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-175",
    "category": "entrance",
    "name": "Rodos Steel F 136",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-175.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-176",
    "category": "entrance",
    "name": "Rodos Steel F 141",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-176.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-177",
    "category": "entrance",
    "name": "Rodos Steel F 154",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-177.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-178",
    "category": "entrance",
    "name": "Rodos Steel F 155",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-178.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-179",
    "category": "entrance",
    "name": "Rodos Steel F 159",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos Steel, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos Steel",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-179.jpg",
    "brand": "Rodos Steel",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-180",
    "category": "interior",
    "name": "Rodos Atlantic 001  скло",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-180.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-181",
    "category": "interior",
    "name": "Rodos Atlantic 001 глухе",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-181.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-182",
    "category": "interior",
    "name": "Rodos Atlantic 002 глухе",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-182.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-183",
    "category": "interior",
    "name": "Rodos Atlantic 002 напівскло",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-183.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-184",
    "category": "interior",
    "name": "Rodos Atlantic 002 скло",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-184.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-185",
    "category": "interior",
    "name": "Rodos Atlantic 003 глухе",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-185.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-186",
    "category": "interior",
    "name": "Rodos Atlantic 003 напівскло",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-186.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-187",
    "category": "interior",
    "name": "Rodos Atlantic 004 глухе",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-187.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-188",
    "category": "interior",
    "name": "Rodos Atlantic 004 напівскло",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-188.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-189",
    "category": "interior",
    "name": "Rodos Atlantic 004 скло",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-189.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-190",
    "category": "interior",
    "name": "Rodos Atlantic 005 глухе",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-190.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-191",
    "category": "interior",
    "name": "Rodos Atlantic 005 скло",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-191.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-192",
    "category": "interior",
    "name": "Rodos Atlantic 006 глухе",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-192.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-193",
    "category": "interior",
    "name": "Rodos Atlantic 006 скло",
    "material": "Міжкімнатні",
    "style": "Колекція Atlantic ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Atlantic ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Atlantic ПВХ"
    ],
    "image": "/catalog-assets/products/product-193.jpg",
    "brand": "Rodos",
    "collection": "Atlantic ПВХ"
  },
  {
    "slug": "catalog-194",
    "category": "interior",
    "name": "Rodos Cortes Dolce-3",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-194.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-195",
    "category": "interior",
    "name": "Rodos Cortes Dolce-4",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-195.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-196",
    "category": "interior",
    "name": "Rodos Cortes Dolce",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-196.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-197",
    "category": "interior",
    "name": "Rodos Cortes Galant глухе",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-197.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-198",
    "category": "interior",
    "name": "Rodos Cortes Galant напівскло",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-198.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-199",
    "category": "interior",
    "name": "Rodos Cortes Galant скло",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-199.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-200",
    "category": "interior",
    "name": "Rodos Cortes Galliano",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-200.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-201",
    "category": "interior",
    "name": "Rodos Cortes Gaudi",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-201.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-202",
    "category": "interior",
    "name": "Rodos Cortes Jazz",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-202.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-203",
    "category": "interior",
    "name": "Rodos Cortes Prima 1G",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-203.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-204",
    "category": "interior",
    "name": "Rodos Cortes Prima 3G",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-204.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-205",
    "category": "interior",
    "name": "Rodos Cortes Prima 3V",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-205.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-206",
    "category": "interior",
    "name": "Rodos Cortes Prima 3V1",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-206.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-207",
    "category": "interior",
    "name": "Rodos Cortes Prima глухе",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-207.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-208",
    "category": "interior",
    "name": "Rodos Cortes Prima напівскло",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-208.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-209",
    "category": "interior",
    "name": "Rodos Cortes Prima скло",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-209.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-210",
    "category": "interior",
    "name": "Rodos Cortes Roma",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-210.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-211",
    "category": "interior",
    "name": "Rodos Cortes Salsa",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-211.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-212",
    "category": "interior",
    "name": "Rodos Cortes Selena",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-212.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-213",
    "category": "interior",
    "name": "Rodos Cortes Tango",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-213.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-214",
    "category": "interior",
    "name": "Rodos Cortes Venezia глухе",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-214.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-215",
    "category": "interior",
    "name": "Rodos Cortes Venezia напівскло",
    "material": "Міжкімнатні",
    "style": "Колекція Cortes фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Cortes фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Cortes фарба"
    ],
    "image": "/catalog-assets/products/product-215.jpg",
    "brand": "Rodos",
    "collection": "Cortes фарба"
  },
  {
    "slug": "catalog-216",
    "category": "interior",
    "name": "Rodos Loft Arrigo",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-216.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-217",
    "category": "interior",
    "name": "Rodos Loft Arte",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-217.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-218",
    "category": "interior",
    "name": "Rodos Loft Aura",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-218.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-219",
    "category": "interior",
    "name": "Rodos Loft Berta G",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-219.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-220",
    "category": "interior",
    "name": "Rodos Loft Berta GL",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-220.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-221",
    "category": "interior",
    "name": "Rodos Loft Berta GW",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-221.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-222",
    "category": "interior",
    "name": "Rodos Loft Berta V",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-222.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-223",
    "category": "interior",
    "name": "Rodos Loft Berta V1",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-223.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-224",
    "category": "interior",
    "name": "Rodos Loft Cosmo",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-224.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-225",
    "category": "interior",
    "name": "Rodos Loft Lago 1",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-225.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-226",
    "category": "interior",
    "name": "Rodos Loft Lago 2",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-226.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-227",
    "category": "interior",
    "name": "Rodos Loft Lago 3",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-227.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-228",
    "category": "interior",
    "name": "Rodos Loft Nikoletta",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-228.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-229",
    "category": "interior",
    "name": "Rodos Loft Olimpia 2",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-229.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-230",
    "category": "interior",
    "name": "Rodos Loft Olimpia 3",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-230.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-231",
    "category": "interior",
    "name": "Rodos Loft Olimpia",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-231.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-232",
    "category": "interior",
    "name": "Rodos Loft Porto 2",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-232.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-233",
    "category": "interior",
    "name": "Rodos Loft Porto 3",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-233.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-234",
    "category": "interior",
    "name": "Rodos Loft Porto",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-234.png",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-235",
    "category": "interior",
    "name": "Rodos Loft Wave G",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-235.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-236",
    "category": "interior",
    "name": "Rodos Loft Wave V",
    "material": "Міжкімнатні",
    "style": "Колекція Loft фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft фарба"
    ],
    "image": "/catalog-assets/products/product-236.jpg",
    "brand": "Rodos",
    "collection": "Loft фарба"
  },
  {
    "slug": "catalog-237",
    "category": "interior",
    "name": "Rodos Loft Surf Шпон",
    "material": "Міжкімнатні",
    "style": "Колекція Loft шпон",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Loft шпон. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Loft шпон"
    ],
    "image": "/catalog-assets/products/product-237.jpg",
    "brand": "Rodos",
    "collection": "Loft шпон"
  },
  {
    "slug": "catalog-238",
    "category": "interior",
    "name": "Rodos Avalon Шпон скло",
    "material": "Міжкімнатні",
    "style": "Колекція Royal шпон",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Royal шпон. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Royal шпон"
    ],
    "image": "/catalog-assets/products/product-238.jpg",
    "brand": "Rodos",
    "collection": "Royal шпон"
  },
  {
    "slug": "catalog-239",
    "category": "interior",
    "name": "Rodos Avalon Шпон",
    "material": "Міжкімнатні",
    "style": "Колекція Royal шпон",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Royal шпон. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Royal шпон"
    ],
    "image": "/catalog-assets/products/product-239.jpg",
    "brand": "Rodos",
    "collection": "Royal шпон"
  },
  {
    "slug": "catalog-240",
    "category": "interior",
    "name": "Rodos Siena Asti скло",
    "material": "Міжкімнатні",
    "style": "Колекція Siena фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Siena фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Siena фарба"
    ],
    "image": "/catalog-assets/products/product-240.jpg",
    "brand": "Rodos",
    "collection": "Siena фарба"
  },
  {
    "slug": "catalog-241",
    "category": "interior",
    "name": "Rodos Siena Asti",
    "material": "Міжкімнатні",
    "style": "Колекція Siena фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Siena фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Siena фарба"
    ],
    "image": "/catalog-assets/products/product-241.png",
    "brand": "Rodos",
    "collection": "Siena фарба"
  },
  {
    "slug": "catalog-242",
    "category": "interior",
    "name": "Rodos Siena Laura скло",
    "material": "Міжкімнатні",
    "style": "Колекція Siena фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Siena фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Siena фарба"
    ],
    "image": "/catalog-assets/products/product-242.png",
    "brand": "Rodos",
    "collection": "Siena фарба"
  },
  {
    "slug": "catalog-243",
    "category": "interior",
    "name": "Rodos Siena Laura",
    "material": "Міжкімнатні",
    "style": "Колекція Siena фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Siena фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Siena фарба"
    ],
    "image": "/catalog-assets/products/product-243.jpg",
    "brand": "Rodos",
    "collection": "Siena фарба"
  },
  {
    "slug": "catalog-244",
    "category": "interior",
    "name": "Rodos Siena Rossi скло",
    "material": "Міжкімнатні",
    "style": "Колекція Siena фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Siena фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Siena фарба"
    ],
    "image": "/catalog-assets/products/product-244.png",
    "brand": "Rodos",
    "collection": "Siena фарба"
  },
  {
    "slug": "catalog-245",
    "category": "interior",
    "name": "Rodos Siena Rossi",
    "material": "Міжкімнатні",
    "style": "Колекція Siena фарба",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Siena фарба. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Siena фарба"
    ],
    "image": "/catalog-assets/products/product-245.png",
    "brand": "Rodos",
    "collection": "Siena фарба"
  },
  {
    "slug": "catalog-246",
    "category": "interior",
    "name": "Rodos MODERN STYLE 1   BLK",
    "material": "Міжкімнатні",
    "style": "Колекція Style ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Style ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Style ПВХ"
    ],
    "image": "/catalog-assets/products/product-246.jpg",
    "brand": "Rodos",
    "collection": "Style ПВХ"
  },
  {
    "slug": "catalog-247",
    "category": "interior",
    "name": "Rodos MODERN STYLE 1",
    "material": "Міжкімнатні",
    "style": "Колекція Style ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Style ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Style ПВХ"
    ],
    "image": "/catalog-assets/products/product-247.jpg",
    "brand": "Rodos",
    "collection": "Style ПВХ"
  },
  {
    "slug": "catalog-248",
    "category": "interior",
    "name": "Rodos MODERN Style 2   BLK",
    "material": "Міжкімнатні",
    "style": "Колекція Style ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Style ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Style ПВХ"
    ],
    "image": "/catalog-assets/products/product-248.jpg",
    "brand": "Rodos",
    "collection": "Style ПВХ"
  },
  {
    "slug": "catalog-249",
    "category": "interior",
    "name": "Rodos MODERN Style 2",
    "material": "Міжкімнатні",
    "style": "Колекція Style ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Style ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Style ПВХ"
    ],
    "image": "/catalog-assets/products/product-249.jpg",
    "brand": "Rodos",
    "collection": "Style ПВХ"
  },
  {
    "slug": "catalog-250",
    "category": "interior",
    "name": "Rodos MODERN STYLE 3     BLK",
    "material": "Міжкімнатні",
    "style": "Колекція Style ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Style ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Style ПВХ"
    ],
    "image": "/catalog-assets/products/product-250.jpg",
    "brand": "Rodos",
    "collection": "Style ПВХ"
  },
  {
    "slug": "catalog-251",
    "category": "interior",
    "name": "Rodos MODERN STYLE 3",
    "material": "Міжкімнатні",
    "style": "Колекція Style ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Style ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Style ПВХ"
    ],
    "image": "/catalog-assets/products/product-251.jpg",
    "brand": "Rodos",
    "collection": "Style ПВХ"
  },
  {
    "slug": "catalog-252",
    "category": "interior",
    "name": "Rodos MODERN STYLE 4  BLK",
    "material": "Міжкімнатні",
    "style": "Колекція Style ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Style ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Style ПВХ"
    ],
    "image": "/catalog-assets/products/product-252.jpg",
    "brand": "Rodos",
    "collection": "Style ПВХ"
  },
  {
    "slug": "catalog-253",
    "category": "interior",
    "name": "Rodos MODERN STYLE 4",
    "material": "Міжкімнатні",
    "style": "Колекція Style ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Style ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Style ПВХ"
    ],
    "image": "/catalog-assets/products/product-253.jpg",
    "brand": "Rodos",
    "collection": "Style ПВХ"
  },
  {
    "slug": "catalog-254",
    "category": "interior",
    "name": "Rodos MODERN STYLE 5    BLK4",
    "material": "Міжкімнатні",
    "style": "Колекція Style ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Style ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Style ПВХ"
    ],
    "image": "/catalog-assets/products/product-254.jpg",
    "brand": "Rodos",
    "collection": "Style ПВХ"
  },
  {
    "slug": "catalog-255",
    "category": "interior",
    "name": "Rodos MODERN STYLE 5",
    "material": "Міжкімнатні",
    "style": "Колекція Style ПВХ",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Rodos, колекція Style ПВХ. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Rodos",
      "Колекція Style ПВХ"
    ],
    "image": "/catalog-assets/products/product-255.jpg",
    "brand": "Rodos",
    "collection": "Style ПВХ"
  },
  {
    "slug": "catalog-256",
    "category": "entrance",
    "name": "Страж Proof 1.5 Slim P Double",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-256.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-257",
    "category": "entrance",
    "name": "Страж Proof 2.3 Alfa Rio Double",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-257.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-258",
    "category": "entrance",
    "name": "Страж Proof 2.3 Estra Slim Double",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-258.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-259",
    "category": "entrance",
    "name": "Страж Proof Forza",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-259.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-260",
    "category": "entrance",
    "name": "Страж Proof Malta",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-260.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-261",
    "category": "entrance",
    "name": "Страж PROOF Nominal",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-261.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-262",
    "category": "entrance",
    "name": "Страж Proof Regola",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-262.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-263",
    "category": "entrance",
    "name": "Страж PROOF Rio-S Loft",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-263.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-264",
    "category": "entrance",
    "name": "Страж PROOF Slim S",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-264.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-265",
    "category": "entrance",
    "name": "Страж Proof Valetta",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-265.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-266",
    "category": "entrance",
    "name": "Страж PROOF Vega Maxi",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-266.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-267",
    "category": "entrance",
    "name": "Страж Straj Proof 2.0 Alfa Doble",
    "material": "Вхідні",
    "style": "Колекція Вулиця",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Вулиця. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Вулиця"
    ],
    "image": "/catalog-assets/products/product-267.webp",
    "brand": "Страж",
    "collection": "Вулиця"
  },
  {
    "slug": "catalog-268",
    "category": "entrance",
    "name": "Страж Avenue",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-268.webp",
    "brand": "Страж",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-269",
    "category": "entrance",
    "name": "Страж Delica AL Mono",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-269.webp",
    "brand": "Страж",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-270",
    "category": "entrance",
    "name": "Страж Fusion Vertical",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-270.webp",
    "brand": "Страж",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-271",
    "category": "entrance",
    "name": "Страж Orlanda",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-271.webp",
    "brand": "Страж",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-272",
    "category": "entrance",
    "name": "Страж Slim S Glass-A",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-272.webp",
    "brand": "Страж",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-273",
    "category": "entrance",
    "name": "Страж Terra S New",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-273.webp",
    "brand": "Страж",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-274",
    "category": "entrance",
    "name": "Страж Tira",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-274.webp",
    "brand": "Страж",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-275",
    "category": "entrance",
    "name": "Страж Vodaria",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-275.webp",
    "brand": "Страж",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-276",
    "category": "entrance",
    "name": "Страж Піраміс",
    "material": "Вхідні",
    "style": "Колекція Квартира",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Квартира. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Квартира"
    ],
    "image": "/catalog-assets/products/product-276.webp",
    "brand": "Страж",
    "collection": "Квартира"
  },
  {
    "slug": "catalog-277",
    "category": "entrance",
    "name": "Страж Berez Lux Mela B",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-277.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-278",
    "category": "entrance",
    "name": "Страж Berez Lux Porte",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-278.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-279",
    "category": "entrance",
    "name": "Страж Florence",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-279.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-280",
    "category": "entrance",
    "name": "Страж Fusion Vertical",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-280.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-281",
    "category": "entrance",
    "name": "Страж Prestige Delica AL Mono",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-281.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-282",
    "category": "entrance",
    "name": "Страж Prestige Matrix",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-282.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-283",
    "category": "entrance",
    "name": "Страж Prestige Terra S New",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-283.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-284",
    "category": "entrance",
    "name": "Страж PROOF Nominal",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-284.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-285",
    "category": "entrance",
    "name": "Страж PROOF Party D 1200",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-285.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-286",
    "category": "entrance",
    "name": "Страж PROOF Party D",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-286.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-287",
    "category": "entrance",
    "name": "Страж PROOF Rio-S Loft 1200",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-287.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-288",
    "category": "entrance",
    "name": "Страж PROOF Rio-S Loft",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-288.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-289",
    "category": "entrance",
    "name": "Страж PROOF Slim S 1200",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-289.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-290",
    "category": "entrance",
    "name": "Страж PROOF Slim S",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-290.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-291",
    "category": "entrance",
    "name": "Страж ROOF Vega Maxi",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-291.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-292",
    "category": "entrance",
    "name": "Страж Standart Mirage",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-292.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-293",
    "category": "entrance",
    "name": "Страж Standart Піраміс",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-293.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-294",
    "category": "entrance",
    "name": "Страж Street PF Rio-S",
    "material": "Вхідні",
    "style": "Колекція Склад",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Страж, колекція Склад. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Страж",
      "Колекція Склад"
    ],
    "image": "/catalog-assets/products/product-294.webp",
    "brand": "Страж",
    "collection": "Склад"
  },
  {
    "slug": "catalog-295",
    "category": "interior",
    "name": "Термінус модель 41",
    "material": "Міжкімнатні",
    "style": "Колекція Caro",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Caro. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Caro"
    ],
    "image": "/catalog-assets/products/product-295.webp",
    "brand": "Термінус",
    "collection": "Caro"
  },
  {
    "slug": "catalog-296",
    "category": "interior",
    "name": "Термінус модель 50",
    "material": "Міжкімнатні",
    "style": "Колекція Caro",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Caro. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Caro"
    ],
    "image": "/catalog-assets/products/product-296.webp",
    "brand": "Термінус",
    "collection": "Caro"
  },
  {
    "slug": "catalog-297",
    "category": "interior",
    "name": "Термінус модель 52",
    "material": "Міжкімнатні",
    "style": "Колекція Caro",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Caro. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Caro"
    ],
    "image": "/catalog-assets/products/product-297.webp",
    "brand": "Термінус",
    "collection": "Caro"
  },
  {
    "slug": "catalog-298",
    "category": "interior",
    "name": "Термінус модель 53",
    "material": "Міжкімнатні",
    "style": "Колекція Caro",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Caro. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Caro"
    ],
    "image": "/catalog-assets/products/product-298.webp",
    "brand": "Термінус",
    "collection": "Caro"
  },
  {
    "slug": "catalog-299",
    "category": "interior",
    "name": "Термінус модель 55",
    "material": "Міжкімнатні",
    "style": "Колекція Caro",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Caro. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Caro"
    ],
    "image": "/catalog-assets/products/product-299.webp",
    "brand": "Термінус",
    "collection": "Caro"
  },
  {
    "slug": "catalog-300",
    "category": "interior",
    "name": "Термінус модель 109",
    "material": "Міжкімнатні",
    "style": "Колекція Elit plus",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Elit plus. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Elit plus"
    ],
    "image": "/catalog-assets/products/product-300.webp",
    "brand": "Термінус",
    "collection": "Elit plus"
  },
  {
    "slug": "catalog-301",
    "category": "interior",
    "name": "Термінус модель 111",
    "material": "Міжкімнатні",
    "style": "Колекція Elit plus",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Elit plus. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Elit plus"
    ],
    "image": "/catalog-assets/products/product-301.webp",
    "brand": "Термінус",
    "collection": "Elit plus"
  },
  {
    "slug": "catalog-302",
    "category": "interior",
    "name": "Термінус модель 112",
    "material": "Міжкімнатні",
    "style": "Колекція Elit plus",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Elit plus. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Elit plus"
    ],
    "image": "/catalog-assets/products/product-302.webp",
    "brand": "Термінус",
    "collection": "Elit plus"
  },
  {
    "slug": "catalog-303",
    "category": "interior",
    "name": "Термінус модель 24.1",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-303.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-304",
    "category": "interior",
    "name": "Термінус модель 24.2",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-304.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-305",
    "category": "interior",
    "name": "Термінус модель 24.3",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-305.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-306",
    "category": "interior",
    "name": "Термінус модель 24.4",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-306.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-307",
    "category": "interior",
    "name": "Термінус модель 24.5",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-307.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-308",
    "category": "interior",
    "name": "Термінус модель 29",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-308.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-309",
    "category": "interior",
    "name": "Термінус модель 704",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-309.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-310",
    "category": "interior",
    "name": "Термінус модель 705.1",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-310.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-311",
    "category": "interior",
    "name": "Термінус модель 705.2",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-311.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-312",
    "category": "interior",
    "name": "Термінус модель 705.3",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-312.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-313",
    "category": "interior",
    "name": "Термінус модель 705.4",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-313.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-314",
    "category": "interior",
    "name": "Термінус модель 706.1",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-314.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-315",
    "category": "interior",
    "name": "Термінус модель 706.2",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-315.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-316",
    "category": "interior",
    "name": "Термінус модель 706.3",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-316.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-317",
    "category": "interior",
    "name": "Термінус модель 707.1",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-317.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-318",
    "category": "interior",
    "name": "Термінус модель 707.2",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-318.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-319",
    "category": "interior",
    "name": "Термінус модель 707.3",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-319.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-320",
    "category": "interior",
    "name": "Термінус модель 707.4",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-320.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-321",
    "category": "interior",
    "name": "Термінус модель 708",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-321.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-322",
    "category": "interior",
    "name": "Термінус модель 714",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-322.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-323",
    "category": "interior",
    "name": "Термінус модель 715",
    "material": "Міжкімнатні",
    "style": "Колекція Frezato",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Frezato. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Frezato"
    ],
    "image": "/catalog-assets/products/product-323.webp",
    "brand": "Термінус",
    "collection": "Frezato"
  },
  {
    "slug": "catalog-324",
    "category": "interior",
    "name": "Термінус ПК-01",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-324.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-325",
    "category": "interior",
    "name": "Термінус ПК-02",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-325.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-326",
    "category": "interior",
    "name": "Термінус ПК-03",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-326.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-327",
    "category": "interior",
    "name": "Термінус ПК-04",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-327.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-328",
    "category": "interior",
    "name": "Термінус ПК-05",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-328.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-329",
    "category": "interior",
    "name": "Термінус ПК-06",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-329.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-330",
    "category": "interior",
    "name": "Термінус ПК-07",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-330.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-331",
    "category": "interior",
    "name": "Термінус ПК-08",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-331.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-332",
    "category": "interior",
    "name": "Термінус ПК-09",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-332.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-333",
    "category": "interior",
    "name": "Термінус ПК-10",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-333.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-334",
    "category": "interior",
    "name": "Термінус ПК-11",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-334.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-335",
    "category": "interior",
    "name": "Термінус ПК-12",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-335.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-336",
    "category": "interior",
    "name": "Термінус ПК-13",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-336.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-337",
    "category": "interior",
    "name": "Термінус ПК-14",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-337.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-338",
    "category": "interior",
    "name": "Термінус ПК-15",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-338.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-339",
    "category": "interior",
    "name": "Термінус ПК-16",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-339.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-340",
    "category": "interior",
    "name": "Термінус ПК-17",
    "material": "Міжкімнатні",
    "style": "Колекція Light",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Light. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Light"
    ],
    "image": "/catalog-assets/products/product-340.webp",
    "brand": "Термінус",
    "collection": "Light"
  },
  {
    "slug": "catalog-341",
    "category": "interior",
    "name": "Термінус модель 401",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-341.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-342",
    "category": "interior",
    "name": "Термінус модель 402",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-342.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-343",
    "category": "interior",
    "name": "Термінус модель 404",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-343.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-344",
    "category": "interior",
    "name": "Термінус модель 601",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-344.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-345",
    "category": "interior",
    "name": "Термінус модель 602",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-345.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-346",
    "category": "interior",
    "name": "Термінус модель 603",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-346.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-347",
    "category": "interior",
    "name": "Термінус модель 604",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-347.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-348",
    "category": "interior",
    "name": "Термінус модель 605",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-348.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-349",
    "category": "interior",
    "name": "Термінус модель 606",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-349.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-350",
    "category": "interior",
    "name": "Термінус модель 607",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-350.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-351",
    "category": "interior",
    "name": "Термінус модель 608",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-351.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-352",
    "category": "interior",
    "name": "Термінус модель 609",
    "material": "Міжкімнатні",
    "style": "Колекція Neoclassico",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Neoclassico. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Neoclassico"
    ],
    "image": "/catalog-assets/products/product-352.webp",
    "brand": "Термінус",
    "collection": "Neoclassico"
  },
  {
    "slug": "catalog-353",
    "category": "interior",
    "name": "Термінус модель 801",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-353.webp",
    "brand": "Термінус",
    "collection": "Solid"
  },
  {
    "slug": "catalog-354",
    "category": "interior",
    "name": "Термінус модель 802",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-354.webp",
    "brand": "Термінус",
    "collection": "Solid"
  },
  {
    "slug": "catalog-355",
    "category": "interior",
    "name": "Термінус модель 803",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-355.webp",
    "brand": "Термінус",
    "collection": "Solid"
  },
  {
    "slug": "catalog-356",
    "category": "interior",
    "name": "Термінус модель 804",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-356.webp",
    "brand": "Термінус",
    "collection": "Solid"
  },
  {
    "slug": "catalog-357",
    "category": "interior",
    "name": "Термінус модель 805",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-357.webp",
    "brand": "Термінус",
    "collection": "Solid"
  },
  {
    "slug": "catalog-358",
    "category": "interior",
    "name": "Термінус модель 806",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-358.webp",
    "brand": "Термінус",
    "collection": "Solid"
  },
  {
    "slug": "catalog-359",
    "category": "interior",
    "name": "Термінус модель 807",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-359.webp",
    "brand": "Термінус",
    "collection": "Solid"
  },
  {
    "slug": "catalog-360",
    "category": "interior",
    "name": "Термінус модель 808",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-360.webp",
    "brand": "Термінус",
    "collection": "Solid"
  },
  {
    "slug": "catalog-361",
    "category": "interior",
    "name": "Термінус модель 809",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-361.webp",
    "brand": "Термінус",
    "collection": "Solid"
  },
  {
    "slug": "catalog-362",
    "category": "interior",
    "name": "Термінус модель 810",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-362.webp",
    "brand": "Термінус",
    "collection": "Solid"
  },
  {
    "slug": "catalog-363",
    "category": "interior",
    "name": "Термінус модель 812",
    "material": "Міжкімнатні",
    "style": "Колекція Solid",
    "color": "Варіанти декорів",
    "price": "Ціна за запитом",
    "description": "Термінус, колекція Solid. Характеристики та актуальну ціну уточнюйте у менеджера.",
    "features": [
      "Фабрика Термінус",
      "Колекція Solid"
    ],
    "image": "/catalog-assets/products/product-363.webp",
    "brand": "Термінус",
    "collection": "Solid"
  }
];

// «Склад» був технічною групою імпорту, а не колекцією для покупців.
// Нормалізація потрібна для локального резервного каталогу, якщо Supabase тимчасово недоступний.
const collectionCorrections: Record<string, string> = {
  "catalog-9": "Вулиця", "catalog-10": "Вулиця", "catalog-11": "Вулиця", "catalog-12": "Вулиця", "catalog-13": "Вулиця", "catalog-14": "Вулиця",
  "catalog-138": "Milenium",
  "catalog-139": "Plato", "catalog-140": "Plato", "catalog-141": "Plato", "catalog-142": "Plato", "catalog-143": "Plato",
  "catalog-144": "iDoors", "catalog-145": "iDoors",
  "catalog-146": "Tetra", "catalog-147": "Tetra", "catalog-148": "Tetra", "catalog-149": "Tetra", "catalog-150": "Tetra", "catalog-151": "Tetra",
  "catalog-277": "Квартира", "catalog-278": "Квартира", "catalog-279": "Квартира", "catalog-280": "Квартира", "catalog-281": "Квартира", "catalog-282": "Квартира", "catalog-283": "Квартира",
  "catalog-284": "Вулиця", "catalog-285": "Вулиця", "catalog-286": "Вулиця", "catalog-287": "Вулиця", "catalog-288": "Вулиця", "catalog-289": "Вулиця", "catalog-290": "Вулиця", "catalog-291": "Вулиця", "catalog-292": "Квартира", "catalog-293": "Квартира", "catalog-294": "Вулиця",
};

export const importedProducts: Product[] = rawImportedProducts.map((product) => {
  const collection = collectionCorrections[product.slug];
  if (!collection) return product;
  return {
    ...product,
    collection,
    style: `Колекція ${collection}`,
    features: [`Фабрика ${product.brand}`, `Колекція ${collection}`],
    description: product.description.replace(/колекція Склад/gi, `колекція ${collection}`),
  };
});
