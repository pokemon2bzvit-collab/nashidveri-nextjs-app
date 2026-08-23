"use client";
import { ArrowUpRight, ChevronRight } from "lucide-react";
import { useState } from "react";
const products = {
  interior: [
    { name: "Linea 02", detail: "МДФ · Екошпон · Білий дуб", price: "від 6 450 грн", image: "https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?auto=format&fit=crop&w=900&q=80" },
    { name: "Classic 4", detail: "Масив · Шпон · Горіх", price: "від 9 800 грн", image: "https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&w=900&q=80" },
    { name: "Loft Glass", detail: "МДФ · Скло · Антрацит", price: "від 8 250 грн", image: "https://images.unsplash.com/photo-1600210491369-e753d80a41f3?auto=format&fit=crop&w=900&q=80" },
  ],
  entrance: [
    { name: "Fortis Thermo", detail: "Сталь · 86 мм · 3 контури", price: "від 22 900 грн", image: "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=900&q=80" },
    { name: "Safe House", detail: "Сталь · МДФ накладка · 2 замки", price: "від 27 500 грн", image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=900&q=80" },
    { name: "Guardian 100", detail: "Терморозрив · Шумоізоляція", price: "від 31 800 грн", image: "https://images.unsplash.com/photo-1600607688969-a5bfcd646154?auto=format&fit=crop&w=900&q=80" },
  ],
  windows: [
    { name: "Comfort 70", detail: "5 камер · Склопакет 40 мм", price: "від 4 600 грн/м²", image: "https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?auto=format&fit=crop&w=900&q=80" },
    { name: "Alu Slide", detail: "Алюміній · Панорамна система", price: "від 12 400 грн/м²", image: "https://images.unsplash.com/photo-1600573472550-8090b5e0745e?auto=format&fit=crop&w=900&q=80" },
    { name: "Energy Pro", detail: "7 камер · Енергозбереження", price: "від 6 200 грн/м²", image: "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=900&q=80" },
  ]
};
const tabs = [{ id: "interior", label: "Міжкімнатні двері" }, { id: "entrance", label: "Вхідні двері" }, { id: "windows", label: "Вікна" }] as const;
export function ProductCatalog({ onOrder }: { onOrder: () => void }) { const [tab, setTab] = useState<keyof typeof products>("interior"); return <section id="catalog" className="section-pad container-page"><div className="flex flex-col justify-between gap-5 md:flex-row md:items-end"><div><p className="eyebrow">Наш каталог</p><h2 className="heading mt-3">Відкрийте двері<br />до вашого дому</h2></div><p className="max-w-sm text-sm leading-6 text-stone-600">Підібрали моделі, у яких дизайн зустрічається з надійністю. Більше варіантів покажемо у салоні.</p></div><div className="mt-10 flex w-full gap-2 overflow-x-auto border-b pb-3">{tabs.map(item => <button key={item.id} onClick={() => setTab(item.id)} className={`whitespace-nowrap rounded-full px-5 py-2.5 text-sm font-semibold transition ${tab === item.id ? "bg-ink text-white" : "text-stone-500 hover:bg-stone-100"}`}>{item.label}</button>)}</div><div className="mt-7 grid gap-5 md:grid-cols-3">{products[tab].map((product, index) => <article className="group overflow-hidden rounded-2xl border bg-white shadow-soft" key={product.name}><div className="relative aspect-[1.12] overflow-hidden"><img className="h-full w-full object-cover transition duration-500 group-hover:scale-105" src={product.image} alt={product.name} /><span className="absolute left-4 top-4 rounded-full bg-white/90 px-3 py-1 text-xs font-bold">0{index + 1}</span></div><div className="p-5"><p className="text-lg font-bold">{product.name}</p><p className="mt-1 text-sm text-stone-500">{product.detail}</p><div className="mt-5 flex items-center justify-between"><span className="font-display text-xl">{product.price}</span><button aria-label={`Замовити ${product.name}`} onClick={onOrder} className="rounded-full border p-2.5 transition hover:bg-ink hover:text-white"><ArrowUpRight size={18} /></button></div></div></article>)}</div><div className="mt-8 text-center"><a href="#calculator" className="inline-flex items-center gap-1 text-sm font-bold text-clay underline-offset-4 hover:underline">Допоможемо підібрати модель <ChevronRight size={16} /></a></div></section> }
