"use client";

import { Check, ChevronRight, Image as ImageIcon, Palette, RotateCcw, SlidersHorizontal, X } from "lucide-react";
import { useEffect, useMemo, useState } from "react";
import type { ProductOption, ProductVariant } from "@/lib/catalog";

type ProductConfigurationProps = {
  options: ProductOption[];
  variants: ProductVariant[];
  onImageChange: (image: string | null) => void;
  previewImage: string;
  productName: string;
  productSlug: string;
};

export function ProductConfiguration({ options, variants, onImageChange, previewImage, productName, productSlug }: ProductConfigurationProps) {
  const visualVariants = useMemo(() => variants.filter((variant) => Boolean(variant.image)), [variants]);
  const groups = useMemo(() => {
    const collection = new Map<string, ProductOption[]>();
    options.forEach((option) => collection.set(option.group, [...(collection.get(option.group) || []), option]));
    return [...collection.values()];
  }, [options]);
  const [selected, setSelected] = useState<Record<string, number>>({});
  const [draftSelected, setDraftSelected] = useState<Record<string, number>>({});
  const [isOpen, setIsOpen] = useState(false);

  const hasPhotoForOption = (groupKey: string, label: string) => visualVariants.some(
    (variant) => Boolean(variant.image) && variant.selections[groupKey] === label,
  );
  const selectedIndexFor = (group: ProductOption[], selection: Record<string, number>) => {
    const savedIndex = selection[group[0].group];
    if (savedIndex !== undefined) return savedIndex;
    const defaultIndex = group.findIndex((option) => visualVariants[0]?.selections[group[0].group] === option.label);
    if (defaultIndex >= 0) return defaultIndex;
    const firstWithPhoto = group.findIndex((option) => hasPhotoForOption(group[0].group, option.label));
    return firstWithPhoto >= 0 ? firstWithPhoto : 0;
  };

  const selectionValues = useMemo(
    () => Object.fromEntries(groups.map((group) => [group[0].group, group[selectedIndexFor(group, selected)]?.label || ""])),
    [groups, selected, variants],
  );
  const selectedOptions = useMemo(
    () => groups.map((group) => group[selectedIndexFor(group, selected)]).filter((option): option is ProductOption => Boolean(option)),
    [groups, selected, variants],
  );
  const draftSelectionValues = useMemo(
    () => Object.fromEntries(groups.map((group) => [group[0].group, group[selectedIndexFor(group, draftSelected)]?.label || ""])),
    [draftSelected, groups, variants],
  );
  const matchingVariant = useMemo(
    () => variants.find((variant) => Object.entries(variant.selections).every(([group, label]) => selectionValues[group] === label)),
    [selectionValues, variants],
  );
  const draftMatchingVariant = useMemo(
    () => variants.find((variant) => Object.entries(variant.selections).every(([group, label]) => draftSelectionValues[group] === label)),
    [draftSelectionValues, variants],
  );
  const hasVisualPreview = Boolean(matchingVariant?.image);

  useEffect(() => {
    onImageChange(matchingVariant?.image || null);
  }, [matchingVariant?.image, onImageChange]);

  useEffect(() => {
    if (!isOpen) return;
    const previousOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => { document.body.style.overflow = previousOverflow; };
  }, [isOpen]);

  if (!groups.length) return null;

  if (!visualVariants.length) return <section className="mt-5 rounded-2xl border border-stone-200 bg-white p-4 shadow-sm sm:p-5"><div className="flex items-start gap-3"><span className="grid size-9 shrink-0 place-items-center rounded-xl bg-sand text-clay"><Palette size={17} /></span><div><h2 className="text-sm font-bold text-ink">Варіанти покриття</h2><p className="mt-1 text-sm leading-6 text-stone-600">{options.map((option) => option.label).join(" · ")}</p><p className="mt-2 text-xs leading-5 text-stone-500">Фото для інших декорів цієї моделі ще не підтверджені. У салоні покажемо точні зразки.</p></div></div></section>;

  const openConfigurator = () => {
    setDraftSelected(selected);
    setIsOpen(true);
  };
  const reset = () => setDraftSelected({});
  const selectOption = (groupKey: string, index: number) => setDraftSelected((current) => ({ ...current, [groupKey]: index }));
  const applySelection = () => {
    setSelected(draftSelected);
    const configuration = groups.map((group) => {
      const option = group[selectedIndexFor(group, draftSelected)];
      return option ? `${option.groupLabel}: ${option.label}` : "";
    }).filter(Boolean);
    window.localStorage.setItem(`nashi-dveri-config-${productSlug}`, JSON.stringify(configuration));
    setIsOpen(false);
  };

  return <section className="mt-5 rounded-2xl border border-stone-200 bg-white p-4 shadow-sm sm:p-5">
    <div className="flex items-start justify-between gap-3">
      <div>
        <div className="flex items-center gap-2 text-sm font-bold text-ink"><Palette size={17} className="text-clay" /> Декор і комплектація</div>
        <p className="mt-1 text-xs leading-5 text-stone-500">Оберіть колір, скло або кромку для цієї моделі.</p>
      </div>
      <span className="rounded-full bg-sand px-2.5 py-1 text-[11px] font-bold text-stone-600">{visualVariants.length} з фото</span>
    </div>

    <div className="mt-4 flex gap-2 overflow-hidden">
      {selectedOptions.slice(0, 4).map((option) => <span key={`${option.group}-${option.label}`} title={option.label} className="flex h-9 min-w-9 items-center justify-center rounded-xl border border-stone-200 bg-[#faf9f7] px-2">
        {option.image ? <img src={option.image} alt="" className="h-6 w-6 rounded-md object-cover" /> : option.swatch ? <span aria-hidden="true" className="h-5 w-5 rounded-full border border-black/10" style={{ backgroundColor: option.swatch }} /> : <span className="max-w-20 truncate text-[11px] font-bold text-stone-600">{option.label}</span>}
      </span>)}
    </div>

    <button type="button" onClick={openConfigurator} className="mt-4 inline-flex min-h-11 w-full items-center justify-between rounded-xl bg-ink px-4 text-sm font-bold text-white transition hover:bg-ink/90">
      <span className="flex items-center gap-2"><SlidersHorizontal size={17} /> Обрати декор</span><ChevronRight size={17} />
    </button>
    <p className="mt-2 text-xs text-stone-500">{hasVisualPreview ? "Для обраного варіанту показано фото." : "Доступні лише декори з підтвердженим фото моделі."}</p>

    {isOpen && <div role="dialog" aria-modal="true" aria-label="Вибір декору та комплектації" className="fixed inset-0 z-[90]">
      <button type="button" aria-label="Закрити панель" onClick={() => setIsOpen(false)} className="decor-backdrop absolute inset-0 bg-ink/35 backdrop-blur-[2px]" />
      <aside className="decor-panel absolute inset-x-0 bottom-0 max-h-[88svh] overflow-y-auto rounded-t-[2rem] bg-[#fcfbf9] p-5 shadow-2xl sm:p-7 lg:inset-y-0 lg:left-auto lg:right-0 lg:max-h-none lg:w-[30rem] lg:rounded-none">
        <div className="mx-auto mb-5 h-1.5 w-12 rounded-full bg-stone-300 lg:hidden" />
        <div className="flex items-start justify-between gap-4">
          <div><p className="text-xs font-bold uppercase tracking-[.14em] text-clay">Ваша комплектація</p><h2 className="mt-1 font-display text-3xl text-ink">Оберіть декор</h2></div>
          <div className="flex items-start gap-2"><div className="w-12 shrink-0 rounded-xl border border-stone-200 bg-white p-1.5 sm:w-14"><img src={draftMatchingVariant?.image || previewImage} alt={`Обраний вигляд: ${productName}`} className="aspect-[3/4] w-full object-contain" /></div><button type="button" onClick={() => setIsOpen(false)} aria-label="Закрити панель" className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full border border-stone-200 bg-white text-ink transition hover:border-clay hover:text-clay"><X size={19} /></button></div>
        </div>
        <p className="mt-3 text-sm leading-6 text-stone-600">Доступні лише параметри для цієї моделі. Фото оновлюється, коли для варіанту є точне зображення.</p>

        <div className="mt-7 space-y-7">
          {groups.map((group) => {
            const groupKey = group[0].group;
            const selectedIndex = selectedIndexFor(group, draftSelected);
            return <div key={groupKey}>
              <div className="flex items-baseline justify-between gap-3"><p className="text-base font-bold text-ink">{group[0].groupLabel}</p><p className="max-w-[52%] truncate text-right text-xs font-semibold text-clay">{group[selectedIndex]?.label}</p></div>
              <div className="mt-3 grid grid-cols-2 gap-2 sm:grid-cols-3">
                {group.map((option, index) => {
                  const isSelected = selectedIndex === index;
                  const isAvailable = visualVariants.some((variant) => Object.entries(variant.selections).every(([key, label]) => key === groupKey ? label === option.label : label === draftSelectionValues[key]));
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
          <div className="flex gap-3"><button type="button" onClick={reset} className="inline-flex min-h-11 items-center gap-2 rounded-xl border border-stone-200 bg-white px-4 text-sm font-bold text-stone-700 transition hover:border-clay"><RotateCcw size={16} /> Скинути</button><button type="button" onClick={applySelection} className="button-primary flex-1 justify-center">Застосувати</button></div>
          <p className="mt-3 text-center text-[11px] leading-4 text-stone-500">Відтінок на екрані може відрізнятися. Точний зразок покажемо в салоні.</p>
        </div>
      </aside>
    </div>}
  </section>;
}
