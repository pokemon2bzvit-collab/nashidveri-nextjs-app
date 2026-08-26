const logoByBrand: Record<string, { full: string; compact?: string }> = {
  Grand: { full: "/brand-logos/grand.svg", compact: "/brand-logos/grand-mark.svg" },
  "Papa Carlo": { full: "/brand-logos/papa-carlo.svg" },
  Rodos: { full: "/brand-logos/rodos.png" },
  StilDoors: { full: "/brand-logos/stildoors.jpg" },
  "Термінус": { full: "/brand-logos/terminus.png" },
  Abwehr: { full: "/brand-logos/abwehr.png" },
  "Страж": { full: "/brand-logos/strazh.jpg" },
  "Q Doors": { full: "/brand-logos/qdoors.png" },
  "Rodos Steel": { full: "/brand-logos/rodos.png" },
  Magda: { full: "/brand-logos/magda.svg" },
};

export function BrandLogo({ brand, className = "", imageClassName = "", compact = false }: { brand: string; className?: string; imageClassName?: string; compact?: boolean }) {
  const logo = logoByBrand[brand];
  if (!logo) return <span className={`font-display font-semibold tracking-[-.03em] text-ink ${className}`}>{brand}</span>;
  const src = compact ? logo.compact || logo.full : logo.full;
  return <span className={`inline-flex min-w-0 items-center ${className}`}><img src={src} alt={`${brand} — логотип виробника`} className={`h-full max-w-full object-contain object-left ${imageClassName}`} /></span>;
}
