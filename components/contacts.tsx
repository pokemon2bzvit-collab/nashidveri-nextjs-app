"use client";

import { Facebook, Instagram, LoaderCircle, Mail, MapPin, Phone } from "lucide-react";
import Link from "next/link";
import { BrandMark } from "./brand-mark";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { useState } from "react";

const schema = z.object({
  name: z.string().min(2, "Вкажіть ваше ім’я"),
  phone: z.string().regex(/^\+380\d{9}$/, "Формат: +380XXXXXXXXX"),
  message: z.string().min(5, "Напишіть трохи більше деталей").max(1200),
  contactMethod: z.enum(["phone", "viber", "telegram"]),
  consent: z.literal(true, { errorMap: () => ({ message: "Потрібна згода на обробку даних." }) }),
  website: z.string().max(0).optional(),
});
type Contact = z.infer<typeof schema>;

export function Contacts() {
  const [serverError, setServerError] = useState("");
  const [sent, setSent] = useState(false);
  const { register, handleSubmit, reset, formState: { errors, isSubmitting } } = useForm<Contact>({
    resolver: zodResolver(schema),
    defaultValues: { phone: "+380", contactMethod: "phone", website: "" },
  });
  async function submit(values: Contact) {
    setServerError("");
    const response = await fetch("/api/leads", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ ...values, requestType: "contact_form", sourcePath: window.location.pathname }),
    });
    const result = await response.json();
    if (!response.ok) {
      setServerError(result.message || "Не вдалося надіслати повідомлення.");
      return;
    }
    setSent(true);
    reset({ phone: "+380", contactMethod: "phone", website: "" });
  }
  return <section id="contacts" className="bg-sand py-16 sm:py-24"><div className="container-page grid gap-10 lg:grid-cols-2"><div><p className="eyebrow">Контакти</p><h2 className="heading mt-3">Завітайте до нас<br />у салон</h2><div className="mt-8 space-y-5">{[[MapPin, "вул. Івана Чендея, 44, Ужгород, 88000"], [Phone, "+38 (095) 072-93-41 · +38 (068) 815-54-08"], [Mail, "nashidveri.uzh@gmail.com"]].map(([Icon, text]) => { const IconComp = Icon as typeof MapPin; return <div key={text as string} className="flex gap-4"><span className="rounded-full bg-white p-3 text-clay"><IconComp size={20} /></span><span className="pt-2 text-sm font-medium leading-6">{text as string}</span></div>; })}</div><div className="mt-8 overflow-hidden rounded-2xl bg-[#d8d0c0] p-6 sm:p-8"><MapPin className="text-clay" /><p className="mt-16 font-display text-3xl">Наш салон<br />на карті Ужгорода</p><a target="_blank" rel="noreferrer" className="mt-3 inline-block text-sm font-bold underline" href="https://www.google.com/maps/search/?api=1&query=вул.+Івана+Чендея,+44,+Ужгород,+88000">Відкрити маршрут →</a></div></div><form onSubmit={handleSubmit(submit)} className="rounded-2xl bg-white p-6 shadow-soft sm:p-8"><h3 className="font-display text-3xl">Напишіть нам</h3><p className="mt-2 text-sm text-stone-500">Допоможемо вибрати та відповімо на запитання.</p><input className="hidden" tabIndex={-1} autoComplete="off" {...register("website")} /><label className="mt-7 block text-sm font-semibold">Ваше ім’я<input className="mt-2 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" {...register("name")} /></label>{errors.name && <p className="mt-1 text-xs text-red-600">{errors.name.message}</p>}<label className="mt-4 block text-sm font-semibold">Телефон<input className="mt-2 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" {...register("phone")} /></label>{errors.phone && <p className="mt-1 text-xs text-red-600">{errors.phone.message}</p>}<label className="mt-4 block text-sm font-semibold">Як з вами зв’язатися<select className="mt-2 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" {...register("contactMethod")}><option value="phone">Телефоном</option><option value="viber">Viber</option><option value="telegram">Telegram</option></select></label><label className="mt-4 block text-sm font-semibold">Повідомлення<textarea rows={3} className="mt-2 w-full resize-none rounded-xl border px-4 py-3 outline-none focus:border-clay" placeholder="Наприклад, хочу підібрати двері…" {...register("message")} /></label>{errors.message && <p className="mt-1 text-xs text-red-600">{errors.message.message}</p>}<label className="mt-4 flex items-start gap-2 text-xs leading-5 text-stone-600"><input className="mt-1" type="checkbox" {...register("consent")} /> Погоджуюся на обробку контактних даних для відповіді на заявку.</label>{errors.consent && <p className="mt-1 text-xs text-red-600">{errors.consent.message}</p>}{serverError && <p className="mt-4 rounded-lg bg-red-50 p-3 text-sm text-red-700">{serverError}</p>}{sent && <p className="mt-4 rounded-lg bg-green-50 p-3 text-sm text-pine">Дякуємо! Менеджер зв’яжеться з вами найближчим часом.</p>}<button className="button-primary mt-6 w-full" disabled={isSubmitting} type="submit">{isSubmitting ? <><LoaderCircle className="animate-spin" size={17} /> Надсилання…</> : "Надіслати повідомлення"}</button></form></div></section>;
}

