import { Portfolio } from "@/components/portfolio";
import { SiteShell } from "@/components/site-shell";
export default function PortfolioPage() { return <SiteShell><main><Portfolio /><section className="container-page pb-20"><div className="rounded-2xl border border-stone-200 bg-sand px-7 py-12 sm:px-12"><p className="eyebrow">Ваш інтер’єр — наступний</p><h1 className="mt-4 font-display text-4xl text-ink sm:text-5xl">Створімо простір, у який хочеться повертатись.</h1></div></section></main></SiteShell> }
