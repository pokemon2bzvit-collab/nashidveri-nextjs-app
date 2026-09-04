"use client";

import { createContext, useContext, useEffect, useMemo, useState } from "react";

export type CartProduct = { slug: string; name: string; brand: string; collection: string; image: string };
export type CartItem = CartProduct & { quantity: number };
type CartContextValue = {
  items: CartItem[];
  isOpen: boolean;
  addItem: (item: CartProduct) => void;
  removeItem: (slug: string) => void;
  updateQuantity: (slug: string, quantity: number) => void;
  clear: () => void;
  openCart: () => void;
  closeCart: () => void;
};

const CartContext = createContext<CartContextValue | null>(null);
const storageKey = "nashi-dveri-cart";

export function CartProvider({ children }: { children: React.ReactNode }) {
  const [items, setItems] = useState<CartItem[]>([]);
  const [isOpen, setIsOpen] = useState(false);

  useEffect(() => {
    try {
      const saved = JSON.parse(window.localStorage.getItem(storageKey) || "[]") as CartItem[];
      if (Array.isArray(saved)) setItems(saved.filter((item) => item?.slug && item?.name).slice(0, 12).map((item) => ({ ...item, quantity: Math.min(99, Math.max(1, Number(item.quantity) || 1)) })));
    } catch {
      window.localStorage.removeItem(storageKey);
    }
  }, []);
  useEffect(() => {
    window.localStorage.setItem(storageKey, JSON.stringify(items));
  }, [items]);

  const value = useMemo<CartContextValue>(() => ({
    items,
    isOpen,
    addItem: (item) => {
      setItems((current) => current.some((entry) => entry.slug === item.slug) ? current : [...current, { ...item, quantity: 1 }].slice(0, 12));
      setIsOpen(true);
    },
    removeItem: (slug) => setItems((current) => current.filter((item) => item.slug !== slug)),
    updateQuantity: (slug, quantity) => setItems((current) => current.map((item) => item.slug === slug ? { ...item, quantity: Math.min(99, Math.max(1, quantity)) } : item)),
    clear: () => setItems([]),
    openCart: () => setIsOpen(true),
    closeCart: () => setIsOpen(false),
  }), [items, isOpen]);

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
}

export function useCart() {
  const context = useContext(CartContext);
  if (!context) throw new Error("useCart must be used within CartProvider");
  return context;
}
