import Link from "next/link";
import { ArrowUpRight, Palette, Sparkles } from "lucide-react";
import { categories, type Product, type ProductOption, type ProductSpec } from "@/lib/catalog";
import { BrandLogo } from "./brand-logo";
import { ProductCartButton } from "./product-cart-button";

const visualDecorOptions = (product: Product) => {
  const visualKeys = new Set((product.variants || []).flatMap((variant) => Object.entries(variant.selections)
    .filter(([group, label]) => Boolean(variant.image) && (group === "color" || group === "finish") && Boolean(label))
    .map(([group, label]) => `${group}:${label}`)));
  return (product.options || []).filter((option) => (option.group === "color" || option.group === "finish") && visualKeys.has(`${option.group}:${option.label}`));
};

const productHighlights = (product: Product) => {
  const source = `${product.description} ${product.features.join(" ")}`.toLowerCase();
  const highlights: string[] = [];
  if (/терморозрив/.test(source)) highlights.push("Терморозрив");
  if (/дзеркал/.test(source)) highlights.push("Дзеркало");
  if (/шпон/.test(source)) highlights.push("Шпон");
  if (/екошпон/.test(source)) highlights.push("Екошпон");
  if (/пвх/.test(source)) highlights.push("ПВХ");
  if (/фарб/.test(source) && !highlights.includes("ПВХ")) highlights.push("Фарба");
  if (!highlights.length && product.category === "entrance" && product.collection === "Квартира") highlights.push("Для квартири");
  if (!highlights.length && product.category === "entrance" && product.collection === "Вулиця") highlights.push("Для будинку");
  if (!highlights.length && product.category === "interior") highlights.push("Міжкімнатні");
  return highlights.slice(0, 2);
};

const specPriority = (label: string) => {
  const normalized = label.toLowerCase();
  if (/розмір|габарит/.test(normalized)) return 0;
  if (/товщина.*(полот|сталі|метал)|товщина/.test(normalized)) return 1;
  if (/покрит|оздоблен|матеріал/.test(normalized)) return 2;
  if (/утеплен|терморозрив|ущільнен/.test(normalized)) return 3;
  if (/скло|замок/.test(normalized)) return 4;
  return 10;
};

const keySpecs = (specs?: ProductSpec[]) => [...(specs || [])]
  .sort((left, right) => specPriority(left.label) - specPriority(right.label) || left.sortOrder - right.sortOrder)
  .slice(0, 3);

function DecorPreview({ option }: { option: ProductOption }) {
  if (option.image) return <img src={option.image} alt="" className="h-full w-full object-cover" />;
  if (option.swatch) return <span aria-hidden="true" className="block h-full w-full" style={{ backgroundColor: option.swatch }} />;
  return <span className="block h-full w-full bg-stone-200" />;
}

const productImageAlt = (product: Product) => {
  const category = product.category === "windows" ? "Вікна" : `${categories[product.category].short} двері`;
  return `${category} ${product.brand} ${product.name}, колекція ${product.collection}`;
};

