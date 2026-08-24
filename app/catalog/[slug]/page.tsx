import { notFound } from "next/navigation";
import Link from "next/link";
import { Check, ChevronLeft, Phone } from "lucide-react";
import { getProduct, getProducts } from "@/lib/catalog";
import { ProductGrid } from "@/components/product-grid";
import { SiteShell } from "@/components/site-shell";
import { ImageLightbox } from "@/components/image-lightbox";

export default async function ProductPage({ params }: { params: Promise<{ slug: string }> }) {
  const product = await getProduct((await params).slug);
  if (!product) notFound();
  const catalog = await getProducts();
  const fromCollection = catalog.filter((item) => item.brand === product.brand && item.collection === product.collection && item.slug !== product.slug);
  const fromBrand = catalog.filter((item) => item.brand === product.brand && item.slug !== product.slug);
  const similar = (fromCollection.length ? fromCollection : fromBrand).slice(0, 3);
  const collectionHref = `/catalog?brand=${encodeURIComponent(product.brand)}&collection=${encodeURIComponent(product.collection)}`;
  const similarTitle = fromCollection.length ? `Ще в колекції ${product.collection}` : `Інші моделі ${product.brand}`;
  return <SiteShell><main className="container-page section-pad"><Link href={collectionHref} className="inline-flex items-center gap-1 text-sm font-bold text-stone-500 hover:text-clay"><ChevronLeft size={17} /> До колекції {product.collection}</Link><div className="mt-7 grid gap-9 lg:grid-cols-2 lg:items-start"><div className="aspect-[4/5] overflow-hidden rounded-[2rem] bg-[#f7f5f1] p-5 sm:p-8"><ImageLightbox src={product.image} alt={product.name} className="h-full w-full" imageClassName="h-full w-full object-contain" /></div><div className="lg:pt-7"><p className="eyebrow">{product.brand} · {product.collection}</p><h1 className="heading mt-3">{product.name}</h1><p className="mt-5 max-w-lg text-lg leading-8 text-stone-600">{product.description}</p><p className="mt-7 font-display text-3xl text-clay">{product.price === "Ціна за запитом" ? "Дізнатися ціну" : product.price}</p><div className="mt-8 rounded-2xl bg-sand p-5"><p className="text-sm font-bold">Основні характеристики</p><ul className="mt-4 space-y-3">{product.features.map((feature) => <li key={feature} className="flex items-center gap-3 text-sm"><Check size={17} className="text-clay" />{feature}</li>)}</ul></div><div className="mt-7 flex flex-col gap-3 sm:flex-row"><a href="tel:+380950729341" className="button-primary"><Phone size={17} /> Замовити консультацію</a><Link href="/contacts" className="button-light">Записатися на замір</Link></div></div></div>{similar.length > 0 && <section className="mt-20"><p className="eyebrow">{product.brand}</p><h2 className="mt-3 font-display text-4xl">{similarTitle}</h2><div className="mt-8"><ProductGrid products={similar} /></div></section>}</main></SiteShell>;
}
