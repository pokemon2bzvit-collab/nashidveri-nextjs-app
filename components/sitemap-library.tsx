"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { FileUp, LoaderCircle, Play, RefreshCw, Trash2 } from "lucide-react";
import { AdminRouteGuard } from "@/components/admin-route-guard";
import { getSupabaseBrowserClient } from "@/lib/supabase-browser";

type SitemapFile = { name: string; created_at: string | null };
const button = "inline-flex items-center justify-center gap-2 rounded-xl border border-stone-300 bg-white px-3 py-2.5 text-sm font-bold transition hover:border-clay disabled:cursor-not-allowed disabled:opacity-50";

function SitemapLibraryContent() {
  const supabase = useMemo(() => getSupabaseBrowserClient(), []);
  const [files, setFiles] = useState<SitemapFile[]>([]);
  const [busy, setBusy] = useState(false);
  const [notice, setNotice] = useState("");

  async function load() {
    setBusy(true);
    const { data, error } = await supabase.storage.from("admin-imports").list("sitemaps", { sortBy: { column: "created_at", order: "desc" } });
    setBusy(false);
    if (error) setNotice(error.message); else setFiles((data || []) as SitemapFile[]);
  }
  useEffect(() => { void load(); }, []);

  async function upload(file: File) {
    if (!/\.xml$/iu.test(file.name)) { setNotice("Оберіть XML-файл."); return; }
    setBusy(true);
    const path = "sitemaps/" + Date.now() + "-" + file.name.replace(/[^a-zA-Z0-9._-]/g, "-");
    const { error } = await supabase.storage.from("admin-imports").upload(path, file, { contentType: "application/xml" });
    setBusy(false);
    if (error) setNotice(error.message); else { setNotice("Sitemap збережено."); await load(); }
  }
  async function useForRodos(file: SitemapFile) {
    setBusy(true);
    const { data, error } = await supabase.storage.from("admin-imports").download("sitemaps/" + file.name);
    setBusy(false);
    if (error || !data) { setNotice(error?.message || "Не вдалося відкрити файл."); return; }
    sessionStorage.setItem("rodos-sitemap-xml", await data.text());
    window.location.assign("/admin/rodos-import");
  }
  async function remove(file: SitemapFile) {
    if (!window.confirm(`Видалити «${file.name}»?`)) return;
    setBusy(true);
    const { error } = await supabase.storage.from("admin-imports").remove(["sitemaps/" + file.name]);
    setBusy(false);
    if (error) setNotice(error.message); else { setNotice("Файл видалено."); await load(); }
  }

  return <section className="space-y-5">
    <div className="rounded-3xl bg-ink px-5 py-8 text-white sm:px-8">
      <p className="text-xs font-bold uppercase tracking-[.16em] text-sand">Джерела імпорту</p>
      <h1 className="mt-2 font-display text-4xl">Бібліотека sitemap-файлів</h1>
      <p className="mt-3 max-w-2xl text-sm leading-6 text-white/70">Зберігайте XML-карти сайтів виробників у приватному сховищі, а потім відкривайте їх в імпортері.</p>
      <div className="mt-5 flex flex-wrap gap-2">
        <label className={button + " cursor-pointer border-white/20 bg-white text-ink"}><FileUp size={16} /> Завантажити XML<input className="hidden" type="file" accept=".xml,text/xml,application/xml" onChange={(event) => { const file = event.target.files?.[0]; if (file) void upload(file); event.currentTarget.value = ""; }} /></label>
        <button className={button + " border-white/30 bg-transparent text-white hover:bg-white/10"} onClick={() => void load()} disabled={busy}><RefreshCw size={16} /> Оновити</button>
      </div>
    </div>
    {notice && <p role="status" className="rounded-xl border bg-white p-4 text-sm">{notice}</p>}
    <section className="rounded-2xl border bg-white p-5">
      <div className="flex items-center justify-between gap-3"><div><h2 className="font-display text-3xl">Збережені файли</h2><p className="mt-1 text-sm text-stone-600">Файли доступні лише адміністраторам.</p></div><Link href="/admin/importers" className="button-light">До імпортерів</Link></div>
      {busy && !files.length ? <p className="mt-5 inline-flex items-center gap-2 text-sm text-stone-500"><LoaderCircle className="animate-spin" size={17} /> Завантажуємо…</p> : <div className="mt-5 space-y-2">
        {files.map((file) => <div key={file.name} className="flex flex-wrap items-center justify-between gap-3 rounded-xl border border-stone-200 bg-stone-50 p-3"><div><b className="block text-sm">{file.name}</b><span className="text-xs text-stone-500">{file.created_at ? new Date(file.created_at).toLocaleString("uk-UA") : ""}</span></div><div className="flex gap-2"><button className="button-primary px-3 py-2 text-xs" onClick={() => void useForRodos(file)} disabled={busy}><Play size={14} /> В Rodos</button><button className="button-light px-3 py-2 text-xs" onClick={() => void remove(file)} disabled={busy} aria-label="Видалити"><Trash2 size={15} /></button></div></div>)}
        {!files.length && <p className="rounded-xl bg-stone-50 p-4 text-sm text-stone-500">Поки що файлів немає.</p>}
      </div>}
    </section>
  </section>;
}
export function SitemapLibrary() { return <AdminRouteGuard><SitemapLibraryContent /></AdminRouteGuard>; }
