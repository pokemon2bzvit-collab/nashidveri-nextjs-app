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
  return <>
    <button type="button" aria-label={`Збільшити фото: ${alt}`} onClick={openViewer} className={`group relative block overflow-hidden ${mobileOnly ? "cursor-zoom-in md:cursor-default" : "cursor-zoom-in"} ${className}`}>
      <img loading="lazy" src={src} alt={alt} className={imageClassName} />
      <span className={`absolute bottom-3 right-3 flex h-10 w-10 items-center justify-center rounded-full bg-ink/85 text-white opacity-100 shadow-sm transition sm:opacity-0 sm:group-hover:opacity-100 sm:group-focus-visible:opacity-100 ${mobileOnly ? "md:hidden" : ""}`}><Expand size={17} /></span>
    </button>
    {open && <div role="dialog" aria-modal="true" aria-label={`Перегляд фото: ${alt}`} className="lightbox-backdrop fixed inset-0 z-[100] flex items-center justify-center bg-black/75 p-3 sm:bg-black/90 sm:p-6" onClick={() => setOpen(false)}>
      <div className="lightbox-content relative flex max-h-[90svh] max-w-[94vw] items-center justify-center" onClick={(event) => event.stopPropagation()} onTouchStart={(event) => { touchStartY.current = event.touches[0]?.clientY ?? null; }} onTouchEnd={(event) => { const startY = touchStartY.current; const endY = event.changedTouches[0]?.clientY; if (startY !== null && endY && endY - startY > 90) setOpen(false); touchStartY.current = null; }}>
        <img src={src} alt={alt} className="max-h-[86svh] max-w-[92vw] rounded-xl object-contain shadow-2xl sm:max-h-[88vh] sm:max-w-[88vw] sm:rounded-2xl" />
        <button type="button" aria-label="Закрити перегляд" onClick={() => setOpen(false)} className="absolute right-2 top-2 flex h-10 w-10 items-center justify-center rounded-full bg-black/55 text-white backdrop-blur-sm transition hover:bg-black/75"><X size={20} /></button>
      </div>
    </div>}
  </>;
}
