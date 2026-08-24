import { notFound } from "next/navigation";
import Link from "next/link";
import { ArrowLeft, ArrowUpRight } from "lucide-react";
import { SiteShell } from "@/components/site-shell";
import { entranceBrands, getEntranceBrand } from "@/lib/entrance-brands";
import { catalogImageUrl } from "@/lib/catalog";
import { ImageLightbox } from "@/components/image-lightbox";

export function generateStaticParams() { return entranceBrands.map((brand) => ({ brand: brand.slug })); }

export default async function EntranceBrandPage({ params }: { params: Promise<{ brand: string }> }) {
  const brand = getEntranceBrand((await params).brand);
  if (!brand) notFound();
  return <SiteShell><main><section className="container-page section-pad"><Link href="/vhidni-dveri" className="inline-flex items-center gap-2 text-sm font-bold text-stone-500 hover:text-ink"><ArrowLeft size={16} /> Усі фабрики</Link><div className="mt-7 grid overflow-hidden rounded-[2rem] bg-sand lg:grid-cols-2"><div className="p-8 sm:p-12"><p className="eyebrow">Фабрика вхідних дверей</p><h1 className="heading mt-3">{brand.name}</h1><p className="mt-5 text-lg leading-8 text-stone-600">{brand.description}</p></div><div className="flex h-[250px] items-center justify-center bg-[#f7f5f1] p-6 sm:h-[290px] lg:h-[320px]"><ImageLightbox src={catalogImageUrl(brand.image)} alt={brand.name} className="h-full w-full" imageClassName="h-full w-full object-contain" /></div></div><div className="mt-12"><p className="eyebrow">Каталог фабрики</p><h2 className="mt-3 font-display text-4xl font-semibold tracking-[-.04em]">Колекції</h2><div className="mt-7 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">{brand.collections.map((collection) => <Link key={collection} href={`/catalog?brand=${encodeURIComponent(brand.name)}&collection=${encodeURIComponent(collection)}`} className="group rounded-2xl border bg-white p-6 transition hover:border-clay"><p className="text-xl font-bold">{collection}</p><p className="mt-2 text-sm text-stone-500">Переглянути моделі</p><ArrowUpRight className="mt-5 text-clay" size={18} /></Link>)}</div></div></section></main></SiteShell>;
}
