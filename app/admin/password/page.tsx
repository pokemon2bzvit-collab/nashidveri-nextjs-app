"use client";

import { FormEvent, useEffect, useMemo, useState } from "react";
import { CheckCircle2, KeyRound, LoaderCircle } from "lucide-react";
import { adminEmail, getSupabaseBrowserClient } from "@/lib/supabase-browser";

export default function AdminPasswordPage() {
  const supabase = useMemo(() => getSupabaseBrowserClient(), []);
  const [loading, setLoading] = useState(true);
  const [allowed, setAllowed] = useState(false);
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [notice, setNotice] = useState("");
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => {
      setAllowed(data.session?.user.email === adminEmail);
      setLoading(false);
    });
  }, [supabase]);

  async function submit(event: FormEvent) {
    event.preventDefault();
    if (password.length < 10) return setNotice("Пароль має містити щонайменше 10 символів.");
    if (password !== confirmPassword) return setNotice("Паролі не збігаються.");
    setSaving(true);
    const { error } = await supabase.auth.updateUser({ password });
    setSaving(false);
    setNotice(error ? error.message : "Пароль збережено. Тепер у /admin можна входити за поштою та паролем.");
    if (!error) { setPassword(""); setConfirmPassword(""); }
  }

  if (loading) return <main className="grid min-h-screen place-items-center bg-stone-50 text-stone-600"><LoaderCircle className="animate-spin" /> Завантаження…</main>;
  if (!allowed) return <main className="grid min-h-screen place-items-center bg-stone-50 p-5"><div className="max-w-md rounded-3xl bg-white p-7 text-center shadow-lg"><KeyRound className="mx-auto text-clay" size={32} /><h1 className="mt-4 font-display text-3xl">Спочатку увійдіть</h1><p className="mt-3 text-sm leading-6 text-stone-600">Відкрийте /admin, отримайте одноразове посилання на свою пошту, увійдіть і поверніться сюди.</p></div></main>;
  return <main className="grid min-h-screen place-items-center bg-stone-50 p-5"><form onSubmit={submit} className="w-full max-w-md rounded-3xl border bg-white p-7 shadow-lg"><KeyRound className="text-clay" size={30} /><p className="mt-5 text-xs font-bold uppercase tracking-[.16em] text-clay">Безпека адмінки</p><h1 className="mt-2 font-display text-4xl">Створіть пароль</h1><p className="mt-3 text-sm leading-6 text-stone-600">Пароль зберігається у Supabase Auth. Він не потрапляє в код сайту чи GitHub.</p><label className="mt-6 block text-sm font-bold">Новий пароль<input className="mt-1 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" type="password" minLength={10} required value={password} onChange={(event) => setPassword(event.target.value)} /></label><label className="mt-4 block text-sm font-bold">Повторіть пароль<input className="mt-1 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" type="password" minLength={10} required value={confirmPassword} onChange={(event) => setConfirmPassword(event.target.value)} /></label><button className="button-primary mt-6 w-full" disabled={saving} type="submit">{saving ? <><LoaderCircle className="animate-spin" size={17} /> Збереження…</> : "Зберегти пароль"}</button>{notice && <p className="mt-4 rounded-xl bg-sand p-3 text-sm text-stone-700">{notice}</p>}<p className="mt-5 flex items-center gap-2 text-xs text-stone-500"><CheckCircle2 size={15} className="text-pine" /> Рекомендовано: 12+ символів і унікальний пароль.</p></form></main>;
}
