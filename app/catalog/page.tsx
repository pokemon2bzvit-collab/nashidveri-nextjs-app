import Link from "next/link";
import { CatalogBrowser } from "@/components/catalog-browser";
import { SiteShell } from "@/components/site-shell";
import { categories, getProducts } from "@/lib/catalog";

export default async function CatalogPage({ searchParams }: { searchParams: Promise<{ category?: string; search?: string; brand?: string; collection?: string }> }) {
  const params = await searchParams;
  const current = params.category || "all";
  const products = await getProducts();
  const categoryLinks = Object.entries(categories).filter(([id]) => products.some((product) => product.category === id));
  const factoryLinks = [...new Set(products.filter((product) => current === "all" || product.category === current).map((product) => product.brand))];

  return <SiteShell><main>
    <section className="border-b bg-ink py-8 text-white sm:py-10"><div className="container-page">
      <p className="eyebrow text-[#E8AE83]">Інтернет-каталог</p>
      <div className="mt-2 flex flex-col justify-between gap-5 lg:flex-row lg:items-end"><div><h1 className="font-display text-4xl leading-tight sm:text-5xl">Двері для вашого простору</h1><p className="mt-3 max-w-2xl text-sm leading-6 text-stone-300 sm:text-base">Оберіть категорію, фабрику та колекцію. Допоможемо з комплектацією й прорахунком.</p></div><p className="text-sm text-stone-300">У каталозі: <span className="font-bold text-white">{products.length} моделей</span></p></div>
      <div className="mt-6 flex gap-2 overflow-x-auto pb-1">{categoryLinks.map(([id, category]) => <Link key={id} href={`/catalog?category=${id}`} className={`whitespace-nowrap rounded-full border px-4 py-2 text-sm font-bold transition ${current === id ? "border-clay bg-clay text-white" : "border-white/20 text-white hover:border-white hover:bg-white/10"}`}>{category.title}</Link>)}</div>
      <div className="mt-5 flex items-center gap-3 overflow-x-auto pb-1"><span className="shrink-0 text-xs font-bold uppercase tracking-[.12em] text-stone-400">Фабрики</span>{factoryLinks.map((brand) => <Link key={brand} href={`/catalog?${current !== "all" ? `category=${current}&` : ""}brand=${encodeURIComponent(brand)}`} className="whitespace-nowrap text-sm font-semibold text-white/80 transition hover:text-[#E8AE83]">{brand}</Link>)}</div>
    </div></section>
    <section className="container-page section-pad pt-8 sm:pt-10"><CatalogBrowser products={products} initialCategory={current} initialQuery={params.search || ""} initialBrand={params.brand || "all"} initialCollection={params.collection || "all"} /></section>
  </main></SiteShell>;
}
