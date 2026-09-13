"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { AdminRouteGuard } from "@/components/admin-route-guard";
import { getSupabaseBrowserClient } from "@/lib/supabase-browser";
import { auditProduct, type QualityProduct, type QualityRow } from "@/lib/catalog-quality";

const filters = [["issues", "Потребують уваги"], ["all", "Усі"], ["ready", "Базові дані заповнені"], ["photo", "Без фото"], ["description", "Опис"], ["dimensions", "Розміри"], ["specs", "Характеристики"], ["decor", "Декори й фото"], ["source", "Джерела"]];
function QualityContent() {
  const db = useMemo(() => getSupabaseBrowserClient(), []);
  const [results, setResults] = useState<Array<{ product: QualityProduct; issues: ReturnType<typeof auditProduct> }>>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [revision, setRevision] = useState(0);
  const [brand, setBrand] = useState("");
  const [query, setQuery] = useState("");
  const [filter, setFilter] = useState("issues");
  const [limit, setLimit] = useState(30);
  useEffect(() => {
    let cancelled = false;
    async function readAll<T>(table: string, columns: string, order: string): Promise<T[]> {
      const rows: T[] = [];
      for (let offset = 0; ; offset += 500) {
        const response = await db.from(table).select(columns).order(order).range(offset, offset + 499);
        if (response.error) throw response.error;
        const page = (response.data || []) as unknown as T[];
        rows.push(...page);
        if (page.length < 500 || cancelled) return rows;
      }
    }
    async function load() {
      setLoading(true); setError("");
      try {
        const [products, specs, options, variants, sources] = await Promise.all([
          readAll<QualityProduct>("products", "slug,name,brand,category,collection,image_path,description,is_available", "slug"),
          readAll<QualityRow>("product_specs", "product_slug,label,value,is_active", "id"),
          readAll<QualityRow>("product_options", "product_slug,option_group,label,is_active", "id"),
          readAll<QualityRow>("product_variants", "product_slug,selections,image_path,is_active", "id"),
          readAll<QualityRow>("product_sources", "product_slug,source_url", "id"),
        ]);
        const index = (rows: QualityRow[]) => {
          const map = new Map<string, QualityRow[]>();
          rows.forEach(row => map.set(row.product_slug, [...(map.get(row.product_slug) || []), row]));
          return map;
        };
        const indexes = { specs: index(specs), options: index(options), variants: index(variants), sources: index(sources) };
        if (!cancelled) setResults(products.map(product => ({ product, issues: auditProduct(product, {
          specs: indexes.specs.get(product.slug) || [], options: indexes.options.get(product.slug) || [],
          variants: indexes.variants.get(product.slug) || [], sources: indexes.sources.get(product.slug) || [],
        }) })).sort((a, b) => b.issues.length - a.issues.length || a.product.name.localeCompare(b.product.name, "uk")));
      } catch { if (!cancelled) setError("Не вдалося завершити перевірку. Натисніть «Оновити перевірку»."); }
      finally { if (!cancelled) setLoading(false); }
    }
    void load();
    return () => { cancelled = true; };
  }, [db, revision]);
  useEffect(() => setLimit(30), [brand, query, filter]);
  const scope = results.filter(({ product }) => (!brand || product.brand === brand) && `${product.name} ${product.collection}`.toLocaleLowerCase("uk").includes(query.trim().toLocaleLowerCase("uk")));
  const matches = (issues: ReturnType<typeof auditProduct>, key: string) => key === "all" || (key === "ready" ? !issues.length : key === "issues" ? !!issues.length : issues.some(issue => issue.kind === key));
  const visible = scope.filter(row => matches(row.issues, filter));
  return <div className="space-y-5">
    <header className="flex flex-wrap items-start justify-between gap-3"><div><h1 className="font-display text-3xl">Якість каталогу</h1><p className="mt-2 text-sm text-stone-600">Знайдіть прогалину, відкрийте потрібний розділ товару та збережіть зміни.</p></div><button onClick={() => setRevision(value => value + 1)} disabled={loading} className="button-light disabled:opacity-50">{loading ? "Перевіряємо…" : "Оновити перевірку"}</button></header>
    <p className="rounded-xl bg-sand p-4 text-sm leading-6">Перевіряємо заповнення полів і прив’язки фото. Відповідність фото моделі, точність характеристик та доступність зовнішніх посилань потрібно звірити вручну. Після редагування поверніться сюди й оновіть перевірку.</p>
    {error && <p role="alert" className="text-red-700">{error}</p>}
    {!loading && !error && <>
      <div className="flex flex-wrap gap-3"><label className="flex-1">Пошук<input value={query} onChange={event => setQuery(event.target.value)} className="mt-1 w-full rounded-xl border p-3" placeholder="Назва моделі або колекції" /></label><label>Фабрика<select value={brand} onChange={event => setBrand(event.target.value)} className="mt-1 block rounded-xl border p-3"><option value="">Усі фабрики</option>{[...new Set(results.map(row => row.product.brand))].sort().map(value => <option key={value}>{value}</option>)}</select></label></div>
      <div className="flex flex-wrap gap-2">{filters.map(([key, title]) => <button key={key} aria-pressed={filter === key} onClick={() => setFilter(key)} className={`rounded-full border px-3 py-2 text-sm ${filter === key ? "bg-ink text-white" : "bg-white"}`}>{title} · {scope.filter(row => matches(row.issues, key)).length}</button>)}</div>
      <p className="text-sm text-stone-600" aria-live="polite">Знайдено {visible.length} моделей</p>
      {visible.slice(0, limit).map(({ product, issues }) => <article key={product.slug} className="rounded-2xl border bg-white p-4"><div className="flex flex-wrap justify-between gap-2"><div><Link className="text-lg font-bold underline" href={`/admin/catalog?product=${encodeURIComponent(product.slug)}`}>{product.name}</Link><p className="text-sm text-stone-500">{product.brand} · {product.collection} · {product.is_available ? "Опубліковано" : "Приховано"}</p></div><span className="text-sm">{issues.length ? `${issues.length} пунктів для перевірки` : "Базові дані заповнені"}</span></div><ul className="mt-3 space-y-2">{issues.map((issue, index) => <li key={index}><Link className="block rounded-lg bg-amber-50 p-3 text-sm text-amber-900 hover:underline" href={`/admin/catalog?product=${encodeURIComponent(product.slug)}&tab=${issue.tab}`}>{issue.text} →</Link></li>)}</ul></article>)}
      {!visible.length && <p className="rounded-xl border p-5">За цими фільтрами моделей немає.</p>}
      {visible.length > limit && <button className="button-light" onClick={() => setLimit(value => value + 30)}>Показати ще 30</button>}
    </>}
  </div>;
}
export function AdminQuality() { return <AdminRouteGuard><QualityContent /></AdminRouteGuard>; }
