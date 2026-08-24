import Link from "next/link";
import { ArrowUpRight, Layers3 } from "lucide-react";
import { categories, type Product } from "@/lib/catalog";
import { ImageLightbox } from "./image-lightbox";

export function ProductGrid({ products }: { products: Product[] }) {
  return <div className="grid grid-cols-2 gap-3 sm:gap-5 lg:grid-cols-3">
    {products.map((product) => { const hasPrice = product.price !== "Ціна за запитом"; return <article key={product.slug} className="group flex min-w-0 flex-col overflow-hidden rounded-2xl border border-stone-200/80 bg-white shadow-sm transition duration-300 hover:-translate-y-1 hover:border-stone-300 hover:shadow-xl">
      <div className="relative aspect-[4/5] overflow-hidden bg-[#f7f5f1] p-3 sm:p-5">
          <ImageLightbox src={product.image} alt={product.name} mobileOnly className="h-full w-full" imageClassName="h-full w-full object-contain transition duration-500 group-hover:scale-[1.035]" />
          <span className="absolute left-2 top-2 rounded-full bg-white/95 px-2 py-1 text-[8px] font-bold uppercase tracking-wider text-ink shadow-sm sm:left-3 sm:top-3 sm:px-3 sm:py-1.5 sm:text-[10px]">{categories[product.category].short}</span>
          <Link href={`/catalog/${product.slug}`} aria-label={`Детальніше: ${product.name}`} className="absolute right-2 top-2 flex h-7 w-7 items-center justify-center rounded-full bg-ink text-white shadow-sm transition hover:bg-clay sm:right-3 sm:top-3 sm:h-8 sm:w-8"><ArrowUpRight size={15} /></Link>
      </div>
      <Link href={`/catalog/${product.slug}`} className="flex flex-1 flex-col" aria-label={`Детальніше: ${product.name}`}>
        <div className="flex flex-1 flex-col p-3 sm:p-5">
          <p className="truncate text-[9px] font-bold uppercase tracking-[.1em] text-clay sm:text-[11px] sm:tracking-[.14em]">{product.brand}</p>
          <h3 className="mt-1 line-clamp-2 min-h-10 text-base font-bold leading-tight text-ink sm:min-h-12 sm:text-xl">{product.name}</h3>
          <p className="mt-1 truncate text-[11px] text-stone-500 sm:text-sm">Колекція: {product.collection}</p>
          <div className="mt-3 hidden min-h-7 items-center gap-1.5 text-xs text-stone-600 sm:flex"><Layers3 size={14} className="shrink-0 text-clay" /><span className="truncate">{product.material} · {product.color}</span></div>
          <div className="mt-3 flex items-end justify-between border-t border-stone-100 pt-3 sm:mt-5 sm:pt-4">
            <div><p className="text-[8px] font-bold uppercase tracking-wider text-stone-400 sm:text-[10px]">{hasPrice ? "Вартість" : "Консультація"}</p><span className="mt-1 block font-display text-base leading-tight text-ink sm:text-2xl">{hasPrice ? product.price : "Дізнатися ціну"}</span></div>
            <span className="hidden rounded-full bg-sand px-3 py-2 text-xs font-bold text-ink transition group-hover:bg-ink group-hover:text-white sm:inline-flex">{hasPrice ? "Детальніше" : "Прорахувати"}</span>
          </div>
        </div>
      </Link>
    </article>})}
  </div>;
}
