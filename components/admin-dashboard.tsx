"use client";

import { FormEvent, type ReactNode, useEffect, useMemo, useState } from "react";
import { Check, ChevronLeft, ChevronRight, ExternalLink, FileImage, Link2, LoaderCircle, LogOut, PackageSearch, Paintbrush, Plus, Save, Search, ShieldCheck, SlidersHorizontal, Trash2, Upload } from "lucide-react";
import { useSearchParams } from "next/navigation";
import type { Session } from "@supabase/supabase-js";
import { CatalogManagement } from "@/components/catalog-management";
import { LeadsDashboard } from "@/components/leads-dashboard";
import { catalogImageUrl } from "@/lib/catalog";
import { adminEmail, getSupabaseBrowserClient } from "@/lib/supabase-browser";

type Product = {
  slug: string;
  name: string;
  brand: string;
  collection: string;
  category: string;
  price: string | null;
  description: string | null;
  is_available: boolean;
  image_path: string | null;
};
type Media = { id: string; kind: "main" | "gallery" | "palette"; label: string | null; image_path: string };
type Source = { id: string; source_name: string; source_url: string; verification_status: string };
type Row = Record<string, unknown>;
type Tab = "basic" | "media" | "configuration" | "sources";
type EditorKind = "specs" | "options" | "variants";
type QualityFilter = "all" | "photo" | "description" | "source" | "hidden";

const catalogSources = [
  { name: "Market Dveri", info: "Описи, характеристики та фото багатьох моделей", url: "https://market-dveri.ua/uk/" },
  { name: "Abwehr", info: "Офіційний каталог вхідних дверей", url: "https://abwehr.com.ua/" },
  { name: "Grand", info: "Офіційний каталог фабрики Grand", url: "https://www.granddoor.com.ua/#product" },
  { name: "Papa Carlo", info: "Офіційний каталог міжкімнатних дверей", url: "https://papa-carlo.com.ua/ua/" },
  { name: "Qdoors", info: "Офіційний каталог Qdoors", url: "https://qdoors-dveri.com.ua/dveri/" },
  { name: "Страж", info: "Офіційний каталог вхідних дверей", url: "https://straj.ua/" },
];
const inputClass = "mt-1 w-full rounded-xl border border-stone-300 bg-white px-3 py-2.5 text-sm outline-none transition focus:border-clay focus:ring-2 focus:ring-clay/20";
const areaClass = inputClass + " min-h-32 resize-y leading-6";

