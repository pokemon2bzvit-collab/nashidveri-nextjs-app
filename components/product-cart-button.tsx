"use client";

import { Check, ShoppingBag } from "lucide-react";
import { type CartProduct, useCart } from "@/components/cart-provider";

export function ProductCartButton({ item, compact = false }: { item: CartProduct; compact?: boolean }) {
  const { items, addItem } = useCart();
  const isAdded = items.some((entry) => entry.slug === item.slug);
  const addConfiguredItem = () => {
    let configuration: string[] | undefined;
    let image = item.image;
    try {
      const saved: unknown = JSON.parse(window.localStorage.getItem(`nashi-dveri-config-${item.slug}`) || "[]");
      if (Array.isArray(saved)) configuration = saved.filter((value): value is string => typeof value === "string");
      if (saved && typeof saved === "object" && !Array.isArray(saved)) {
        const savedConfiguration = (saved as { configuration?: unknown }).configuration;
        const savedImage = (saved as { image?: unknown }).image;
        if (Array.isArray(savedConfiguration)) configuration = savedConfiguration.filter((value): value is string => typeof value === "string");
        if (typeof savedImage === "string" && savedImage) image = savedImage;
      }
    } catch { /* selected configuration is optional */ }
    addItem({ ...item, image, configuration });
  };
  if (isAdded) return <button type="button" onClick={addConfiguredItem} className={compact ? "inline-flex items-center gap-1 rounded-full border border-clay px-2.5 py-2 text-[10px] font-bold text-clay" : "button-light"}><Check size={compact ? 13 : 16} /> {compact ? "У кошику" : "Перейти до кошика"}</button>;
  return <button type="button" onClick={addConfiguredItem} className={compact ? "inline-flex items-center gap-1 rounded-full bg-ink px-2.5 py-2 text-[10px] font-bold text-white transition hover:bg-clay" : "button-primary"}><ShoppingBag size={compact ? 13 : 16} /> {compact ? "До кошика" : "Додати до кошика"}</button>;
}
