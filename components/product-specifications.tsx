"use client";

import { ChevronDown } from "lucide-react";
import { useState } from "react";
import type { ProductOption, ProductSpec } from "@/lib/catalog";

const previewPriority = (label: string) => {
  const normalized = label.toLowerCase();
  if (/розмір|габарит/.test(normalized)) return 0;
  if (/товщина.*полот/.test(normalized)) return 1;
  if (/(товщина|глибина).*короб/.test(normalized)) return 2;
  if (/відкриван/.test(normalized)) return 3;
  if (/покрит|оздоблен/.test(normalized)) return 4;
  if (/терморозрив|контур|утеплен/.test(normalized)) return 5;
  return 10;
};

export function ProductSpecifications({ specs, options }: { specs?: ProductSpec[]; options?: ProductOption[] }) {
  const [isOpen, setIsOpen] = useState(false);
  const hiddenIdentitySpecs = new Set(["фабрика", "виробник", "країна виробник", "місто виробник", "країна виробництва", "місто виробництва", "категорія", "купити в", "де купити", "тип полотна"]);
  const decorLabels = Array.from(new Set((options || []).filter((option) => option.group === "color").map((option) => option.label.trim()).filter(Boolean)));
  const visibleSpecs = (specs || [])
    .filter((spec) => !hiddenIdentitySpecs.has(spec.label.trim().toLowerCase()))
    .map((spec) => spec.label.trim().toLowerCase() === "доступні декори" && decorLabels.length ? { ...spec, value: decorLabels.join(", ") } : spec);
  if (!visibleSpecs.length) return null;
  // Найперше покупцеві потрібні габарити та сумісність із прорізом.
  // Повний список нижче зберігає порядок, який задав менеджер в адмінці.
  const orderedSpecs = [...visibleSpecs].sort((left, right) => previewPriority(left.label) - previewPriority(right.label) || left.sortOrder - right.sortOrder);
  const hiddenCount = Math.max(orderedSpecs.length - 3, 0);

  return (
    <section className="mt-7 rounded-2xl border border-stone-200 bg-white p-5 shadow-sm">
      <div className="flex items-start justify-between gap-4">
        <div>
          <h2 className="font-display text-2xl text-stone-900">Технічні характеристики</h2>
          <p className="mt-1 text-sm text-stone-500">{visibleSpecs.length} параметрів моделі</p>
        </div>
        <span className="rounded-full bg-sand px-3 py-1.5 text-xs font-bold text-stone-600">Перевірено</span>
      </div>
      <dl className="mt-5 grid gap-2.5 sm:grid-cols-2">
        {orderedSpecs.map((spec, index) => (
          <div key={`${spec.label}-${spec.value}`} className={`rounded-xl bg-sand/70 p-3.5 ${index >= 3 && !isOpen ? "hidden" : ""}`}>
            <dt className="text-[10px] font-bold uppercase tracking-[.12em] text-stone-400">{spec.label}</dt>
            <dd className="mt-1 text-sm font-semibold leading-6 text-stone-800">{spec.value}</dd>
          </div>
        ))}
      </dl>
      {visibleSpecs.length > 3 && <button
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
