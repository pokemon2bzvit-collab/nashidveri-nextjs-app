import { notFound } from "next/navigation";
import Link from "next/link";
import type { Metadata } from "next";
import { ArrowLeft, ArrowUpRight } from "lucide-react";
import { SiteShell } from "@/components/site-shell";
import { ProductGrid } from "@/components/product-grid";
import { BrandLogo } from "@/components/brand-logo";
import { getInteriorBrand, interiorBrands } from "@/lib/interior-brands";
import { catalogImageUrl, getProducts } from "@/lib/catalog";

export function generateStaticParams() { return interiorBrands.map((brand) => ({ brand: brand.slug })); }

export async function generateMetadata({ params }: { params: Promise<{ brand: string }> }): Promise<Metadata> {
  const brand = getInteriorBrand((await params).brand);
  if (!brand) return { title: "Фабрика не знайдена" };
  return { title: `${brand.name} — міжкімнатні двері в Ужгороді`, description: `${brand.name}: ${brand.description} Колекції, моделі, декори, замір і монтаж у салоні «Наші двері» в Ужгороді.`, alternates: { canonical: `/mizhkimnatni-dveri/${brand.slug}` } };
}

export default async function InteriorBrandPage({ params }: { params: Promise<{ brand: string }> }) {
  const brand = getInteriorBrand((await params).brand);
  if (!brand) notFound();
  const products = (await getProducts()).filter((product) => product.brand === brand.name);
  return <SiteShell><main><section className="container-page section-pad"><Link href="/mizhkimnatni-dveri" className="inline-flex items-center gap-2 text-sm font-bold text-stone-500 hover:text-ink"><ArrowLeft size={16} /> Усі фабрики</Link><div className="mt-7 grid overflow-hidden rounded-[2rem] bg-sand lg:grid-cols-2"><div className="p-8 sm:p-12"><p className="eyebrow">Фабрика міжкімнатних дверей</p><BrandLogo brand={brand.name} className="mt-4 h-10 max-w-[220px]" /><h1 className="heading mt-3">{brand.name}</h1><p className="mt-5 text-lg leading-8 text-stone-600">{brand.description}</p><p className="mt-7 text-sm font-bold text-clay">У каталозі: {products.length} моделей</p></div><div className="flex h-[250px] items-center justify-center bg-[#f7f5f1] p-6 sm:h-[290px] lg:h-[320px]"><img src={catalogImageUrl(brand.image)} alt={brand.name} className="h-full w-full object-contain" /></div></div><div className="mt-12"><p className="eyebrow">Каталог фабрики</p><h2 className="mt-3 font-display text-4xl font-semibold tracking-[-.04em]">Колекції</h2><div className="mt-7 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">{brand.collections.map((collection) => <Link key={collection} href={`/catalog?brand=${encodeURIComponent(brand.name)}&collection=${encodeURIComponent(collection)}`} className="group rounded-2xl border bg-white p-6 transition hover:border-clay"><p className="text-xl font-bold">{collection}</p><p className="mt-2 text-sm text-stone-500">Переглянути моделі</p><ArrowUpRight className="mt-5 text-clay" size={18} /></Link>)}</div></div><div className="mt-16"><div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between"><div><BrandLogo brand={brand.name} className="h-7 max-w-[150px]" /><h2 className="mt-3 font-display text-4xl font-semibold tracking-[-.04em]">Популярні двері</h2></div><Link href={`/catalog?brand=${encodeURIComponent(brand.name)}`} className="inline-flex items-center gap-2 text-sm font-bold text-clay">Усі моделі фабрики <ArrowUpRight size={16} /></Link></div>{products.length ? <div className="mt-8"><ProductGrid products={products.slice(0, 9)} /></div> : <p className="mt-7 text-stone-600">Моделі цієї фабрики незабаром з’являться в каталозі.</p>}</div><div className="mt-12 rounded-[1.5rem] border border-stone-200 bg-sand px-7 py-8 sm:flex sm:items-center sm:justify-between sm:px-9"><p className="max-w-xl font-display text-2xl leading-tight text-ink">Потрібна допомога з вибором дверей {brand.name}?</p><Link href="/contacts" className="mt-5 inline-flex items-center gap-2 text-sm font-bold text-clay sm:mt-0">Замовити прорахунок <ArrowUpRight size={17} /></Link></div></section></main></SiteShell>;
}
