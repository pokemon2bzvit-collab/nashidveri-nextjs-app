"use client";

import { Menu, Phone, X } from "lucide-react";
import Link from "next/link";
import { useState } from "react";
import { BrandMark } from "./brand-mark";
import { Button } from "./ui/button";

const links = [["Головна", "/"], ["Міжкімнатні двері", "/mizhkimnatni-dveri"], ["Вхідні двері", "/vhidni-dveri"], ["Вікна", "/vikna"], ["Контакти", "/contacts"]];

export function Header({ onMeasure }: { onMeasure: () => void }) {
  const [open, setOpen] = useState(false);
  return <header className="sticky top-0 z-40 bg-[#161617]/95 text-white backdrop-blur-xl">
    <div className="hidden border-b border-white/10 lg:block"><div className="container-page flex h-9 items-center justify-between text-[10px] font-semibold tracking-wide text-white/75"><div className="flex items-center gap-5"><a href="tel:+380688155408">(068) 815-54-08</a><a href="tel:+380950729341">(095) 072-93-41</a></div><div className="flex items-center gap-5"><button onClick={onMeasure} className="text-[#edbf85] hover:text-white">ЗАМОВИТИ ДЗВІНОК</button><Link href="/contacts" className="text-[#edbf85] hover:text-white">ЗАМОВЛЕННЯ / ПРОРАХУНОК</Link></div></div></div>
    <div className="container-page flex h-16 items-center justify-between gap-4"><Link href="/" className="shrink-0"><BrandMark dark /></Link><nav className="hidden items-center gap-7 xl:flex">{links.map(([label, href]) => <Link key={label} href={href} className="text-xs font-medium text-white/85 transition hover:text-white">{label}</Link>)}</nav><div className="hidden items-center gap-4 lg:flex"><a href="tel:+380950729341" className="inline-flex items-center gap-1.5 text-xs text-white/80"><Phone size={13} />+38 (095) 072-93-41</a><button onClick={onMeasure} className="rounded-full bg-clay px-3.5 py-1.5 text-xs font-bold text-white transition hover:bg-[#c77f45]">Замовити замір</button></div><button aria-label="Відкрити меню" className="lg:hidden" onClick={() => setOpen(!open)}>{open ? <X size={20} /> : <Menu size={20} />}</button></div>
    {open && <div className="border-t border-white/15 bg-[#161617] px-5 py-5 lg:hidden"><nav className="container-page flex flex-col gap-4">{links.map(([label, href]) => <Link onClick={() => setOpen(false)} key={label} href={href} className="text-sm text-white/90">{label}</Link>)}<a href="tel:+380950729341" className="mt-2 flex items-center justify-center gap-2 rounded-full border border-white/20 px-4 py-3 text-sm font-bold"><Phone size={16} /> Подзвонити зараз</a><Button className="w-full" onClick={() => { setOpen(false); onMeasure(); }}>Замовити замір</Button></nav></div>}
  </header>;
}