function readRows(text: string): Row[] {
  try {
    const parsed = JSON.parse(text);
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
}
function categoryLabel(category: string) {
  if (category === "interior") return "Міжкімнатні";
  if (category === "entrance") return "Вхідні";
  return "Вікна";
}
function SectionTitle({ icon, title }: { icon: ReactNode; title: string }) {
  return <h3 className="flex items-center gap-2 font-display text-2xl">{icon}{title}</h3>;
}
function Card({ icon, title, help, children }: { icon: ReactNode; title: string; help: string; children: ReactNode }) {
  return <section className="rounded-2xl border bg-white p-4 shadow-sm sm:p-5"><SectionTitle icon={icon} title={title} /><p className="mt-2 text-sm leading-6 text-stone-500">{help}</p><div className="mt-5">{children}</div></section>;
}
function ImagePreview({ path, label, compact = false }: { path: string | null | undefined; label: string; compact?: boolean }) {
  if (!path?.trim()) return <div className={(compact ? "h-20 w-16" : "h-52 w-full") + " grid place-items-center rounded-xl border border-dashed border-stone-300 bg-stone-50 p-3 text-center text-xs leading-5 text-stone-400"}>Фото ще не додано</div>;
  return <a href={catalogImageUrl(path)} target="_blank" rel="noreferrer" title="Відкрити фото в новій вкладці" className={(compact ? "h-20 w-16" : "h-52 w-full") + " block overflow-hidden rounded-xl border border-stone-200 bg-stone-50"}><img src={catalogImageUrl(path)} alt={label} className="size-full object-contain p-2" /></a>;
}

export function AdminDashboard() {
  const supabase = useMemo(() => getSupabaseBrowserClient(), []);
  const searchParams = useSearchParams();
  const [session, setSession] = useState<Session | null>(null);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [notice, setNotice] = useState("");
  const [loading, setLoading] = useState(true);
  const [loadingProduct, setLoadingProduct] = useState(false);
  const [saving, setSaving] = useState(false);
  const [products, setProducts] = useState<Product[]>([]);
  const [query, setQuery] = useState("");
  const [brand, setBrand] = useState("all");
  const [quality, setQuality] = useState<QualityFilter>("all");
  const [sourcedSlugs, setSourcedSlugs] = useState<Set<string>>(new Set());
  const [selected, setSelected] = useState<Product | null>(null);
  const [draft, setDraft] = useState<Partial<Product>>({});
  const [tab, setTab] = useState<Tab>("basic");
  const [specsText, setSpecsText] = useState("[]");
  const [optionsText, setOptionsText] = useState("[]");
  const [variantsText, setVariantsText] = useState("[]");
  const [media, setMedia] = useState<Media[]>([]);
  const [sources, setSources] = useState<Source[]>([]);
  const [mediaKind, setMediaKind] = useState<Media["kind"]>("gallery");
  const [mediaUrl, setMediaUrl] = useState("");
  const [mediaLabel, setMediaLabel] = useState("");
  const [sourceName, setSourceName] = useState(catalogSources[0].name);
  const [sourceUrl, setSourceUrl] = useState("");

  const isAdmin = session?.user.email === adminEmail;
  const brands = useMemo(() => Array.from(new Set(products.map((item) => item.brand))).sort(), [products]);
  const filtered = products.filter((item) => {
    const text = (item.name + " " + item.brand + " " + item.collection).toLowerCase();
    const hasPhoto = Boolean(item.image_path?.trim());
    const hasDescription = Boolean(item.description?.trim());
    const matchesQuality = quality === "all"
      || (quality === "photo" && !hasPhoto)
      || (quality === "description" && !hasDescription)
      || (quality === "source" && !sourcedSlugs.has(item.slug))
      || (quality === "hidden" && !item.is_available);
    return text.includes(query.toLowerCase()) && (brand === "all" || item.brand === brand) && matchesQuality;
  });
  const basicDirty = Boolean(selected && (draft.price !== selected.price || draft.description !== selected.description || draft.image_path !== selected.image_path || draft.is_available !== selected.is_available));
  const selectedIndex = selected ? filtered.findIndex((item) => item.slug === selected.slug) : -1;

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => { setSession(data.session); setLoading(false); });
    const { data: listener } = supabase.auth.onAuthStateChange((_event, next) => setSession(next));
    return () => listener.subscription.unsubscribe();
  }, [supabase]);
  useEffect(() => {
    if (!isAdmin) return;
    Promise.all([
      supabase.from("products").select("slug,name,brand,collection,category,price,description,is_available,image_path").order("brand").order("name"),
      supabase.from("product_sources").select("product_slug"),
    ]).then(([productsResult, sourcesResult]) => {
      if (productsResult.error) setNotice(productsResult.error.message);
      else setProducts((productsResult.data || []) as Product[]);
      if (!sourcesResult.error) setSourcedSlugs(new Set((sourcesResult.data || []).map((item) => item.product_slug)));
    });
  }, [isAdmin, supabase]);
  useEffect(() => {
    const requested = searchParams.get("quality");
    if (requested === "photo" || requested === "description" || requested === "source" || requested === "hidden") setQuality(requested);
    else setQuality("all");
  }, [searchParams]);

  async function login(event: FormEvent) {
    event.preventDefault();
    setSaving(true);
    const { error } = await supabase.auth.signInWithOtp({ email, options: { emailRedirectTo: window.location.origin + "/admin" } });
    setSaving(false);
    setNotice(error ? error.message : "Посилання для входу надіслано на пошту. Відкрийте його на цьому пристрої.");
  }
  async function passwordLogin(event: FormEvent) {
    event.preventDefault();
    setSaving(true);
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    setSaving(false);
    setNotice(error ? "Не вдалося увійти. Перевірте пошту й пароль." : "");
  }
  async function choose(product: Product) {
    setLoadingProduct(true);
    setSelected(product);
    setDraft(product);
    setTab("basic");
    setNotice("");
    const [specs, options, variants, mediaResult, sourceResult] = await Promise.all([
      supabase.from("product_specs").select("label,value,sort_order").eq("product_slug", product.slug).order("sort_order"),
      supabase.from("product_options").select("option_group,group_label,label,swatch,image_path,sort_order,is_active").eq("product_slug", product.slug).order("sort_order"),
      supabase.from("product_variants").select("selections,image_path,sort_order,is_active").eq("product_slug", product.slug).order("sort_order"),
      supabase.from("product_media").select("id,kind,label,image_path").eq("product_slug", product.slug).order("sort_order"),
      supabase.from("product_sources").select("id,source_name,source_url,verification_status").eq("product_slug", product.slug).order("created_at", { ascending: false }),
    ]);
    setSpecsText(JSON.stringify(specs.data || [], null, 2));
    setOptionsText(JSON.stringify(options.data || [], null, 2));
    setVariantsText(JSON.stringify(variants.data || [], null, 2));
    setMedia((mediaResult.data || []) as Media[]);
    setSources((sourceResult.data || []) as Source[]);
    setLoadingProduct(false);
  }
  function chooseAdjacent(direction: -1 | 1) {
    const next = filtered[selectedIndex + direction];
    if (next) void choose(next);
  }
  async function saveBasic() {
    if (!selected) return;
    setSaving(true);
    const { error } = await supabase.from("products").update({ price: draft.price || null, description: draft.description || null, image_path: draft.image_path || null, is_available: Boolean(draft.is_available) }).eq("slug", selected.slug);
    setSaving(false);
    setNotice(error ? error.message : "Основні дані збережено.");
    if (!error) {
      const updated = { ...selected, ...draft } as Product;
      setSelected(updated);
      setProducts((items) => items.map((item) => item.slug === updated.slug ? updated : item));
    }
  }
  async function saveRows(table: "product_specs" | "product_options" | "product_variants", text: string, title: string) {
    if (!selected) return;
    let rows: Row[];
    try {
      rows = JSON.parse(text) as Row[];
      if (!Array.isArray(rows)) throw new Error();
    } catch {
      setNotice(title + ": виправте JSON у розширеному режимі.");
      return;
    }
    setSaving(true);
    const deletion = await supabase.from(table).delete().eq("product_slug", selected.slug);
    const insertion = deletion.error || !rows.length ? { error: deletion.error } : await supabase.from(table).insert(rows.map((row) => ({ ...row, product_slug: selected.slug })));
    setSaving(false);
    setNotice(insertion.error ? insertion.error.message : title + " збережено.");
  }
  async function addMedia(path: string) {
    if (!selected || !path.trim()) {
      setNotice("Додайте посилання або завантажте файл.");
      return;
    }
    setSaving(true);
    const { error } = await supabase.from("product_media").insert({ product_slug: selected.slug, kind: mediaKind, label: mediaLabel || null, image_path: path.trim(), sort_order: media.length });
    setSaving(false);
    if (error) setNotice(error.message);
    else {
      setMediaUrl("");
      setMediaLabel("");
      await choose(selected);
      setTab("media");
      setNotice("Фото додано.");
    }
  }
  async function uploadMedia(file: File) {
    if (!selected) return;
    const safeName = file.name.replace(/[^a-zA-Z0-9._-]/g, "-");
    const path = "admin/" + selected.slug + "/" + Date.now() + "-" + safeName;
    setSaving(true);
    const { error } = await supabase.storage.from("catalog-images").upload(path, file, { upsert: false });
    setSaving(false);
    if (error) setNotice(error.message);
    else await addMedia(path);
  }
  async function uploadVariantPhoto(file: File, index: number) {
    if (!selected) return;
    const rows = readRows(variantsText);
    if (!rows[index]) {
      setNotice("Не вдалося знайти варіант декору. Оновіть сторінку та спробуйте ще раз.");
      return;
    }
    const safeName = file.name.replace(/[^a-zA-Z0-9._-]/g, "-");
    const path = "admin/" + selected.slug + "/variants/" + Date.now() + "-" + safeName;
    setSaving(true);
    const { error } = await supabase.storage.from("catalog-images").upload(path, file, { upsert: false });
    setSaving(false);
    if (error) {
      setNotice(error.message);
      return;
    }
    const updated = rows.map((row, rowIndex) => rowIndex === index ? { ...row, image_path: path } : row);
    setVariantsText(JSON.stringify(updated, null, 2));
    setNotice("Фото прив’язано до варіанту. Натисніть «Зберегти», щоб опублікувати його в конфігураторі.");
  }
  async function removeMedia(id: string) {
    if (!selected) return;
    const { error } = await supabase.from("product_media").delete().eq("id", id);
    if (error) setNotice(error.message);
    else {
      await choose(selected);
      setTab("media");
      setNotice("Запис фото видалено.");
    }
  }
  async function addSource() {
    if (!selected || !sourceUrl.trim()) {
      setNotice("Вставте посилання на точну сторінку моделі.");
      return;
    }
    const { error } = await supabase.from("product_sources").insert({ product_slug: selected.slug, source_name: sourceName, source_url: sourceUrl.trim(), verification_status: "verified", verified_at: new Date().toISOString() });
    if (error) setNotice(error.message);
    else {
      setSourceUrl("");
      await choose(selected);
      setTab("sources");
      setNotice("Джерело збережено.");
    }
  }

  if (loading) return <main className="grid min-h-screen place-items-center bg-stone-50 text-stone-600"><LoaderCircle className="animate-spin" /> Завантаження…</main>;
  if (!session) return <AdminLogin email={email} password={password} notice={notice} saving={saving} setEmail={setEmail} setPassword={setPassword} onPasswordLogin={passwordLogin} onMagicLogin={login} />;
  if (!isAdmin) return <main className="grid min-h-screen place-items-center bg-stone-50 p-5"><div className="max-w-md rounded-3xl bg-white p-7 text-center shadow-lg"><ShieldCheck className="mx-auto text-clay" size={32} /><h1 className="mt-4 font-display text-3xl">Немає доступу</h1><p className="mt-3 text-sm text-stone-600">Ця пошта не додана до адміністраторів каталогу.</p><button className="button-light mt-6" onClick={() => supabase.auth.signOut()}>Вийти</button></div></main>;

  return <main className="min-h-screen bg-stone-50 text-ink">
    <header className="sticky top-0 z-20 border-b bg-white/95 backdrop-blur"><div className="mx-auto flex max-w-[1600px] flex-wrap items-center justify-between gap-3 px-4 py-3 sm:px-6"><a href="/admin" className="shrink-0"><p className="text-[11px] font-bold uppercase tracking-[.16em] text-clay">Закрита адмінка</p><h1 className="font-display text-xl sm:text-2xl">Наші двері</h1></a><nav className="order-3 flex w-full gap-1 overflow-x-auto pb-1 text-sm font-bold sm:order-none sm:w-auto sm:pb-0"><a className="shrink-0 rounded-full px-3 py-2 hover:bg-sand" href="/admin">Огляд</a><a className="shrink-0 rounded-full bg-sand px-3 py-2" href="/admin/catalog">Товари</a><a className="shrink-0 rounded-full px-3 py-2 hover:bg-sand" href="/admin/leads">Заявки</a><a className="shrink-0 rounded-full px-3 py-2 hover:bg-sand" href="/admin/structure">Структура</a></nav><button onClick={() => supabase.auth.signOut()} className="button-light px-3 py-2 text-sm"><LogOut size={16} /> Вийти</button></div></header>
    <div className="mx-auto max-w-[1600px] p-4 sm:p-6">
      <div className="mb-5 rounded-2xl border border-clay/20 bg-sand/50 px-4 py-3 text-sm text-stone-700"><b>Як працювати:</b> 1. Оберіть модель. 2. Відкрийте потрібний розділ. 3. Збережіть зміни.</div>
      <div className="grid gap-5 xl:grid-cols-[330px_minmax(0,1fr)]">
        <aside className="rounded-2xl border bg-white p-3 shadow-sm xl:sticky xl:top-20 xl:max-h-[calc(100vh-6rem)]"><div className="p-1"><div className="relative"><Search className="pointer-events-none absolute left-3 top-3.5 text-stone-400" size={17} /><input className={inputClass + " mt-0 pl-10"} value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Пошук моделі чи фабрики" /></div><select className={inputClass} value={brand} onChange={(event) => setBrand(event.target.value)}><option value="all">Усі фабрики</option>{brands.map((item) => <option key={item} value={item}>{item}</option>)}</select><div className="mt-3"><p className="text-xs font-bold uppercase tracking-[.14em] text-stone-400">Швидка перевірка</p><div className="mt-2 flex flex-wrap gap-1.5">{([['all', 'Усі'], ['source', 'Без джерела'], ['photo', 'Без фото'], ['description', 'Без опису'], ['hidden', 'Приховані']] as const).map(([id, label]) => <button key={id} type="button" onClick={() => setQuality(id)} className={"rounded-full px-2.5 py-1.5 text-xs font-bold transition " + (quality === id ? "bg-ink text-white" : "bg-stone-100 text-stone-600 hover:bg-sand")}>{label}</button>)}</div></div><p className="mt-3 text-xs font-bold uppercase tracking-[.14em] text-stone-400">Показано {filtered.length} з {products.length} моделей</p></div><div className="mt-2 max-h-[45vh] space-y-1 overflow-y-auto pr-1 xl:max-h-[calc(100vh-17.5rem)]">{filtered.map((item) => { const hasPhoto = Boolean(item.image_path?.trim()); const hasDescription = Boolean(item.description?.trim()); const hasSource = sourcedSlugs.has(item.slug); return <button key={item.slug} onClick={() => choose(item)} className={"w-full rounded-xl p-3 text-left transition " + (selected?.slug === item.slug ? "bg-ink text-white" : "hover:bg-sand")}><span className="line-clamp-2 block text-sm font-bold">{item.name}</span><span className={"mt-1 block text-xs " + (selected?.slug === item.slug ? "text-white/70" : "text-stone-500")}>{item.brand} · {item.collection}</span>{selected?.slug !== item.slug && (!hasPhoto || !hasDescription || !hasSource || !item.is_available) && <span className="mt-2 flex flex-wrap gap-1">{!hasPhoto && <i className="rounded bg-amber-100 px-1.5 py-0.5 text-[10px] not-italic font-bold text-amber-800">Фото</i>}{!hasDescription && <i className="rounded bg-amber-100 px-1.5 py-0.5 text-[10px] not-italic font-bold text-amber-800">Опис</i>}{!hasSource && <i className="rounded bg-amber-100 px-1.5 py-0.5 text-[10px] not-italic font-bold text-amber-800">Джерело</i>}{!item.is_available && <i className="rounded bg-stone-200 px-1.5 py-0.5 text-[10px] not-italic font-bold text-stone-600">Приховано</i>}</span>}</button>; })}{!filtered.length && <p className="p-4 text-center text-sm text-stone-500">Нічого не знайдено.</p>}</div></aside>
        {!selected ? <section className="grid min-h-80 place-items-center rounded-2xl border border-dashed bg-white p-8 text-center"><div><PackageSearch className="mx-auto text-clay" size={34} /><h2 className="mt-4 font-display text-3xl">Оберіть модель</h2><p className="mt-2 max-w-sm text-sm leading-6 text-stone-500">Скористайтеся пошуком або фабрикою, а потім натисніть на товар у списку.</p></div></section> : <section className="min-w-0">
          <div className="rounded-2xl border bg-white p-5 shadow-sm"><div className="flex flex-wrap items-start justify-between gap-3"><div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">{selected.brand} · {selected.collection}</p><h2 className="mt-2 font-display text-3xl sm:text-4xl">{selected.name}</h2></div><div className="flex flex-wrap gap-2"><button type="button" onClick={() => chooseAdjacent(-1)} disabled={selectedIndex <= 0 || loadingProduct} className="button-light px-3 py-2 text-sm disabled:opacity-40" aria-label="Попередня модель"><ChevronLeft size={16} /> Попередня</button><button type="button" onClick={() => chooseAdjacent(1)} disabled={selectedIndex < 0 || selectedIndex >= filtered.length - 1 || loadingProduct} className="button-light px-3 py-2 text-sm disabled:opacity-40" aria-label="Наступна модель">Наступна <ChevronRight size={16} /></button><a href={"/catalog/" + selected.slug} target="_blank" rel="noreferrer" className="button-light px-3 py-2 text-sm">На сайті <ExternalLink size={15} /></a></div></div><div className="mt-4 flex flex-wrap gap-2 text-xs font-bold"><span className="rounded-full bg-sand px-3 py-1.5 text-stone-700">{categoryLabel(selected.category)}</span><span className={"rounded-full px-3 py-1.5 " + (selected.is_available ? "bg-green-100 text-green-800" : "bg-stone-100 text-stone-600")}>{selected.is_available ? "Показується у каталозі" : "Прихований"}</span>{basicDirty && <span className="rounded-full bg-amber-100 px-3 py-1.5 text-amber-800">Є незбережені зміни</span>}</div></div>
          <nav className="mt-4 flex gap-2 overflow-x-auto pb-1">{([["basic", "Основне", <SlidersHorizontal key="basic" size={16} />], ["media", "Фото", <FileImage key="media" size={16} />], ["configuration", "Декори", <Paintbrush key="configuration" size={16} />], ["sources", "Джерела", <Link2 key="sources" size={16} />]] as const).map(([id, label, icon]) => <button key={id} onClick={() => setTab(id)} className={"inline-flex shrink-0 items-center gap-2 rounded-full px-4 py-2.5 text-sm font-bold " + (tab === id ? "bg-ink text-white" : "border bg-white text-stone-600")}>{icon}{label}</button>)}</nav>
          {loadingProduct ? <div className="mt-4 grid min-h-72 place-items-center rounded-2xl border bg-white text-stone-500"><span className="inline-flex items-center gap-2"><LoaderCircle className="animate-spin" size={18} /> Завантажуємо модель…</span></div> : <div className="mt-4">
            {tab === "basic" && <Card icon={<SlidersHorizontal size={19} />} title="Основні дані" help="Ці дані показуються клієнтам у каталозі та на сторінці товару."><div className="grid gap-5 lg:grid-cols-[minmax(0,1fr)_240px]"><div><div className="grid gap-4 md:grid-cols-2"><label className="text-sm font-bold">Ціна або текст ціни<input className={inputClass} value={draft.price || ""} onChange={(event) => setDraft({ ...draft, price: event.target.value })} placeholder="Наприклад: від 12 500 грн" /></label><label className="text-sm font-bold">Головне фото<input className={inputClass} value={draft.image_path || ""} onChange={(event) => setDraft({ ...draft, image_path: event.target.value })} placeholder="Шлях у Storage або URL" /></label></div><label className="mt-4 block text-sm font-bold">Опис для клієнта<textarea className={areaClass} value={draft.description || ""} onChange={(event) => setDraft({ ...draft, description: event.target.value })} placeholder="Коротко й зрозуміло опишіть модель." /></label><label className="mt-4 inline-flex items-center gap-2 text-sm font-bold"><input type="checkbox" checked={Boolean(draft.is_available)} onChange={(event) => setDraft({ ...draft, is_available: event.target.checked })} /> Показувати товар у каталозі</label></div><div><p className="mb-2 text-sm font-bold">Як побачить клієнт</p><ImagePreview path={draft.image_path} label={selected.name} /><p className="mt-2 text-xs leading-5 text-stone-500">Натисніть фото, щоб відкрити його окремо й перевірити якість.</p></div></div><button onClick={saveBasic} disabled={saving} className="button-primary mt-5"><Save size={16} /> {saving ? "Зберігаємо…" : "Зберегти основні дані"}</button></Card>}
            {tab === "media" && <Card icon={<FileImage size={19} />} title="Фото та палітри" help="Завантажте фото з пристрою або вставте URL / шлях до Supabase Storage."><div className="grid gap-3 md:grid-cols-[170px_1fr_1fr_auto]"><label className="text-sm font-bold">Тип фото<select className={inputClass} value={mediaKind} onChange={(event) => setMediaKind(event.target.value as Media["kind"])}><option value="gallery">Галерея</option><option value="main">Головне фото</option><option value="palette">Палітра</option></select></label><label className="text-sm font-bold">Підпис<input className={inputClass} value={mediaLabel} onChange={(event) => setMediaLabel(event.target.value)} placeholder="Наприклад: дуб золотий" /></label><label className="text-sm font-bold">Посилання або шлях<input className={inputClass} value={mediaUrl} onChange={(event) => setMediaUrl(event.target.value)} placeholder="https://… або папка/файл.jpg" /></label><button onClick={() => addMedia(mediaUrl)} className="button-light self-end"><Plus size={16} /> Додати</button></div><label className="mt-4 inline-flex cursor-pointer items-center gap-2 rounded-full border border-stone-300 bg-white px-4 py-2.5 text-sm font-bold hover:border-clay"><Upload size={16} /> Завантажити фото з пристрою<input className="hidden" type="file" accept="image/*" onChange={(event) => { const file = event.target.files?.[0]; if (file) uploadMedia(file); }} /></label><div className="mt-5 grid gap-3 sm:grid-cols-2 xl:grid-cols-3">{media.map((item) => <div key={item.id} className="flex items-start justify-between gap-3 rounded-xl border border-stone-200 bg-stone-50 p-3 text-sm"><span className="min-w-0"><b className="block">{item.kind}{item.label ? " · " + item.label : ""}</b><span className="mt-1 block break-all text-xs leading-5 text-stone-500">{item.image_path}</span></span><button onClick={() => removeMedia(item.id)} className="shrink-0 text-stone-400 hover:text-red-600" aria-label="Видалити фото"><Trash2 size={17} /></button></div>)}{!media.length && <p className="rounded-xl bg-stone-50 p-4 text-sm text-stone-500">Додаткових фото ще немає.</p>}</div></Card>}
            {tab === "configuration" && <Configuration specsText={specsText} optionsText={optionsText} variantsText={variantsText} setSpecsText={setSpecsText} setOptionsText={setOptionsText} setVariantsText={setVariantsText} onSave={saveRows} onUploadVariant={uploadVariantPhoto} />}
            {tab === "sources" && <Sources sources={sources} sourceName={sourceName} sourceUrl={sourceUrl} setSourceName={setSourceName} setSourceUrl={setSourceUrl} onAdd={addSource} />}
          </div>}
        </section>}
      </div>
    </div>
    {notice && <div className="fixed bottom-4 left-4 right-4 z-30 mx-auto max-w-xl rounded-xl bg-ink px-4 py-3 text-sm font-medium text-white shadow-xl">{notice}</div>}
  </main>;
}

