"use client";

import { useEffect, useMemo, useState } from "react";
import { ExternalLink, LoaderCircle, PackagePlus, RefreshCw } from "lucide-react";
import { getSupabaseBrowserClient } from "@/lib/supabase-browser";

type Item = { url: string; title: string };
type Fact = { label: string; value: string };
type Preview = { sourceUrl: string; title: string; description: string; facts: Fact[]; images: string[]; color: string; glass: string; coating: string };
type Product = { slug: string; name: string };

function hash(value: string) { let result = 2166136261; for (let index = 0; index < value.length; index += 1) result = Math.imul(result ^ value.charCodeAt(index), 16777619); return (result >>> 0).toString(36); }

const modelNames = ["Plato Line PTL-03", "Plato Line PTL-04", "Plato Line PTL-05", "Plato Line PTL-06", "Floriana-01", "Annecy", "Ramona", "Rosalia", "Columbia", "Darina", "Helios", "Leona", "Madrid", "Marsel", "Nadin", "Plato", "Stark", "Violeta", "Avant", "Bordo", "Cascad", "Christi", "Edmond", "Esper", "Galant", "Mary", "Next", "Sabrina", "Selesta", "Senator", "Stella", "Tina", "Vela", "Versal", "Arny"];
function modelFromTitle(title: string) {
  const cleaned = title.replace(/^двері\s+дарумі\s*/iu, "").trim();
  return modelNames.find((model) => cleaned.toLocaleLowerCase("uk-UA").startsWith(model.toLocaleLowerCase("uk-UA"))) || cleaned.split(/\s+/u).slice(0, 2).join(" ");
}
function modelKey(title: string) { return modelFromTitle(title).toLocaleLowerCase("uk-UA"); }

