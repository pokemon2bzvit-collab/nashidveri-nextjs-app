"use client";

import { LoaderCircle, X } from "lucide-react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";

const schema = z.object({
  name: z.string().min(2, "Вкажіть ваше ім’я"),
  phone: z.string().regex(/^\+380\d{9}$/, "Вкажіть номер формату +380XXXXXXXXX"),
  contactMethod: z.enum(["phone", "viber", "telegram"]),
  message: z.string().max(800).optional(),
  consent: z.literal(true, { errorMap: () => ({ message: "Потрібна згода на обробку даних." }) }),
  website: z.string().max(0).optional(),
});
type Values = z.infer<typeof schema>;

export function ProductLeadButton({ productSlug, productName }: { productSlug: string; productName: string }) {
  const [open, setOpen] = useState(false);
  const [success, setSuccess] = useState(false);
  const [serverError, setServerError] = useState("");
  const { register, handleSubmit, reset, formState: { errors, isSubmitting } } = useForm<Values>({
    resolver: zodResolver(schema),
    defaultValues: { phone: "+380", contactMethod: "phone", website: "" },
  });
  async function submit(values: Values) {
    setServerError("");
    const response = await fetch("/api/leads", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ ...values, requestType: "price_request", productSlug, productName, sourcePath: window.location.pathname }),
    });
    const result = await response.json();
    if (!response.ok) return setServerError(result.message || "Не вдалося надіслати заявку.");
    reset({ phone: "+380", contactMethod: "phone", website: "" });
    setSuccess(true);
  }
  return <>
    <button className="button-primary" onClick={() => { setOpen(true); setSuccess(false); setServerError(""); }}>Дізнатися ціну</button>
    {open && <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/45 p-5" role="dialog" aria-modal="true" aria-labelledby="price-title">
      <form onSubmit={handleSubmit(submit)} className="relative w-full max-w-md rounded-2xl bg-white p-6 shadow-2xl sm:p-7">
        <button aria-label="Закрити" type="button" onClick={() => setOpen(false)} className="absolute right-5 top-5 text-stone-500"><X /></button>
        {success ? <div className="py-8 text-center"><p className="eyebrow">Заявку надіслано</p><h2 id="price-title" className="mt-3 font-display text-3xl">Дякуємо!</h2><p className="mt-3 text-sm leading-6 text-stone-600">Менеджер зв’яжеться з вами найближчим часом, щоб уточнити комплектацію та вартість.</p><button type="button" onClick={() => setOpen(false)} className="button-primary mt-6">Гаразд</button></div> : <>
          <p className="eyebrow">Прорахунок моделі</p>
          <h2 id="price-title" className="mt-3 font-display text-3xl">{productName}</h2>
          <p className="mt-3 text-sm leading-6 text-stone-500">Підкажемо ціну, доступні декори й комплектацію.</p>
          <input className="hidden" tabIndex={-1} autoComplete="off" {...register("website")} />
          <label className="mt-5 block text-sm font-bold">Ваше ім’я<input className="mt-1 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" {...register("name")} /></label>
          {errors.name && <p className="mt-1 text-xs text-red-600">{errors.name.message}</p>}
          <label className="mt-4 block text-sm font-bold">Телефон<input className="mt-1 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" {...register("phone")} /></label>
          {errors.phone && <p className="mt-1 text-xs text-red-600">{errors.phone.message}</p>}
          <label className="mt-4 block text-sm font-bold">Зручний зв’язок<select className="mt-1 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" {...register("contactMethod")}><option value="phone">Телефоном</option><option value="viber">Viber</option><option value="telegram">Telegram</option></select></label>
          <label className="mt-4 block text-sm font-bold">Коментар <span className="font-normal text-stone-400">(необов’язково)</span><textarea rows={3} className="mt-1 w-full resize-none rounded-xl border px-4 py-3 outline-none focus:border-clay" placeholder="Наприклад: потрібен монтаж" {...register("message")} /></label>
          <label className="mt-4 flex items-start gap-2 text-xs leading-5 text-stone-600"><input className="mt-1" type="checkbox" {...register("consent")} /> Погоджуюся на обробку контактних даних для відповіді на заявку.</label>
          {errors.consent && <p className="mt-1 text-xs text-red-600">{errors.consent.message}</p>}
          {serverError && <p className="mt-4 rounded-xl bg-red-50 p-3 text-sm text-red-700">{serverError}</p>}
          <button className="button-primary mt-5 w-full" disabled={isSubmitting} type="submit">{isSubmitting ? <><LoaderCircle className="animate-spin" size={17} /> Надсилання…</> : "Отримати прорахунок"}</button>
        </>}
      </form>
    </div>}
  </>;
}
