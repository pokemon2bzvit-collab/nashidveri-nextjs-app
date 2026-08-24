import Link from "next/link";
import { ArrowDownRight } from "lucide-react";
import { catalogImageUrl } from "@/lib/catalog";

export function Hero({ onMeasure }: { onMeasure: () => void }) {
  return <section id="home" className="bg-[#fafafa]"><div className="container-page grid items-center gap-8 py-10 lg:min-h-[620px] lg:grid-cols-[1fr_.9fr] lg:gap-10 lg:py-12"><div className="text-center lg:text-left"><p className="eyebrow">Магазин «Наші двері» · Ужгород</p><h1 className="mt-4 max-w-3xl font-display text-5xl font-semibold tracking-[-.065em] text-ink sm:text-6xl">Двері, що<br /><span className="text-clay">створюють затишок.</span></h1><p className="mx-auto mt-5 max-w-xl text-base leading-7 text-stone-600 sm:text-lg lg:mx-0">Вхідні та міжкімнатні двері в Ужгороді з монтажем і гарантією. Безкоштовний виїзд замірника.</p><div className="mt-8 flex flex-col justify-center gap-3 sm:flex-row lg:justify-start"><Link className="button-primary" href="/catalog">Переглянути каталог <ArrowDownRight size={17} /></Link><button className="button-light" onClick={onMeasure}>Замовити прорахунок</button></div></div><div className="relative overflow-hidden rounded-[2rem] bg-[#f7f5f1] p-5 shadow-soft sm:p-7"><img src={catalogImageUrl("/catalog-assets/products/product-152.jpg")} alt="Вхідні двері Rodos Steel" className="h-[330px] w-full object-contain sm:h-[420px]" /></div></div></section>;
}
