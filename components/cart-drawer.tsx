"use client";

import { LoaderCircle, Minus, Plus, Send, ShoppingBag, Trash2, X } from "lucide-react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { useCart } from "@/components/cart-provider";

const schema = z.object({
  name: z.string().min(2, "Вкажіть ваше ім’я"),
  phone: z.string().regex(/^\+380\d{9}$/, "Вкажіть номер формату +380XXXXXXXXX"),
  contactMethod: z.enum(["phone", "viber", "telegram"]),
  message: z.string().max(400, "Коментар має містити до 400 символів").optional(),
  consent: z.literal(true, { errorMap: () => ({ message: "Потрібна згода на обробку даних." }) }),
  website: z.string().max(0).optional(),
});
type Values = z.infer<typeof schema>;

export function CartDrawer() {
  const { items, isOpen, closeCart, removeItem, updateQuantity, clear } = useCart();
  const [success, setSuccess] = useState(false);
  const [serverError, setServerError] = useState("");
  const { register, handleSubmit, reset, formState: { errors, isSubmitting } } = useForm<Values>({ resolver: zodResolver(schema), defaultValues: { phone: "+380", contactMethod: "phone", website: "" } });

  async function submit(values: Values) {
    const models = items.map((item, index) => `${index + 1}. ${item.brand} ${item.name} (${item.collection}) — ${item.quantity} шт.`).join("\n");
    const message = [values.message?.trim(), "Товари для прорахунку:", models].filter(Boolean).join("\n\n").slice(0, 1200);
    setServerError("");
    const totalDoors = items.reduce((total, item) => total + item.quantity, 0);
    const response = await fetch("/api/leads", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ ...values, message, requestType: "price_request", productName: `Кошик: ${totalDoors} шт.`, sourcePath: window.location.pathname }) });
    const result = await response.json();
    if (!response.ok) return setServerError(result.message || "Не вдалося надіслати заявку.");
    clear();
    reset({ phone: "+380", contactMethod: "phone", website: "" });
    setSuccess(true);
  }

  const totalDoors = items.reduce((total, item) => total + item.quantity, 0);
  if (!isOpen) return null;
  return <div className="fixed inset-0 z-[60] bg-black/35" role="dialog" aria-modal="true" aria-labelledby="cart-title" onMouseDown={(event) => { if (event.target === event.currentTarget) closeCart(); }}>
    <aside className="ml-auto flex h-full w-full max-w-xl flex-col overflow-y-auto bg-white shadow-2xl">
      <header className="sticky top-0 z-10 flex items-center justify-between border-b border-stone-200 bg-white px-5 py-4"><div><p className="eyebrow">Прорахунок</p><h2 id="cart-title" className="mt-1 flex items-center gap-2 font-display text-3xl"><ShoppingBag size={24} /> Обрані моделі</h2></div><button type="button" onClick={closeCart} className="rounded-full p-2 text-stone-500 transition hover:bg-sand hover:text-ink" aria-label="Закрити кошик"><X /></button></header>
      {success ? <div className="m-auto max-w-sm p-7 text-center"><p className="eyebrow">Заявку надіслано</p><h3 className="mt-3 font-display text-3xl">Дякуємо!</h3><p className="mt-3 text-sm leading-6 text-stone-600">Ми отримали перелік моделей і зв’яжемося з вами для уточнення комплектації та вартості.</p><button type="button" className="button-primary mt-6" onClick={() => { setSuccess(false); closeCart(); }}>Гаразд</button></div> : !items.length ? <div className="m-auto max-w-sm p-7 text-center"><ShoppingBag className="mx-auto text-clay" size={34} /><h3 className="mt-4 font-display text-3xl">Кошик порожній</h3><p className="mt-3 text-sm leading-6 text-stone-600">Додайте моделі з картки товару — сформуємо одну заявку на прорахунок.</p><button type="button" className="button-primary mt-6" onClick={closeCart}>Закрити</button></div> : <form onSubmit={handleSubmit(submit)} className="p-5 sm:p-6"><div className="space-y-3">{items.map((item) => <article key={item.slug} className="flex gap-3 rounded-xl border border-stone-200 bg-stone-50 p-3"><img src={item.image} alt="" className="h-20 w-16 rounded-lg bg-white object-contain p-1" /><div className="min-w-0 flex-1"><p className="text-xs font-bold uppercase tracking-wide text-clay">{item.brand}</p><b className="mt-1 block text-sm leading-5">{item.name}</b><p className="mt-1 text-xs text-stone-500">Колекція {item.collection}</p><div className="mt-2 inline-flex items-center rounded-lg border border-stone-200 bg-white"><button type="button" onClick={() => updateQuantity(item.slug, item.quantity - 1)} className="p-1.5 text-stone-600 hover:text-clay" aria-label={`Зменшити кількість ${item.name}`}><Minus size={14} /></button><span className="min-w-8 text-center text-xs font-bold">{item.quantity}</span><button type="button" onClick={() => updateQuantity(item.slug, item.quantity + 1)} className="p-1.5 text-stone-600 hover:text-clay" aria-label={`Збільшити кількість ${item.name}`}><Plus size={14} /></button></div></div><button type="button" onClick={() => removeItem(item.slug)} className="h-9 rounded-lg p-2 text-stone-400 hover:bg-white hover:text-red-600" aria-label={`Прибрати ${item.name}`}><Trash2 size={17} /></button></article>)}</div><div className="mt-5 flex items-center justify-between border-t border-stone-200 pt-4"><b className="text-sm">{totalDoors} шт. для прорахунку</b><button type="button" onClick={clear} className="text-xs font-bold text-stone-500 hover:text-red-600">Очистити кошик</button></div><p className="mt-5 text-sm font-bold">Ваші контакти</p><input className="hidden" tabIndex={-1} autoComplete="off" {...register("website")} /><label className="mt-3 block text-sm font-bold">Ім’я<input className="mt-1 w-full rounded-xl border border-stone-300 px-3 py-2.5 text-sm outline-none focus:border-clay" {...register("name")} /></label>{errors.name && <p className="mt-1 text-xs text-red-600">{errors.name.message}</p>}<label className="mt-3 block text-sm font-bold">Телефон<input className="mt-1 w-full rounded-xl border border-stone-300 px-3 py-2.5 text-sm outline-none focus:border-clay" {...register("phone")} /></label>{errors.phone && <p className="mt-1 text-xs text-red-600">{errors.phone.message}</p>}<label className="mt-3 block text-sm font-bold">Зручний зв’язок<select className="mt-1 w-full rounded-xl border border-stone-300 px-3 py-2.5 text-sm outline-none focus:border-clay" {...register("contactMethod")}><option value="phone">Телефоном</option><option value="viber">Viber</option><option value="telegram">Telegram</option></select></label><label className="mt-3 block text-sm font-bold">Коментар <span className="font-normal text-stone-400">(необов’язково)</span><textarea rows={3} className="mt-1 w-full resize-none rounded-xl border border-stone-300 px-3 py-2.5 text-sm outline-none focus:border-clay" placeholder="Наприклад: потрібен монтаж або замір" {...register("message")} /></label><label className="mt-4 flex items-start gap-2 text-xs leading-5 text-stone-600"><input className="mt-1" type="checkbox" {...register("consent")} /> Погоджуюся на обробку контактних даних для відповіді на заявку.</label>{errors.consent && <p className="mt-1 text-xs text-red-600">{errors.consent.message}</p>}{serverError && <p className="mt-4 rounded-xl bg-red-50 p-3 text-sm text-red-700">{serverError}</p>}<button className="button-primary mt-5 w-full" disabled={isSubmitting} type="submit">{isSubmitting ? <><LoaderCircle className="animate-spin" size={17} /> Надсилання…</> : <><Send size={16} /> Надіслати на прорахунок</>}</button></form>}
    </aside>
  </div>;
}
