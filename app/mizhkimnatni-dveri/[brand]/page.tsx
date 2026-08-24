import { notFound } from "next/navigation";
import Link from "next/link";
import { ArrowLeft, ArrowUpRight } from "lucide-react";
import { SiteShell } from "@/components/site-shell";
import { getInteriorBrand, interiorBrands } from "@/lib/interior-brands";

const papaCarloCollections = new Set(["Tetra", "Plato", "Milenium", "STYLE", "Склад"]);

export function generateStaticParams() { return interiorBrands.map((brand) => ({ brand: brand.slug })); }

export default async function InteriorBrandPage({ params }: { params: Promise<{ brand: string }> }) {
  const { brand: slug } = await params;
  const brand = getInteriorBrand(slug);
  if (!brand) notFound();
  return <SiteShell><main><section className="container-page section-pad"><Link href="/mizhkimnatni-dveri" className="inline-flex items-center gap-2 text-sm font-bold text-stone-500 hover:text-ink"><ArrowLeft size={16} /> Усі фабрики</Link><div className="mt-7 grid overflow-hidden rounded-[2rem] bg-sand lg:grid-cols-2"><div className="p-8 sm:p-12"><p className="eyebrow">Фабрика міжкімнатних дверей</p><h1 className="heading mt-3">{brand.name}</h1><p className="mt-5 text-lg leading-8 text-stone-600">{brand.description}</p></div><img src={brand.image} alt={brand.name} className="h-full min-h-64 w-full object-cover" /></div><div className="mt-12"><p className="eyebrow">Каталог фабрики</p><h2 className="mt-3 font-display text-4xl font-semibold tracking-[-.04em]">Колекції</h2>{brand.collections.length ? <div className="mt-7 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">{brand.collections.map((collection) => <Link key={collection} href={brand.slug === "papa-carlo" && papaCarloCollections.has(collection) ? `/catalog?search=${encodeURIComponent(`колекція ${collection}`)}` : "/contacts"} className="group rounded-2xl border bg-white p-6 transition hover:border-clay"><p className="text-xl font-bold">{collection}</p><p className="mt-2 text-sm text-stone-500">Переглянути моделі</p><ArrowUpRight className="mt-5 text-clay" size={18} /></Link>)}</div> : <div className="mt-7 rounded-2xl border border-dashed bg-white p-8 text-stone-600">Колекції цієї фабрики додаємо. Надішліть сторінку зі старого сайту — і я одразу внесу їх.</div>}</div></section></main></SiteShell>;
}
