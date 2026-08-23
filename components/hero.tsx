import Link from "next/link";
import { ArrowDownRight } from "lucide-react";

export function Hero({ onMeasure }: { onMeasure: () => void }) {
  return <section id="home" className="flex min-h-[calc(100vh-3.5rem)] items-center bg-white text-center lg:min-h-[calc(100vh-5.75rem)]"><div className="container-page py-20 sm:py-28"><p className="eyebrow">Магазин «Наші двері» · Ужгород</p><h1 className="mx-auto mt-4 max-w-4xl font-display text-5xl font-semibold tracking-[-.065em] text-ink sm:text-7xl lg:text-8xl">Гарантія вашого<br /><span className="text-clay">затишку.</span></h1><p className="mx-auto mt-6 max-w-lg text-base leading-7 text-stone-600 sm:text-lg">Двері та вікна для оселі, у якій хочеться бути.</p><div className="mt-9 flex flex-col justify-center gap-3 sm:flex-row"><Link className="button-primary" href="/catalog">Переглянути каталог <ArrowDownRight size={17} /></Link><button className="button-light" onClick={onMeasure}>Замовити прорахунок</button></div></div></section>;
}
