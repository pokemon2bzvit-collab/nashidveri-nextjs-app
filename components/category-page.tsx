import { ProductGrid } from "./product-grid";
import { SiteShell } from "./site-shell";
import { categories, products, type Category } from "@/lib/catalog";

export function CategoryPage({ category }: { category: Category }) {
  const info = categories[category];
  const list = products.filter((product) => product.category === category);
  return <SiteShell><main><section className="container-page pt-8 sm:pt-12"><div className="relative overflow-hidden rounded-[2rem] bg-sand px-7 py-14 sm:px-12 lg:min-h-[380px] lg:py-20">{info.image && <img className="absolute inset-y-0 right-0 hidden h-full w-[45%] object-contain p-8 lg:block" src={info.image} alt="" />}<div className="relative max-w-2xl"><p className="eyebrow">Каталог · Наші двері</p><h1 className="heading mt-3">{info.title}</h1><p className="mt-5 max-w-xl text-lg leading-8 text-stone-600">{info.description}</p><a href="#models" className="button-primary mt-8">Переглянути моделі</a></div></div></section><section id="models" className="container-page section-pad"><p className="eyebrow">Популярні моделі</p><h2 className="mt-3 font-display text-4xl sm:text-5xl">Оберіть свій варіант</h2>{list.length ? <div className="mt-9"><ProductGrid products={list} /></div> : <p className="mt-8 max-w-xl text-stone-600">Каталог вікон наповнюємо. Надішліть фото або прайс — і додамо реальні моделі.</p>}</section></main></SiteShell>;
}
