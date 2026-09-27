"use client";

import { useEffect, useMemo, useState } from "react";
import { ExternalLink, FileSearch, LoaderCircle, PackagePlus, RefreshCw } from "lucide-react";
import { getSupabaseBrowserClient } from "@/lib/supabase-browser";

type Item = { url: string; title: string };
type Fact = { label: string; value: string };
type Preview = { sourceUrl: string; title: string; description: string; facts: Fact[]; image: string | null };
type Product = { slug: string; source_url?: string };

function hash(value: string) {
  let result = 2166136261;
  for (let index = 0; index < value.length; index += 1) result = Math.imul(result ^ value.charCodeAt(index), 16777619);
  return (result >>> 0).toString(36);
}

function productName(title: string) {
  const cleaned = title.replace(/^міжкімнатні\s+двері\s*/iu, "").replace(/^двері\s*/iu, "").trim();
  return /^kfd\b/iu.test(cleaned) ? cleaned : `KFD ${cleaned}`;
}

export function KfdImporter() {
  const supabase = useMemo(() => getSupabaseBrowserClient(), []);
  const [token, setToken] = useState("");
  const [items, setItems] = useState<Item[]>([]);
  const [knownUrls, setKnownUrls] = useState<Set<string>>(new Set());
  const [knownSlugs, setKnownSlugs] = useState<Set<string>>(new Set());
  const [active, setActive] = useState<Item | null>(null);
  const [preview, setPreview] = useState<Preview | null>(null);
  const [busy, setBusy] = useState(false);
  const [notice, setNotice] = useState("");

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => setToken(data.session?.access_token || ""));
    Promise.all([
      supabase.from("products").select("slug").eq("brand", "KFD"),
      supabase.from("product_sources").select("source_url,product_slug").eq("source_name", "Market Dveri"),
    ]).then(([productResult, sourceResult]) => {
      setKnownSlugs(new Set(((productResult.data || []) as Product[]).map((item) => item.slug)));
      setKnownUrls(new Set((sourceResult.data || []).map((item) => item.source_url as string)));
    });
  }, [supabase]);

  async function scan() {
    setBusy(true); setNotice(""); setPreview(null); setActive(null);
    try {
      const response = await fetch("/api/admin/import/kfd/catalog", { headers: { Authorization: `Bearer ${token}` } });
      const data = await response.json();
      if (!response.ok) throw new Error(data.message || "Не вдалося відсканувати KFD.");
      setItems(data.products || []);
    } catch (error) { setNotice(error instanceof Error ? error.message : "Не вдалося відсканувати KFD."); }
    finally { setBusy(false); }
  }

  async function inspect(item: Item) {
    setBusy(true); setNotice(""); setActive(item); setPreview(null);
    try {
      const response = await fetch(`/api/admin/import/market-dveri?url=${encodeURIComponent(item.url)}`, { headers: { Authorization: `Bearer ${token}` } });
      const data = await response.json();
      if (!response.ok) throw new Error(data.message || "Не вдалося прочитати картку.");
      setPreview(data);
    } catch (error) { setNotice(error instanceof Error ? error.message : "Не вдалося прочитати картку."); }
    finally { setBusy(false); }
  }

  async function addDraft() {
    if (!preview) return;
    const slug = `kfd-${hash(preview.sourceUrl)}`;
    if (knownUrls.has(preview.sourceUrl) || knownSlugs.has(slug)) return setNotice("Ця картка вже є в каталозі.");
    setBusy(true); setNotice("");
    try {
      const material = preview.facts.find((item) => /матеріал покриття/iu.test(item.label))?.value || "Міжкімнатні";
      const product = await supabase.from("products").insert({ slug, category: "interior", brand: "KFD", collection: "KFD", name: productName(preview.title), material, style: "Колекція KFD", color: "Варіанти покриттів", price: "Ціна за запитом", description: preview.description, features: ["Фабрика KFD", "Колекція KFD"], image_path: preview.image, sort_order: 99999, is_available: false });
      if (product.error) throw new Error(product.error.message);
      const requests: PromiseLike<{ error: { message: string } | null }>[] = [
        supabase.from("product_sources").insert({ product_slug: slug, source_name: "Market Dveri", source_url: preview.sourceUrl, source_product_name: preview.title, verification_status: "verified", verified_at: new Date().toISOString(), notes: "Імпортовано через адмінку з української картки Market Dveri. Чернетка потребує перевірки перед публікацією." }),
      ];
      if (preview.facts.length) requests.push(supabase.from("product_specs").insert(preview.facts.map((fact, index) => ({ product_slug: slug, label: fact.label, value: fact.value, sort_order: 100 + index * 10, is_active: true }))));
      if (preview.image) requests.push(supabase.from("product_media").insert({ product_slug: slug, kind: "main", label: "Головне фото", image_path: preview.image, sort_order: 0 }));
      const results = await Promise.all(requests);
      const error = results.find((result) => result.error)?.error;
      if (error) throw new Error(error.message);
      setKnownUrls((current) => new Set([...current, preview.sourceUrl]));
      setKnownSlugs((current) => new Set([...current, slug]));
      setNotice("Чернетку KFD створено: опис, характеристики, фото та джерело додані. Покупці її не бачать, доки ви не увімкнете показ.");
    } catch (error) { setNotice(error instanceof Error ? error.message : "Не вдалося створити чернетку."); }
    finally { setBusy(false); }
  }

  return <section className="space-y-5"><div className="rounded-3xl bg-ink px-5 py-8 text-white sm:px-8"><p className="text-xs font-bold uppercase tracking-[.16em] text-sand">Імпорт із перевіркою</p><h1 className="mt-2 font-display text-4xl">Каталог KFD</h1><p className="mt-3 max-w-2xl text-sm leading-6 text-white/70">Сканер читає український каталог KFD у Market Dveri. Кожна модель спершу створюється прихованою чернеткою з описом, характеристиками, фото та посиланням на джерело.</p><div className="mt-5 flex flex-wrap gap-2"><button className="button-light" onClick={scan} disabled={busy || !token}>{busy ? <><LoaderCircle className="animate-spin" size={16} /> Скануємо…</> : <><RefreshCw size={16} /> Сканувати KFD</>}</button><a className="button-light" href="https://market-dveri.ua/uk/kfd/" target="_blank" rel="noreferrer">Відкрити джерело <ExternalLink size={15} /></a></div></div>
    {notice && <p role="status" className="rounded-xl border bg-white p-4 text-sm text-stone-700">{notice}</p>}
    {items.length > 0 && <section className="rounded-2xl border bg-white p-5"><div className="flex flex-wrap items-end justify-between gap-3"><div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">План імпорту</p><h2 className="mt-1 font-display text-3xl">Знайдено {items.length} моделей</h2><p className="mt-2 text-sm leading-6 text-stone-600">Спершу відкрийте конкретну картку, звірте модель, а потім додайте її чернеткою.</p></div><a className="button-light" href="/admin/catalog?brand=KFD&quality=hidden">Чернетки KFD</a></div><div className="mt-5 grid gap-2 lg:grid-cols-2">{items.map((item) => { const exists = knownUrls.has(item.url) || knownSlugs.has(`kfd-${hash(item.url)}`); return <article key={item.url} className="rounded-xl border border-stone-200 p-3"><div className="flex items-start justify-between gap-3"><div><b className="block text-sm">{item.title}</b><a className="mt-1 block break-all text-xs text-stone-500 hover:text-clay" href={item.url} target="_blank" rel="noreferrer">Джерело ↗</a></div><span className={exists ? "rounded-full bg-green-100 px-2 py-1 text-xs font-bold text-green-800" : "rounded-full bg-sky-100 px-2 py-1 text-xs font-bold text-sky-800"}>{exists ? "Є у нас" : "Нова"}</span></div><button type="button" className="mt-3 text-sm font-bold text-clay underline" onClick={() => inspect(item)} disabled={busy}>{active?.url === item.url && busy ? "Завантажуємо…" : "Перевірити картку"}</button></article>; })}</div></section>}
    {active && <section className="rounded-2xl border bg-white p-5"><div className="flex flex-wrap items-start justify-between gap-3"><div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">Перевірка моделі</p><h2 className="mt-1 font-display text-3xl">{active.title}</h2></div><a className="button-light" href={active.url} target="_blank" rel="noreferrer">У джерелі <ExternalLink size={15} /></a></div>{busy && !preview ? <p className="mt-5 text-sm text-stone-600">Завантажуємо дані моделі…</p> : preview && <div className="mt-5 grid gap-5 lg:grid-cols-[240px_1fr]"><div>{preview.image ? <img src={preview.image} alt={preview.title} className="h-72 w-full rounded-xl border object-contain p-2" /> : <div className="grid h-72 place-items-center rounded-xl bg-stone-50 text-sm text-stone-500">Фото не знайдено</div>}</div><div><p className="text-sm leading-6 text-stone-700">{preview.description}</p><dl className="mt-4 grid gap-x-6 text-sm sm:grid-cols-2">{preview.facts.map((fact) => <div key={fact.label} className="flex justify-between gap-3 border-b py-2"><dt className="text-stone-500">{fact.label}</dt><dd className="text-right font-semibold">{fact.value}</dd></div>)}</dl><button className="button-primary mt-5" onClick={addDraft} disabled={busy || knownUrls.has(preview.sourceUrl) || knownSlugs.has(`kfd-${hash(preview.sourceUrl)}`)}><PackagePlus size={16} /> {knownUrls.has(preview.sourceUrl) || knownSlugs.has(`kfd-${hash(preview.sourceUrl)}`) ? "Вже у каталозі" : "Додати як чернетку"}</button><p className="mt-3 text-xs text-stone-500">Чернетка буде прихована. Ціни з джерела не додаються.</p></div></div>}</section>}
  </section>;
}
