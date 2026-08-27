"use client";

import { Check, Palette } from "lucide-react";
import { useMemo, useState } from "react";
import type { ProductOption } from "@/lib/catalog";

export function ProductConfiguration({ options, onImageChange }: { options: ProductOption[]; onImageChange: (image: string | null) => void }) {
  const groups = useMemo(() => {
    const collection = new Map<string, ProductOption[]>();
    options.forEach((option) => collection.set(option.group, [...(collection.get(option.group) || []), option]));
    return [...collection.values()];
  }, [options]);
  const [selected, setSelected] = useState<Record<string, number>>({});

  if (!groups.length) return null;

  return <section className="mt-7 rounded-2xl border border-stone-200 bg-white p-5 sm:p-6">
    <div className="flex items-center gap-2"><Palette size={18} className="text-clay" /><h2 className="text-base font-bold text-ink">Варіанти виконання</h2></div>
    <p className="mt-2 text-xs leading-5 text-stone-500">Оберіть декор і комплектацію. Відтінок на екрані може відрізнятися — точний зразок покажемо в салоні.</p>
    <div className="mt-5 space-y-5">{groups.map((group) => {
      const groupKey = group[0].group;
      const selectedIndex = selected[groupKey] ?? 0;
      return <div key={groupKey}><p className="text-sm font-bold text-ink">{group[0].groupLabel}</p><div className="mt-2.5 flex flex-wrap gap-2">{group.map((option, index) => {
        const isSelected = selectedIndex === index;
        return <button type="button" key={`${option.group}-${option.label}`} onClick={() => { setSelected((current) => ({ ...current, [groupKey]: index })); onImageChange(option.image); }} className={`inline-flex min-h-10 items-center gap-2 rounded-xl border px-3 py-2 text-sm font-semibold transition ${isSelected ? "border-ink bg-ink text-white" : "border-stone-200 bg-white text-stone-700 hover:border-clay"}`}>
          {option.swatch && <span aria-hidden="true" className={`h-4 w-4 rounded-full border border-black/10 ${isSelected ? "ring-1 ring-white/80" : ""}`} style={{ backgroundColor: option.swatch }} />}{option.label}{isSelected && <Check size={14} />}
        </button>;
      })}</div></div>;
    })}</div>
  </section>;
}
