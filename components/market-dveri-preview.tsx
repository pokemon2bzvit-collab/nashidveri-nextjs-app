"use client";

import { useState } from "react";

type Fact = { label: string; value: string };
type Preview = { sourceUrl: string; title: string; facts: Fact[]; description: string };
type Product = { name: string; brand: string; collection: string };

export function MarketDveriPreview({ accessToken, product }: { accessToken: string; product: Product }) {
  const [url, setUrl] = useState("");
  const [preview, setPreview] = useState<Preview | null>(null);
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(false);

  async function inspect() {
    if (!url.trim()) return;
    setLoading(true); setPreview(null); setMessage("");
    try {
      const response = await fetch("/api/admin/import/market-dveri?url=" + encodeURIComponent(url.trim()), { headers: { Authorization: "Bearer " + accessToken } });
      const data = await response.json();
      if (!response.ok) throw new Error(data.message || "Не вдалося перевірити картку.");
      setPreview(data);
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Не вдалося перевірити картку.");
    } finally { setLoading(false); }
  }

  return <section className="rounded-2xl border border-sky-200 bg-sky-50/50 p-5">
    <p className="text-xs font-bold uppercase tracking-[.14em] text-sky-800">Тестове зіставлення</p>
    <h3 className="mt-1 font-display text-2xl">Характеристики з Market Dveri</h3>
    <p className="mt-2 max-w-2xl text-sm leading-6 text-stone-600">Вставте URL точної моделі. Спершу лише переглянемо знайдені параметри та український опис — нічого в товарі не зберігається.</p>
    <p className="mt-2 text-sm font-semibold text-stone-700">Звіряємо з: {product.brand} {product.name} · {product.collection}</p>
    <div className="mt-4 flex flex-col gap-2 sm:flex-row"><input value={url} onChange={(event) => setUrl(event.target.value)} placeholder="https://market-dveri.ua/uk/…" className="min-w-0 flex-1 rounded-xl border border-stone-300 bg-white px-3 py-2.5 text-sm outline-none focus:border-clay" /><button type="button" onClick={inspect} disabled={loading || !url.trim()} className="button-primary shrink-0">{loading ? "Перевіряємо…" : "Показати дані"}</button></div>
    {message && <p role="alert" className="mt-3 text-sm text-red-700">{message}</p>}
    {preview && <div className="mt-5 rounded-xl border border-sky-200 bg-white p-4"><div className="flex flex-wrap items-start justify-between gap-2"><div><p className="font-bold">{preview.title}</p><a href={preview.sourceUrl} target="_blank" rel="noreferrer" className="mt-1 inline-block break-all text-xs font-bold text-clay underline">Відкрити джерело ↗</a></div><span className="rounded-full bg-amber-100 px-2.5 py-1 text-xs font-bold text-amber-800">Лише перегляд</span></div><p className="mt-4 text-sm leading-6 text-stone-700"><b>Наш майбутній опис:</b> {preview.description}</p><dl className="mt-4 grid gap-x-6 sm:grid-cols-2">{preview.facts.map((fact) => <div key={fact.label} className="flex justify-between gap-3 border-b border-stone-100 py-2 text-sm"><dt className="text-stone-500">{fact.label}</dt><dd className="text-right font-semibold text-stone-800">{fact.value}</dd></div>)}</dl><p className="mt-4 text-xs leading-5 text-stone-500">Після звірки додамо окрему дію «Застосувати характеристики». Фото, ціни, відгуки та текст продавця не імпортуються.</p></div>}
  </section>;
}
