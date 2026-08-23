"use client";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import { ProductGrid } from "@/components/product-grid";
import { SiteShell } from "@/components/site-shell";
import { categories, products, type Category } from "@/lib/catalog";
const filters = [{ id: "all", label: "Усі моделі" }, ...Object.entries(categories).map(([id, category]) => ({ id, label: category.title }))];
export default function CatalogPage() { const params = useSearchParams(); const current = params.get("category") || "all"; const shown = current === "all" ? products : products.filter((product) => product.category === current); return <SiteShell><main className="container-page section-pad"><p className="eyebrow">Каталог</p><h1 className="heading mt-3">Двері й вікна<br />для вашого простору</h1><p className="mt-5 max-w-xl text-stone-600">Обирайте з популярних моделей або завітайте в салон — покажемо матеріали й допоможемо з комплектацією.</p><div className="mt-10 flex gap-2 overflow-x-auto pb-3">{filters.map((filter) => <Link key={filter.id} href={filter.id === "all" ? "/catalog" : `/catalog?category=${filter.id}`} className={`whitespace-nowrap rounded-full px-5 py-2.5 text-sm font-semibold ${current === filter.id ? "bg-ink text-white" : "border bg-white text-stone-600 hover:border-ink"}`}>{filter.label}</Link>)}</div><p className="mt-7 text-sm text-stone-500">Знайдено моделей: {shown.length}</p><div className="mt-4"><ProductGrid products={shown} /></div></main></SiteShell> }
