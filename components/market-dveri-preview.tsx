"use client";

import { useState } from "react";

type Fact = { label: string; value: string };
type Preview = { sourceUrl: string; title: string; facts: Fact[]; description: string };
type Product = { name: string; brand: string; collection: string };
type Candidate = { url: string; title: string; score: number; confidence: "high" | "possible" };

export function MarketDveriPreview({ accessToken, product }: { accessToken: string; product: Product }) {
  const [url, setUrl] = useState("");
  const [search, setSearch] = useState(() => `${product.brand} ${product.name}`.replace(/\s+/g, " ").trim());
  const [preview, setPreview] = useState<Preview | null>(null);
  const [candidates, setCandidates] = useState<Candidate[]>([]);
  const [searched, setSearched] = useState(false);
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(false);
  const [finding, setFinding] = useState(false);

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

  async function findUrl() {
    if (!search.trim()) return;
    setFinding(true); setCandidates([]); setSearched(false); setMessage("");
    try {
      const response = await fetch("/api/admin/import/market-dveri/search?name=" + encodeURIComponent(search.trim()) + "&brand=" + encodeURIComponent(product.brand), { headers: { Authorization: "Bearer " + accessToken } });
      const data = await response.json();
      if (!response.ok) throw new Error(data.message || "Не вдалося знайти посилання.");
      setCandidates(data.candidates || []); setSearched(true);
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Не вдалося знайти посилання.");
    } finally { setFinding(false); }
  }

  const googleSearch = (site?: string) => "https://www.google.com/search?q=" + encodeURIComponent(`${site ? `site:${site} ` : ""}${search}`);

  return <section className="rounded-2xl border border-sky-200 bg-sky-50/50 p-5">
    <p className="text-xs font-bold uppercase tracking-[.14em] text-sky-800">Тестове зіставлення</p>
    <h3 className="mt-1 font-display text-2xl">Характеристики з Market Dveri</h3>
    <p className="mt-2 max-w-2xl text-sm leading-6 text-stone-600">Вставте URL точної моделі. Спершу лише переглянемо знайдені параметри та український опис — нічого в товарі не зберігається.</p>
    <p className="mt-2 text-sm font-semibold text-stone-700">Звіряємо з: {product.brand} {product.name} · {product.collection}</p>
    <div className="mt-4 rounded-xl border border-sky-200 bg-white p-4">
      <p className="text-sm font-bold text-stone-900">Знайти точну картку</p>
      <p className="mt-1 text-xs leading-5 text-stone-500">За потреби скоригуйте назву, відкрийте результат, звірте модель і вставте посилання нижче.</p>
      <div className="mt-3 flex flex-col gap-2 sm:flex-row"><input value={search} onChange={(event) => setSearch(event.target.value)} className="min-w-0 flex-1 rounded-xl border border-stone-300 bg-white px-3 py-2.5 text-sm outline-none focus:border-clay" aria-label="Пошуковий запит моделі" /><button type="button" onClick={findUrl} disabled={finding || !search.trim()} className="button-primary shrink-0">{finding ? "Шукаємо…" : "Знайти URL"}</button><a href={googleSearch("market-dveri.ua/uk")} target="_blank" rel="noreferrer" className="button-light shrink-0 justify-center">Google ↗</a></div>
      <div className="mt-2 flex flex-wrap gap-2 text-sm"><a href={googleSearch("rodos.ua")} target="_blank" rel="noreferrer" className="font-bold text-clay underline">У Rodos ↗</a><a href={googleSearch()} target="_blank" rel="noreferrer" className="font-bold text-clay underline">У всьому Google ↗</a></div>
      {candidates.length > 0 && <div className="mt-4 space-y-2 border-t border-sky-100 pt-3"><p className="text-xs font-bold uppercase tracking-[.12em] text-stone-500">Знайдені кандидати — оберіть точну модель</p>{candidates.map((candidate) => <button key={candidate.url} type="button" onClick={() => { setUrl(candidate.url); setCandidates([]); setPreview(null); }} className="flex w-full items-center justify-between gap-3 rounded-lg border border-stone-200 px-3 py-2 text-left text-sm transition hover:border-clay hover:bg-sand/40"><span><b>{candidate.title}</b><span className="mt-0.5 block break-all text-xs text-stone-500">{candidate.url}</span></span><span className={candidate.confidence === "high" ? "shrink-0 rounded-full bg-emerald-100 px-2 py-1 text-xs font-bold text-emerald-800" : "shrink-0 rounded-full bg-amber-100 px-2 py-1 text-xs font-bold text-amber-800"}>{candidate.confidence === "high" ? "Точний збіг" : "Схожий"}</span></button>)}</div>}
      {searched && candidates.length === 0 && !finding && <p className="mt-3 text-xs leading-5 text-stone-500">У карті сайту збігів не знайдено. Скористайтеся Google-пошуком нижче.</p>}
    </div>
    <div className="mt-4 flex flex-col gap-2 sm:flex-row"><input value={url} onChange={(event) => setUrl(event.target.value)} placeholder="https://market-dveri.ua/uk/…" className="min-w-0 flex-1 rounded-xl border border-stone-300 bg-white px-3 py-2.5 text-sm outline-none focus:border-clay" /><button type="button" onClick={inspect} disabled={loading || !url.trim()} className="button-primary shrink-0">{loading ? "Перевіряємо…" : "Показати дані"}</button></div>
    {message && <p role="alert" className="mt-3 text-sm text-red-700">{message}</p>}
    {preview && <div className="mt-5 rounded-xl border border-sky-200 bg-white p-4"><div className="flex flex-wrap items-start justify-between gap-2"><div><p className="font-bold">{preview.title}</p><a href={preview.sourceUrl} target="_blank" rel="noreferrer" className="mt-1 inline-block break-all text-xs font-bold text-clay underline">Відкрити джерело ↗</a></div><span className="rounded-full bg-amber-100 px-2.5 py-1 text-xs font-bold text-amber-800">Лише перегляд</span></div><p className="mt-4 text-sm leading-6 text-stone-700"><b>Наш майбутній опис:</b> {preview.description}</p><dl className="mt-4 grid gap-x-6 sm:grid-cols-2">{preview.facts.map((fact) => <div key={fact.label} className="flex justify-between gap-3 border-b border-stone-100 py-2 text-sm"><dt className="text-stone-500">{fact.label}</dt><dd className="text-right font-semibold text-stone-800">{fact.value}</dd></div>)}</dl><p className="mt-4 text-xs leading-5 text-stone-500">Після звірки додамо окрему дію «Застосувати характеристики». Фото, ціни, відгуки та текст продавця не імпортуються.</p></div>}
  </section>;
}
