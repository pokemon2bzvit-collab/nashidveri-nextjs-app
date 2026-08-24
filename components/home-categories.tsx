import Link from "next/link";
import { ArrowUpRight } from "lucide-react";
import { catalogImageUrl } from "@/lib/catalog";

const featuredProducts = [
  { slug: "catalog-85", category: "Міжкімнатні двері", brand: "Papa Carlo", name: "ML-00", image: "/catalog-assets/products/product-85.jpg" },
  { slug: "catalog-1", category: "Вхідні двері", brand: "Abwehr", name: "Harmonia", image: "/catalog-assets/products/product-1.webp" },
  { slug: "catalog-152", category: "Вхідні двері", brand: "Rodos Steel", name: "F 120", image: "/catalog-assets/products/product-152.jpg" },
];

export function HomeCategories() {
  return <section className="container-page py-14 sm:py-20">
    <div className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
      <div><p className="eyebrow">Добірка моделей</p><h2 className="heading mt-3">Двері для вашого дому</h2></div>
      <Link href="/catalog" className="inline-flex w-fit items-center gap-2 text-sm font-bold text-clay transition hover:text-ink">Увесь каталог <ArrowUpRight size={17} /></Link>
    </div>
    <div className="mt-8 grid gap-4 sm:grid-cols-3">
      {featuredProducts.map((product) => <article key={product.slug} className="group overflow-hidden rounded-[1.5rem] border border-stone-200 bg-white">
        <Link href={`/catalog/${product.slug}`} className="flex h-72 items-center justify-center bg-[#f7f5f1] p-5 sm:h-64 lg:h-72" aria-label={`Переглянути ${product.brand} ${product.name}`}>
          <img src={catalogImageUrl(product.image)} alt={`${product.brand} ${product.name}`} className="h-full w-full object-contain transition duration-500 group-hover:scale-[1.03]" />
        </Link>
        <div className="p-5"><p className="text-xs font-semibold text-clay">{product.category}</p><h3 className="mt-2 font-display text-2xl tracking-[-.035em]">{product.brand} {product.name}</h3><p className="mt-2 text-sm text-stone-500">Ціна за запитом</p><Link href={`/catalog/${product.slug}`} className="mt-5 inline-flex items-center gap-2 text-sm font-bold text-ink">Детальніше <ArrowUpRight size={16} /></Link></div>
      </article>)}
    </div>
    <div className="mt-8 flex flex-col items-start justify-between gap-4 rounded-[1.5rem] bg-sand px-6 py-6 sm:flex-row sm:items-center sm:px-8"><p className="max-w-xl font-display text-2xl leading-tight text-ink sm:text-3xl">Не знаєте, з чого почати? Підберемо двері під ваш простір і бюджет.</p><Link href="/contacts" className="button-primary shrink-0">Замовити прорахунок <ArrowUpRight size={17} /></Link></div>
  </section>;
}
