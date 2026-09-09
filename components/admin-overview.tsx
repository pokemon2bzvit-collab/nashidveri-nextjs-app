"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { ArrowRight, Search, Package, ClipboardList, Download, Eye } from "lucide-react";
import { AdminRouteGuard } from "@/components/admin-route-guard";
import { getSupabaseBrowserClient } from "@/lib/supabase-browser";

type Product = { slug: string; name: string; brand: string; is_available: boolean; image_path: string | null; description: string | null };
const actions = [
  { href: "/admin/catalog", title: "Редагувати товари", text: "Фото, ціна, опис і характеристики.", icon: Package },
  { href: "/admin/leads", title: "Опрацювати заявки", text: "Контакти клієнтів і статуси звернень.", icon: ClipboardList },
  { href: "/admin/importers", title: "Імпортувати товари", text: "Каталоги виробників і збережені XML-файли.", icon: Download },
  { href: "/admin/preview", title: "Переглянути сайт", text: "Вигляд на телефоні, планшеті та ПК.", icon: Eye },
];

function AdminOverviewContent() {
  const db = useMemo(() => getSupabaseBrowserClient(), []);
  const [products, setProducts] = useState<Product[]>([]);
  const [query, setQuery] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  useEffect(() => {
    let cancelled = false;
    async function load() {
      try {
        const result = await db.from("products").select("slug,name,brand,is_available,image_path,description").order("name");
        if (result.error) throw result.error;
        if (!cancelled) setProducts((result.data || []) as Product[]);
      } catch { if (!cancelled) setError("Не вдалося завантажити товари. Оновіть сторінку."); }
      finally { if (!cancelled) setLoading(false); }
    }
    void load();
    return () => { cancelled = true; };
  }, [db]);
  const search = query.trim().toLocaleLowerCase("uk");
  const matches = search ? products.filter(p => (p.name + " " + p.brand).toLocaleLowerCase("uk").includes(search)) : [];
  const brands = [...new Set(products.map(p => p.brand))].sort((a, b) => a.localeCompare(b, "uk"));
  const checks = [
    { title: "Усі товари", count: products.length, href: "/admin/catalog" },
    { title: "Приховані", count: products.filter(p => !p.is_available).length, href: "/admin/catalog?quality=hidden" },
    { title: "Без фото", count: products.filter(p => !p.image_path?.trim()).length, href: "/admin/catalog?quality=photo" },
    { title: "Без опису", count: products.filter(p => !p.description?.trim()).length, href: "/admin/catalog?quality=description" },
  ];
  return <div className="space-y-6">
    <header className="flex flex-wrap items-start justify-between gap-3">
      <div><h1 className="font-display text-3xl sm:text-4xl">Керування сайтом</h1><p className="mt-2 text-sm text-stone-600">Оберіть дію або знайдіть потрібний товар.</p></div>
      <Link href="/admin/structure?tab=products" className="button-primary">+ Додати товар</Link>
    </header>
    <section aria-label="Основні дії" className="grid gap-3 sm:grid-cols-2">
      {actions.map(({ href, title, text, icon: Icon }) => <Link key={href} href={href} className="group flex items-center gap-4 rounded-2xl border bg-white p-4 transition hover:border-clay sm:p-5">
        <span className="grid size-11 shrink-0 place-items-center rounded-xl bg-sand text-clay"><Icon size={22} /></span>
        <span className="min-w-0 flex-1"><b className="block text-base sm:text-lg">{title}</b><span className="mt-1 block text-sm text-stone-600">{text}</span></span>
        <ArrowRight size={18} className="shrink-0 text-stone-400 group-hover:text-clay" />
      </Link>)}
    </section>
    <section className="rounded-2xl border bg-white p-4 sm:p-5">
      <label htmlFor="admin-quick-search" className="font-semibold">Швидко знайти товар</label>
      <div className="relative mt-3"><Search size={18} className="absolute left-3 top-3.5 text-stone-400" /><input id="admin-quick-search" value={query} onChange={e => setQuery(e.target.value)} placeholder="Наприклад: Rodos або назва моделі" className="w-full rounded-xl border border-stone-300 py-3 pl-10 pr-4 text-sm focus:border-clay focus:outline-none" /></div>
      {error && <p role="alert" className="mt-3 text-sm text-red-700">{error}</p>}
      {search && <div aria-live="polite" className="mt-3 space-y-1">
        {loading ? <p className="p-2 text-sm">Завантаження…</p> : matches.length ? <>
          {matches.slice(0, 8).map(p => <Link key={p.slug} href={"/admin/catalog?product=" + encodeURIComponent(p.slug)} className="flex items-center justify-between gap-3 rounded-lg p-3 text-sm hover:bg-sand"><span><b>{p.name}</b><span className="ml-2 text-stone-500">{p.brand}</span></span><span className="text-clay">Редагувати →</span></Link>)}
          {matches.length > 8 && <p className="p-2 text-xs text-stone-500">Знайдено {matches.length}. Уточніть назву, щоб звузити список.</p>}
        </> : !error && <p className="p-2 text-sm text-stone-500">Нічого не знайдено. Спробуйте іншу назву.</p>}
      </div>}
    </section>
    <section aria-label="Стан каталогу" className="grid grid-cols-2 gap-3 sm:grid-cols-4">
      {checks.map(check => <Link key={check.title} href={check.href} className="rounded-xl border bg-white p-4 hover:border-clay"><b className="block text-2xl">{loading || error ? "—" : check.count}</b><span className="mt-1 block text-sm text-stone-600">{check.title}</span></Link>)}
    </section>
    <details className="rounded-2xl border bg-white p-4 sm:p-5">
      <summary className="cursor-pointer font-semibold">Товари за фабриками</summary>
      <div className="mt-4 grid gap-2 sm:grid-cols-2 lg:grid-cols-3">{brands.map(brand => <Link key={brand} href={"/admin/catalog?brand=" + encodeURIComponent(brand)} className="flex justify-between gap-3 rounded-lg bg-stone-50 p-3 text-sm hover:bg-sand"><span>{brand}</span><span className="text-stone-500">{products.filter(p => p.brand === brand).length} →</span></Link>)}</div>
    </details>
    <div className="flex flex-wrap gap-x-6 gap-y-3 text-sm font-semibold text-stone-600">
      <Link className="underline hover:text-clay" href="/admin/sitemaps">Збережені XML-файли</Link>
      <Link className="underline hover:text-clay" href="/admin/structure">Фабрики й колекції</Link>
      <Link className="underline hover:text-clay" href="/admin/password">Змінити пароль</Link>
    </div>
  </div>;
}
export function AdminOverview() { return <AdminRouteGuard><AdminOverviewContent /></AdminRouteGuard>; }
