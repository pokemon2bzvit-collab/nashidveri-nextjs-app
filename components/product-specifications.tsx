"use client";

import { ChevronDown } from "lucide-react";
import { useState } from "react";
import type { ProductSpec } from "@/lib/catalog";

export function ProductSpecifications({ specs }: { specs?: ProductSpec[] }) {
  const [isOpen, setIsOpen] = useState(false);
  if (!specs?.length) return null;

  return (
    <section className="mt-7 rounded-2xl border border-stone-200 bg-white p-5 shadow-sm">
      <button
        type="button"
        onClick={() => setIsOpen((open) => !open)}
        aria-expanded={isOpen}
        className="flex w-full items-center justify-between gap-4 text-left"
      >
        <span>
          <span className="block font-display text-2xl text-stone-900">Технічні характеристики</span>
          <span className="mt-1 block text-sm text-stone-500">{specs.length} параметрів моделі</span>
        </span>
        <ChevronDown className={`shrink-0 text-clay transition-transform duration-300 ${isOpen ? "rotate-180" : ""}`} size={22} />
      </button>
      <div className={`grid transition-[grid-template-rows,opacity] duration-300 ease-out ${isOpen ? "mt-5 grid-rows-[1fr] opacity-100" : "grid-rows-[0fr] opacity-0"}`}>
        <div className="overflow-hidden">
          <dl className="grid gap-x-7 gap-y-4 sm:grid-cols-2">
            {specs.map((spec) => (
              <div key={`${spec.label}-${spec.value}`} className="border-b border-stone-100 pb-3">
                <dt className="text-xs font-bold uppercase tracking-[.12em] text-stone-400">{spec.label}</dt>
                <dd className="mt-1 text-sm font-medium leading-6 text-stone-800">{spec.value}</dd>
              </div>
            ))}
          </dl>
        </div>
      </div>
    </section>
  );
}
