import { Palette } from "lucide-react";
import { ImageLightbox } from "@/components/image-lightbox";
import type { Product } from "@/lib/catalog";

const loftSurfColors = [
  "Дуб білий",
  "Горіх",
  "Палісандр",
  "Шпон дуба LTL 6403",
  "Шпон дуба LTL 6515",
  "Шпон дуба LTL 6908",
  "Шпон дуба LTL 6112",
  "Шпон дуба LTL 6721",
];

export function ProductOptions({ product }: { product: Product }) {
  const hasLoftSurfOptions = product.brand === "Rodos" && product.name.toLowerCase().includes("loft surf") && product.name.toLowerCase().includes("шпон");
  if (!hasLoftSurfOptions) return null;

  return (
    <section className="mt-8 rounded-2xl border border-stone-200 bg-white p-5 shadow-sm">
      <div className="flex items-center gap-2 text-ink"><Palette size={18} className="text-clay" /><h2 className="font-display text-xl">Кольори та декори</h2></div>
      <p className="mt-2 text-sm leading-6 text-stone-600">Для Rodos Loft Surf Шпон доступні натуральні декори та фарбування за каталогом RAL.</p>
      <div className="mt-4 flex flex-wrap gap-2">
        {loftSurfColors.map((color) => <span key={color} className="rounded-full border border-stone-200 bg-stone-50 px-3 py-1.5 text-xs font-semibold text-stone-700">{color}</span>)}
      </div>
      <div className="mt-4 flex items-center gap-3 rounded-xl bg-sand p-3">
        <ImageLightbox src={product.image} alt="Палітра RAL для Rodos Loft Surf Шпон" className="h-16 w-12 shrink-0 rounded-lg bg-white" imageClassName="h-full w-full rounded-lg object-cover" />
        <p className="text-xs leading-5 text-stone-600"><span className="font-bold text-ink">Палітра RAL.</span> Натисніть, щоб збільшити. Конкретний декор і термін виготовлення підтвердить менеджер.</p>
      </div>
    </section>
  );
}
