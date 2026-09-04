"use client";

import { Menu, Phone, ShoppingBag, X } from "lucide-react";
import Link from "next/link";
import { useState } from "react";
import { BrandMark } from "./brand-mark";
import { Button } from "./ui/button";
import { useCart } from "./cart-provider";

const links = [["Головна", "/"], ["Міжкімнатні двері", "/mizhkimnatni-dveri"], ["Вхідні двері", "/vhidni-dveri"], ["Вікна", "/vikna"], ["Про нас", "/pro-nas"], ["Контакти", "/contacts"]];

export function Header({ onMeasure }: { onMeasure: () => void }) {
  const [open, setOpen] = useState(false);
  const { items, openCart } = useCart();
  return <header className="sticky top-0 z-40 border-b border-stone-200 bg-white/95 text-ink backdrop-blur-xl">
    <div className="hidden border-b border-stone-200 lg:block"><div className="container-page flex h-9 items-center justify-between text-[10px] font-semibold tracking-wide text-stone-500"><div className="flex items-center gap-5"><a className="hover:text-ink" href="tel:+380688155408">(068) 815-54-08</a><a className="hover:text-ink" href="tel:+380950729341">(095) 072-93-41</a></div><div className="flex items-center gap-5"><button onClick={onMeasure} className="text-clay hover:text-ink">ЗАМОВИТИ ДЗВІНОК</button><Link href="/contacts" className="text-clay hover:text-ink">ЗАМОВЛЕННЯ / ПРОРАХУНОК</Link></div></div></div>
    <div className="container-page flex h-16 items-center justify-between gap-4"><Link href="/" className="shrink-0"><BrandMark /></Link><nav className="hidden items-center gap-7 xl:flex">{links.map(([label, href]) => <Link key={label} href={href} className="text-xs font-medium text-stone-600 transition hover:text-ink">{label}</Link>)}</nav><div className="hidden items-center gap-4 lg:flex"><a href="tel:+380950729341" className="inline-flex items-center gap-1.5 text-xs text-stone-600"><Phone size={13} />+38 (095) 072-93-41</a><button onClick={openCart} className="relative rounded-full border border-stone-300 p-2 text-ink transition hover:border-clay hover:text-clay" aria-label="Відкрити кошик"><ShoppingBag size={16} />{items.length > 0 && <span className="absolute -right-1.5 -top-1.5 grid size-4 place-items-center rounded-full bg-clay text-[9px] font-bold text-white">{items.length}</span>}</button><button onClick={onMeasure} className="rounded-full bg-ink px-3.5 py-1.5 text-xs font-bold text-white transition hover:bg-clay">Замовити замір</button></div><div className="flex items-center gap-2 lg:hidden"><button onClick={openCart} className="relative rounded-full p-2 text-ink" aria-label="Відкрити кошик"><ShoppingBag size={19} />{items.length > 0 && <span className="absolute -right-1 -top-1 grid size-4 place-items-center rounded-full bg-clay text-[9px] font-bold text-white">{items.length}</span>}</button><button aria-label="Відкрити меню" onClick={() => setOpen(!open)}>{open ? <X size={20} /> : <Menu size={20} />}</button></div></div>
    {open && <div className="border-t border-stone-200 bg-white px-5 py-5 lg:hidden"><nav className="container-page flex flex-col gap-4">{links.map(([label, href]) => <Link onClick={() => setOpen(false)} key={label} href={href} className="text-sm text-stone-700">{label}</Link>)}<a href="tel:+380950729341" className="mt-2 flex items-center justify-center gap-2 rounded-full border border-stone-300 px-4 py-3 text-sm font-bold"><Phone size={16} /> Подзвонити зараз</a><Button className="w-full" onClick={() => { setOpen(false); onMeasure(); }}>Замовити замір</Button></nav></div>}
  </header>;
}
