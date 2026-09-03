import { ArrowRight, HeartHandshake, MapPin, Ruler, ShieldCheck, Truck } from "lucide-react";
import Link from "next/link";
import type { Metadata } from "next";
import { SiteShell } from "@/components/site-shell";

export const metadata: Metadata = { title: "Про салон «Наші двері» в Ужгороді", description: "«Наші двері» — салон дверей і вікон в Ужгороді. Підбір, замір, комплектація, доставка та професійний монтаж.", alternates: { canonical: "/pro-nas" } };

const steps = [
  { number: "01", title: "Знайомимось із простором", text: "Вислухаємо ваші побажання, підкажемо тип дверей, покриття та комплектацію." },
  { number: "02", title: "Робимо замір", text: "Уточнюємо параметри прорізу, напрямок відкривання та важливі деталі монтажу." },
  { number: "03", title: "Комплектуємо замовлення", text: "Допомагаємо узгодити полотно, коробку, фурнітуру, скло та декор." },
  { number: "04", title: "Доставляємо й монтуємо", text: "Організовуємо доставку та професійний монтаж у зручний для вас час." },
];

const values = [
  { icon: HeartHandshake, title: "Людський підхід", text: "Не нав’язуємо найдорожче — допомагаємо знайти рішення під ваш простір і бюджет." },
  { icon: Ruler, title: "Уважний замір", text: "Правильний замір допомагає уникнути зайвих витрат і несподіванок під час монтажу." },
  { icon: ShieldCheck, title: "Впевненість у виборі", text: "Пояснюємо відмінності матеріалів, конструкцій і покриттів зрозумілою мовою." },
  { icon: Truck, title: "Від вибору до встановлення", text: "Супроводжуємо замовлення на всіх етапах: від консультації до готового результату." },
];

export default function AboutPage() {
  return <SiteShell><main>
    <section className="bg-sand py-16 sm:py-24"><div className="container-page grid gap-10 lg:grid-cols-[1.05fr_.95fr] lg:items-end"><div><p className="eyebrow">Про магазин</p><h1 className="heading mt-4 max-w-3xl">Ваш затишок починається з правильного вибору.</h1><p className="mt-6 max-w-2xl text-base leading-8 text-stone-600 sm:text-lg">«Наші двері» — салон дверей та вікон в Ужгороді. Ми допомагаємо підібрати вхідні й міжкімнатні двері, віконні системи та комплектацію, яка пасуватиме саме вашому дому.</p><div className="mt-8 flex flex-col gap-3 sm:flex-row"><Link href="/catalog" className="button-primary">Переглянути каталог <ArrowRight size={17} /></Link><Link href="/contacts" className="button-light">Записатися на замір</Link></div></div><div className="rounded-[2rem] bg-white p-7 shadow-soft sm:p-9"><MapPin className="text-clay" size={26} /><p className="mt-10 font-display text-3xl leading-tight text-ink">Працюємо в Ужгороді<br />та поруч із вами.</p><p className="mt-4 text-sm leading-6 text-stone-600">Завітайте до салону: вул. Івана Чендея, 44, Ужгород, 88000. Тут можна побачити матеріали, декори й фурнітуру наживо.</p><a href="https://www.google.com/maps/search/?api=1&query=вул.+Івана+Чендея,+44,+Ужгород,+88000" target="_blank" rel="noreferrer" className="mt-6 inline-flex items-center gap-2 text-sm font-bold text-clay hover:text-ink">Побудувати маршрут <ArrowRight size={16} /></a></div></div></section>
    <section className="container-page section-pad"><div className="max-w-2xl"><p className="eyebrow">Наш підхід</p><h2 className="heading mt-3">Двері — це не просто покупка.</h2><p className="mt-5 text-base leading-8 text-stone-600">Вони відповідають за перше враження, тишу, тепло, безпеку та щоденний комфорт. Тому ми вважаємо важливим не лише показати модель на фото, а й допомогти розібратися в усіх нюансах до замовлення.</p></div><div className="mt-10 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">{values.map(({ icon: Icon, title, text }) => <article key={title} className="rounded-2xl border border-stone-200 bg-white p-6"><span className="inline-flex rounded-full bg-sand p-3 text-clay"><Icon size={21} /></span><h3 className="mt-5 text-lg font-bold text-ink">{title}</h3><p className="mt-2 text-sm leading-6 text-stone-600">{text}</p></article>)}</div></section>
    <section className="bg-ink py-16 text-white sm:py-20"><div className="container-page"><p className="eyebrow !text-[#d7b77a]">Як ми працюємо</p><h2 className="mt-3 max-w-2xl font-display text-4xl font-semibold tracking-[-.04em] sm:text-5xl">Спокійний шлях від ідеї до встановлених дверей.</h2><div className="mt-12 grid gap-7 sm:grid-cols-2 lg:grid-cols-4">{steps.map((step) => <article key={step.number} className="border-t border-white/20 pt-5"><p className="text-sm font-bold text-[#d7b77a]">{step.number}</p><h3 className="mt-5 text-xl font-bold">{step.title}</h3><p className="mt-3 text-sm leading-6 text-white/65">{step.text}</p></article>)}</div></div></section>
    <section className="container-page section-pad"><div className="rounded-[2rem] bg-sand px-7 py-10 sm:px-12 sm:py-14 lg:flex lg:items-center lg:justify-between lg:gap-10"><div><p className="eyebrow">Потрібна консультація?</p><h2 className="heading mt-3 max-w-2xl">Допоможемо обрати рішення для вашого простору.</h2><p className="mt-4 max-w-xl leading-7 text-stone-600">Надішліть фото прорізу або завітайте до салону — зорієнтуємо з моделями, декорами й комплектацією.</p></div><div className="mt-7 flex shrink-0 flex-col gap-3 sm:flex-row lg:mt-0 lg:flex-col"><a href="tel:+380950729341" className="button-primary">Подзвонити</a><Link href="/contacts" className="button-light">Написати нам</Link></div></div></section>
  </main></SiteShell>;
}
