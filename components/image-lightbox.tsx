"use client";

import { Expand, X } from "lucide-react";
import { useEffect, useRef, useState } from "react";

export function ImageLightbox({ src, alt, className = "", imageClassName = "", mobileOnly = false }: { src: string; alt: string; className?: string; imageClassName?: string; mobileOnly?: boolean }) {
  const [open, setOpen] = useState(false);
  const touchStartY = useRef<number | null>(null);
  useEffect(() => {
    const closeOnEscape = (event: KeyboardEvent) => { if (event.key === "Escape") setOpen(false); };
    window.addEventListener("keydown", closeOnEscape);
    return () => window.removeEventListener("keydown", closeOnEscape);
  }, []);
  useEffect(() => {
    if (!open) return;
    const previousOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => { document.body.style.overflow = previousOverflow; };
  }, [open]);

  const openViewer = () => { if (!mobileOnly || window.matchMedia("(max-width: 767px)").matches) setOpen(true); };
  return <><button type="button" aria-label={`Збільшити фото: ${alt}`} onClick={openViewer} className={`group relative block overflow-hidden ${mobileOnly ? "cursor-zoom-in md:cursor-default" : "cursor-zoom-in"} ${className}`}><img loading="lazy" src={src} alt={alt} className={imageClassName} /><span className={`absolute bottom-3 right-3 flex h-10 w-10 items-center justify-center rounded-full bg-ink/85 text-white opacity-100 shadow-sm transition sm:opacity-0 sm:group-hover:opacity-100 sm:group-focus-visible:opacity-100 ${mobileOnly ? "md:hidden" : ""}`}><Expand size={17} /></span></button>{open && <div role="dialog" aria-modal="true" aria-label={`Перегляд фото: ${alt}`} className="fixed inset-0 z-[100] bg-[#f7f5f1] sm:flex sm:items-center sm:justify-center sm:bg-black/90 sm:p-4" onClick={() => setOpen(false)}><div className="relative flex h-full w-full flex-col sm:max-h-[90vh] sm:max-w-5xl sm:rounded-2xl sm:bg-[#f7f5f1]" onClick={(event) => event.stopPropagation()} onTouchStart={(event) => { touchStartY.current = event.touches[0]?.clientY ?? null; }} onTouchEnd={(event) => { const startY = touchStartY.current; const endY = event.changedTouches[0]?.clientY; if (startY !== null && endY && endY - startY > 90) setOpen(false); touchStartY.current = null; }}><div className="flex shrink-0 items-center justify-between px-5 py-4 sm:px-6"><p className="max-w-[75%] truncate text-sm font-bold text-ink">{alt}</p><button type="button" aria-label="Закрити перегляд" onClick={() => setOpen(false)} className="flex h-11 w-11 items-center justify-center rounded-full bg-white text-ink shadow-sm"><X size={21} /></button></div><div className="flex min-h-0 flex-1 items-center justify-center px-3 pb-8 sm:p-6"><img src={src} alt={alt} className="max-h-full max-w-full object-contain" /></div><p className="pb-5 text-center text-xs font-medium text-stone-500 sm:hidden">Проведіть униз або натисніть ×, щоб закрити</p></div></div>}</>;
}
