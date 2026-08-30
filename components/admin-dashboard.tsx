"use client";

import { FormEvent, type ReactNode, useEffect, useMemo, useState } from "react";
import { Check, FileImage, Link2, LoaderCircle, LogOut, Plus, Save, ShieldCheck, Trash2, Upload } from "lucide-react";
import type { Session } from "@supabase/supabase-js";
import { adminEmail, getSupabaseBrowserClient } from "@/lib/supabase-browser";

type ProductRow = { slug: string; name: string; brand: string; collection: string; price: string; description: string; is_available: boolean; image_path: string };
type Spec = { label: string; value: string; sort_order: number };
type Media = { id: string; kind: "main" | "gallery" | "palette"; label: string | null; image_path: string; sort_order: number };
type Source = { id: string; source_name: string; source_url: string; verification_status: "verified" | "review" | "rejected" };

const inputClass = "mt-1 w-full rounded-xl border border-stone-300 bg-white px-3 py-2.5 text-sm outline-none transition focus:border-clay focus:ring-2 focus:ring-clay/20";
const areaClass = `${inputClass} min-h-28 resize-y leading-6`;

function safeJson<T>(value: string, title: string): T | null {
  try { return JSON.parse(value) as T; } catch { alert(`${title}: виправте JSON перед збереженням.`); return null; }
}