function SourceLibrary() {
  return <Card icon={<Link2 size={19} />} title="Бібліотека джерел" help="Відкрийте каталог, знайдіть точну модель і збережіть URL в джерелах. Загальна сторінка фабрики не підтверджує конкретний декор.">
    <div className="grid gap-2 sm:grid-cols-2 xl:grid-cols-3">{catalogSources.map((source) => <a key={source.name} href={source.url} target="_blank" rel="noreferrer" className="rounded-xl border border-stone-200 bg-stone-50 p-3 transition hover:border-clay hover:bg-sand"><b className="flex items-center gap-2 text-sm">{source.name}<ExternalLink size={13} /></b><span className="mt-1 block text-xs leading-5 text-stone-500">{source.info}</span></a>)}</div>
    <ManagementDisclosure />
  </Card>;
}

function ManagementDisclosure() {
  const [open, setOpen] = useState(false);
  return <details className="mt-5 rounded-xl border border-stone-200 bg-white p-3" onToggle={(event) => setOpen(event.currentTarget.open)}>
    <summary className="cursor-pointer text-sm font-bold text-stone-700">Керувати каталогом і заявками</summary>
    <p className="mt-2 text-xs leading-5 text-stone-500">Тут можна керувати фабриками, колекціями, товарами та заявками клієнтів.</p>
    {open && <div className="mt-4 space-y-5"><LeadsDashboard /><CatalogManagement /></div>}
  </details>;
}
function Sources({ sources, sourceName, sourceUrl, setSourceName, setSourceUrl, onAdd }: { sources: Source[]; sourceName: string; sourceUrl: string; setSourceName: (value: string) => void; setSourceUrl: (value: string) => void; onAdd: () => void }) {
  return <div className="space-y-4"><SourceLibrary /><Card icon={<Link2 size={19} />} title="Перевірені джерела моделі" help="Збережіть URL точної картки цієї моделі. Так легко повернутися до першоджерела."><div className="grid gap-3 md:grid-cols-[190px_1fr_auto]"><label className="text-sm font-bold">Джерело<select className={inputClass} value={sourceName} onChange={(event) => setSourceName(event.target.value)}>{catalogSources.map((source) => <option key={source.name}>{source.name}</option>)}<option>Інше джерело</option></select></label><label className="text-sm font-bold">Посилання на модель<input className={inputClass} value={sourceUrl} onChange={(event) => setSourceUrl(event.target.value)} placeholder="Вставте URL саме картки товару" /></label><button onClick={onAdd} className="button-primary self-end"><Plus size={16} /> Додати</button></div><div className="mt-5 space-y-2">{sources.map((source) => <a key={source.id} className="block rounded-xl border border-stone-200 bg-stone-50 p-3 text-sm hover:border-clay" href={source.source_url} target="_blank" rel="noreferrer"><b className="flex items-center gap-2">{source.source_name}<ExternalLink size={14} /></b><span className="mt-1 block break-all text-xs leading-5 text-stone-500">{source.source_url}</span></a>)}{!sources.length && <p className="rounded-xl bg-stone-50 p-4 text-sm text-stone-500">Посилань на першоджерела ще немає.</p>}</div></Card></div>;
}
function Configuration({ specsText, optionsText, variantsText, setSpecsText, setOptionsText, setVariantsText, onSave, onUploadVariant }: { specsText: string; optionsText: string; variantsText: string; setSpecsText: (value: string) => void; setOptionsText: (value: string) => void; setVariantsText: (value: string) => void; onSave: (table: "product_specs" | "product_options" | "product_variants", text: string, title: string) => void; onUploadVariant: (file: File, index: number) => void }) {
  const [kind, setKind] = useState<EditorKind>("specs");
  const config = kind === "specs" ? { title: "Технічні характеристики", help: "Наприклад: «Товщина полотна» — «100 мм».", value: specsText, change: setSpecsText, table: "product_specs" as const } : kind === "options" ? { title: "Декори й опції", help: "Колір, скло, покриття, кромка або комплектація.", value: optionsText, change: setOptionsText, table: "product_options" as const } : { title: "Точні фото варіантів", help: "Прив’яжіть до декору точне фото цієї моделі.", value: variantsText, change: setVariantsText, table: "product_variants" as const };
  return <div className="space-y-4"><div className="flex flex-wrap gap-2">{([["specs", "Характеристики"], ["options", "Декори й опції"], ["variants", "Фото варіантів"]] as const).map(([id, title]) => <button key={id} onClick={() => setKind(id)} className={"rounded-full px-4 py-2 text-sm font-bold " + (kind === id ? "bg-clay text-white" : "border bg-white text-stone-600")}>{title}</button>)}</div>{kind === "variants" && <SourceLibrary />}<RowsEditor kind={kind} title={config.title} help={config.help} value={config.value} onChange={config.change} onSave={() => onSave(config.table, config.value, config.title)} onUploadVariant={onUploadVariant} /></div>;
}
function RowsEditor({ kind, title, help, value, onChange, onSave, onUploadVariant }: { kind: EditorKind; title: string; help: string; value: string; onChange: (value: string) => void; onSave: () => void; onUploadVariant: (file: File, index: number) => void }) {
  const rows = readRows(value);
  const write = (items: Row[]) => onChange(JSON.stringify(items, null, 2));
  const update = (index: number, patch: Row) => write(rows.map((row, current) => current === index ? { ...row, ...patch } : row));
  const add = () => {
    if (kind === "specs") write([...rows, { label: "Нова характеристика", value: "", sort_order: rows.length + 1 }]);
    if (kind === "options") write([...rows, { option_group: "color", group_label: "Колір", label: "Новий декор", swatch: "#d8d1c5", image_path: null, sort_order: rows.length + 1, is_active: true }]);
    if (kind === "variants") write([...rows, { selections: { color: "Новий декор" }, image_path: "", sort_order: rows.length + 1, is_active: true }]);
  };
  const remove = (index: number) => write(rows.filter((_row, current) => current !== index));
  const selection = (row: Row) => Object.entries((row.selections || {}) as Record<string, string>).map(([key, item]) => key + "=" + item).join("; ");
  const parseSelection = (text: string) => Object.fromEntries(text.split(";").map((part) => { const [key, ...rest] = part.split("="); return [key?.trim() || "", rest.join("=").trim()] as const; }).filter(([key, item]) => key && item));
  return <Card icon={<Check size={19} />} title={title} help={help}>{!rows.length && <p className="rounded-xl bg-sand p-4 text-sm text-stone-600">Ще нічого не додано. Натисніть «Додати рядок».</p>}<div className="space-y-3">{rows.map((row, index) => <div key={index} className="rounded-xl border border-stone-200 bg-stone-50 p-3"><div className="grid gap-2 md:grid-cols-[1fr_1.4fr_auto]">{kind === "specs" && <><input className={inputClass} value={String(row.label || "")} onChange={(event) => update(index, { label: event.target.value })} placeholder="Назва, наприклад: Товщина" /><input className={inputClass} value={String(row.value || "")} onChange={(event) => update(index, { value: event.target.value })} placeholder="Значення, наприклад: 100 мм" /></>}{kind === "options" && <><div className="grid grid-cols-2 gap-2"><select className={inputClass} value={String(row.option_group || "color")} onChange={(event) => update(index, { option_group: event.target.value })}><option value="color">Колір</option><option value="finish">Покриття</option><option value="glass">Скло</option><option value="edge">Кромка</option><option value="configuration">Комплектація</option></select><input className={inputClass} value={String(row.group_label || "")} onChange={(event) => update(index, { group_label: event.target.value })} placeholder="Назва групи" /></div><input className={inputClass} value={String(row.label || "")} onChange={(event) => update(index, { label: event.target.value })} placeholder="Назва декору" /></>}{kind === "variants" && <><input className={inputClass} value={selection(row)} onChange={(event) => update(index, { selections: parseSelection(event.target.value) })} placeholder="color=Беж; glass=Сатин" /><input className={inputClass} value={String(row.image_path || "")} onChange={(event) => update(index, { image_path: event.target.value })} placeholder="Шлях або URL точного фото" /></>}<button type="button" onClick={() => remove(index)} className="mt-1 flex min-h-11 items-center justify-center rounded-xl border border-stone-300 bg-white text-stone-500 hover:border-red-300 hover:text-red-600" aria-label="Видалити рядок"><Trash2 size={17} /></button></div>{kind === "variants" && <label className="mt-3 inline-flex cursor-pointer items-center gap-2 rounded-lg border border-stone-300 bg-white px-3 py-2 text-xs font-bold text-stone-700 hover:border-clay"><Upload size={15} /> Завантажити точне фото для цього варіанту<input className="hidden" type="file" accept="image/*" onChange={(event) => { const file = event.target.files?.[0]; if (file) onUploadVariant(file, index); }} /></label>}{kind === "options" && <div className="mt-2 grid gap-2 md:grid-cols-[150px_1fr]"><label className="text-xs font-bold text-stone-600">Колір зразка<input className={inputClass + " h-11 p-1"} type="color" value={String(row.swatch || "#d8d1c5")} onChange={(event) => update(index, { swatch: event.target.value })} /></label><label className="text-xs font-bold text-stone-600">Текстура / мініатюра<input className={inputClass} value={String(row.image_path || "")} onChange={(event) => update(index, { image_path: event.target.value || null })} placeholder="Необов’язково" /></label></div>}</div>)}</div><div className="mt-5 flex flex-wrap gap-3"><button type="button" onClick={add} className="button-light"><Plus size={16} /> Додати рядок</button><button type="button" onClick={onSave} className="button-primary"><Save size={16} /> Зберегти</button></div><details className="mt-5 rounded-xl border border-stone-200 bg-stone-50 p-3"><summary className="cursor-pointer text-sm font-bold text-stone-600">Розширений режим (JSON)</summary><p className="mt-2 text-xs leading-5 text-stone-500">Потрібен лише для складних варіантів. Звичайних полів вище достатньо майже завжди.</p><textarea className={areaClass + " mt-3 font-mono text-xs"} value={value} onChange={(event) => onChange(event.target.value)} /></details></Card>;
}

