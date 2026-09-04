"use client";

import { FormEvent, useEffect, useMemo, useState } from "react";
import { Building2, Eye, EyeOff, FolderInput, FolderTree, LoaderCircle, PackagePlus, Pencil, Plus, Save, Trash2, X } from "lucide-react";
import { useSearchParams } from "next/navigation";
import { getSupabaseBrowserClient } from "@/lib/supabase-browser";

type Brand = { id: string; name: string; description: string; image_path: string | null; is_active: boolean; sort_order: number };
type Collection = { id: string; brand_id: string; name: string; category: "interior" | "entrance" | "windows"; description: string; image_path: string | null; is_active: boolean; sort_order: number };
type Product = { slug: string; name: string; brand: string; collection: string; category: "interior" | "entrance" | "windows"; material: string; style: string; color: string; price: string; description: string; image_path: string; is_available: boolean };
type BrandDraft = Omit<Brand, "id" | "image_path"> & { image_path: string };
type CollectionDraft = Omit<Collection, "id" | "image_path"> & { image_path: string };
type ManageTab = "brands" | "collections" | "products";

const inputClass = "mt-1 w-full rounded-xl border border-stone-300 bg-white px-3 py-2.5 text-sm outline-none transition focus:border-clay focus:ring-2 focus:ring-clay/20";
const categories = [
  { value: "interior", label: "Міжкімнатні двері" },
  { value: "entrance", label: "Вхідні двері" },
  { value: "windows", label: "Вікна" },
] as const;
const blankBrand: BrandDraft = { name: "", description: "", image_path: "", is_active: true, sort_order: 0 };
const blankCollection: CollectionDraft = { brand_id: "", name: "", category: "interior", description: "", image_path: "", is_active: true, sort_order: 0 };
const blankProduct: Product = { slug: "", name: "", brand: "", collection: "", category: "interior", material: "Уточнюйте у менеджера", style: "Уточнюйте у менеджера", color: "Уточнюйте у менеджера", price: "Ціна за запитом", description: "", image_path: "", is_available: false };

function categoryName(category: string) {
  return categories.find((item) => item.value === category)?.label || category;
}

