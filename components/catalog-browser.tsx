"use client";

import { Search, SlidersHorizontal, X } from "lucide-react";
import { useEffect, useMemo, useState } from "react";
import { ProductGrid } from "./product-grid";
import { categories, type Product } from "@/lib/catalog";

const PAGE_SIZE = 24;
const priceRanges = [{ id: "under-10000", label: "до 10 000 грн", max: 10000 }, { id: "10000-25000", label: "10 000–25 000 грн", min: 10000, max: 25000 }, { id: "over-25000", label: "від 25 000 грн", min: 25000 }];
const getPriceNumber = (price: string) => Number(price.replace(/[^\d]/g, "")) || null;

export function CatalogBrowser({ products, initialCategory = "all", initialQuery = "", initialBrand = "all", initialCollection = "all" }: { products: Product[]; initialCategory?: string; initialQuery?: string; initialBrand?: string; initialCollection?: string }) {
  const [category, setCategory] = useState(initialCategory);
  const [brand, setBrand] = useState(initialBrand);
  const [collection, setCollection] = useState(initialCollection);
  const [material, setMaterial] = useState("all");
  const [style, setStyle] = useState("all");
  const [color, setColor] = useState("all");
  const [priceRange, setPriceRange] = useState("all");
  const [query, setQuery] = useState(initialQuery);
  const [filtersOpen, setFiltersOpen] = useState(false);
  const [visibleCount, setVisibleCount] = useState(PAGE_SIZE);

  const categoryFilters = useMemo(() => [{ id: "all", label: "Усі моделі" }, ...Object.entries(categories).filter(([id]) => products.some((product) => product.category === id)).map(([id, item]) => ({ id, label: item.title }))], [products]);
  const categoryProducts = useMemo(() => products.filter((product) => category === "all" || product.category === category), [products, category]);
  const availableBrands = useMemo(() => [...new Set(categoryProducts.map((product) => product.brand))], [categoryProducts]);
  const facetProducts = useMemo(() => categoryProducts.filter((product) => brand === "all" || product.brand === brand), [categoryProducts, brand]);
  const availableCollections = useMemo(() => [...new Set(facetProducts.map((product) => product.collection))], [facetProducts]);
  const materials = useMemo(() => [...new Set(facetProducts.map((product) => product.material))], [facetProducts]);
  const styles = useMemo(() => [...new Set(facetProducts.map((product) => product.style))], [facetProducts]);
  const colors = useMemo(() => [...new Set(facetProducts.map((product) => product.color))], [facetProducts]);
  const hasPrices = useMemo(() => products.some((product) => getPriceNumber(product.price) !== null), [products]);

  const result = useMemo(() => products.filter((product) => {
    const price = getPriceNumber(product.price);
    const range = priceRanges.find((item) => item.id === priceRange);
    const matchesPrice = !range || (price !== null && (!range.min || price >= range.min) && (!range.max || price < range.max));
    const searchable = `${product.name} ${product.brand} ${product.collection} ${product.features.join(" ")} ${product.description}`.toLowerCase();
    return (category === "all" || product.category === category) && (brand === "all" || product.brand === brand) && (collection === "all" || product.collection === collection) && (material === "all" || product.material === material) && (style === "all" || product.style === style) && (color === "all" || product.color === color) && matchesPrice && searchable.includes(query.toLowerCase());
  }), [products, category, brand, collection, material, style, color, priceRange, query]);

  useEffect(() => setVisibleCount(PAGE_SIZE), [category, brand, collection, material, style, color, priceRange, query]);
  const visibleProducts = result.slice(0, visibleCount);
  const reset = () => { setCategory("all"); setBrand("all"); setCollection("all"); setMaterial("all"); setStyle("all"); setColor("all"); setPriceRange("all"); setQuery(""); };
  const active = category !== "all" || brand !== "all" || collection !== "all" || material !== "all" || style !== "all" || color !== "all" || priceRange !== "all" || query.length > 0;
  const activeFilters = [
    category !== "all" && { label: categories[category as keyof typeof categories]?.short || category, clear: () => { setCategory("all"); setBrand("all"); setCollection("all"); } },
    brand !== "all" && { label: brand, clear: () => { setBrand("all"); setCollection("all"); } },
    collection !== "all" && { label: collection, clear: () => setCollection("all") },
    material !== "all" && { label: material, clear: () => setMaterial("all") },
    style !== "all" && { label: style, clear: () => setStyle("all") },
    color !== "all" && { label: color, clear: () => setColor("all") },
    priceRange !== "all" && { label: priceRanges.find((item) => item.id === priceRange)?.label || "Ціна", clear: () => setPriceRange("all") },
  ].filter(Boolean) as { label: string; clear: () => void }[];

  return <div className="mt-0 grid gap-8 lg:grid-cols-[255px_minmax(0,1fr)]">
    <button aria-label="Відкрити фільтри" className="fixed left-0 top-1/2 z-30 -translate-y-1/2 rounded-r-xl bg-ink px-2.5 py-4 text-xs font-bold text-white shadow-lg lg:hidden" onClick={() => setFiltersOpen(true)}><span className="[writing-mode:vertical-rl]">Фільтри</span></button>
    {filtersOpen && <button aria-label="Закрити фільтри" className="fixed inset-0 z-40 bg-black/35 lg:hidden" onClick={() => setFiltersOpen(false)} />}
    <aside className={`surface-card fixed inset-y-0 left-0 z-50 h-full w-[min(88vw,330px)] overflow-y-auto p-5 shadow-2xl transition-transform lg:sticky lg:top-28 lg:z-auto lg:h-fit lg:w-auto lg:translate-x-0 lg:shadow-none ${filtersOpen ? "translate-x-0" : "-translate-x-full"}`}>
      <div className="flex items-center justify-between"><p className="flex items-center gap-2 text-sm font-bold"><SlidersHorizontal size={17} className="text-clay" /> Фільтри</p><div className="flex items-center gap-3">{active && <button onClick={reset} className="text-xs font-bold text-clay hover:underline">Очистити</button>}<button aria-label="Закрити фільтри" className="lg:hidden" onClick={() => setFiltersOpen(false)}><X size={19} /></button></div></div>
      <FilterGroup title="Категорія">{categoryFilters.map((filter) => <FilterButton key={filter.id} selected={category === filter.id} onClick={() => { setCategory(filter.id); setBrand("all"); setCollection("all"); setMaterial("all"); setStyle("all"); setColor("all"); }}>{filter.label}</FilterButton>)}</FilterGroup>
      {availableBrands.length > 1 && <FilterGroup title="Фабрика">{availableBrands.map((item) => <FilterButton key={item} selected={brand === item} onClick={() => { setBrand(brand === item ? "all" : item); setCollection("all"); }}>{item}</FilterButton>)}</FilterGroup>}
      {availableCollections.length > 1 && <FilterGroup title="Колекція">{availableCollections.map((item) => <FilterButton key={item} selected={collection === item} onClick={() => setCollection(collection === item ? "all" : item)}>{item}</FilterButton>)}</FilterGroup>}
      {materials.length > 1 && <FilterGroup title="Матеріал">{materials.map((item) => <FilterButton key={item} selected={material === item} onClick={() => setMaterial(material === item ? "all" : item)}>{item}</FilterButton>)}</FilterGroup>}
      {styles.length > 1 && <FilterGroup title="Стиль / призначення">{styles.map((item) => <FilterButton key={item} selected={style === item} onClick={() => setStyle(style === item ? "all" : item)}>{item}</FilterButton>)}</FilterGroup>}
      {colors.length > 1 && <FilterGroup title="Колір">{colors.map((item) => <FilterButton key={item} selected={color === item} onClick={() => setColor(color === item ? "all" : item)}>{item}</FilterButton>)}</FilterGroup>}
      {hasPrices && <FilterGroup title="Ціновий діапазон">{priceRanges.map((item) => <FilterButton key={item.id} selected={priceRange === item.id} onClick={() => setPriceRange(priceRange === item.id ? "all" : item.id)}>{item.label}</FilterButton>)}</FilterGroup>}
      <button className="button-primary mt-7 w-full lg:hidden" onClick={() => setFiltersOpen(false)}>Показати {result.length} моделей</button>
    </aside>
    <div>
      <div className="flex flex-col justify-between gap-4 border-b pb-5 sm:flex-row sm:items-center"><label className="relative block max-w-md flex-1"><Search className="absolute left-4 top-1/2 -translate-y-1/2 text-stone-400" size={18} /><input value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Пошук за моделлю, фабрикою чи колекцією" className="w-full rounded-xl border bg-white py-3 pl-11 pr-10 text-sm outline-none transition focus:border-clay" />{query && <button aria-label="Очистити пошук" onClick={() => setQuery("")} className="absolute right-3 top-1/2 -translate-y-1/2 text-stone-400"><X size={16} /></button>}</label><div className="flex items-center justify-between gap-4"><p className="text-sm text-stone-500">Знайдено: <span className="font-bold text-ink">{result.length}</span> моделей</p><button className="inline-flex items-center gap-2 rounded-full border px-3 py-2 text-xs font-bold lg:hidden" onClick={() => setFiltersOpen(true)}><SlidersHorizontal size={15} /> Фільтри</button></div></div>
      {activeFilters.length > 0 && <div className="mt-4 flex flex-wrap items-center gap-2"><span className="text-xs font-semibold text-stone-500">Обрано:</span>{activeFilters.map((filter) => <button key={filter.label} onClick={filter.clear} className="inline-flex items-center gap-1 rounded-full bg-sand px-3 py-1.5 text-xs font-bold text-ink hover:bg-stone-200">{filter.label}<X size={13} /></button>)}</div>}
      {result.length ? <><div className="mt-7"><ProductGrid products={visibleProducts} /></div>{visibleCount < result.length && <div className="mt-9 text-center"><button className="button-light" onClick={() => setVisibleCount((count) => count + PAGE_SIZE)}>Показати ще {Math.min(PAGE_SIZE, result.length - visibleCount)} моделей</button><p className="mt-3 text-xs text-stone-500">Показано {visibleProducts.length} з {result.length}</p></div>}</> : <div className="mt-7 rounded-2xl border border-dashed bg-white p-10 text-center"><p className="font-display text-2xl">За вашими умовами нічого не знайдено</p><p className="mt-2 text-sm text-stone-500">Спробуйте скинути один або кілька фільтрів.</p><button onClick={reset} className="button-primary mt-5">Показати всі моделі</button></div>}
    </div>
  </div>;
}

function FilterGroup({ title, children }: { title: string; children: React.ReactNode }) { return <div className="mt-6 border-t pt-5"><p className="text-xs font-bold uppercase tracking-[.12em] text-stone-500">{title}</p><div className="mt-3 flex flex-wrap gap-2">{children}</div></div>; }
function FilterButton({ selected, children, onClick }: { selected: boolean; children: React.ReactNode; onClick: () => void }) { return <button onClick={onClick} className={`rounded-full border px-3 py-1.5 text-xs font-semibold transition ${selected ? "border-ink bg-ink text-white" : "bg-white text-stone-600 hover:border-stone-400"}`}>{children}</button>; }
