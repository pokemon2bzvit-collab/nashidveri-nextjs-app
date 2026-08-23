"use client";
import { Search, SlidersHorizontal, X } from "lucide-react";
import { useMemo, useState } from "react";
import { ProductGrid } from "./product-grid";
import { categories, products, type Category } from "@/lib/catalog";

const categoryFilters = [{ id: "all", label: "Усі моделі" }, ...Object.entries(categories).map(([id, category]) => ({ id, label: category.title }))];
const materials = [...new Set(products.map((product) => product.material))];
const styles = [...new Set(products.map((product) => product.style))];

export function CatalogBrowser({ initialCategory = "all", initialQuery = "" }: { initialCategory?: string; initialQuery?: string }) {
  const [category, setCategory] = useState(initialCategory);
  const [material, setMaterial] = useState("all");
  const [style, setStyle] = useState("all");
  const [query, setQuery] = useState(initialQuery);
  const result = useMemo(() => products.filter((product) => (category === "all" || product.category === category) && (material === "all" || product.material === material) && (style === "all" || product.style === style) && `${product.name} ${product.features.join(" ")} ${product.description}`.toLowerCase().includes(query.toLowerCase())), [category, material, style, query]);
  const reset = () => { setCategory("all"); setMaterial("all"); setStyle("all"); setQuery(""); };
  const active = category !== "all" || material !== "all" || style !== "all" || query.length > 0;
  return <div className="mt-8 grid gap-8 lg:grid-cols-[255px_minmax(0,1fr)]"><aside className="surface-card h-fit p-5 lg:sticky lg:top-28"><div className="flex items-center justify-between"><p className="flex items-center gap-2 text-sm font-bold"><SlidersHorizontal size={17} className="text-clay" /> Фільтри</p>{active && <button onClick={reset} className="text-xs font-bold text-clay hover:underline">Очистити</button>}</div><FilterGroup title="Категорія">{categoryFilters.map((filter) => <FilterButton key={filter.id} selected={category === filter.id} onClick={() => setCategory(filter.id)}>{filter.label}</FilterButton>)}</FilterGroup><FilterGroup title="Матеріал">{materials.map((item) => <FilterButton key={item} selected={material === item} onClick={() => setMaterial(material === item ? "all" : item)}>{item}</FilterButton>)}</FilterGroup><FilterGroup title="Стиль / призначення">{styles.map((item) => <FilterButton key={item} selected={style === item} onClick={() => setStyle(style === item ? "all" : item)}>{item}</FilterButton>)}</FilterGroup></aside><div><div className="flex flex-col justify-between gap-4 border-b pb-6 sm:flex-row sm:items-center"><label className="relative block max-w-md flex-1"><Search className="absolute left-4 top-1/2 -translate-y-1/2 text-stone-400" size={18} /><input value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Пошук за назвою або матеріалом" className="w-full rounded-xl border bg-white py-3 pl-11 pr-10 text-sm outline-none transition focus:border-clay" />{query && <button aria-label="Очистити пошук" onClick={() => setQuery("")} className="absolute right-3 top-1/2 -translate-y-1/2 text-stone-400"><X size={16} /></button>}</label><p className="text-sm text-stone-500">Знайдено: <span className="font-bold text-ink">{result.length}</span> моделей</p></div>{result.length ? <div className="mt-7"><ProductGrid products={result} /></div> : <div className="mt-7 rounded-2xl border border-dashed bg-white p-10 text-center"><p className="font-display text-2xl">За вашими умовами нічого не знайдено</p><p className="mt-2 text-sm text-stone-500">Спробуйте скинути один або кілька фільтрів.</p><button onClick={reset} className="button-primary mt-5">Показати всі моделі</button></div>}</div></div>;
}
function FilterGroup({ title, children }: { title: string; children: React.ReactNode }) { return <div className="mt-6 border-t pt-5"><p className="text-xs font-bold uppercase tracking-[.12em] text-stone-500">{title}</p><div className="mt-3 flex flex-wrap gap-2">{children}</div></div> }
function FilterButton({ selected, children, onClick }: { selected: boolean; children: React.ReactNode; onClick: () => void }) { return <button onClick={onClick} className={`rounded-full border px-3 py-1.5 text-xs font-semibold transition ${selected ? "border-ink bg-ink text-white" : "bg-white text-stone-600 hover:border-stone-400"}`}>{children}</button> }