export function AdminDashboard() {
  const supabase = useMemo(() => getSupabaseBrowserClient(), []);
  const [session, setSession] = useState<Session | null>(null);
  const [email, setEmail] = useState("");
  const [notice, setNotice] = useState("");
  const [loading, setLoading] = useState(true);
  const [products, setProducts] = useState<ProductRow[]>([]);
  const [query, setQuery] = useState("");
  const [selected, setSelected] = useState<ProductRow | null>(null);
  const [draft, setDraft] = useState<Partial<ProductRow>>({});
  const [specsText, setSpecsText] = useState("[]");
  const [optionsText, setOptionsText] = useState("[]");
  const [variantsText, setVariantsText] = useState("[]");
  const [media, setMedia] = useState<Media[]>([]);
  const [sources, setSources] = useState<Source[]>([]);
  const [mediaKind, setMediaKind] = useState<Media["kind"]>("gallery");
  const [mediaUrl, setMediaUrl] = useState("");
  const [mediaLabel, setMediaLabel] = useState("");
  const [sourceUrl, setSourceUrl] = useState("");
  const [sourceName, setSourceName] = useState("Market Dveri");
  const [saving, setSaving] = useState(false);

  const isAdmin = session?.user.email === adminEmail;
  const filtered = products.filter((product) => `${product.name} ${product.brand} ${product.collection}`.toLowerCase().includes(query.toLowerCase()));

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => { setSession(data.session); setLoading(false); });
    const { data: listener } = supabase.auth.onAuthStateChange((_event, nextSession) => setSession(nextSession));
    return () => listener.subscription.unsubscribe();
  }, [supabase]);

  useEffect(() => {
    if (!isAdmin) return;
    supabase.from("products").select("slug,name,brand,collection,price,description,is_available,image_path").order("brand").order("name").then(({ data, error }) => {
      if (error) setNotice(error.message); else setProducts((data || []) as ProductRow[]);
    });
  }, [isAdmin, supabase]);

  async function sendMagicLink(event: FormEvent) {
    event.preventDefault(); setSaving(true);
    const { error } = await supabase.auth.signInWithOtp({ email, options: { emailRedirectTo: `${window.location.origin}/admin` } });
    setSaving(false); setNotice(error ? error.message : "Посилання для входу надіслано на пошту. Відкрийте його на цьому пристрої.");
  }

  async function selectProduct(product: ProductRow) {
    setSelected(product); setDraft(product); setNotice("");
    const [specsResult, optionsResult, variantsResult, mediaResult, sourceResult] = await Promise.all([
      supabase.from("product_specs").select("label,value,sort_order").eq("product_slug", product.slug).order("sort_order"),
      supabase.from("product_options").select("option_group,group_label,label,swatch,image_path,sort_order,is_active").eq("product_slug", product.slug).order("sort_order"),
      supabase.from("product_variants").select("selections,image_path,sort_order,is_active").eq("product_slug", product.slug).order("sort_order"),
      supabase.from("product_media").select("id,kind,label,image_path,sort_order").eq("product_slug", product.slug).order("sort_order"),
      supabase.from("product_sources").select("id,source_name,source_url,verification_status").eq("product_slug", product.slug).order("created_at", { ascending: false }),
    ]);
    setSpecsText(JSON.stringify(specsResult.data || [], null, 2));
    setOptionsText(JSON.stringify(optionsResult.data || [], null, 2));
    setVariantsText(JSON.stringify(variantsResult.data || [], null, 2));
    setMedia((mediaResult.data || []) as Media[]); setSources((sourceResult.data || []) as Source[]);
  }

  async function saveProduct() {
    if (!selected) return; setSaving(true);
    const { error } = await supabase.from("products").update({ price: draft.price, description: draft.description, is_available: draft.is_available, image_path: draft.image_path }).eq("slug", selected.slug);
    setSaving(false); setNotice(error ? error.message : "Основні дані збережено.");
    if (!error) { const updated = { ...selected, ...draft } as ProductRow; setSelected(updated); setProducts((items) => items.map((item) => item.slug === updated.slug ? updated : item)); }
  }

  async function replaceJsonRows(table: "product_specs" | "product_options" | "product_variants", text: string, title: string) {
    if (!selected) return;
    const rows = safeJson<Record<string, unknown>[]>(text, title); if (!rows) return;
    setSaving(true);
    const deletion = await supabase.from(table).delete().eq("product_slug", selected.slug);
    const insertion = deletion.error || !rows.length ? { error: deletion.error } : await supabase.from(table).insert(rows.map((row) => ({ ...row, product_slug: selected.slug })));
    setSaving(false); setNotice(insertion.error ? insertion.error.message : `${title} збережено.`);
  }

  async function addMedia(path: string) {
    if (!selected || !path.trim()) return;
    setSaving(true);
    const { error } = await supabase.from("product_media").insert({ product_slug: selected.slug, kind: mediaKind, label: mediaLabel || null, image_path: path.trim(), sort_order: media.length });
    setSaving(false); setNotice(error ? error.message : "Фото додано.");
    if (!error) { setMediaUrl(""); setMediaLabel(""); await selectProduct(selected); }
  }

  async function uploadMedia(file: File) {
    if (!selected) return;
    const cleanName = file.name.replace(/[^a-zA-Z0-9._-]/g, "-");
    const path = `admin/${selected.slug}/${Date.now()}-${cleanName}`;
    setSaving(true);
    const { error } = await supabase.storage.from("catalog-images").upload(path, file, { upsert: false });
    setSaving(false); if (error) { setNotice(error.message); return; }
    await addMedia(path);
  }

  async function removeMedia(id: string) {
    const { error } = await supabase.from("product_media").delete().eq("id", id);
    setNotice(error ? error.message : "Запис медіа видалено."); if (!error && selected) await selectProduct(selected);
  }

  async function addSource() {
    if (!selected || !sourceUrl.trim()) return;
    const { error } = await supabase.from("product_sources").insert({ product_slug: selected.slug, source_name: sourceName, source_url: sourceUrl.trim(), verification_status: "verified", verified_at: new Date().toISOString() });
    setNotice(error ? error.message : "Джерело збережено."); if (!error) { setSourceUrl(""); await selectProduct(selected); }
  }

  if (loading) return <main className="grid min-h-screen place-items-center bg-stone-50 text-stone-600"><LoaderCircle className="animate-spin" /> Завантаження…</main>;
  if (!session) return <main className="grid min-h-screen place-items-center bg-stone-50 p-5"><form onSubmit={sendMagicLink} className="w-full max-w-md rounded-3xl border bg-white p-7 shadow-lg"><ShieldCheck className="text-clay" size={30} /><p className="mt-5 text-xs font-bold uppercase tracking-[.16em] text-clay">Адмінка каталогу</p><h1 className="mt-2 font-display text-4xl text-ink">Наші двері</h1><p className="mt-3 text-sm leading-6 text-stone-600">Введіть пошту адміністратора. Ми надішлемо одноразове посилання для безпечного входу.</p><label className="mt-6 block text-sm font-bold">Електронна пошта<input className={inputClass} type="email" required value={email} onChange={(event) => setEmail(event.target.value)} placeholder="name@example.com" /></label><button className="button-primary mt-5 w-full" disabled={saving}>{saving ? "Надсилання…" : "Надіслати посилання"}</button>{notice && <p className="mt-4 rounded-xl bg-sand p-3 text-sm text-stone-700">{notice}</p>}</form></main>;
  if (!isAdmin) return <main className="grid min-h-screen place-items-center bg-stone-50 p-5"><div className="max-w-md rounded-3xl bg-white p-7 text-center shadow-lg"><ShieldCheck className="mx-auto text-clay" size={32} /><h1 className="mt-4 font-display text-3xl">Немає доступу</h1><p className="mt-3 text-sm text-stone-600">Ця пошта не додана до адміністраторів каталогу.</p><button className="button-light mt-6" onClick={() => supabase.auth.signOut()}>Вийти</button></div></main>;

  return <main className="min-h-screen bg-stone-50 text-ink"><header className="border-b bg-white"><div className="mx-auto flex max-w-[1600px] items-center justify-between gap-4 px-5 py-4"><div><p className="text-xs font-bold uppercase tracking-[.16em] text-clay">Закрита адмінка</p><h1 className="font-display text-2xl">Каталог «Наші двері»</h1></div><button onClick={() => supabase.auth.signOut()} className="inline-flex items-center gap-2 text-sm font-bold text-stone-600 hover:text-clay"><LogOut size={16} /> Вийти</button></div></header><div className="mx-auto grid max-w-[1600px] gap-5 p-5 lg:grid-cols-[340px_1fr]"><aside className="rounded-2xl border bg-white p-4 shadow-sm"><input className={inputClass} value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Пошук моделі або фабрики" /><p className="mt-4 text-xs font-bold uppercase tracking-[.14em] text-stone-400">{filtered.length} моделей</p><div className="mt-3 max-h-[72vh] space-y-1 overflow-y-auto pr-1">{filtered.map((product) => <button key={product.slug} onClick={() => selectProduct(product)} className={`w-full rounded-xl p-3 text-left transition ${selected?.slug === product.slug ? "bg-ink text-white" : "hover:bg-sand"}`}><span className="block text-sm font-bold">{product.name}</span><span className={`mt-1 block text-xs ${selected?.slug === product.slug ? "text-white/70" : "text-stone-500"}`}>{product.brand} · {product.collection}</span></button>)}</div></aside><section>{!selected ? <div className="grid min-h-80 place-items-center rounded-2xl border border-dashed bg-white p-8 text-center text-stone-500">Оберіть модель ліворуч, щоб редагувати її дані.</div> : <div className="space-y-5"><div className="rounded-2xl border bg-white p-5 shadow-sm"><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">{selected.brand} · {selected.collection}</p><h2 className="mt-2 font-display text-4xl">{selected.name}</h2><div className="mt-6 grid gap-4 md:grid-cols-2"><label className="text-sm font-bold">Ціна<input className={inputClass} value={draft.price || ""} onChange={(event) => setDraft({ ...draft, price: event.target.value })} /></label><label className="text-sm font-bold">Головне фото: шлях у Storage або URL<input className={inputClass} value={draft.image_path || ""} onChange={(event) => setDraft({ ...draft, image_path: event.target.value })} /></label></div><label className="mt-4 block text-sm font-bold">Наш опис<textarea className={areaClass} value={draft.description || ""} onChange={(event) => setDraft({ ...draft, description: event.target.value })} /></label><label className="mt-4 inline-flex items-center gap-2 text-sm font-bold"><input type="checkbox" checked={Boolean(draft.is_available)} onChange={(event) => setDraft({ ...draft, is_available: event.target.checked })} /> Показувати товар у каталозі</label><button onClick={saveProduct} disabled={saving} className="button-primary mt-5"><Save size={16} /> Зберегти основні дані</button></div><JsonEditor title="Технічні характеристики" help="Масив об’єктів: label, value, sort_order." value={specsText} onChange={setSpecsText} onSave={() => replaceJsonRows("product_specs", specsText, "Характеристики")} /><JsonEditor title="Декори й опції" help="Масив: option_group, group_label, label, swatch, image_path, sort_order, is_active." value={optionsText} onChange={setOptionsText} onSave={() => replaceJsonRows("product_options", optionsText, "Опції")} /><JsonEditor title="Точні фото варіантів" help="Масив: selections (наприклад {&quot;color&quot;:&quot;Беж&quot;}), image_path, sort_order, is_active." value={variantsText} onChange={setVariantsText} onSave={() => replaceJsonRows("product_variants", variantsText, "Варіанти")} /><div className="rounded-2xl border bg-white p-5 shadow-sm"><SectionTitle icon={<FileImage size={18} />} title="Фото та палітри" /><div className="mt-4 grid gap-3 md:grid-cols-[140px_1fr_1fr_auto]"><select className={inputClass} value={mediaKind} onChange={(event) => setMediaKind(event.target.value as Media["kind"])}><option value="gallery">Галерея</option><option value="main">Головне</option><option value="palette">Палітра</option></select><input className={inputClass} value={mediaLabel} onChange={(event) => setMediaLabel(event.target.value)} placeholder="Підпис" /><input className={inputClass} value={mediaUrl} onChange={(event) => setMediaUrl(event.target.value)} placeholder="URL або шлях Storage" /><button onClick={() => addMedia(mediaUrl)} className="button-light"><Plus size={16} /> Додати</button></div><label className="mt-3 inline-flex cursor-pointer items-center gap-2 rounded-full border border-stone-300 bg-white px-4 py-2.5 text-sm font-bold hover:border-clay"><Upload size={16} /> Завантажити файл<input className="hidden" type="file" accept="image/*" onChange={(event) => { const file = event.target.files?.[0]; if (file) uploadMedia(file); }} /></label><div className="mt-4 grid gap-2 sm:grid-cols-2">{media.map((item) => <div key={item.id} className="flex items-center justify-between gap-3 rounded-xl bg-stone-50 p-3 text-sm"><span className="min-w-0 truncate"><b>{item.kind}</b>{item.label ? ` · ${item.label}` : ""}<br /><span className="text-xs text-stone-500">{item.image_path}</span></span><button onClick={() => removeMedia(item.id)} className="shrink-0 text-stone-400 hover:text-red-600" aria-label="Видалити фото"><Trash2 size={17} /></button></div>)}</div></div><div className="rounded-2xl border bg-white p-5 shadow-sm"><SectionTitle icon={<Link2 size={18} />} title="Перевірені джерела" /><div className="mt-4 grid gap-3 md:grid-cols-[180px_1fr_auto]"><input className={inputClass} value={sourceName} onChange={(event) => setSourceName(event.target.value)} placeholder="Назва джерела" /><input className={inputClass} value={sourceUrl} onChange={(event) => setSourceUrl(event.target.value)} placeholder="Посилання на точну картку моделі" /><button onClick={addSource} className="button-light"><Plus size={16} /> Додати</button></div><div className="mt-4 space-y-2">{sources.map((source) => <a key={source.id} className="block truncate rounded-xl bg-stone-50 p-3 text-sm hover:text-clay" href={source.source_url} target="_blank" rel="noreferrer"><b>{source.source_name}</b> · {source.verification_status}<br /><span className="text-xs text-stone-500">{source.source_url}</span></a>)}</div></div>{notice && <div className="sticky bottom-4 rounded-xl bg-ink px-4 py-3 text-sm font-medium text-white shadow-xl">{notice}</div>}</div>}</section></div></main>;
}

