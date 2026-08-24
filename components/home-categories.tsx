import Link from "next/link";
import { ArrowUpRight, PanelsTopLeft } from "lucide-react";
import { catalogImageUrl } from "@/lib/catalog";

const items = [
  { number: "01", title: "Міжкімнатні двері", text: "Сучасний та класичний дизайн для інтер’єру, у якому важливі якість, комфорт і натуральність.", href: "/mizhkimnatni-dveri", image: catalogImageUrl("/catalog-assets/products/product-85.jpg") },
  { number: "02", title: "Вхідні двері", text: "Безпека, теплоізоляція, шумоізоляція та моделі на будь-який смак.", href: "/vhidni-dveri", image: catalogImageUrl("/catalog-assets/products/product-1.webp") },
  { number: "03", title: "Вікна", text: "Металопластикові та алюмінієві системи для квартири, будинку чи тераси.", href: "/vikna", image: null },
];

export function HomeCategories() { return <section id="directions" className="container-page section-pad"><div className="mx-auto max-w-2xl text-center"><p className="eyebrow">Наші напрямки</p><h2 className="heading mt-3">Оберіть рішення<br />для свого дому</h2></div><div className="mt-10 space-y-8">{items.map((item, index) => <article key={item.title} className="grid overflow-hidden rounded-[2rem] bg-sand lg:grid-cols-2"><div className={`flex min-h-72 items-center justify-center bg-[#f7f5f1] p-8 sm:p-10 ${index === 1 ? "lg:order-2" : ""}`}>{item.image ? <img src={item.image} alt={item.title} className="h-52 w-full max-w-[250px] object-contain sm:h-60 sm:max-w-[290px]" /> : <div className="flex h-full flex-col items-center justify-center text-center text-stone-500"><PanelsTopLeft size={42} className="text-clay" /><p className="mt-4 text-sm font-semibold">Фото вікон додамо<br />з вашого асортименту</p></div>}</div><div className="flex flex-col justify-center p-8 sm:p-12"><p className="eyebrow">{item.number}</p><h2 className="mt-3 font-display text-4xl font-semibold tracking-[-.04em] sm:text-5xl">{item.title}</h2><p className="mt-5 max-w-lg leading-7 text-stone-600">{item.text}</p><Link href={item.href} className="button-primary mt-7 w-fit">Перейти до каталогу <ArrowUpRight size={17} /></Link></div></article>)}</div></section>; }
