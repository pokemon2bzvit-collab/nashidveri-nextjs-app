"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { catalogImageUrl } from "@/lib/catalog";
import { getSupabaseBrowserClient } from "@/lib/supabase-browser";

export type ImportFields = { photo: boolean; description: boolean; specs: boolean; decor: boolean };
type Product = { slug: string; name: string; brand: string; collection: string; category: string; price: string | null; description: string | null; is_available: boolean; image_path: string | null };
type Item = { url: string; title: string };
type Fact = { label: string; value: string };
type Preview = { sourceUrl: string; title: string; productCode: string | null; description: string; images: string[]; facts: Fact[]; finish: string | null };
type Props = {
  accessToken: string; saving: boolean; products: Product[]; sourceProductSlugs: Record<string, string>;
  matchModel: (title: string, products: Product[]) => { product: Product; confidence: "exact" | "possible" } | null;
  onImport: (preview: Preview, target?: Product, fields?: ImportFields) => Promise<string | null>;
  onCreate: (preview: Preview) => Promise<string | null>;
  onMarkExisting: (item: Item, target: Product) => Promise<string | null>;
};
const input = "w-full rounded-xl border border-stone-300 bg-white px-3 py-2.5 text-sm";
const button = "rounded-xl border bg-white px-3 py-2.5 text-sm font-semibold disabled:opacity-40";
const defaults: ImportFields = { photo: false, description: true, specs: true, decor: true };

