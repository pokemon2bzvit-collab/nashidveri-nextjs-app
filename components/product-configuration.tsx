"use client";

import { Check, ChevronRight, Image as ImageIcon, Palette, RotateCcw, SlidersHorizontal, X } from "lucide-react";
import { useEffect, useMemo, useState } from "react";
import type { ProductOption, ProductVariant } from "@/lib/catalog";

type ProductConfigurationProps = {
  options: ProductOption[];
  variants: ProductVariant[];
  onImageChange: (image: string | null) => void;
};

export function ProductConfiguration({ options, variants, onImageChange }: ProductConfigurationProps) {
  const groups = useMemo(() => {
    const collection = new Map<string, ProductOption[]>();
    options.forEach((option) => collection.set(option.group, [...(collection.get(option.group) || []), option]));
    return [...collection.values()];
  }, [options]);
  const [selected, setSelected] = useState<Record<string, number>>({});
  const [isOpen, setIsOpen] = useState(false);

  const selectionValues = useMemo(
    () => Object.fromEntries(groups.map((group) => [group[0].group, group[selected[group[0].group] ?? 0]?.label || ""])),
    [groups, selected],
  );
  const selectedOptions = useMemo(
    () => groups.map((group) => group[selected[group[0].group] ?? 0]).filter((option): option is ProductOption => Boolean(option)),
    [groups, selected],
  );
  const matchingVariant = useMemo(
    () => variants.find((variant) => Object.entries(selectionValues).every(([group, label]) => variant.selections[group] === label)),
    [selectionValues, variants],
  );
  const selectedOptionImage = useMemo(
    () => groups.flatMap((group) => group).reverse().find((option) => option.label === selectionValues[option.group])?.image,
    [groups, selectionValues],
  );
  const hasVisualPreview = Boolean(matchingVariant?.image || selectedOptionImage);

  useEffect(() => {
    onImageChange(matchingVariant?.image || selectedOptionImage || null);
  }, [matchingVariant?.image, onImageChange, selectedOptionImage]);

  useEffect(() => {
    if (!isOpen) return;
    const previousOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => { document.body.style.overflow = previousOverflow; };
  }, [isOpen]);

  if (!groups.length) return null;

  const reset = () => setSelected({});
  const selectOption = (groupKey: string, index: number) => setSelected((current) => ({ ...current, [groupKey]: index }));

  return <section className="mt-5 rounded-2xl border border-stone-200 bg-white p-4 shadow-sm sm:p-5">
    <div className="flex items-start justify-between gap-3">
      <div>
        <div className="flex items-center gap-2 text-sm font-bold text-ink"><Palette size={17} className="text-clay" /> Декор і комплектація</div>
        <p className="mt-1 text-xs leading-5 text-stone-500">Оберіть колір, скло або кромку для цієї моделі.</p>
      </div>
      <span className="rounded-full bg-sand px-2.5 py-1 text-[11px] font-bold text-stone-600">{options.length} варіантів</span>
    </div>

    <div className="mt-4 flex gap-2 overflow-hidden">
      {selectedOptions.slice(0, 4).map((option) => <span key={`${option.group}-${option.label}`} title={option.label} className="flex h-9 min-w-9 items-center justify-center rounded-xl border border-stone-200 bg-[#faf9f7] px-2">
        {option.image ? <img src={option.image} alt="" className="h-6 w-6 rounded-md object-cover" /> : option.swatch ? <span aria-hidden="true" className="h-5 w-5 rounded-full border border-black/10" style={{ backgroundColor: option.swatch }} /> : <span className="max-w-20 truncate text-[11px] font-bold text-stone-600">{option.label}</span>}
      </span>)}
    </div>

    <button type="button" onClick={() => setIsOpen(true)} className="mt-4 inline-flex min-h-11 w-full items-center justify-between rounded-xl bg-ink px-4 text-sm font-bold text-white transition hover:bg-ink/90">
      <span className="flex items-center gap-2"><SlidersHorizontal size={17} /> Обрати декор</span><ChevronRight size={17} />
    </button>
    <p className="mt-2 text-xs text-stone-500">{hasVisualPreview ? "Для обраного варіанту показано фото." : "Точний зразок декору покажемо в салоні."}</p>

    {isOpen && <div role="dialog" aria-modal="true" aria-label="Вибір декору та комплектації" className="fixed inset-0 z-[90]">
      <button type="button" aria-label="Закрити панель" onClick={() => setIsOpen(false)} className="decor-backdrop absolute inset-0 bg-ink/35 backdrop-blur-[2px]" />
      <aside className="decor-panel absolute inset-x-0 bottom-0 max-h-[88svh] overflow-y-auto rounded-t-[2rem] bg-[#fcfbf9] p-5 shadow-2xl sm:p-7 lg:inset-y-0 lg:left-auto lg:right-0 lg:max-h-none lg:w-[30rem] lg:rounded-none">
        <div className="mx-auto mb-5 h-1.5 w-12 rounded-full bg-stone-300 lg:hidden" />
        <div className="flex items-start justify-between gap-4">
          <div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">Ваша комплектація</p><h2 className="mt-1 font-display text-3xl text-ink">Оберіть декор</h2></div>
          <button type="button" onClick={() => setIsOpen(false)} aria-label="Закрити панель" className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full border border-stone-200 bg-white text-ink transition hover:border-clay hover:text-clay"><X size={19} /></button>
        </div>
        <p className="mt-3 text-sm leading-6 text-stone-600">Доступні лише параметри для цієї моделі. Фото оновлюється, коли для варіанту є точне зображення.</p>

        <div className="mt-7 space-y-7">
          {groups.map((group) => {
            const groupKey = group[0].group;
            const selectedIndex = selected[groupKey] ?? 0;
            return <div key={groupKey}>
              <div className="flex items-baseline justify-between gap-3"><p className="text-base font-bold text-ink">{group[0].groupLabel}</p><p className="max-w-[52%] truncate text-right text-xs font-semibold text-clay">{group[selectedIndex]?.label}</p></div>
              <div className="mt-3 grid grid-cols-2 gap-2 sm:grid-cols-3">
                {group.map((option, index) => {
                  const isSelected = selectedIndex === index;
                  const isAvailable = !variants.length || variants.some((variant) => variant.selections[groupKey] === option.label && Object.entries(selectionValues).every(([otherGroup, label]) => otherGroup === groupKey || variant.selections[otherGroup] === label));
                  return <button type="button" disabled={!isAvailable} key={`${option.group}-${option.label}`} onClick={() => selectOption(groupKey, index)} className={`relative flex min-h-14 items-center gap-2 rounded-xl border p-2.5 text-left text-xs font-bold transition disabled:cursor-not-allowed disabled:opacity-35 ${isSelected ? "border-ink bg-ink text-white shadow-sm" : "border-stone-200 bg-white text-stone-700 hover:border-clay"}`}>
                    {option.image ? <img src={option.image} alt="" className="h-9 w-9 shrink-0 rounded-lg object-cover" /> : option.swatch ? <span aria-hidden="true" className={`h-7 w-7 shrink-0 rounded-full border border-black/10 ${isSelected ? "ring-1 ring-white" : ""}`} style={{ backgroundColor: option.swatch }} /> : <ImageIcon size={18} className={isSelected ? "text-white" : "text-clay"} />}
                    <span className="line-clamp-2">{option.label}</span>{isSelected && <Check size={14} className="absolute right-2 top-2" />}
                  </button>;
                })}
              </div>
            </div>;
          })}
        </div>

        <div className="sticky bottom-0 -mx-5 mt-8 border-t border-stone-200 bg-[#fcfbf9]/95 px-5 pb-[max(1.25rem,env(safe-area-inset-bottom))] pt-4 backdrop-blur sm:-mx-7 sm:px-7">
          <div className="flex gap-3"><button type="button" onClick={reset} className="inline-flex min-h-11 items-center gap-2 rounded-xl border border-stone-200 bg-white px-4 text-sm font-bold text-stone-700 transition hover:border-clay"><RotateCcw size={16} /> Скинути</button><button type="button" onClick={() => setIsOpen(false)} className="button-primary flex-1 justify-center">Застосувати</button></div>
          <p className="mt-3 text-center text-[11px] leading-4 text-stone-500">Відтінок на екрані може відрізнятися. Точний зразок покажемо в салоні.</p>
        </div>
      </aside>
    </div>}
  </section>;
}
