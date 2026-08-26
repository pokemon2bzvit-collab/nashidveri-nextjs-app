import Link from "next/link";
import { ArrowUpRight } from "lucide-react";
import { interiorBrands } from "@/lib/interior-brands";
import { entranceBrands } from "@/lib/entrance-brands";

const groups = [
  { title: "Міжкімнатні двері", href: "/mizhkimnatni-dveri", brands: interiorBrands, prefix: "/mizhkimnatni-dveri" },
  { title: "Вхідні двері", href: "/vhidni-dveri", brands: entranceBrands, prefix: "/vhidni-dveri" },
];

export function HomeCategories() {
  return <section className="container-page py-14 sm:py-20">
    <div className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
      <div><p className="eyebrow">Наші виробники</p><h2 className="heading mt-3">Фабрики, яким довіряють</h2><p className="mt-4 max-w-xl text-sm leading-6 text-stone-600 sm:text-base">Оберіть фабрику, перегляньте її колекції та знайдіть модель для свого дому.</p></div>
      <Link href="/catalog" className="inline-flex w-fit items-center gap-2 text-sm font-bold text-clay transition hover:text-ink">Увесь каталог <ArrowUpRight size={17} /></Link>
    </div>
    <div className="mt-9 space-y-8">
      {groups.map((group) => <div key={group.title}><div className="flex items-center justify-between"><h3 className="font-display text-2xl tracking-[-.035em] text-ink sm:text-3xl">{group.title}</h3><Link href={group.href} className="text-sm font-bold text-clay hover:text-ink">Усі фабрики</Link></div><div className="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-5">{group.brands.map((brand) => <Link key={brand.slug} href={`${group.prefix}/${brand.slug}`} className="group rounded-2xl border border-stone-200 bg-white p-4 transition hover:-translate-y-0.5 hover:border-clay hover:shadow-soft sm:p-5"><p className="font-display text-xl tracking-[-.035em] text-ink sm:text-2xl">{brand.name}</p><p className="mt-2 line-clamp-2 min-h-10 text-xs leading-5 text-stone-500">{brand.collections.slice(0, 2).join(" · ")}</p><span className="mt-5 inline-flex items-center gap-1 text-xs font-bold text-clay">Колекції <ArrowUpRight size={14} className="transition group-hover:translate-x-0.5 group-hover:-translate-y-0.5" /></span></Link>)}</div></div>)}
    </div>
    <div className="mt-10 flex flex-col items-start justify-between gap-4 rounded-[1.5rem] bg-sand px-6 py-6 sm:flex-row sm:items-center sm:px-8"><p className="max-w-xl font-display text-2xl leading-tight text-ink sm:text-3xl">Не знаєте, з якої фабрики почати? Підберемо двері під ваш простір і бюджет.</p><Link href="/contacts" className="button-primary shrink-0">Замовити прорахунок <ArrowUpRight size={17} /></Link></div>
  </section>;
}