export function Footer() {
  const links = [["Головна", "/"], ["Міжкімнатні двері", "/mizhkimnatni-dveri"], ["Вхідні двері", "/vhidni-dveri"], ["Вікна", "/vikna"], ["Про нас", "/pro-nas"], ["Контакти", "/contacts"]] as const;
  return <footer className="border-t border-stone-200 bg-sand pb-24 pt-12 text-stone-600 sm:pb-10 sm:pt-14"><div className="container-page grid gap-10 sm:grid-cols-2 lg:grid-cols-[1.25fr_1fr_1fr]"><div><BrandMark /><p className="mt-4 max-w-xs text-sm leading-6">Гарантія вашого затишку. Двері й вікна з професійним підбором та монтажем в Ужгороді.</p><div className="mt-5 flex gap-3"><a aria-label="Facebook" href="https://www.facebook.com/nashidveriuz" target="_blank" rel="noreferrer" className="rounded-full border border-stone-300 bg-white p-2.5 transition hover:border-clay hover:text-clay"><Facebook size={18} /></a><a aria-label="Instagram" href="https://www.instagram.com/nashi_dveri_uzh/" target="_blank" rel="noreferrer" className="rounded-full border border-stone-300 bg-white p-2.5 transition hover:border-clay hover:text-clay"><Instagram size={18} /></a></div></div><div><p className="text-xs font-bold uppercase tracking-[.14em] text-stone-400">Навігація</p><nav className="mt-4 grid gap-3 text-sm font-medium">{links.map(([label, href]) => <Link key={href} href={href} className="w-fit transition hover:text-clay">{label}</Link>)}</nav></div><div><p className="text-xs font-bold uppercase tracking-[.14em] text-stone-400">Зв’язок</p><div className="mt-4 grid gap-3 text-sm font-medium"><a href="tel:+380950729341" className="flex w-fit items-center gap-2 transition hover:text-clay"><Phone size={16} className="text-clay" />+38 (095) 072-93-41</a><a href="mailto:nashidveri.uzh@gmail.com" className="flex w-fit items-center gap-2 transition hover:text-clay"><Mail size={16} className="text-clay" />Написати нам</a><Link href="/contacts" className="mt-2 inline-flex w-fit items-center rounded-full bg-ink px-4 py-2.5 text-xs font-bold text-white transition hover:bg-clay">Замовити замір</Link></div></div></div><div className="container-page mt-10 flex flex-col gap-2 border-t border-stone-200 pt-5 text-xs text-stone-500 sm:flex-row sm:items-center sm:justify-between"><span>© НАШІ ДВЕРІ. Всі права застережено</span><span>Ужгород · вул. Івана Чендея, 44</span></div></footer>;
}
