"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { AlertTriangle, ArrowRight, ClipboardList, FileImage, LoaderCircle, Package, PencilLine, Settings2, ShieldCheck } from "lucide-react";
import { AdminRouteGuard } from "@/components/admin-route-guard";
import { getSupabaseBrowserClient } from "@/lib/supabase-browser";

type Product = { slug: string; is_available: boolean; image_path: string | null; description: string | null };
type Lead = { id: string; name: string; phone: string; status: string; created_at: string; request_type: string };
type Stats = { total: number; published: number; withoutPhoto: number; withoutDescription: number; withoutSource: number };
const leadLabels: Record<string, string> = { measurement: "Замір", price_request: "Прорахунок", contact_form: "Повідомлення", consultation: "Консультація" };

function ActionCard({ href, icon, title, text, action }: { href: string; icon: React.ReactNode; title: string; text: string; action: string }) {
  return <Link href={href} className="group rounded-2xl border bg-white p-5 shadow-sm transition hover:-translate-y-0.5 hover:border-clay hover:shadow-md"><span className="grid size-11 place-items-center rounded-xl bg-sand text-clay">{icon}</span><h2 className="mt-5 font-display text-2xl">{title}</h2><p className="mt-2 min-h-12 text-sm leading-6 text-stone-600">{text}</p><span className="mt-5 inline-flex items-center gap-2 text-sm font-bold text-clay">{action}<ArrowRight className="transition group-hover:translate-x-1" size={16} /></span></Link>;
}

