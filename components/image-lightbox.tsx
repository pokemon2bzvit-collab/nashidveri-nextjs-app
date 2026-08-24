"use client";

import { Expand, X } from "lucide-react";
import { useEffect, useState } from "react";

export function ImageLightbox({ src, alt, className = "", imageClassName = "", mobileOnly = false }: { src: string; alt: string; className?: string; imageClassName?: string; mobileOnly?: boolean }) {
  const [open, setOpen] = useState(false);
  useEffect(() => {
    const closeOnEscape = (event: KeyboardEvent) => { if (event.key === "Escape") setOpen(false); };
    window.addEventListener("keydown", closeOnEscape);
    return () => window.removeEventListener("keydown", closeOnEscape);
  }, []);

  const openViewer = () => { if (!mobileOnly || window.matchMedia("(max-width: 767px)").matches) setOpen(true); };
  return <><button type="button" aria-label={`Збільшити фото: ${alt}`} onClick={openViewer} className={`group relative block overflow-hidden ${mobileOnly ? "cursor-zoom-in md:cursor-default" : "cursor-zoom-in"} ${className}`}><img loading="lazy" src={src} alt={alt} className={imageClassName} /><span className={`absolute bottom-3 right-3 flex h-9 w-9 items-center justify-center rounded-full bg-ink/85 text-white opacity-0 shadow-sm transition group-hover:opacity-100 group-focus-visible:opacity-100 ${mobileOnly ? "md:hidden" : ""}`}><Expand size={17} /></span></button>{open && <div role="dialog" aria-modal="true" aria-label={`Перегляд фото: ${alt}`} className="fixed inset-0 z-[100] flex items-center justify-center bg-black/90 p-0 sm:p-4" onClick={() => setOpen(false)}><div className="relative flex h-full w-full items-center justify-center sm:max-w-5xl" onClick={(event) => event.stopPropagation()}><img src={src} alt={alt} className="max-h-full max-w-full object-contain" /><button type="button" aria-label="Закрити перегляд" onClick={() => setOpen(false)} className="absolute right-3 top-3 flex h-11 w-11 items-center justify-center rounded-full bg-white text-ink shadow-lg"><X size={21} /></button></div></div>}</>;
}
