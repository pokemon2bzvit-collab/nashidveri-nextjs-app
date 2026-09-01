"use client";

import { LoaderCircle, X } from "lucide-react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { useState } from "react";

const schema = z.object({
  name: z.string().min(2, "Вкажіть ваше ім’я"),
  phone: z.string().regex(/^\+380\d{9}$/, "Вкажіть номер формату +380XXXXXXXXX"),
  contactMethod: z.enum(["phone", "viber", "telegram"]),
  consent: z.literal(true, { errorMap: () => ({ message: "Потрібна згода на обробку даних." }) }),
  website: z.string().max(0).optional(),
});
type Values = z.infer<typeof schema>;

export function MeasureModal({ open, onClose }: { open: boolean; onClose: () => void }) {
  const [serverError, setServerError] = useState("");
  const { register, handleSubmit, reset, formState: { errors, isSubmitting } } = useForm<Values>({
    resolver: zodResolver(schema),
    defaultValues: { phone: "+380", contactMethod: "phone", website: "" },
  });
  if (!open) return null;

  async function submit(values: Values) {
    setServerError("");
    const response = await fetch("/api/leads", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ ...values, requestType: "measurement", sourcePath: window.location.pathname }),
    });
    const result = await response.json();
    if (!response.ok) {
      setServerError(result.message || "Не вдалося надіслати заявку.");
      return;
    }
    reset({ phone: "+380", contactMethod: "phone", website: "" });
    onClose();
  }

  return <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/45 p-5" role="dialog" aria-modal="true" aria-labelledby="measure-title">
    <form onSubmit={handleSubmit(submit)} className="relative w-full max-w-md rounded-2xl bg-white p-6 shadow-2xl sm:p-7">
      <button aria-label="Закрити" type="button" onClick={onClose} className="absolute right-5 top-5 text-stone-500"><X /></button>
      <p className="eyebrow">Безкоштовний замір</p>
      <h2 id="measure-title" className="mt-3 font-display text-3xl">Узгодимо зручний час</h2>
      <p className="mt-3 text-sm leading-6 text-stone-500">Залиште контакти — менеджер зв’яжеться з вами для запису на замір.</p>
      <input className="hidden" tabIndex={-1} autoComplete="off" {...register("website")} />
      <label className="mt-5 block text-sm font-bold">Ваше ім’я<input autoFocus className="mt-1 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" {...register("name")} /></label>
      {errors.name && <p className="mt-1 text-xs text-red-600">{errors.name.message}</p>}
      <label className="mt-4 block text-sm font-bold">Телефон<input className="mt-1 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" {...register("phone")} /></label>
      {errors.phone && <p className="mt-1 text-xs text-red-600">{errors.phone.message}</p>}
      <label className="mt-4 block text-sm font-bold">Як з вами зв’язатися<select className="mt-1 w-full rounded-xl border px-4 py-3 outline-none focus:border-clay" {...register("contactMethod")}><option value="phone">Телефоном</option><option value="viber">Viber</option><option value="telegram">Telegram</option></select></label>
      <label className="mt-4 flex items-start gap-2 text-xs leading-5 text-stone-600"><input className="mt-1" type="checkbox" {...register("consent")} /> Погоджуюся на обробку контактних даних для відповіді на заявку.</label>
      {errors.consent && <p className="mt-1 text-xs text-red-600">{errors.consent.message}</p>}
      {serverError && <p className="mt-4 rounded-xl bg-red-50 p-3 text-sm text-red-700">{serverError}</p>}
      <button className="button-primary mt-5 w-full" disabled={isSubmitting} type="submit">{isSubmitting ? <><LoaderCircle className="animate-spin" size={17} /> Надсилання…</> : "Замовити замір"}</button>
    </form>
  </div>;
}
