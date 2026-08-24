import Link from "next/link";
import { ArrowUpRight, ArrowRight, PanelsTopLeft } from "lucide-react";
import { catalogImageUrl } from "@/lib/catalog";
import { interiorBrands } from "@/lib/interior-brands";
import { entranceBrands } from "@/lib/entrance-brands";

const items = [
  { number: "01", title: "Міжкімнатні двері", text: "Сучасний та класичний дизайн для інтер’єру, у якому важливі якість, комфорт і натуральність.", href: "/mizhkimnatni-dveri", image: catalogImageUrl("/catalog-assets/products/product-85.jpg") },
  { number: "02", title: "Вхідні двері", text: "Безпека, теплоізоляція, шумоізоляція та моделі на будь-який смак.", href: "/vhidni-dveri", image: catalogImageUrl("/catalog-assets/products/product-1.webp") },
  { number: "03", title: "Вікна", text: "Металопластикові та алюмінієві системи для квартири, будинку чи тераси.", href: "/vikna", image: null },
];

const featuredBrands = [
  ...interiorBrands.filter((brand) => ["papa-carlo", "rodos", "terminus"].includes(brand.slug)).map((brand) => ({ ...brand, href: `/mizhkimnatni-dveri/${brand.slug}` })),
  ...entranceBrands.filter((brand) => ["abwehr", "strazh", "magda"].includes(brand.slug)).map((brand) => ({ ...brand, href: `/vhidni-dveri/${brand.slug}` })),
];

export function HomeCategories() {
  const [interior, entrance, windows] = items;
  return <section id="directions" className="container-page section-pad">
    <div className="mx-auto max-w-2xl text-center"><p className="eyebrow">Наші напрямки</p><h2 className="heading mt-3">Оберіть рішення для свого дому</h2><p className="mt-4 text-sm leading-6 text-stone-600 sm:text-base">Почніть з категорії — далі покажемо фабрики, колекції та моделі.</p></div>
    <div className="mt-9 grid gap-4 lg:grid-cols-2">
      {[interior, entrance].map((item) => <article key={item.title} className="group grid overflow-hidden rounded-[1.75rem] bg-sand sm:grid-cols-[.8fr_1fr] lg:block">
        <div className="flex h-52 items-center justify-center bg-[#f7f5f1] p-5 sm:h-auto sm:min-h-72 lg:h-72"><img src={item.image!} alt={item.title} className="h-full w-full max-w-[240px] object-contain transition duration-500 group-hover:scale-[1.03]" /></div>
        <div className="flex flex-col justify-center p-6 sm:p-7"><p className="eyebrow">{item.number}</p><h3 className="mt-2 font-display text-3xl font-semibold tracking-[-.04em]">{item.title}</h3><p className="mt-3 text-sm leading-6 text-stone-600">{item.text}</p><Link href={item.href} className="mt-5 inline-flex w-fit items-center gap-2 text-sm font-bold text-clay transition hover:text-ink">Перейти до каталогу <ArrowUpRight size={16} /></Link></div>
      </article>)}
    </div>
    <article className="mt-4 flex flex-col gap-5 rounded-[1.75rem] bg-ink p-6 text-white sm:flex-row sm:items-center sm:justify-between sm:p-8">
      <div className="flex items-start gap-4"><span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-white/10 text-[#e8ae83]"><PanelsTopLeft size={21} /></span><div><p className="text-xs font-bold uppercase tracking-[.16em] text-[#e8ae83]">{windows.number}</p><h3 className="mt-1 font-display text-3xl">{windows.title}</h3><p className="mt-2 max-w-2xl text-sm leading-6 text-stone-300">{windows.text}</p></div></div>
      <Link href={windows.href} className="inline-flex shrink-0 items-center gap-2 text-sm font-bold text-white">Дізнатись більше <ArrowRight size={17} /></Link>
    </article>
    <div className="mt-14 rounded-[1.75rem] border border-stone-200 bg-white p-6 sm:p-8"><div className="flex flex-col justify-between gap-4 sm:flex-row sm:items-end"><div><p className="eyebrow">Перевірені фабрики</p><h3 className="mt-2 font-display text-3xl tracking-[-.04em] sm:text-4xl">Почніть з улюбленої фабрики</h3></div><Link href="/catalog" className="inline-flex items-center gap-2 text-sm font-bold text-clay">Увесь каталог <ArrowUpRight size={16} /></Link></div><div className="mt-7 grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-6">{featuredBrands.map((brand) => <Link key={brand.slug} href={brand.href} className="group rounded-2xl border border-stone-200 p-4 transition hover:border-clay hover:bg-sand"><p className="font-display text-xl">{brand.name}</p><p className="mt-2 truncate text-xs text-stone-500">{brand.collections.slice(0, 2).join(" · ")}</p><ArrowUpRight size={15} className="mt-5 text-clay transition group-hover:translate-x-0.5 group-hover:-translate-y-0.5" /></Link>)}</div></div>
  </section>;
}
