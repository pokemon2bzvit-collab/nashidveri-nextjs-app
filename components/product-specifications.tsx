"use client";

import { ChevronDown } from "lucide-react";
import { useState } from "react";
import type { ProductSpec } from "@/lib/catalog";

export function ProductSpecifications({ specs }: { specs?: ProductSpec[] }) {
  const [isOpen, setIsOpen] = useState(false);
  if (!specs?.length) return null;
  const visibleSpecs = isOpen ? specs : specs.slice(0, 3);
  const hiddenCount = Math.max(specs.length - visibleSpecs.length, 0);

  return (
    <section className="mt-7 rounded-2xl border border-stone-200 bg-white p-5 shadow-sm">
      <div className="flex items-start justify-between gap-4">
        <div>
          <h2 className="font-display text-2xl text-stone-900">Технічні характеристики</h2>
          <p className="mt-1 text-sm text-stone-500">{specs.length} параметрів моделі</p>
        </div>
        <span className="rounded-full bg-sand px-3 py-1.5 text-xs font-bold text-stone-600">Перевірено</span>
      </div>
      <dl className="mt-5 grid gap-2.5 sm:grid-cols-2">
        {visibleSpecs.map((spec) => (
          <div key={`${spec.label}-${spec.value}`} className="rounded-xl bg-sand/70 p-3.5">
            <dt className="text-[10px] font-bold uppercase tracking-[.12em] text-stone-400">{spec.label}</dt>
            <dd className="mt-1 text-sm font-semibold leading-6 text-stone-800">{spec.value}</dd>
          </div>
        ))}
      </dl>
      {specs.length > 3 && <button
        type="button"
        onClick={() => setIsOpen((open) => !open)}
        aria-expanded={isOpen}
        className="mt-5 flex w-full items-center justify-center gap-2 rounded-xl border border-stone-200 bg-white px-4 py-3 text-sm font-bold text-ink transition hover:border-clay hover:text-clay"
      >
        {isOpen ? "Згорнути характеристики" : `Показати ще ${hiddenCount} параметрів`}
        <ChevronDown className={`transition-transform duration-300 ${isOpen ? "rotate-180" : ""}`} size={18} />
      </button>}
    </section>
  );
}
