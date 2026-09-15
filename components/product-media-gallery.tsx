"use client";

import { Images, Palette } from "lucide-react";
import { useState } from "react";
import { ImageLightbox } from "@/components/image-lightbox";
import { ProductConfiguration } from "@/components/product-configuration";
import type { Product, ProductMedia, ProductVariant } from "@/lib/catalog";

export function ProductMediaGallery({ product }: { product: Product }) {
  const media = product.media || [];
  const visualMedia = media.filter((item) => item.kind === "main" || item.kind === "gallery");
  const gallery: ProductMedia[] = visualMedia.length ? visualMedia : [{ kind: "main", label: product.name, image: product.image, sortOrder: 0 }];
  const visualVariants = (product.variants || []).filter((variant) => Boolean(variant.image));
  const variantGallery: ProductMedia[] = visualVariants
    .map((variant) => ({
      kind: "gallery",
      label: Object.values(variant.selections).join(" · "),
      image: variant.image,
      sortOrder: variant.sortOrder,
    }));
  const palettes = media.filter((item) => item.kind === "palette");
  const [selectedIndex, setSelectedIndex] = useState(0);
  const [optionImage, setOptionImage] = useState<string | null>(null);
  const [activeVariant, setActiveVariant] = useState<ProductVariant | null>(null);
  const [isConfigurationActive, setIsConfigurationActive] = useState(false);
  const displayedGallery = isConfigurationActive && variantGallery.length ? variantGallery : gallery;
  const selected = displayedGallery[selectedIndex] || displayedGallery[0];
  const productImageAlt = `${product.category === "windows" ? "Вікна" : `${product.category === "entrance" ? "Вхідні" : "Міжкімнатні"} двері`} ${product.brand} ${product.name}, колекція ${product.collection}`;
  const selectedImageAlt = optionImage ? `Обраний декор: ${productImageAlt}` : selected.label ? `${productImageAlt} — ${selected.label}` : productImageAlt;
  const handleConfigurationImage = (image: string | null, variant: ProductVariant | null) => {
    setOptionImage(image);
    setActiveVariant(variant);
    if (!image) {
      setIsConfigurationActive(false);
      setSelectedIndex(0);
      return;
    }
    const variantIndex = variantGallery.findIndex((item) => item.image === image);
    setIsConfigurationActive(variantIndex >= 0);
    setSelectedIndex(variantIndex >= 0 ? variantIndex : 0);
  };
  const selectConfigurationPhoto = (index: number) => {
    const variant = visualVariants[index];
    if (!variant) return;
    setOptionImage(variant.image);
    setActiveVariant(variant);
    setIsConfigurationActive(true);
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

  return <div>
    <div className="aspect-[4/5] overflow-hidden rounded-[2rem] bg-[#f7f5f1] p-5 sm:p-8">
      <ImageLightbox src={optionImage || selected.image} alt={selectedImageAlt} className="h-full w-full" imageClassName="h-full w-full object-contain" />
    </div>
    {displayedGallery.length > 1 && <div className="mt-3 flex gap-2 overflow-x-auto pb-1">
      {displayedGallery.map((item, index) => isConfigurationActive
        ? <button type="button" key={`${item.image}-${index}`} aria-label={`Обрати фото варіанту: ${item.label || index + 1}`} onClick={() => selectConfigurationPhoto(index)} className={`h-16 w-12 shrink-0 overflow-hidden rounded-lg border-2 bg-[#f7f5f1] transition ${selectedIndex === index ? "border-clay" : "border-transparent hover:border-stone-300"}`}><img src={item.image} alt="" className="h-full w-full object-contain" /></button>
        : <button type="button" key={`${item.image}-${index}`} aria-label={`Обрати фото: ${item.label || index + 1}`} onClick={() => selectGalleryPhoto(item, index)} className={`h-16 w-12 shrink-0 overflow-hidden rounded-lg border-2 bg-[#f7f5f1] transition ${selectedIndex === index ? "border-clay" : "border-transparent hover:border-stone-300"}`}><img src={item.image} alt="" className="h-full w-full object-contain" /></button>)}
    </div>}
    {palettes.length > 0 && <section className="mt-5 rounded-2xl border border-stone-200 bg-white p-4 shadow-sm">
      <div className="flex items-center gap-2 text-sm font-bold text-ink"><Palette size={17} className="text-clay" /> Кольори та декори</div>
      <p className="mt-1.5 text-xs leading-5 text-stone-600">Оберіть декор під час консультації — наявність і термін виготовлення підтвердить менеджер.</p>
      <div className="mt-3 flex gap-3 overflow-x-auto pb-1">
        {palettes.map((item, index) => <div key={`${item.image}-${index}`} className="w-24 shrink-0"><ImageLightbox src={item.image} alt={item.label || "Палітра кольорів"} className="h-20 w-24 rounded-lg bg-sand" imageClassName="h-full w-full rounded-lg object-cover" /><p className="mt-1 line-clamp-2 text-xs font-semibold text-stone-700">{item.label || "Палітра"}</p></div>)}
      </div>
    </section>}
    <ProductConfiguration options={product.options || []} variants={product.variants || []} onImageChange={handleConfigurationImage} activeVariant={activeVariant} previewImage={optionImage || selected.image} productName={product.name} productSlug={product.slug} />
    {displayedGallery.length > 1 && <p className="mt-3 flex items-center gap-2 text-xs font-medium text-stone-500"><Images size={15} /> {isConfigurationActive ? "Фото доступних виконань скла." : "Натисніть мініатюру, щоб переглянути варіант."}</p>}
  </div>;
}
