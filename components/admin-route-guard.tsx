"use client";

import Link from "next/link";
import { type FormEvent, type ReactNode, useEffect, useMemo, useState } from "react";
import { LoaderCircle, LogOut, ShieldCheck } from "lucide-react";
import type { Session } from "@supabase/supabase-js";
import { adminEmail, getSupabaseBrowserClient } from "@/lib/supabase-browser";

const inputClass = "mt-1 w-full rounded-xl border border-stone-300 bg-white px-3 py-2.5 text-sm outline-none transition focus:border-clay focus:ring-2 focus:ring-clay/20";

export function AdminRouteGuard({ children }: { children: ReactNode }) {
  const supabase = useMemo(() => getSupabaseBrowserClient(), []);
  const [session, setSession] = useState<Session | null>(null);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [notice, setNotice] = useState("");
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const isAdmin = session?.user.email === adminEmail;

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => { setSession(data.session); setLoading(false); });
    const { data: listener } = supabase.auth.onAuthStateChange((_event, next) => setSession(next));
    return () => listener.subscription.unsubscribe();
  }, [supabase]);

  async function passwordLogin(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setSaving(true);
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    setSaving(false);
    setNotice(error ? "Не вдалося увійти. Перевірте пошту й пароль." : "");
  }

  async function magicLogin() {
    if (!email) { setNotice("Спершу введіть електронну пошту."); return; }
    setSaving(true);
    const { error } = await supabase.auth.signInWithOtp({ email, options: { emailRedirectTo: window.location.origin + "/admin" } });
    setSaving(false);
    setNotice(error ? error.message : "Посилання для входу надіслано на пошту.");
  }

  if (loading) return <main className="grid min-h-screen place-items-center bg-stone-50 text-stone-600"><span className="inline-flex items-center gap-2"><LoaderCircle className="animate-spin" size={18} /> Завантаження…</span></main>;
  if (!session) return <main className="grid min-h-screen place-items-center bg-stone-50 p-5"><form onSubmit={passwordLogin} className="w-full max-w-md rounded-3xl border bg-white p-7 shadow-lg"><ShieldCheck className="text-clay" size={30} /><p className="mt-5 text-xs font-bold uppercase tracking-[.16em] text-clay">Адмінка каталогу</p><h1 className="mt-2 font-display text-4xl">Наші двері</h1><p className="mt-3 text-sm leading-6 text-stone-600">Увійдіть за поштою й паролем адміністратора.</p><label className="mt-6 block text-sm font-bold">Електронна пошта<input className={inputClass} type="email" required value={email} onChange={(event) => setEmail(event.target.value)} placeholder="name@example.com" /></label><label className="mt-4 block text-sm font-bold">Пароль<input className={inputClass} type="password" required value={password} onChange={(event) => setPassword(event.target.value)} placeholder="Ваш пароль" /></label><button className="button-primary mt-5 w-full" disabled={saving}>{saving ? "Вхід…" : "Увійти"}</button><div className="mt-5 border-t pt-5 text-center"><p className="text-xs leading-5 text-stone-500">Забули пароль або ще не створювали його?</p><button type="button" onClick={magicLogin} className="mt-2 text-sm font-bold text-clay hover:text-ink">Надіслати одноразове посилання</button></div>{notice && <p className="mt-4 rounded-xl bg-sand p-3 text-sm">{notice}</p>}</form></main>;
  if (!isAdmin) return <main className="grid min-h-screen place-items-center bg-stone-50 p-5"><div className="max-w-md rounded-3xl bg-white p-7 text-center shadow-lg"><ShieldCheck className="mx-auto text-clay" size={32} /><h1 className="mt-4 font-display text-3xl">Немає доступу</h1><p className="mt-3 text-sm text-stone-600">Ця пошта не додана до адміністраторів каталогу.</p><button className="button-light mt-6" onClick={() => supabase.auth.signOut()}>Вийти</button></div></main>;

  return <main className="min-h-screen bg-stone-50 text-ink"><header className="sticky top-0 z-20 border-b bg-white/95 backdrop-blur"><div className="mx-auto flex max-w-7xl flex-wrap items-center justify-between gap-3 px-4 py-3 sm:px-6"><Link href="/admin" className="shrink-0"><p className="text-[11px] font-bold uppercase tracking-[.16em] text-clay">Закрита адмінка</p><p className="font-display text-xl">Наші двері</p></Link><nav className="order-3 flex w-full gap-1 overflow-x-auto pb-1 text-sm font-bold sm:order-none sm:w-auto sm:pb-0"><Link className="shrink-0 rounded-full px-3 py-2 hover:bg-sand" href="/admin">Огляд</Link><Link className="shrink-0 rounded-full px-3 py-2 hover:bg-sand" href="/admin/catalog">Товари</Link><Link className="shrink-0 rounded-full px-3 py-2 hover:bg-sand" href="/admin/leads">Заявки</Link><Link className="shrink-0 rounded-full px-3 py-2 hover:bg-sand" href="/admin/structure">Структура</Link></nav><button onClick={() => supabase.auth.signOut()} className="button-light px-3 py-2 text-sm"><LogOut size={16} /> Вийти</button></div></header><div className="mx-auto max-w-7xl p-4 sm:p-6">{children}</div></main>;
}