export function DarumiImporter() {
  const supabase = useMemo(() => getSupabaseBrowserClient(), []);
  const [token, setToken] = useState("");
  const [items, setItems] = useState<Item[]>([]);
  const [knownUrls, setKnownUrls] = useState<Set<string>>(new Set());
  const [knownSlugs, setKnownSlugs] = useState<Set<string>>(new Set());
  const [knownModels, setKnownModels] = useState<Map<string, string>>(new Map());
  const [active, setActive] = useState<Item | null>(null);
  const [preview, setPreview] = useState<Preview | null>(null);
  const [busy, setBusy] = useState(false);
  const [notice, setNotice] = useState("");

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => setToken(data.session?.access_token || ""));
    Promise.all([
      supabase.from("products").select("slug,name").eq("brand", "Darumi"),
      supabase.from("product_sources").select("source_url").eq("source_name", "Darumi"),
    ]).then(([products, sources]) => {
      setKnownSlugs(new Set(((products.data || []) as Product[]).map((item) => item.slug)));
      setKnownModels(new Map(((products.data || []) as Product[]).map((item) => [item.name.replace(/^Darumi\s+/iu, "").toLocaleLowerCase("uk-UA"), item.slug])));
      setKnownUrls(new Set((sources.data || []).map((item) => item.source_url as string)));
    });
  }, [supabase]);

  async function scan() {
    setBusy(true); setNotice(""); setPreview(null); setActive(null);
    try {
      const response = await fetch("/api/admin/import/darumi/catalog", { headers: { Authorization: `Bearer ${token}` } });
      const data = await response.json();
      if (!response.ok) throw new Error(data.message || "Не вдалося відсканувати Darumi.");
      setItems(data.products || []);
    } catch (error) { setNotice(error instanceof Error ? error.message : "Не вдалося відсканувати Darumi."); }
    finally { setBusy(false); }
  }

  async function inspect(item: Item) {
    setBusy(true); setNotice(""); setActive(item); setPreview(null);
    try {
      const response = await fetch(`/api/admin/import/darumi?url=${encodeURIComponent(item.url)}`, { headers: { Authorization: `Bearer ${token}` } });
      const data = await response.json();
      if (!response.ok) throw new Error(data.message || "Не вдалося прочитати картку.");
      setPreview(data);
    } catch (error) { setNotice(error instanceof Error ? error.message : "Не вдалося прочитати картку."); }
    finally { setBusy(false); }
  }

  async function ensureBrand() {
    const brand = await supabase.from("catalog_brands").upsert({ name: "Darumi", description: "Міжкімнатні двері Darumi з Корюківки", is_active: true, sort_order: 95 }, { onConflict: "name" }).select("id").single();
    if (brand.error || !brand.data) throw new Error(brand.error?.message || "Не вдалося створити фабрику Darumi.");
    const collection = await supabase.from("catalog_collections").upsert({ brand_id: brand.data.id, name: "Darumi", category: "interior", description: "Колекції міжкімнатних дверей Darumi.", is_active: true, sort_order: 95 }, { onConflict: "brand_id,name,category" });
    if (collection.error) throw new Error(collection.error.message);
  }

  async function addDraft() {
    if (!preview) return;
    const model = modelFromTitle(preview.title);
    const existingSlug = knownModels.get(model.toLocaleLowerCase("uk-UA"));
    const slug = existingSlug || `darumi-${hash(preview.sourceUrl)}`;
    if (knownUrls.has(preview.sourceUrl)) return setNotice("Саме це виконання вже додано до моделі.");
    setBusy(true); setNotice("");
    try {
      await ensureBrand();
      const name = `Darumi ${model}`;
      const image = preview.images[0] || null;
      const material = preview.coating || preview.facts.find((fact) => fact.label === "Матеріал")?.value || "Міжкімнатні";
      if (!existingSlug) {
        const created = await supabase.from("products").insert({ slug, category: "interior", brand: "Darumi", collection: "Darumi", name, material, style: preview.facts.find((fact) => fact.label === "Стиль")?.value || "Міжкімнатні двері", color: preview.color || "Варіанти покриттів", price: "Ціна за запитом", description: preview.description, features: ["Фабрика Darumi", "Колекція Darumi"], image_path: image, sort_order: 99999, is_available: false });
        if (created.error) throw new Error(created.error.message);
      } else if (image) {
        const updated = await supabase.from("products").update({ image_path: image }).eq("slug", slug);
        if (updated.error) throw new Error(updated.error.message);
      }
      const requests: PromiseLike<{ error: { message: string } | null }>[] = [
        supabase.from("product_sources").upsert({ product_slug: slug, source_name: "Darumi", source_url: preview.sourceUrl, source_product_name: preview.title, verification_status: "verified", verified_at: new Date().toISOString(), notes: "Імпортовано з офіційної картки darumi.in.ua. Чернетка потребує перевірки перед публікацією." }, { onConflict: "product_slug,source_url" }),
      ];
      if (preview.facts.length) requests.push(supabase.from("product_specs").insert(preview.facts.map((fact, index) => ({ product_slug: slug, label: fact.label, value: fact.value, sort_order: 100 + index * 10, is_active: true }))));
      if (preview.images.length) requests.push(supabase.from("product_media").insert(preview.images.map((imagePath, index) => ({ product_slug: slug, kind: index ? "gallery" : "main", label: index ? `Фото ${index + 1}` : "Головне фото", image_path: imagePath, sort_order: index }))));
      const selections = Object.fromEntries([["color", preview.color], ["glass", preview.glass]].filter(([, value]) => Boolean(value)));
      if (image && Object.keys(selections).length) {
        requests.push(supabase.from("product_variants").insert({ product_slug: slug, selections, image_path: image, sort_order: 0, is_active: true }));
        if (preview.color) requests.push(supabase.from("product_options").insert({ product_slug: slug, option_group: "color", group_label: "Колір", label: preview.color, image_path: image, sort_order: 10, is_active: true }));
        if (preview.glass) requests.push(supabase.from("product_options").insert({ product_slug: slug, option_group: "glass", group_label: "Скло", label: preview.glass, image_path: image, sort_order: 20, is_active: true }));
      }
      const results = await Promise.all(requests);
      const error = results.find((result) => result.error)?.error;
      if (error) throw new Error(error.message);
      setKnownUrls((current) => new Set([...current, preview.sourceUrl]));
      setKnownSlugs((current) => new Set([...current, slug]));
      setKnownModels((current) => new Map([...current, [model.toLocaleLowerCase("uk-UA"), slug]]));
      setNotice(existingSlug ? "Варіант кольору/скла додано до існуючої моделі Darumi. Покупці його не побачать, доки ти не увімкнеш показ моделі." : "Чернетку Darumi створено: фото, опис, характеристики та поточний варіант кольору/скла додані. Покупці її не бачать, доки ти не увімкнеш показ.");
    } catch (error) { setNotice(error instanceof Error ? error.message : "Не вдалося створити чернетку."); }
    finally { setBusy(false); }
  }

  const modelEntries = useMemo(() => Array.from(new Map(items.map((item) => [modelKey(item.title), item])).values()), [items]);

  async function addAllModels() {
    const additions = modelEntries.filter((item) => !knownModels.has(modelKey(item.title)));
    if (!additions.length) return setNotice("Усі знайдені моделі Darumi вже є в каталозі.");
    if (!window.confirm(`Додати ${additions.length} моделей Darumi як приховані чернетки? Покупці їх не побачать, доки ти не увімкнеш показ.`)) return;
    setBusy(true); setNotice("");
    try {
      await ensureBrand();
      const payload = additions.map((item, index) => ({ slug: `darumi-${hash(item.url)}`, category: "interior", brand: "Darumi", collection: "Darumi", name: `Darumi ${modelFromTitle(item.title)}`, material: "Міжкімнатні", style: "Міжкімнатні двері", color: "Варіанти покриттів", price: "Ціна за запитом", description: `Darumi ${modelFromTitle(item.title)} — міжкімнатні двері фабрики Darumi. Фото, точні декори, характеристики та комплектацію додамо з офіційної картки виробника перед публікацією.`, features: ["Фабрика Darumi", "Колекція Darumi"], image_path: "", sort_order: 99000 + index, is_available: false }));
      for (let offset = 0; offset < payload.length; offset += 25) {
        const result = await supabase.from("products").insert(payload.slice(offset, offset + 25));
        if (result.error) throw new Error(result.error.message);
      }
      const sources = additions.map((item) => ({ product_slug: `darumi-${hash(item.url)}`, source_name: "Darumi", source_url: item.url, source_product_name: item.title, verification_status: "verified", verified_at: new Date().toISOString(), notes: "Базова чернетка з офіційного каталогу Darumi. Перед публікацією завантажте точне фото, характеристики й варіанти." }));
      for (let offset = 0; offset < sources.length; offset += 25) {
        const result = await supabase.from("product_sources").upsert(sources.slice(offset, offset + 25), { onConflict: "product_slug,source_url" });
        if (result.error) throw new Error(result.error.message);
      }
      setKnownSlugs((current) => new Set([...current, ...payload.map((item) => item.slug)]));
      setKnownModels((current) => new Map([...current, ...payload.map((item): [string, string] => [item.name.replace(/^Darumi\s+/iu, "").toLocaleLowerCase("uk-UA"), item.slug]) ]));
      setNotice(`Готово: ${additions.length} моделей Darumi додано як приховані чернетки. Тепер відкривай модель, натискай «Перевірити картку» й додавай точні фото, характеристики та декори.`);
    } catch (error) { setNotice(error instanceof Error ? error.message : "Не вдалося додати моделі Darumi."); }
    finally { setBusy(false); }
  }

  return <section className="space-y-5"><div className="rounded-3xl bg-ink px-5 py-8 text-white sm:px-8"><p className="text-xs font-bold uppercase tracking-[.16em] text-sand">Офіційний імпорт</p><h1 className="mt-2 font-display text-4xl">Каталог Darumi</h1><p className="mt-3 max-w-2xl text-sm leading-6 text-white/70">Сканер читає офіційний каталог Darumi. Під час перевірки видно фото, характеристики, колір і скло. Кожна модель спершу створюється прихованою чернеткою.</p><div className="mt-5 flex flex-wrap gap-2"><button className="button-light" onClick={scan} disabled={busy || !token}>{busy ? <><LoaderCircle className="animate-spin" size={16} /> Скануємо…</> : <><RefreshCw size={16} /> Сканувати каталог</>}</button><a className="button-light" href="https://darumi.in.ua/dveri/" target="_blank" rel="noreferrer">Відкрити джерело <ExternalLink size={15} /></a></div></div>
    {notice && <p role="status" className="rounded-xl border bg-white p-4 text-sm text-stone-700">{notice}</p>}
    {items.length > 0 && <section className="rounded-2xl border bg-white p-5"><div className="flex flex-wrap items-end justify-between gap-4"><div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">План імпорту</p><h2 className="mt-1 font-display text-3xl">Знайдено {modelEntries.length} моделей · {items.length} виконань</h2><p className="mt-2 max-w-2xl text-sm leading-6 text-stone-600">Можна одразу створити всі моделі як приховані чернетки. Виконання однієї моделі можуть відрізнятися кольором чи склом — їх перевіряємо й додаємо до тієї самої картки.</p></div><button className="button-primary" onClick={addAllModels} disabled={busy || !modelEntries.some((item) => !knownModels.has(modelKey(item.title)))}><PackagePlus size={16} /> Додати {modelEntries.filter((item) => !knownModels.has(modelKey(item.title))).length} моделей чернетками</button></div><div className="mt-5 grid gap-2 lg:grid-cols-2">{items.map((item) => { const exists = knownUrls.has(item.url) || knownModels.has(modelKey(item.title)); return <article key={item.url} className="rounded-xl border border-stone-200 p-3"><div className="flex items-start justify-between gap-3"><div><b className="block text-sm">{item.title}</b><a className="mt-1 block break-all text-xs text-stone-500 hover:text-clay" href={item.url} target="_blank" rel="noreferrer">Джерело ↗</a></div><span className={exists ? "rounded-full bg-green-100 px-2 py-1 text-xs font-bold text-green-800" : "rounded-full bg-sky-100 px-2 py-1 text-xs font-bold text-sky-800"}>{exists ? "Є у нас" : "Нова"}</span></div><button type="button" className="mt-3 text-sm font-bold text-clay underline" onClick={() => inspect(item)} disabled={busy}>{active?.url === item.url && busy ? "Завантажуємо…" : "Перевірити картку"}</button></article>; })}</div></section>}
    {active && <section className="rounded-2xl border bg-white p-5"><div className="flex flex-wrap items-start justify-between gap-3"><div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">Перевірка моделі</p><h2 className="mt-1 font-display text-3xl">{active.title}</h2></div><a className="button-light" href={active.url} target="_blank" rel="noreferrer">У виробника <ExternalLink size={15} /></a></div>{busy && !preview ? <p className="mt-5 text-sm text-stone-600">Завантажуємо фото, опис і характеристики…</p> : preview && <div className="mt-5 grid gap-5 lg:grid-cols-[260px_1fr]"><div>{preview.images[0] ? <img src={preview.images[0]} alt={preview.title} className="h-72 w-full rounded-xl border object-contain p-2" /> : <div className="grid h-72 place-items-center rounded-xl bg-stone-50 text-sm text-stone-500">Фото не знайдено</div>}</div><div><div className="flex flex-wrap gap-2 text-xs font-bold"><span className="rounded-full bg-sand px-2.5 py-1">Darumi</span>{preview.color && <span className="rounded-full bg-sand px-2.5 py-1">{preview.color}</span>}{preview.glass && <span className="rounded-full bg-sand px-2.5 py-1">{preview.glass}</span>}<span className="rounded-full bg-stone-100 px-2.5 py-1">буде прихована</span></div><p className="mt-4 text-sm leading-6 text-stone-700">{preview.description}</p><dl className="mt-4 grid gap-x-6 text-sm sm:grid-cols-2">{preview.facts.map((fact) => <div key={fact.label} className="flex justify-between gap-3 border-b py-2"><dt className="text-stone-500">{fact.label}</dt><dd className="text-right font-semibold">{fact.value}</dd></div>)}</dl><button className="button-primary mt-5" onClick={addDraft} disabled={busy || knownUrls.has(preview.sourceUrl)}><PackagePlus size={16} /> {knownUrls.has(preview.sourceUrl) ? "Вже у каталозі" : knownModels.has(modelKey(preview.title)) ? "Додати варіант до моделі" : "Додати як чернетку"}</button><p className="mt-3 text-xs text-stone-500">Ціни з джерела не додаються. Поточний варіант кольору й скла прив’язується до його точного фото.</p></div></div>}</section>}
  </section>;
}