export function ProductGrid({ products }: { products: Product[] }) {
  return <div className="grid grid-cols-2 gap-3 sm:gap-5 lg:grid-cols-3">
    {products.map((product) => { const hasPrice = product.price !== "Ціна за запитом"; const decorOptions = visualDecorOptions(product); const highlights = productHighlights(product); const specs = keySpecs(product.specs); return <article key={product.slug} className="group flex min-w-0 flex-col overflow-hidden rounded-2xl border border-stone-200/80 bg-white shadow-sm transition duration-300 hover:-translate-y-1 hover:border-stone-300 hover:shadow-xl">
      <Link href={`/catalog/${product.slug}`} className="relative aspect-[4/5] overflow-hidden bg-[#f7f5f1] p-3 sm:p-5" aria-label={`Детальніше: ${product.name}`}>
          <img loading="lazy" decoding="async" src={product.image} alt={productImageAlt(product)} className="h-full w-full object-contain transition duration-500 group-hover:scale-[1.035]" />
          <span className="absolute left-2 top-2 rounded-full bg-white/95 px-2 py-1 text-[8px] font-bold uppercase tracking-wider text-ink shadow-sm sm:left-3 sm:top-3 sm:px-3 sm:py-1.5 sm:text-[10px]">{categories[product.category].short}</span>
          <span className="absolute right-2 top-2 flex h-7 w-7 items-center justify-center rounded-full bg-ink text-white shadow-sm transition group-hover:bg-clay sm:right-3 sm:top-3 sm:h-8 sm:w-8"><ArrowUpRight size={15} /></span>
      </Link>
      <Link href={`/catalog/${product.slug}`} className="flex flex-1 flex-col" aria-label={`Детальніше: ${product.name}`}>
        <div className="flex flex-1 flex-col p-3 sm:p-5">
          <BrandLogo brand={product.brand} className="h-4 max-w-[125px] sm:h-5 sm:max-w-[145px]" />
          <h3 className="mt-1 line-clamp-2 min-h-10 text-base font-bold leading-tight text-ink sm:min-h-12 sm:text-xl">{product.name}</h3>
          <p className="mt-1 truncate text-[11px] text-stone-500 sm:text-sm">Колекція: {product.collection}</p>
          <div className="mt-3 flex min-h-6 flex-wrap gap-1.5">{highlights.map((item) => <span key={item} className="rounded-full bg-sand px-2 py-1 text-[9px] font-bold text-stone-600 sm:text-[10px]">{item}</span>)}</div>
          {decorOptions.length > 0 ? <div className="mt-3 flex items-center gap-2" title={`${decorOptions.length} декорів з підтвердженим фото`}><div className="flex -space-x-1.5">{decorOptions.slice(0, 3).map((option) => <span key={`${option.group}-${option.label}`} className="h-6 w-6 overflow-hidden rounded-full border-2 border-white bg-stone-100 shadow-sm sm:h-7 sm:w-7"><DecorPreview option={option} /></span>)}</div><span className="inline-flex min-w-0 items-center gap-1 text-[10px] font-bold text-clay sm:text-xs"><Palette size={12} /> <span className="truncate">{decorOptions.length} {decorOptions.length === 1 ? "декор з фото" : "декори з фото"}</span></span></div> : <div className="mt-3 min-h-7" />}
          <p className="mt-3 line-clamp-2 min-h-8 text-[11px] leading-4 text-stone-600 sm:min-h-10 sm:text-xs sm:leading-5">{product.description}</p>
          {specs.length > 0 ? <dl className="mt-3 hidden divide-y divide-stone-100 border-y border-stone-100 text-[10px] leading-4 text-stone-600 sm:block">{specs.map((spec) => <div key={spec.label} className="flex items-baseline justify-between gap-3 py-1.5"><dt className="truncate text-stone-400">{spec.label}</dt><dd className="max-w-[58%] text-right font-semibold text-ink">{spec.value}</dd></div>)}</dl> : null}
          <div className="mt-3 flex items-end justify-between border-t border-stone-100 pt-3 sm:mt-5 sm:pt-4">
            <div><p className="text-[8px] font-bold uppercase tracking-wider text-stone-400 sm:text-[10px]">{hasPrice ? "Вартість" : "Консультація"}</p><span className="mt-1 block font-display text-base leading-tight text-ink sm:text-2xl">{hasPrice ? product.price : "Дізнатися ціну"}</span></div>
            <span className="inline-flex items-center gap-1 rounded-full bg-sand px-2.5 py-2 text-[10px] font-bold text-ink transition group-hover:bg-ink group-hover:text-white sm:px-3 sm:text-xs">Детальніше <Sparkles size={12} /></span>
          </div>
        </div>
      </Link>
      <div className="border-t border-stone-100 px-3 py-2.5 sm:px-5 sm:py-3"><ProductCartButton compact item={{ slug: product.slug, name: product.name, brand: product.brand, collection: product.collection, image: product.image }} /></div>
    </article>})}
  </div>;
}
