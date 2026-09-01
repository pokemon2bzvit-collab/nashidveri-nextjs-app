"use client";

import { useEffect, useMemo, useState } from "react";
import { ClipboardList, LoaderCircle, Phone, RefreshCw, Save } from "lucide-react";
import { getSupabaseBrowserClient } from "@/lib/supabase-browser";

type Lead = { id: string; created_at: string; name: string; phone: string; contact_method: string; message: string | null; request_type: string; product_name: string | null; status: string };
const statusLabels: Record<string, string> = { new: "Нова", in_progress: "У роботі", measurement: "Замір", offer_sent: "Прорахунок надіслано", won: "Успішно", lost: "Відмова" };
const typeLabels: Record<string, string> = { measurement: "Замір", price_request: "Прорахунок моделі", contact_form: "Повідомлення", consultation: "Консультація" };

export function LeadsDashboard() {
  const supabase = useMemo(() => getSupabaseBrowserClient(), []);
  const [leads, setLeads] = useState<Lead[]>([]);
  const [loading, setLoading] = useState(true);
  const [notice, setNotice] = useState("");
  async function load() {
    setLoading(true);
    const { data, error } = await supabase.from("leads").select("id,created_at,name,phone,contact_method,message,request_type,product_name,status").order("created_at", { ascending: false }).limit(100);
    setLoading(false);
    if (error) setNotice("Спершу виконайте SQL-файл leads-management.sql у Supabase. " + error.message);
    else { setLeads((data || []) as Lead[]); setNotice(""); }
  }
  useEffect(() => { load(); }, []);
  async function setStatus(id: string, status: string) {
    const { error } = await supabase.from("leads").update({ status, updated_at: new Date().toISOString() }).eq("id", id);
    if (error) setNotice(error.message);
    else setLeads((items) => items.map((item) => item.id === id ? { ...item, status } : item));
  }
  return <section className="mt-5 rounded-2xl border bg-white p-4 shadow-sm sm:p-5"><div className="flex flex-wrap items-center justify-between gap-3"><div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">Звернення клієнтів</p><h3 className="mt-1 flex items-center gap-2 font-display text-3xl"><ClipboardList size={24} /> Заявки</h3></div><button onClick={load} className="button-light px-3 py-2 text-sm"><RefreshCw size={15} /> Оновити</button></div>{loading ? <div className="grid min-h-32 place-items-center text-sm text-stone-500"><span className="inline-flex items-center gap-2"><LoaderCircle className="animate-spin" size={17} /> Завантаження…</span></div> : <div className="mt-5 space-y-3">{leads.map((lead) => <article key={lead.id} className="rounded-xl border border-stone-200 bg-stone-50 p-4"><div className="flex flex-wrap items-start justify-between gap-3"><div><b>{lead.name}</b><p className="mt-1 flex items-center gap-1 text-sm text-stone-600"><Phone size={14} /> <a className="underline hover:text-clay" href={"tel:" + lead.phone}>{lead.phone}</a> · {lead.contact_method === "phone" ? "дзвінок" : lead.contact_method}</p></div><span className="text-xs text-stone-500">{new Intl.DateTimeFormat("uk-UA", { dateStyle: "short", timeStyle: "short" }).format(new Date(lead.created_at))}</span></div><p className="mt-3 text-sm"><b>{typeLabels[lead.request_type] || lead.request_type}</b>{lead.product_name ? " · " + lead.product_name : ""}</p>{lead.message && <p className="mt-2 text-sm leading-6 text-stone-600">{lead.message}</p>}<label className="mt-3 flex max-w-xs items-center gap-2 text-xs font-bold text-stone-600">Статус<select className="w-full rounded-lg border border-stone-300 bg-white px-2 py-2 text-sm" value={lead.status} onChange={(event) => setStatus(lead.id, event.target.value)}>{Object.entries(statusLabels).map(([value, label]) => <option key={value} value={value}>{label}</option>)}</select></label></article>)}{!leads.length && !notice && <p className="rounded-xl bg-sand p-4 text-sm text-stone-600">Заявок ще немає.</p>}</div>}{notice && <p className="mt-4 rounded-xl bg-sand p-3 text-sm text-stone-700">{notice}</p>}</section>;
}