function SectionTitle({ icon, title }: { icon: ReactNode; title: string }) { return <h3 className="flex items-center gap-2 font-display text-2xl">{icon}{title}</h3>; }
type EditorKind = "specs" | "options" | "variants";
type EditorRow = Record<string, unknown>;

function JsonEditor({ title, help, value, onChange, onSave }: { title: string; help: string; value: string; onChange: (value: string) => void; onSave: () => void }) {
  const kind: EditorKind = title === "Технічні характеристики" ? "specs" : title === "Декори й опції" ? "options" : "variants";
  const friendlyHelp = kind === "specs"
    ? "Заповнюйте назву й значення — наприклад «Товщина полотна» / «100 мм»."
    : kind === "options"
      ? "Додайте колір, скло, покриття чи кромку. Варіант стає активним у конфігураторі лише після додавання точного фото нижче."
      : "Вкажіть декор і відповідне йому фото моделі. Без фото декор не буде доступний клієнтам.";
  return <FriendlyEditor title={title} help={friendlyHelp || help} value={value} onChange={onChange} onSave={onSave} kind={kind} />;
}

function FriendlyEditor({ title, help, value, onChange, onSave, kind }: { title: string; help: string; value: string; onChange: (value: string) => void; onSave: () => void; kind: EditorKind }) {
  let rows: EditorRow[] = [];
  try { const parsed = JSON.parse(value); rows = Array.isArray(parsed) ? parsed : []; } catch { /* JSON is available in advanced mode for repair. */ }
  const write = (next: EditorRow[]) => onChange(JSON.stringify(next, null, 2));
  const update = (index: number, patch: EditorRow) => write(rows.map((row, current) => current === index ? { ...row, ...patch } : row));
  const remove = (index: number) => write(rows.filter((_row, current) => current !== index));
  const add = () => {
    if (kind === "specs") write([...rows, { label: "Нова характеристика", value: "", sort_order: rows.length * 10 + 10 }]);
    if (kind === "options") write([...rows, { option_group: "color", group_label: "Колір", label: "Новий декор", swatch: "#d8d1c5", image_path: null, sort_order: rows.length + 1, is_active: true }]);
    if (kind === "variants") write([...rows, { selections: { color: "Новий декор" }, image_path: "", sort_order: rows.length + 1, is_active: true }]);
  };
  const selectionLabel = (row: EditorRow) => Object.entries((row.selections || {}) as Record<string, string>).map(([key, entry]) => `${key}=${entry}`).join("; ");
  const parseSelection = (text: string) => Object.fromEntries(text.split(";").map((part) => { const [key, ...rest] = part.split("="); return [key?.trim() || "", rest.join("=").trim()] as const; }).filter(([key, entry]) => key && entry));
  return <div className="rounded-2xl border bg-white p-5 shadow-sm"><SectionTitle icon={<Check size={18} />} title={title} /><p className="mt-2 text-sm leading-6 text-stone-500">{help}</p><div className="mt-5 space-y-3">{rows.length === 0 && <p className="rounded-xl bg-sand p-4 text-sm text-stone-600">Ще нічого не додано.</p>}{rows.map((row, index) => <div key={index} className="rounded-xl border border-stone-200 bg-stone-50 p-3"><div className="grid gap-2 md:grid-cols-[1fr_1.4fr_auto]">{kind === "specs" && <><input className={inputClass} value={String(row.label || "")} onChange={(event) => update(index, { label: event.target.value })} placeholder="Наприклад: Товщина полотна" /><input className={inputClass} value={String(row.value || "")} onChange={(event) => update(index, { value: event.target.value })} placeholder="Наприклад: 100 мм" /></>}{kind === "options" && <><div className="grid grid-cols-2 gap-2"><select className={inputClass} value={String(row.option_group || "color")} onChange={(event) => update(index, { option_group: event.target.value })}><option value="color">Колір</option><option value="finish">Покриття</option><option value="glass">Скло</option><option value="edge">Кромка</option><option value="configuration">Комплектація</option></select><input className={inputClass} value={String(row.group_label || "")} onChange={(event) => update(index, { group_label: event.target.value })} placeholder="Назва групи" /></div><input className={inputClass} value={String(row.label || "")} onChange={(event) => update(index, { label: event.target.value })} placeholder="Назва декору" /></>}{kind === "variants" && <><input className={inputClass} value={selectionLabel(row)} onChange={(event) => update(index, { selections: parseSelection(event.target.value) })} placeholder="color=Беж; glass=Сатин" /><input className={inputClass} value={String(row.image_path || "")} onChange={(event) => update(index, { image_path: event.target.value })} placeholder="URL або шлях фото" /></>}<button type="button" onClick={() => remove(index)} className="flex min-h-11 items-center justify-center rounded-xl border border-stone-300 bg-white text-stone-500 hover:border-red-300 hover:text-red-600" aria-label="Видалити рядок"><Trash2 size={17} /></button></div>{kind === "options" && <div className="mt-2 grid gap-2 md:grid-cols-[130px_1fr]"><input className={`${inputClass} h-11 p-1`} type="color" value={String(row.swatch || "#d8d1c5")} onChange={(event) => update(index, { swatch: event.target.value })} title="Колір зразка" /><input className={inputClass} value={String(row.image_path || "")} onChange={(event) => update(index, { image_path: event.target.value || null })} placeholder="Мініатюра/текстура (необов’язково)" /></div>}</div>)}</div><div className="mt-4 flex flex-wrap gap-3"><button type="button" onClick={add} className="button-light"><Plus size={16} /> Додати</button><button type="button" onClick={onSave} className="button-primary"><Save size={16} /> Зберегти {title.toLowerCase()}</button></div><details className="mt-5 rounded-xl border border-stone-200 bg-stone-50 p-3"><summary className="cursor-pointer text-sm font-bold text-stone-600">Розширений режим (JSON)</summary><p className="mt-2 text-xs leading-5 text-stone-500">Для складних комбінацій. Звичайні поля вище достатні для більшості товарів.</p><textarea className={`${areaClass} mt-3 font-mono text-xs`} value={value} onChange={(event) => onChange(event.target.value)} /></details></div>;
}