function AdminOverviewContent() {
  const supabase = useMemo(() => getSupabaseBrowserClient(), []);
  const [stats, setStats] = useState<Stats | null>(null);
  const [leads, setLeads] = useState<Lead[]>([]);
  const [leadsAvailable, setLeadsAvailable] = useState(true);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function load() {
      const [productsResult, sourcesResult, leadsResult] = await Promise.all([
        supabase.from("products").select("slug,is_available,image_path,description"),
        supabase.from("product_sources").select("product_slug"),
        supabase.from("leads").select("id,name,phone,status,created_at,request_type").order("created_at", { ascending: false }).limit(5),
      ]);
      const products = (productsResult.data || []) as Product[];
      const sourced = new Set((sourcesResult.data || []).map((item) => item.product_slug));
      setStats({ total: products.length, published: products.filter((item) => item.is_available).length, withoutPhoto: products.filter((item) => !item.image_path).length, withoutDescription: products.filter((item) => !item.description?.trim()).length, withoutSource: products.filter((item) => !sourced.has(item.slug)).length });
      if (leadsResult.error) setLeadsAvailable(false); else setLeads(leadsResult.data as Lead[] || []);
      setLoading(false);
    }
    load();
  }, [supabase]);

  return <><section className="rounded-3xl bg-ink px-5 py-8 text-white sm:px-8"><p className="text-xs font-bold uppercase tracking-[.16em] text-sand">Робоча панель</p><h1 className="mt-2 font-display text-4xl sm:text-5xl">Керування каталогом</h1><p className="mt-3 max-w-2xl text-sm leading-6 text-white/70 sm:text-base">Тут видно, що потребує уваги, і можна одразу перейти до товарів, заявок або структури каталогу.</p></section>
  {loading ? <div className="grid min-h-52 place-items-center"><span className="inline-flex items-center gap-2 text-sm text-stone-500"><LoaderCircle className="animate-spin" size={18} /> Оновлюємо дані…</span></div> : <><section className="mt-5 grid gap-3 sm:grid-cols-2 lg:grid-cols-4"><div className="rounded-2xl border bg-white p-4"><Package className="text-clay" size={20} /><b className="mt-4 block font-display text-3xl">{stats?.total || 0}</b><span className="text-sm text-stone-600">усього моделей</span></div><div className="rounded-2xl border bg-white p-4"><ShieldCheck className="text-clay" size={20} /><b className="mt-4 block font-display text-3xl">{stats?.published || 0}</b><span className="text-sm text-stone-600">показується в каталозі</span></div><Link href="/admin/leads" className="rounded-2xl border bg-white p-4 transition hover:border-clay"><ClipboardList className="text-clay" size={20} /><b className="mt-4 block font-display text-3xl">{leadsAvailable ? leads.length : "—"}</b><span className="text-sm text-stone-600">останні заявки</span></Link><Link href="/admin/catalog" className="rounded-2xl border bg-white p-4 transition hover:border-clay"><AlertTriangle className="text-clay" size={20} /><b className="mt-4 block font-display text-3xl">{(stats?.withoutPhoto || 0) + (stats?.withoutDescription || 0)}</b><span className="text-sm text-stone-600">товарів без даних</span></Link></section>
  <section className="mt-5 grid gap-4 md:grid-cols-2 xl:grid-cols-4"><ActionCard href="/admin/catalog" icon={<PencilLine size={21} />} title="Товари" text="Редагуйте опис, ціну, фото, декори, характеристики та джерела." action="Відкрити товари" /><ActionCard href="/admin/leads" icon={<ClipboardList size={21} />} title="Заявки" text="Передзвонюйте клієнтам і відмічайте етап роботи із заявкою." action="Відкрити заявки" /><ActionCard href="/admin/structure" icon={<Settings2 size={21} />} title="Структура" text="Керуйте фабриками, колекціями та складом каталогу." action="Відкрити структуру" /><ActionCard href="/admin/password" icon={<ShieldCheck size={21} />} title="Доступ" text="Змініть пароль адміністратора, якщо це потрібно." action="Налаштувати доступ" /></section>
  <section className="mt-5 grid gap-5 xl:grid-cols-[1.15fr_.85fr]"><div className="rounded-2xl border bg-white p-5 shadow-sm"><div className="flex items-center justify-between gap-3"><div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">Контроль якості</p><h2 className="mt-1 font-display text-3xl">Що варто доповнити</h2></div><Link className="text-sm font-bold text-clay" href="/admin/catalog">До товарів</Link></div><div className="mt-5 space-y-3"><div className="flex items-center justify-between rounded-xl bg-stone-50 px-4 py-3 text-sm"><span className="inline-flex items-center gap-2"><FileImage size={17} className="text-clay" /> Без головного фото</span><b>{stats?.withoutPhoto || 0}</b></div><div className="flex items-center justify-between rounded-xl bg-stone-50 px-4 py-3 text-sm"><span className="inline-flex items-center gap-2"><PencilLine size={17} className="text-clay" /> Без опису</span><b>{stats?.withoutDescription || 0}</b></div><div className="flex items-center justify-between rounded-xl bg-stone-50 px-4 py-3 text-sm"><span className="inline-flex items-center gap-2"><AlertTriangle size={17} className="text-clay" /> Без посилання на джерело</span><b>{stats?.withoutSource || 0}</b></div></div></div><div className="rounded-2xl border bg-white p-5 shadow-sm"><div className="flex items-center justify-between gap-3"><div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">Нові звернення</p><h2 className="mt-1 font-display text-3xl">Останні заявки</h2></div><Link className="text-sm font-bold text-clay" href="/admin/leads">Усі</Link></div>{!leadsAvailable ? <p className="mt-5 rounded-xl bg-sand p-4 text-sm leading-6 text-stone-700">Щоб увімкнути заявки, виконайте SQL-файл <b>supabase/leads-management.sql</b> у Supabase.</p> : <div className="mt-5 space-y-3">{leads.map((lead) => <Link key={lead.id} href="/admin/leads" className="block rounded-xl bg-stone-50 p-3 transition hover:bg-sand"><div className="flex justify-between gap-3"><b className="text-sm">{lead.name}</b><span className="text-xs text-stone-500">{leadLabels[lead.request_type] || lead.request_type}</span></div><p className="mt-1 text-sm text-stone-600">{lead.phone}</p></Link>)}{!leads.length && <p className="rounded-xl bg-stone-50 p-4 text-sm text-stone-600">Поки що заявок немає.</p>}</div>}</div></section></>}</>;
}

export function AdminOverview() { return <AdminRouteGuard><AdminOverviewContent /></AdminRouteGuard>; }
