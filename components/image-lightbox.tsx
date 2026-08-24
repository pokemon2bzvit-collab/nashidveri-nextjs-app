"use client";

import { Expand, X } from "lucide-react";
import { useEffect, useState } from "react";

export function ImageLightbox({ src, alt, className = "", imageClassName = "" }: { src: string; alt: string; className?: string; imageClassName?: string }) {
  const [open, setOpen] = useState(false);
  useEffect(() => {
    const closeOnEscape = (event: KeyboardEvent) => { if (event.key === "Escape") setOpen(false); };
    window.addEventListener("keydown", closeOnEscape);
    return () => window.removeEventListener("keydown", closeOnEscape);
  }, []);

  return <><button type="button" aria-label={`Збільшити фото: ${alt}`} onClick={() => setOpen(true)} className={`group relative block overflow-hidden ${className}`}><img loading="lazy" src={src} alt={alt} className={imageClassName} /><span className="absolute bottom-3 right-3 flex h-9 w-9 items-center justify-center rounded-full bg-ink/85 text-white opacity-0 shadow-sm transition group-hover:opacity-100 group-focus-visible:opacity-100"><Expand size={17} /></span></button>{open && <div role="dialog" aria-modal="true" aria-label={`Перегляд фото: ${alt}`} className="fixed inset-0 z-[100] flex items-center justify-center bg-black/85 p-4" onClick={() => setOpen(false)}><div className="relative flex h-full w-full max-w-5xl items-center justify-center" onClick={(event) => event.stopPropagation()}><img src={src} alt={alt} className="max-h-full max-w-full object-contain" /><button type="button" aria-label="Закрити перегляд" onClick={() => setOpen(false)} className="absolute right-0 top-0 flex h-11 w-11 items-center justify-center rounded-full bg-white text-ink shadow-lg"><X size={21} /></button></div></div>}</>;
}
