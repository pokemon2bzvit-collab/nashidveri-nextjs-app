"use client";

import { Check, ShoppingBag } from "lucide-react";
import { type CartProduct, useCart } from "@/components/cart-provider";

export function ProductCartButton({ item, compact = false }: { item: CartProduct; compact?: boolean }) {
  const { items, addItem, openCart } = useCart();
  const isAdded = items.some((entry) => entry.slug === item.slug);
  if (isAdded) return <button type="button" onClick={openCart} className={compact ? "inline-flex items-center gap-1 rounded-full border border-clay px-2.5 py-2 text-[10px] font-bold text-clay" : "button-light"}><Check size={compact ? 13 : 16} /> {compact ? "У кошику" : "Перейти до кошика"}</button>;
  return <button type="button" onClick={() => addItem(item)} className={compact ? "inline-flex items-center gap-1 rounded-full bg-ink px-2.5 py-2 text-[10px] font-bold text-white transition hover:bg-clay" : "button-primary"}><ShoppingBag size={compact ? 13 : 16} /> {compact ? "До кошика" : "Додати до кошика"}</button>;
}
