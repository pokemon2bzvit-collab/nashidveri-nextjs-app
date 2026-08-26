const logoByBrand: Record<string, string> = {
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
  if (brand === "Grand") {
    return (
      <span className={`inline-flex min-w-0 items-center gap-1.5 ${className}`}>
        <img src="/brand-logos/grand-mark.svg" alt="" aria-hidden="true" className={`h-full w-auto shrink-0 object-contain ${imageClassName}`} />
        <img src="/brand-logos/grand.svg" alt="Grand — логотип виробника" className={`h-[84%] min-w-0 max-w-[78%] object-contain object-left ${imageClassName}`} />
      </span>
    );
  }
  const logo = logoByBrand[brand];
  if (!logo) return <span className={`font-display font-semibold tracking-[-.03em] text-ink ${className}`}>{brand}</span>;
  return <span className={`inline-flex min-w-0 items-center ${className}`}><img src={logo} alt={`${brand} — логотип виробника`} className={`h-full max-w-full object-contain object-left ${imageClassName}`} /></span>;
}
