import { ArrowUpRight } from "lucide-react";
import Link from "next/link";
import { catalogImageUrl } from "@/lib/catalog";

const works = [
  { title: "Сучасна класика", subtitle: "Міжкімнатні двері Papa Carlo", image: catalogImageUrl("/catalog-assets/products/product-85.jpg"), href: "/mizhkimnatni-dveri/papa-carlo" },
  { title: "Захищений вхід", subtitle: "Вхідні двері Abwehr", image: catalogImageUrl("/catalog-assets/products/product-1.webp"), href: "/vhidni-dveri/abwehr" },
  { title: "Лаконічний дизайн", subtitle: "Міжкімнатні двері Термінус", image: catalogImageUrl("/catalog-assets/products/product-295.webp"), href: "/mizhkimnatni-dveri/terminus" },
];

export function Portfolio() {
  return <section id="portfolio" className="container-page section-pad">
    <div className="max-w-2xl"><p className="eyebrow">Натхнення</p><h2 className="heading mt-3">Рішення для<br />вашого простору</h2><p className="mt-5 text-base leading-7 text-stone-600">Добірка моделей із нашого каталогу — для сучасного інтер’єру та надійного входу.</p></div>
    <div className="mt-10 grid gap-5 md:grid-cols-3">
      {works.map((work, index) => <article key={work.title} className="group overflow-hidden rounded-[1.5rem] border border-stone-200 bg-white shadow-sm transition duration-300 hover:-translate-y-1 hover:shadow-xl">
        <div className="flex aspect-[4/3] items-center justify-center bg-[#f7f5f1] p-6 sm:p-8"><img loading="lazy" src={work.image} alt={work.subtitle} className="h-full w-full object-contain transition duration-500 group-hover:scale-[1.03]" /></div>
        <div className="p-5 sm:p-6"><p className="eyebrow">0{index + 1}</p><h3 className="mt-2 font-display text-2xl font-semibold tracking-[-.03em] text-ink">{work.title}</h3><p className="mt-2 text-sm leading-6 text-stone-600">{work.subtitle}</p><Link href={work.href} className="mt-5 inline-flex items-center gap-1 text-sm font-bold text-clay transition hover:text-ink">Переглянути колекцію <ArrowUpRight size={16} /></Link></div>
      </article>)}
    </div>
  </section>;
}
