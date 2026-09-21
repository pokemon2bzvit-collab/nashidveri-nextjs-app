"use client";

import { Images, Palette } from "lucide-react";
import { useCallback, useEffect, useMemo, useState } from "react";
import { ImageLightbox } from "@/components/image-lightbox";
import { ProductConfiguration } from "@/components/product-configuration";
import type { Product, ProductMedia, ProductOption, ProductVariant } from "@/lib/catalog";

export function ProductMediaGallery({ product }: { product: Product }) {
  const media = product.media || [];
  const isTaggedVariantPhoto = (item: ProductMedia) => item.label?.startsWith("glass:") || item.label?.startsWith("config:") || false;
  const visualMedia = media.filter((item) => (item.kind === "main" || item.kind === "gallery") && !isTaggedVariantPhoto(item));
  const gallery: ProductMedia[] = visualMedia.length ? visualMedia : [{ kind: "main", label: product.name, image: product.image, sortOrder: 0 }];
  const visualVariants = useMemo(() => (product.variants || []).filter((variant) => Boolean(variant.image)), [product.variants]);
  const optionGroups = useMemo(() => {
    const grouped = new Map<string, ProductOption[]>();
    (product.options || []).forEach((option) => grouped.set(option.group, [...(grouped.get(option.group) || []), option]));
    return [...grouped.values()];
  }, [product.options]);
  const hasCompleteVariantCoverage = Boolean(visualVariants.length) && optionGroups.every((group) => {
    const groupKey = group[0]?.group;
    return Boolean(groupKey) && group.every((option) => visualVariants.some((variant) => variant.selections[groupKey] === option.label));
  }) && visualVariants.every((variant) => optionGroups.every((group) => Boolean(variant.selections[group[0]?.group || ""])));
  const variantGallery: ProductMedia[] = useMemo(() => visualVariants
    .map((variant) => ({
      kind: "gallery",
      label: Object.values(variant.selections).join(" · "),
      image: variant.image,
      sortOrder: variant.sortOrder,
    })), [visualVariants]);
  const isGlassOnlyConfiguration = Boolean(product.options?.length) && product.options!.every((option) => option.group === "glass");
  const usesGlassVariantGallery = isGlassOnlyConfiguration && variantGallery.length > 0;
  const palettes = media.filter((item) => item.kind === "palette");
  const [selectedIndex, setSelectedIndex] = useState(0);
  const [optionImage, setOptionImage] = useState<string | null>(null);
  const [activeVariant, setActiveVariant] = useState<ProductVariant | null>(null);
  const activeGlassGallery = useMemo(() => {
    const glass = activeVariant?.selections.glass;
    if (!isGlassOnlyConfiguration || !glass) return [];
    const prefix = `glass:${glass}:`;
    return media
      .filter((item) => item.kind === "gallery" && item.label?.startsWith(prefix))
      .map((item) => ({ ...item, label: item.label?.slice(prefix.length) || "Фото" }));
  }, [activeVariant?.selections.glass, isGlassOnlyConfiguration, media]);
  const activeConfigurationGallery = useMemo(() => {
    if (!activeVariant || isGlassOnlyConfiguration) return [];
    const configuration = Object.entries(activeVariant.selections)
      .sort(([left], [right]) => left.localeCompare(right))
      .map(([group, value]) => `${group}=${encodeURIComponent(value)}`)
      .join("&");
    const prefix = `config:${configuration}:`;
    return media
      .filter((item) => item.kind === "gallery" && item.label?.startsWith(prefix))
      .map((item) => ({ ...item, label: item.label?.slice(prefix.length) || "Фото" }));
  }, [activeVariant, isGlassOnlyConfiguration, media]);
  const activeVariantGallery = activeConfigurationGallery.length ? activeConfigurationGallery : activeGlassGallery;
  const usesActiveVariantGallery = activeVariantGallery.length > 0;
  // Відображаємо точні виконання під головним фото для кожної фабрики,
  // щойно виробник надав фото цих виконань. Це дає однаковий сценарій,
  // як у Rodos: мініатюра = вибір декору й головного фото.
  const usesVariantThumbnailGallery = !usesActiveVariantGallery && hasCompleteVariantCoverage && variantGallery.length > 0;
  // Після вибору декору показуємо під головним фото лише підтверджені фото
  // цього виконання. Для фабрик, що дають один кадр на комбінацію, це буде
  // одна мініатюра; якщо є кілька ракурсів, activeConfigurationGallery вище
  // автоматично покаже всі.
  const selectedVariantThumbnailGallery = useMemo(() => {
    if (!usesVariantThumbnailGallery || !activeVariant) return variantGallery;
    return visualVariants
      .filter((variant) => Object.entries(activeVariant.selections).every(([group, value]) => variant.selections[group] === value))
      .map((variant) => ({
        kind: "gallery" as const,
        label: Object.values(variant.selections).join(" · "),
        image: variant.image,
        sortOrder: variant.sortOrder,
      }));
  }, [activeVariant, usesVariantThumbnailGallery, variantGallery, visualVariants]);
  // Галерея показує ракурси тільки одного вибраного виконання. Не змішуємо
  // фото різних кольорів чи видів полотна в один ряд мініатюр.
  const displayedGallery = usesActiveVariantGallery
    ? activeVariantGallery
    : usesGlassVariantGallery
      ? variantGallery
      : usesVariantThumbnailGallery
        ? selectedVariantThumbnailGallery
        : gallery;
  const selected = displayedGallery[selectedIndex] || displayedGallery[0];
  const displayName = product.name.toLocaleLowerCase("uk").startsWith(product.brand.toLocaleLowerCase("uk"))
    ? product.name
    : `${product.brand} ${product.name}`;
  const productImageAlt = `${product.category === "windows" ? "Вікна" : `${product.category === "entrance" ? "Вхідні" : "Міжкімнатні"} двері`} ${displayName}, колекція ${product.collection}`;
  const selectedImageAlt = selected.label ? `${productImageAlt} — ${selected.label}` : productImageAlt;
  const handleConfigurationImage = useCallback((image: string | null, variant: ProductVariant | null) => {
    setOptionImage(image);
    setActiveVariant(variant);
    if (!image) {
      setSelectedIndex(0);
      return;
    }
    setSelectedIndex(0);
  }, []);
  useEffect(() => {
    if (!usesVariantThumbnailGallery || !activeVariant) return;
    // Після вибору декору галерея звужується до фото цього виконання,
    // тому активна мініатюра завжди перша в новому, короткому списку.
    setSelectedIndex(0);
  }, [activeVariant, usesVariantThumbnailGallery]);
  const selectConfigurationPhoto = (index: number) => {
    const variant = visualVariants[index];
    if (!variant) return;
    setOptionImage(variant.image);
    setActiveVariant(variant);
    setSelectedIndex(index);
  };
  const imageStem = (image: string) => image.split("?")[0].split("/").pop()?.replace(/\.(avif|webp|png|jpe?g)$/i, "") || image;
  const selectGalleryPhoto = (item: ProductMedia, index: number) => {
    const variantIndex = visualVariants.findIndex((variant) => imageStem(variant.image) === imageStem(item.image));
    if (variantIndex >= 0) {
      selectConfigurationPhoto(variantIndex);
      return;
    }
    setSelectedIndex(index);
    setOptionImage(null);
  };
  const selectActiveVariantPhoto = (index: number) => {
    const photo = activeVariantGallery[index];
    if (!photo) return;
    setOptionImage(photo.image);
    setSelectedIndex(index);
  };

  return <div>
    <div className="aspect-[4/5] overflow-hidden rounded-[2rem] bg-[#f7f5f1] p-5 sm:p-8">
      <ImageLightbox src={optionImage || selected.image} alt={selectedImageAlt} className="h-full w-full" imageClassName="h-full w-full object-contain" />
    </div>
    {(displayedGallery.length > 1 || (Boolean(activeVariant) && (usesActiveVariantGallery || usesVariantThumbnailGallery))) && <div className="mt-3 flex gap-2 overflow-x-auto pb-1">
      {displayedGallery.map((item, index) => usesActiveVariantGallery
        ? <button type="button" key={`${item.image}-${index}`} aria-label={`Обрати фото: ${item.label || index + 1}`} onClick={() => selectActiveVariantPhoto(index)} className={`h-16 w-12 shrink-0 overflow-hidden rounded-lg border-2 bg-[#f7f5f1] transition ${selectedIndex === index ? "border-clay" : "border-transparent hover:border-stone-300"}`}><img src={item.image} alt="" className="h-full w-full object-contain" /></button>
        : usesGlassVariantGallery || usesVariantThumbnailGallery
          ? <button type="button" key={`${item.image}-${index}`} aria-label={`Обрати фото варіанту: ${item.label || index + 1}`} onClick={() => usesVariantThumbnailGallery ? selectGalleryPhoto(item, index) : selectConfigurationPhoto(index)} className={`h-16 w-12 shrink-0 overflow-hidden rounded-lg border-2 bg-[#f7f5f1] transition ${selectedIndex === index ? "border-clay" : "border-transparent hover:border-stone-300"}`}><img src={item.image} alt="" className="h-full w-full object-contain" /></button>
          : <button type="button" key={`${item.image}-${index}`} aria-label={`Обрати фото: ${item.label || index + 1}`} onClick={() => selectGalleryPhoto(item, index)} className={`h-16 w-12 shrink-0 overflow-hidden rounded-lg border-2 bg-[#f7f5f1] transition ${selectedIndex === index ? "border-clay" : "border-transparent hover:border-stone-300"}`}><img src={item.image} alt="" className="h-full w-full object-contain" /></button>)}
    </div>}
    {palettes.length > 0 && <section className="mt-5 rounded-2xl border border-stone-200 bg-white p-4 shadow-sm">
      <div className="flex items-center gap-2 text-sm font-bold text-ink"><Palette size={17} className="text-clay" /> Кольори та декори</div>
      <p className="mt-1.5 text-xs leading-5 text-stone-600">Оберіть декор під час консультації — наявність і термін виготовлення підтвердить менеджер.</p>
      <div className="mt-3 flex gap-3 overflow-x-auto pb-1">
        {palettes.map((item, index) => <div key={`${item.image}-${index}`} className="w-24 shrink-0"><ImageLightbox src={item.image} alt={item.label || "Палітра кольорів"} className="h-20 w-24 rounded-lg bg-sand" imageClassName="h-full w-full rounded-lg object-cover" /><p className="mt-1 line-clamp-2 text-xs font-semibold text-stone-700">{item.label || "Палітра"}</p></div>)}
      </div>
    </section>}
    <ProductConfiguration options={product.options || []} variants={product.variants || []} onImageChange={handleConfigurationImage} activeVariant={activeVariant} previewImage={optionImage || selected.image} productName={product.name} productBrand={product.brand} productSlug={product.slug} />
    {(displayedGallery.length > 1 || (Boolean(activeVariant) && (usesActiveVariantGallery || usesVariantThumbnailGallery))) && <p className="mt-3 flex items-center gap-2 text-xs font-medium text-stone-500"><Images size={15} /> {usesActiveVariantGallery ? "Фото обраного виконання." : usesGlassVariantGallery ? "Фото доступних виконань скла." : usesVariantThumbnailGallery ? "Фото обраного декору." : "Натисніть мініатюру, щоб переглянути варіант."}</p>}
  </div>;
}
