const logoByBrand: Record<string, string> = {
  Grand: "/brand-logos/grand.svg",
  "Papa Carlo": "/brand-logos/papa-carlo.svg",
  Rodos: "/brand-logos/rodos.png",
  StilDoors: "/brand-logos/stildoors.jpg",
  "Термінус": "/brand-logos/terminus.png",
  Abwehr: "/brand-logos/abwehr.png",
  "Страж": "/brand-logos/strazh.jpg",
  "Q Doors": "/brand-logos/qdoors.png",
  "Rodos Steel": "/brand-logos/rodos.png",
  Magda: "/brand-logos/magda.svg",
};

export function BrandLogo({ brand, className = "", imageClassName = "" }: { brand: string; className?: string; imageClassName?: string }) {
  const src = logoByBrand[brand];
  if (!src) return <span className={`font-display font-semibold tracking-[-.03em] text-ink ${className}`}>{brand}</span>;
  return <span className={`inline-flex min-w-0 items-center ${className}`}><img src={src} alt={`${brand} — логотип виробника`} className={`h-full max-w-full object-contain object-left ${imageClassName}`} /></span>;
}