export function CatalogManagement() {
  const supabase = useMemo(() => getSupabaseBrowserClient(), []);
  const searchParams = useSearchParams();
  const [tab, setTab] = useState<ManageTab>("brands");
  const [brands, setBrands] = useState<Brand[]>([]);
  const [collections, setCollections] = useState<Collection[]>([]);
  const [products, setProducts] = useState<Product[]>([]);
  const [brandDraft, setBrandDraft] = useState<BrandDraft>(blankBrand);
  const [collectionDraft, setCollectionDraft] = useState<CollectionDraft>(blankCollection);
  const [productDraft, setProductDraft] = useState<Product>(blankProduct);
  const [editBrandId, setEditBrandId] = useState<string | null>(null);
  const [editCollectionId, setEditCollectionId] = useState<string | null>(null);
  const [editProductSlug, setEditProductSlug] = useState<string | null>(null);
  const [selectedProductSlugs, setSelectedProductSlugs] = useState<string[]>([]);
  const [bulkCollectionId, setBulkCollectionId] = useState("");
  const [busy, setBusy] = useState(false);
  const [notice, setNotice] = useState("");
  const [ready, setReady] = useState(false);

  async function load() {
    setReady(false);
    const [brandResult, collectionResult, productResult] = await Promise.all([
      supabase.from("catalog_brands").select("id,name,description,image_path,is_active,sort_order").order("sort_order").order("name"),
      supabase.from("catalog_collections").select("id,brand_id,name,category,description,image_path,is_active,sort_order").order("sort_order").order("name"),
      supabase.from("products").select("slug,name,brand,collection,category,material,style,color,price,description,image_path,is_available").order("brand").order("name"),
    ]);
    const error = brandResult.error || collectionResult.error || productResult.error;
    if (error) setNotice("Спершу виконайте SQL-файл catalog-structure-management.sql у Supabase. " + error.message);
    else {
      setBrands((brandResult.data || []) as Brand[]);
      setCollections((collectionResult.data || []) as Collection[]);
      setProducts((productResult.data || []) as Product[]);
      setNotice("");
    }
    setReady(true);
  }
  useEffect(() => { load(); }, []);
  useEffect(() => {
    if (searchParams.get("tab") !== "products" || !brands.length) return;
    const requestedBrand = searchParams.get("brand");
    setTab("products");
    if (requestedBrand && brands.some((brand) => brand.name === requestedBrand)) {
      setEditProductSlug(null);
      setProductDraft({ ...blankProduct, brand: requestedBrand });
    }
  }, [searchParams, brands]);

  const collectionsForDraftBrand = collections.filter((item) => item.brand_id === collectionDraft.brand_id);
  const productCollections = collections.filter((item) => {
    const selectedBrand = brands.find((brand) => brand.name === productDraft.brand);
    return selectedBrand ? item.brand_id === selectedBrand.id && item.category === productDraft.category : false;
  });
  const selectedCount = selectedProductSlugs.length;

  function startBrand(brand?: Brand) {
    setEditBrandId(brand?.id || null);
    setBrandDraft(brand ? { name: brand.name, description: brand.description, image_path: brand.image_path || "", is_active: brand.is_active, sort_order: brand.sort_order } : blankBrand);
  }
  function startCollection(collection?: Collection) {
    setEditCollectionId(collection?.id || null);
    setCollectionDraft(collection ? { brand_id: collection.brand_id, name: collection.name, category: collection.category, description: collection.description, image_path: collection.image_path || "", is_active: collection.is_active, sort_order: collection.sort_order } : { ...blankCollection, brand_id: brands[0]?.id || "" });
  }
  function startProduct(product?: Product) {
    setEditProductSlug(product?.slug || null);
    setProductDraft(product ? { ...product } : { ...blankProduct, brand: brands[0]?.name || "", collection: "" });
  }

  async function saveBrand(event: FormEvent) {
    event.preventDefault();
    if (!brandDraft.name.trim()) return setNotice("Вкажіть назву фабрики.");
    setBusy(true);
    const existing = brands.find((item) => item.id === editBrandId);
    const result = editBrandId
      ? await supabase.from("catalog_brands").update({ ...brandDraft, name: brandDraft.name.trim(), image_path: brandDraft.image_path || null }).eq("id", editBrandId)
      : await supabase.from("catalog_brands").insert({ ...brandDraft, name: brandDraft.name.trim(), image_path: brandDraft.image_path || null });
    if (!result.error && existing && existing.name !== brandDraft.name.trim()) await supabase.from("products").update({ brand: brandDraft.name.trim() }).eq("brand", existing.name);
    setBusy(false);
    setNotice(result.error ? result.error.message : "Фабрику збережено.");
    if (!result.error) { startBrand(); await load(); }
  }
  async function removeBrand(brand: Brand) {
    const count = products.filter((item) => item.brand === brand.name).length;
    if (count) return setNotice("Неможливо видалити «" + brand.name + "»: у ній " + count + " товарів. Спочатку перенесіть або видаліть ці товари, або вимкніть фабрику.");
    if (!window.confirm("Видалити фабрику «" + brand.name + "»?")) return;
    setBusy(true);
    const { error } = await supabase.from("catalog_brands").delete().eq("id", brand.id);
    setBusy(false);
    setNotice(error ? error.message : "Фабрику видалено.");
    if (!error) await load();
  }
  async function saveCollection(event: FormEvent) {
    event.preventDefault();
    if (!collectionDraft.brand_id || !collectionDraft.name.trim()) return setNotice("Оберіть фабрику й введіть назву колекції.");
    setBusy(true);
    const existing = collections.find((item) => item.id === editCollectionId);
    const result = editCollectionId
      ? await supabase.from("catalog_collections").update({ ...collectionDraft, name: collectionDraft.name.trim(), image_path: collectionDraft.image_path || null }).eq("id", editCollectionId)
      : await supabase.from("catalog_collections").insert({ ...collectionDraft, name: collectionDraft.name.trim(), image_path: collectionDraft.image_path || null });
    if (!result.error && existing && existing.name !== collectionDraft.name.trim()) {
      const oldBrand = brands.find((item) => item.id === existing.brand_id)?.name;
      const newBrand = brands.find((item) => item.id === collectionDraft.brand_id)?.name;
      if (oldBrand && newBrand) await supabase.from("products").update({ brand: newBrand, collection: collectionDraft.name.trim(), category: collectionDraft.category }).eq("brand", oldBrand).eq("collection", existing.name);
    }
    setBusy(false);
    setNotice(result.error ? result.error.message : "Колекцію збережено.");
    if (!result.error) { startCollection(); await load(); }
  }
  async function removeCollection(collection: Collection) {
    const brandName = brands.find((brand) => brand.id === collection.brand_id)?.name;
    const count = products.filter((item) => item.brand === brandName && item.collection === collection.name).length;
    if (count) return setNotice("Неможливо видалити колекцію: у ній " + count + " товарів. Спочатку перенесіть, приховайте або видаліть товари.");
    if (!window.confirm("Видалити колекцію «" + collection.name + "»?")) return;
    setBusy(true);
    const { error } = await supabase.from("catalog_collections").delete().eq("id", collection.id);
    setBusy(false);
    setNotice(error ? error.message : "Колекцію видалено.");
    if (!error) await load();
  }
  async function saveProduct(event: FormEvent) {
    event.preventDefault();
    if (!productDraft.name.trim() || !productDraft.brand || !productDraft.collection) return setNotice("Для товару потрібні назва, фабрика та колекція.");
    setBusy(true);
    const slug = productDraft.slug.trim() || "admin-" + Date.now();
    const payload = { ...productDraft, slug, name: productDraft.name.trim(), image_path: productDraft.image_path || "" };
    const result = editProductSlug
      ? await supabase.from("products").update(payload).eq("slug", editProductSlug)
      : await supabase.from("products").insert(payload);
    setBusy(false);
    setNotice(result.error ? result.error.message : editProductSlug ? "Товар оновлено." : "Створено чернетку товару. Додайте фото та опис, тоді увімкніть показ у каталозі.");
    if (!result.error) { startProduct(); await load(); }
  }
  async function removeProduct(product: Product) {
    if (!window.confirm("Видалити товар «" + product.name + "» разом з його фото, декорами, характеристиками та джерелами?")) return;
    setBusy(true);
    const { error } = await supabase.from("products").delete().eq("slug", product.slug);
    setBusy(false);
    setNotice(error ? error.message : "Товар видалено.");
    if (!error) await load();
  }
  function toggleProduct(slug: string) {
    setSelectedProductSlugs((items) => items.includes(slug) ? items.filter((item) => item !== slug) : [...items, slug]);
  }
  async function setSelectedAvailability(isAvailable: boolean) {
    if (!selectedProductSlugs.length) return;
    const action = isAvailable ? "показати" : "приховати";
    if (!window.confirm(`Справді ${action} ${selectedProductSlugs.length} товарів у каталозі?`)) return;
    setBusy(true);
    const { error } = await supabase.from("products").update({ is_available: isAvailable }).in("slug", selectedProductSlugs);
    setBusy(false);
    setNotice(error ? error.message : `Готово: ${selectedProductSlugs.length} товарів ${isAvailable ? "показано" : "приховано"}.`);
    if (!error) { setSelectedProductSlugs([]); await load(); }
  }
  async function moveSelectedProducts() {
    const collection = collections.find((item) => item.id === bulkCollectionId);
    const brand = collection && brands.find((item) => item.id === collection.brand_id);
    if (!collection || !brand || !selectedProductSlugs.length) return setNotice("Оберіть колекцію для перенесення.");
    if (!window.confirm(`Перенести ${selectedProductSlugs.length} товарів до «${brand.name} — ${collection.name}»?`)) return;
    setBusy(true);
    const { error } = await supabase.from("products").update({ brand: brand.name, collection: collection.name, category: collection.category }).in("slug", selectedProductSlugs);
    setBusy(false);
    setNotice(error ? error.message : `Готово: ${selectedProductSlugs.length} товарів перенесено до колекції «${collection.name}».`);
    if (!error) { setSelectedProductSlugs([]); setBulkCollectionId(""); await load(); }
  }

  if (!ready) return <div className="grid min-h-44 place-items-center rounded-2xl border bg-white text-sm text-stone-500"><span className="inline-flex items-center gap-2"><LoaderCircle className="animate-spin" size={17} /> Завантажуємо структуру…</span></div>;

  return <section className="rounded-2xl border bg-white p-4 shadow-sm sm:p-5">
    <div className="flex flex-wrap items-start justify-between gap-3"><div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">Повне керування</p><h3 className="mt-1 font-display text-3xl">Структура каталогу</h3><p className="mt-2 max-w-2xl text-sm leading-6 text-stone-500">Додавайте, редагуйте, приховуйте або видаляйте фабрики, колекції й товари. Видалення захищене: структура не зникне, поки в ній є товари.</p></div></div>
    <div className="mt-5 flex gap-2 overflow-x-auto pb-1">{([["brands", "Фабрики", <Building2 key="b" size={16} />], ["collections", "Колекції", <FolderTree key="c" size={16} />], ["products", "Товари", <PackagePlus key="p" size={16} />]] as const).map(([id, label, icon]) => <button key={id} onClick={() => setTab(id)} className={"inline-flex shrink-0 items-center gap-2 rounded-full px-4 py-2 text-sm font-bold " + (tab === id ? "bg-ink text-white" : "border bg-white text-stone-600")}>{icon}{label}</button>)}</div>
    {tab === "brands" && <div className="mt-5 grid gap-5 xl:grid-cols-[minmax(0,1fr)_360px]"><div className="space-y-2">{brands.map((item) => <div key={item.id} className="flex items-center justify-between gap-3 rounded-xl border border-stone-200 bg-stone-50 p-3"><span><b className="block text-sm">{item.name}</b><span className="text-xs text-stone-500">{item.is_active ? "Активна" : "Прихована"} · {products.filter((product) => product.brand === item.name).length} товарів</span></span><span className="flex gap-2"><button className="button-light px-3 py-2 text-xs" onClick={() => startBrand(item)}><Pencil size={14} /> Змінити</button><button className="button-light px-3 py-2 text-xs text-red-600" onClick={() => removeBrand(item)}><Trash2 size={14} /></button></span></div>)}{!brands.length && <p className="rounded-xl bg-stone-50 p-4 text-sm text-stone-500">Фабрик ще немає.</p>}</div><form onSubmit={saveBrand} className="rounded-xl border border-stone-200 bg-stone-50 p-4"><b>{editBrandId ? "Редагувати фабрику" : "Додати фабрику"}</b><label className="mt-3 block text-sm font-bold">Назва<input className={inputClass} value={brandDraft.name} onChange={(event) => setBrandDraft({ ...brandDraft, name: event.target.value })} placeholder="Наприклад: Rodos" /></label><label className="mt-3 block text-sm font-bold">Короткий опис<textarea className={inputClass + " min-h-20 resize-y"} value={brandDraft.description} onChange={(event) => setBrandDraft({ ...brandDraft, description: event.target.value })} /></label><label className="mt-3 block text-sm font-bold">Фото / обкладинка<input className={inputClass} value={brandDraft.image_path || ""} onChange={(event) => setBrandDraft({ ...brandDraft, image_path: event.target.value })} /></label><label className="mt-3 inline-flex items-center gap-2 text-sm font-bold"><input type="checkbox" checked={brandDraft.is_active} onChange={(event) => setBrandDraft({ ...brandDraft, is_active: event.target.checked })} /> Показувати фабрику</label><div className="mt-4 flex gap-2"><button disabled={busy} className="button-primary"><Save size={16} /> Зберегти</button><button type="button" className="button-light" onClick={() => startBrand()}>Очистити</button></div></form></div>}
    {tab === "collections" && <div className="mt-5 grid gap-5 xl:grid-cols-[minmax(0,1fr)_360px]"><div className="space-y-2">{collections.map((item) => { const brand = brands.find((entry) => entry.id === item.brand_id); return <div key={item.id} className="flex items-center justify-between gap-3 rounded-xl border border-stone-200 bg-stone-50 p-3"><span><b className="block text-sm">{item.name}</b><span className="text-xs text-stone-500">{brand?.name || "Без фабрики"} · {categoryName(item.category)} · {item.is_active ? "Активна" : "Прихована"}</span></span><span className="flex gap-2"><button className="button-light px-3 py-2 text-xs" onClick={() => startCollection(item)}><Pencil size={14} /> Змінити</button><button className="button-light px-3 py-2 text-xs text-red-600" onClick={() => removeCollection(item)}><Trash2 size={14} /></button></span></div>; })}{!collections.length && <p className="rounded-xl bg-stone-50 p-4 text-sm text-stone-500">Колекцій ще немає.</p>}</div><form onSubmit={saveCollection} className="rounded-xl border border-stone-200 bg-stone-50 p-4"><b>{editCollectionId ? "Редагувати колекцію" : "Додати колекцію"}</b><label className="mt-3 block text-sm font-bold">Фабрика<select className={inputClass} value={collectionDraft.brand_id} onChange={(event) => setCollectionDraft({ ...collectionDraft, brand_id: event.target.value })}><option value="">Оберіть фабрику</option>{brands.map((item) => <option key={item.id} value={item.id}>{item.name}</option>)}</select></label><label className="mt-3 block text-sm font-bold">Розділ<select className={inputClass} value={collectionDraft.category} onChange={(event) => setCollectionDraft({ ...collectionDraft, category: event.target.value as Collection["category"] })}>{categories.map((item) => <option key={item.value} value={item.value}>{item.label}</option>)}</select></label><label className="mt-3 block text-sm font-bold">Назва колекції<input className={inputClass} value={collectionDraft.name} onChange={(event) => setCollectionDraft({ ...collectionDraft, name: event.target.value })} placeholder="Наприклад: DELUX" /></label><label className="mt-3 block text-sm font-bold">Опис<textarea className={inputClass + " min-h-20 resize-y"} value={collectionDraft.description} onChange={(event) => setCollectionDraft({ ...collectionDraft, description: event.target.value })} /></label><label className="mt-3 inline-flex items-center gap-2 text-sm font-bold"><input type="checkbox" checked={collectionDraft.is_active} onChange={(event) => setCollectionDraft({ ...collectionDraft, is_active: event.target.checked })} /> Показувати колекцію</label><div className="mt-4 flex gap-2"><button disabled={busy} className="button-primary"><Save size={16} /> Зберегти</button><button type="button" className="button-light" onClick={() => startCollection()}>Очистити</button></div></form></div>}
    {tab === "products" && <div className="mt-5 grid gap-5 xl:grid-cols-[minmax(0,1fr)_400px]"><div><div className="mb-3 rounded-xl border border-stone-200 bg-sand/50 p-3"><div className="flex flex-wrap items-center justify-between gap-2"><p className="text-sm font-bold">{selectedCount ? `Вибрано: ${selectedCount}` : "Масові дії з товарами"}</p><div className="flex gap-2"><button type="button" className="text-xs font-bold text-clay" onClick={() => setSelectedProductSlugs(products.map((item) => item.slug))}>Вибрати всі</button>{selectedCount > 0 && <button type="button" className="inline-flex items-center gap-1 text-xs font-bold text-stone-600" onClick={() => setSelectedProductSlugs([])}><X size={14} /> Очистити</button>}</div></div>{selectedCount > 0 && <div className="mt-3 grid gap-2 sm:grid-cols-2"><button type="button" disabled={busy} onClick={() => setSelectedAvailability(true)} className="button-light justify-center px-3 py-2 text-xs"><Eye size={15} /> Показати</button><button type="button" disabled={busy} onClick={() => setSelectedAvailability(false)} className="button-light justify-center px-3 py-2 text-xs"><EyeOff size={15} /> Приховати</button><select className="rounded-xl border border-stone-300 bg-white px-3 py-2 text-xs font-bold" value={bulkCollectionId} onChange={(event) => setBulkCollectionId(event.target.value)}><option value="">Перенести до колекції…</option>{collections.map((item) => { const itemBrand = brands.find((brand) => brand.id === item.brand_id); return <option key={item.id} value={item.id}>{itemBrand?.name || ""} — {item.name}</option>; })}</select><button type="button" disabled={busy || !bulkCollectionId} onClick={moveSelectedProducts} className="button-primary justify-center px-3 py-2 text-xs"><FolderInput size={15} /> Перенести</button></div>}<p className="mt-2 text-xs leading-5 text-stone-500">Масове перенесення змінює фабрику, колекцію та розділ. Перед дією адмінка попросить підтвердження.</p></div><div className="max-h-[55vh] space-y-2 overflow-y-auto pr-1">{products.map((item) => <div key={item.slug} className={"flex items-center justify-between gap-3 rounded-xl border p-3 " + (selectedProductSlugs.includes(item.slug) ? "border-clay bg-sand" : "border-stone-200 bg-stone-50")}><label className="flex min-w-0 cursor-pointer items-center gap-3"><input type="checkbox" checked={selectedProductSlugs.includes(item.slug)} onChange={() => toggleProduct(item.slug)} aria-label={`Вибрати ${item.name}`} /><span><b className="block text-sm">{item.name}</b><span className="text-xs text-stone-500">{item.brand} · {item.collection} · {item.is_available ? "В каталозі" : "Чернетка"}</span></span></label><span className="flex shrink-0 gap-2"><button className="button-light px-3 py-2 text-xs" onClick={() => startProduct(item)}><Pencil size={14} /> Змінити</button><button className="button-light px-3 py-2 text-xs text-red-600" onClick={() => removeProduct(item)}><Trash2 size={14} /></button></span></div>)}</div></div><form onSubmit={saveProduct} className="rounded-xl border border-stone-200 bg-stone-50 p-4"><b>{editProductSlug ? "Редагувати товар" : "Створити товар-чернетку"}</b><p className="mt-2 text-xs leading-5 text-stone-500">Чернетка не з’явиться на сайті, доки не увімкнете показ у каталозі.</p><label className="mt-3 block text-sm font-bold">Назва моделі<input className={inputClass} value={productDraft.name} onChange={(event) => setProductDraft({ ...productDraft, name: event.target.value })} /></label><label className="mt-3 block text-sm font-bold">URL-код товару (необов’язково)<input className={inputClass} value={productDraft.slug} onChange={(event) => setProductDraft({ ...productDraft, slug: event.target.value })} placeholder="Створиться автоматично" /></label><div className="mt-3 grid gap-3 sm:grid-cols-2"><label className="text-sm font-bold">Фабрика<select className={inputClass} value={productDraft.brand} onChange={(event) => setProductDraft({ ...productDraft, brand: event.target.value, collection: "" })}><option value="">Оберіть фабрику</option>{brands.map((item) => <option key={item.id}>{item.name}</option>)}</select></label><label className="text-sm font-bold">Розділ<select className={inputClass} value={productDraft.category} onChange={(event) => setProductDraft({ ...productDraft, category: event.target.value as Product["category"], collection: "" })}>{categories.map((item) => <option key={item.value} value={item.value}>{item.label}</option>)}</select></label></div><label className="mt-3 block text-sm font-bold">Колекція<select className={inputClass} value={productDraft.collection} onChange={(event) => setProductDraft({ ...productDraft, collection: event.target.value })}><option value="">Оберіть колекцію</option>{productCollections.map((item) => <option key={item.id}>{item.name}</option>)}</select></label><label className="mt-3 block text-sm font-bold">Ціна<input className={inputClass} value={productDraft.price} onChange={(event) => setProductDraft({ ...productDraft, price: event.target.value })} /></label><label className="mt-3 block text-sm font-bold">Опис<textarea className={inputClass + " min-h-20 resize-y"} value={productDraft.description} onChange={(event) => setProductDraft({ ...productDraft, description: event.target.value })} /></label><label className="mt-3 block text-sm font-bold">Головне фото<input className={inputClass} value={productDraft.image_path} onChange={(event) => setProductDraft({ ...productDraft, image_path: event.target.value })} placeholder="Додайте після створення або вставте шлях" /></label><label className="mt-3 inline-flex items-center gap-2 text-sm font-bold"><input type="checkbox" checked={productDraft.is_available} onChange={(event) => setProductDraft({ ...productDraft, is_available: event.target.checked })} /> Показувати товар у каталозі</label><div className="mt-4 flex gap-2"><button disabled={busy} className="button-primary"><Save size={16} /> Зберегти</button><button type="button" className="button-light" onClick={() => startProduct()}>Очистити</button></div></form></div>}
    {notice && <p className="mt-5 rounded-xl bg-sand p-3 text-sm text-stone-700">{notice}</p>}
  </section>;
}