export function QdoorsReview(props: Props) {
  const db = useMemo(() => getSupabaseBrowserClient(), []);
  const dialog = useRef<HTMLDialogElement>(null);
  const requestId = useRef(0);
  const [catalogUrl, setCatalogUrl] = useState("https://qdoors.ua/shop");
  const [url, setUrl] = useState("");
  const [items, setItems] = useState<Item[]>([]);
  const [scanning, setScanning] = useState(false);
  const [scanError, setScanError] = useState("");
  const [active, setActive] = useState<Item | null>(null);
  const [preview, setPreview] = useState<Preview | null>(null);
  const [loading, setLoading] = useState(false);
  const [working, setWorking] = useState(false);
  const [message, setMessage] = useState("");
  const [targetSlug, setTargetSlug] = useState("");
  const [search, setSearch] = useState("");
  const [mobileTab, setMobileTab] = useState("source");
  const [fields, setFields] = useState<ImportFields>(defaults);
  const [facts, setFacts] = useState<Fact[]>([]);
  const [factsError, setFactsError] = useState("");
  const [factsLoading, setFactsLoading] = useState(false);
  const [revision, setRevision] = useState(0);
  const busy = working || props.saving;
  const target = props.products.find(p => p.slug === targetSlug);
  const index = items.findIndex(p => p.url === active?.url);
  const linked = active ? props.sourceProductSlugs[active.url] : undefined;

  useEffect(() => {
    if (!active) return;
    const previous = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => { document.body.style.overflow = previous; };
  }, [Boolean(active)]);
  useEffect(() => {
    let cancelled = false;
    setFacts([]); setFactsError("");
    if (!targetSlug) { setFactsLoading(false); return; }
    setFactsLoading(true);
    db.from("product_specs").select("label,value").eq("product_slug", targetSlug).eq("is_active", true).order("sort_order").then(({ data, error }) => {
      if (cancelled) return;
      setFactsLoading(false);
      if (error) setFactsError("Не вдалося завантажити характеристики.");
      else setFacts((data || []) as Fact[]);
    });
    return () => { cancelled = true; };
  }, [db, targetSlug, revision]);

  async function scan() {
    setScanning(true); setScanError("");
    try {
      const response = await fetch("/api/admin/import/qdoors/catalog?url=" + encodeURIComponent(catalogUrl), { headers: { Authorization: "Bearer " + props.accessToken } });
      const data = await response.json();
      if (!response.ok) throw new Error(data.message);
      setItems(data.products || []);
    } catch (e) { setScanError(e instanceof Error ? e.message : "Не вдалося завантажити каталог."); }
    finally { setScanning(false); }
  }
  async function open(item: Item) {
    if (busy) return;
    const id = ++requestId.current;
    setActive(item); setPreview(null); setLoading(true); setMessage(""); setSearch(""); setMobileTab("source"); setFields(defaults);
    setTargetSlug(props.sourceProductSlugs[item.url] || "");
    dialog.current?.showModal();
    try {
      const response = await fetch("/api/admin/import/qdoors?url=" + encodeURIComponent(item.url), { headers: { Authorization: "Bearer " + props.accessToken } });
      const data = await response.json();
      if (!response.ok) throw new Error(data.message);
      if (requestId.current !== id) return;
      setPreview(data);
      setTargetSlug(props.sourceProductSlugs[data.sourceUrl] || props.sourceProductSlugs[item.url] || "");
      setFields({ photo: false, description: Boolean(data.description), specs: Boolean(data.facts?.length), decor: Boolean(data.finish && data.images?.length) });
    } catch (e) { if (requestId.current === id) setMessage(e instanceof Error ? e.message : "Не вдалося перевірити модель."); }
    finally { if (requestId.current === id) setLoading(false); }
  }
  function close() { if (busy) return; ++requestId.current; dialog.current?.close(); setActive(null); setLoading(false); }
  async function save(action: "link" | "update" | "create") {
    if (!preview || busy || (action !== "create" && !target)) return;
    setWorking(true); setMessage("");
    try {
      const error = action === "link" ? await props.onMarkExisting({ url: preview.sourceUrl, title: preview.title }, target!) : action === "update" ? await props.onImport(preview, target, fields) : await props.onCreate(preview);
      if (error) throw new Error(error);
      setMessage(action === "link" ? "Зв’язок з нашою моделлю збережено." : action === "update" ? "Вибрані дані оновлено." : "Нову модель додано до каталогу.");
      setRevision(n => n + 1);
      if (action === "create") setTargetSlug("qdoors-" + preview.productCode);
    } catch (e) { setMessage((e instanceof Error ? e.message : "Помилка збереження") + " Перевірте дані перед повторною спробою."); }
    finally { setWorking(false); }
  }
  const suggestion = preview ? props.matchModel(preview.title, props.products) : null;
  const targetOptions = props.products.filter(p => p.brand === "Q Doors" && (p.slug === targetSlug || (p.name + " " + p.collection).toLowerCase().includes(search.toLowerCase())));
  return <div className="space-y-4">
    <section className="rounded-2xl border bg-white p-5">
      <h3 className="font-display text-2xl">Каталог Qdoors</h3><p className="mt-2 text-sm text-stone-600">Відкрийте модель, порівняйте з нашим товаром і виберіть потрібну дію.</p>
      <div className="mt-4 flex flex-col gap-2 sm:flex-row"><input aria-label="Адреса каталогу Qdoors" className={input} value={catalogUrl} onChange={e => setCatalogUrl(e.target.value)} /><button className={button} disabled={scanning} onClick={scan}>{scanning ? "Скануємо…" : "Сканувати"}</button></div>
      {scanError && <p role="alert" className="mt-3 text-sm text-red-700">{scanError}</p>}
      <p className="my-3 text-sm">Знайдено {items.length} карток</p>
      <div className="max-h-96 space-y-2 overflow-y-auto">{items.map(item => {
        const existing = props.products.find(p => p.slug === props.sourceProductSlugs[item.url]);
        const possible = props.matchModel(item.title, props.products);
        return <button key={item.url} onClick={() => open(item)} className="flex w-full items-center justify-between gap-3 rounded-xl border p-3 text-left hover:bg-stone-50"><span><b className="block text-sm">{item.title}</b><span className={"text-xs " + (existing ? "text-green-700" : "text-stone-600")}>{existing ? "Підтверджено: " + existing.name : possible ? "Звірити з: " + possible.product.name : "Не знайдено збігу — можна додати"}</span></span><span className="text-sm font-bold text-clay">Звірити →</span></button>;
      })}</div>
      <div className="mt-5 flex flex-col gap-2 border-t pt-4 sm:flex-row"><input aria-label="Посилання на конкретну модель" className={input} placeholder="Посилання на конкретну модель Qdoors" value={url} onChange={e => setUrl(e.target.value)} /><button className={button} disabled={!url.trim()} onClick={() => open({ url: url.trim(), title: "Перевірка моделі" })}>Перевірити</button></div>
    </section>
    <dialog ref={dialog} aria-labelledby="qdoors-review-title" onCancel={e => { e.preventDefault(); close(); }} className="m-auto h-[100dvh] max-h-[100dvh] w-full max-w-6xl bg-white p-0 text-ink backdrop:bg-black/50 sm:h-[92dvh] sm:rounded-2xl">
      <div className="flex h-full min-h-0 flex-col">
        <header className="flex shrink-0 items-center justify-between gap-3 border-b p-4"><div><h2 id="qdoors-review-title" className="font-display text-2xl">Звірка моделі</h2><p className="text-xs text-stone-500">{index >= 0 ? `${index + 1} з ${items.length}` : "Картка Qdoors"}</p></div><button autoFocus className={button} onClick={close} disabled={busy} aria-label="Закрити звірку">Закрити ✕</button></header>
        <div className="flex shrink-0 gap-2 border-b p-2 md:hidden">{[["source", "У виробника"], ["ours", "У нас"]].map(([key, text]) => <button key={key} aria-pressed={mobileTab === key} onClick={() => setMobileTab(key)} className={button + (mobileTab === key ? " bg-sand" : "")}>{text}</button>)}</div>
        <div className="min-h-0 flex-1 overflow-y-auto overscroll-contain p-4">
          {loading ? <p role="status" className="p-8 text-center">Завантажуємо фото й характеристики…</p> : preview ? <div className="grid gap-5 md:grid-cols-2">
            <section className={(mobileTab === "source" ? "block" : "hidden") + " min-w-0 md:block"}>
              <h3 className="font-semibold">У виробника</h3><p className="mt-2 font-bold">{preview.title}</p><a href={preview.sourceUrl} target="_blank" rel="noreferrer" className="text-sm text-clay underline">Відкрити картку Qdoors ↗</a>
              <div className="my-3 flex gap-2 overflow-x-auto">{preview.images.map(image => <a key={image} href={image} target="_blank" rel="noreferrer" className="shrink-0"><img src={image} alt={preview.title} className="h-60 w-44 rounded-xl border object-contain p-2" /></a>)}</div>
              <p className="text-sm font-semibold">{preview.finish}</p><p className="my-3 whitespace-pre-line text-sm leading-6">{preview.description}</p><Facts facts={preview.facts} />
            </section>
            <section className={(mobileTab === "ours" ? "block" : "hidden") + " min-w-0 md:block"}>
              <h3 className="font-semibold">У нашому каталозі</h3>
              {suggestion && !target && <button disabled={busy} className={button + " my-2 w-full text-left"} onClick={() => setTargetSlug(suggestion.product.slug)}>Порівняти з {suggestion.product.name}</button>}
              <input disabled={busy} className={input + " mt-3"} aria-label="Пошук нашої моделі" placeholder="Знайти нашу модель за назвою" value={search} onChange={e => setSearch(e.target.value)} />
              <select disabled={busy} aria-label="Наша модель" className={input + " mt-2"} value={targetSlug} onChange={e => setTargetSlug(e.target.value)}><option value="">Нова модель / оберіть товар для звірки</option>{targetOptions.map(p => <option key={p.slug} value={p.slug}>{p.name} · {p.collection}</option>)}</select>
              {target ? <><p className="mt-3 font-bold">{target.name}</p><p className="text-xs text-stone-500">{target.collection}</p><a href={"/catalog/" + target.slug} target="_blank" rel="noreferrer" className="text-sm text-clay underline">Відкрити нашу картку ↗</a>{target.image_path ? <img src={catalogImageUrl(target.image_path)} alt={target.name} className="my-3 h-60 w-full rounded-xl border object-contain p-2" /> : <p className="my-6 text-sm">Фото ще немає</p>}<p className="my-3 whitespace-pre-line text-sm leading-6">{target.description || "Опис ще не додано."}</p>{factsLoading ? <p>Завантажуємо характеристики…</p> : factsError ? <p role="alert">{factsError}</p> : <Facts facts={facts} />}</> : <p className="mt-5 text-sm text-stone-500">Оберіть товар, щоб побачити його фото й характеристики. Якщо це нова модель, скористайтеся кнопкою додавання.</p>}
            </section>
          </div> : null}
        </div>
        <footer className="max-h-[40dvh] shrink-0 overflow-y-auto border-t bg-stone-50 p-3 sm:p-4">
          {message && <p role="status" className="mb-3 rounded-lg bg-white p-2 text-sm">{message}</p>}
          {preview && target && <fieldset disabled={busy} className="mb-3"><legend className="mb-2 text-xs font-bold">Що перенести в «{target.name}»</legend><div className="flex flex-wrap gap-3">{([['photo', 'Головне фото'], ['description', 'Опис'], ['specs', 'Характеристики'], ['decor', 'Декор з фото']] as const).map(([key, text]) => <label key={key} className="flex items-center gap-2 text-sm"><input type="checkbox" checked={fields[key]} onChange={e => setFields({ ...fields, [key]: e.target.checked })} />{text}</label>)}</div><p className="mt-2 text-xs text-stone-500">Вибрані поля буде оновлено; характеристики з однаковими назвами заміняться.</p></fieldset>}
          <div className="flex flex-wrap gap-2">
            {target ? <><button className={button} disabled={busy || loading || !preview} onClick={() => save("link")}>Це наша модель</button><button className={button + " bg-sand"} disabled={busy || loading || !preview || !Object.values(fields).some(Boolean)} onClick={() => save("update")}>Оновити вибрані дані</button></> : <button className={button + " bg-sand"} disabled={busy || loading || !preview?.productCode || !preview.images.length || !preview.finish || Boolean(linked)} onClick={() => save("create")}>Додати нову модель</button>}
            <button className={button + " sm:ml-auto"} disabled={busy || loading || index < 0 || index >= items.length - 1} onClick={() => open(items[index + 1])}>Наступна →</button>
            {busy && <span role="status" className="self-center text-sm">Зберігаємо…</span>}
          </div>
        </footer>
      </div>
    </dialog>
  </div>;
}

function Facts({ facts }: { facts: Fact[] }) {
  return <dl className="text-sm">{facts.length ? facts.map((fact, i) => <div key={fact.label + i} className="grid grid-cols-2 gap-3 border-b py-2"><dt className="text-stone-500">{fact.label}</dt><dd className="break-words font-medium">{fact.value}</dd></div>) : <p className="text-stone-500">Характеристики ще не додано.</p>}</dl>;
}
