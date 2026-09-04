"use client";

import { createContext, useContext, useEffect, useMemo, useState } from "react";

export type CartItem = { slug: string; name: string; brand: string; collection: string; image: string };
type CartContextValue = {
  items: CartItem[];
  isOpen: boolean;
  addItem: (item: CartItem) => void;
  removeItem: (slug: string) => void;
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
      if (Array.isArray(saved)) setItems(saved.filter((item) => item?.slug && item?.name).slice(0, 12));
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
      setItems((current) => current.some((entry) => entry.slug === item.slug) ? current : [...current, item].slice(0, 12));
      setIsOpen(true);
    },
    removeItem: (slug) => setItems((current) => current.filter((item) => item.slug !== slug)),
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
