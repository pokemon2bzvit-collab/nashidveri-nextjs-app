import { catalogImageUrl } from "@/lib/catalog";
const works = [
  ["Сучасна класика", "Міжкімнатні двері Papa Carlo", catalogImageUrl("/catalog-assets/products/product-85.jpg")],
  ["Захищений вхід", "Вхідні двері Abwehr", catalogImageUrl("/catalog-assets/products/product-1.webp")],
  ["Лаконічний дизайн", "Міжкімнатні двері Термінус", catalogImageUrl("/catalog-assets/products/product-295.webp")]
];
export function Portfolio() { return <section id="portfolio" className="container-page section-pad"><div className="flex items-end justify-between gap-6"><div><p className="eyebrow">Натхнення</p><h2 className="heading mt-3">Рішення для<br />вашого простору</h2></div><span className="hidden text-sm text-stone-500 sm:block">Додамо сюди ваші реальні виконані об’єкти</span></div><div className="mt-10 grid gap-4 md:grid-cols-2 lg:grid-cols-3">{works.map(([title, subtitle, image], i) => <figure key={title} className={`group relative overflow-hidden rounded-2xl ${i === 0 ? "md:col-span-2 lg:col-span-1" : ""}`}><img src={image} alt={title} className="h-80 w-full object-cover transition duration-500 group-hover:scale-105" /><figcaption className="absolute inset-x-0 bottom-0 bg-gradient-to-t from-black/70 to-transparent px-5 pb-5 pt-14 text-white"><p className="font-bold">{title}</p><p className="mt-1 text-sm text-white/70">{subtitle}</p></figcaption></figure>)}</div></section> }
