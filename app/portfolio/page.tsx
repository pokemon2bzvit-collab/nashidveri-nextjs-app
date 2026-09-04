import { Portfolio } from "@/components/portfolio";
import { SiteShell } from "@/components/site-shell";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Портфоліо дверей та інтер’єрних рішень в Ужгороді",
  description: "Добірка дверних рішень від «Наші двері»: міжкімнатні та вхідні двері для сучасних інтер’єрів і надійного входу в Ужгороді.",
  alternates: { canonical: "/portfolio" },
};

export default function PortfolioPage() { return <SiteShell><main><Portfolio standalone /><section className="container-page pb-20"><div className="rounded-2xl border border-stone-200 bg-sand px-7 py-12 sm:px-12"><p className="eyebrow">Ваш інтер’єр — наступний</p><h2 className="mt-4 font-display text-4xl text-ink sm:text-5xl">Створімо простір, у який хочеться повертатись.</h2></div></section></main></SiteShell>; }
