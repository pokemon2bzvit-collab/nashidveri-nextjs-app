"use client";

import { AlignLeft, ChevronDown } from "lucide-react";
import { useState } from "react";

export function ProductDescription({ description }: { description: string }) {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <section className="mt-5 rounded-2xl border border-stone-200 bg-white p-5 shadow-sm lg:border-0 lg:bg-transparent lg:p-0 lg:shadow-none">
      <button
        type="button"
        onClick={() => setIsOpen((open) => !open)}
        aria-expanded={isOpen}
        className="flex w-full items-center justify-between gap-4 text-left lg:pointer-events-none"
      >
        <span className="flex items-center gap-2 font-display text-2xl text-stone-900 lg:hidden">
          <AlignLeft size={19} className="text-clay" /> Повний опис
        </span>
        <ChevronDown className={`shrink-0 text-clay transition-transform duration-300 lg:hidden ${isOpen ? "rotate-180" : ""}`} size={22} />
      </button>
      <div className={`grid transition-[grid-template-rows,opacity,margin] duration-300 ease-out lg:mt-0 lg:grid-rows-[1fr] lg:opacity-100 ${isOpen ? "mt-4 grid-rows-[1fr] opacity-100" : "grid-rows-[0fr] opacity-0"}`}>
        <div className="overflow-hidden">
          <p className="max-w-lg text-base leading-7 text-stone-600 lg:text-lg lg:leading-8">{description}</p>
        </div>
      </div>
    </section>
  );
}