function AdminLogin({ email, password, notice, saving, setEmail, setPassword, onPasswordLogin, onMagicLogin }: { email: string; password: string; notice: string; saving: boolean; setEmail: (value: string) => void; setPassword: (value: string) => void; onPasswordLogin: (event: FormEvent) => void; onMagicLogin: (event: FormEvent) => void }) {
  return <main className="grid min-h-screen place-items-center bg-stone-50 p-5"><form onSubmit={onPasswordLogin} className="w-full max-w-md rounded-3xl border bg-white p-7 shadow-lg"><ShieldCheck className="text-clay" size={30} /><p className="mt-5 text-xs font-bold uppercase tracking-[.16em] text-clay">Адмінка каталогу</p><h1 className="mt-2 font-display text-4xl">Наші двері</h1><p className="mt-3 text-sm leading-6 text-stone-600">Увійдіть за поштою й паролем адміністратора.</p><label className="mt-6 block text-sm font-bold">Електронна пошта<input className={inputClass} type="email" required value={email} onChange={(event) => setEmail(event.target.value)} placeholder="name@example.com" /></label><label className="mt-4 block text-sm font-bold">Пароль<input className={inputClass} type="password" required value={password} onChange={(event) => setPassword(event.target.value)} placeholder="Ваш пароль" /></label><button className="button-primary mt-5 w-full" disabled={saving}>{saving ? "Вхід…" : "Увійти"}</button><div className="mt-5 border-t pt-5 text-center"><p className="text-xs leading-5 text-stone-500">Ще не створювали пароль або забули його?</p><button type="button" onClick={(event) => onMagicLogin(event as unknown as FormEvent)} className="mt-2 text-sm font-bold text-clay hover:text-ink">Надіслати одноразове посилання</button></div>{notice && <p className="mt-4 rounded-xl bg-sand p-3 text-sm">{notice}</p>}</form></main>;
}
