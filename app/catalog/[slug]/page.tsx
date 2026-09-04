import { notFound } from "next/navigation";
import Link from "next/link";
import type { Metadata } from "next";
import { Check, ChevronLeft, Phone } from "lucide-react";
import { categories, getProduct, getProducts } from "@/lib/catalog";
import { ProductGrid } from "@/components/product-grid";
import { SiteShell } from "@/components/site-shell";
import { BrandLogo } from "@/components/brand-logo";
import { ProductMediaGallery } from "@/components/product-media-gallery";
import { ProductSpecifications } from "@/components/product-specifications";
import { ProductDescription } from "@/components/product-description";
import { ProductLeadButton } from "@/components/product-lead-button";
import { ProductCartButton } from "@/components/product-cart-button";
import { absoluteUrl, jsonLd, siteName } from "@/lib/site";

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const slug = (await params).slug;
  const product = await getProduct(slug);
  if (!product) return { title: "Модель не знайдена" };
  const category = categories[product.category].short.toLowerCase();
  const keySpecs = (product.specs || []).slice(0, 2).map((spec) => `${spec.label}: ${spec.value}`).join(". ");
  const description = `${product.name} — ${product.brand}, колекція ${product.collection}. ${keySpecs ? `${keySpecs}. ` : ""}Декори, характеристики та консультація в салоні «Наші двері» в Ужгороді.`;
  return {
    title: `${product.name} — ${category} ${product.brand}`,
    description,
    alternates: { canonical: `/catalog/${product.slug}` },
    openGraph: { type: "website", title: `${product.name} — ${siteName}`, description, images: [{ url: absoluteUrl(product.image), alt: `${product.name}, ${product.brand}` }] },
  };
}

export default async function ProductPage({ params }: { params: Promise<{ slug: string }> }) {
  const slug = (await params).slug;
  // Модель і картки «Ще в колекції» завантажуємо паралельно, без двох послідовних очікувань.
  const [product, catalog] = await Promise.all([getProduct(slug), getProducts()]);
  if (!product) notFound();
  const fromCollection = catalog.filter((item) => item.brand === product.brand && item.collection === product.collection && item.slug !== product.slug);
  const fromBrand = catalog.filter((item) => item.brand === product.brand && item.slug !== product.slug);
  const similar = (fromCollection.length ? fromCollection : fromBrand).slice(0, 3);
  const collectionHref = `/catalog?brand=${encodeURIComponent(product.brand)}&collection=${encodeURIComponent(product.collection)}`;
  const similarTitle = fromCollection.length ? `Ще в колекції ${product.collection}` : `Інші моделі ${product.brand}`;
  const visibleColors = [...new Set((product.options || []).filter((option) => option.group === "color" || option.group === "finish").map((option) => option.label))];
  const productSchema = { "@context": "https://schema.org", "@type": "Product", name: product.name, image: [absoluteUrl(product.image), ...(product.media || []).filter((media) => media.kind !== "palette").map((media) => absoluteUrl(media.image))], description: product.description, sku: product.slug, brand: { "@type": "Brand", name: product.brand }, category: categories[product.category].title, color: visibleColors.length ? visibleColors.join(", ") : undefined, url: absoluteUrl(`/catalog/${product.slug}`), additionalProperty: (product.specs || []).map((spec) => ({ "@type": "PropertyValue", name: spec.label, value: spec.value })) };
  const breadcrumbSchema = { "@context": "https://schema.org", "@type": "BreadcrumbList", itemListElement: [{ "@type": "ListItem", position: 1, name: "Головна", item: absoluteUrl("/") }, { "@type": "ListItem", position: 2, name: categories[product.category].title, item: absoluteUrl(`/catalog?category=${product.category}`) }, { "@type": "ListItem", position: 3, name: product.brand, item: absoluteUrl(`/catalog?brand=${encodeURIComponent(product.brand)}`) }, { "@type": "ListItem", position: 4, name: product.name, item: absoluteUrl(`/catalog/${product.slug}`) }] };
  return <SiteShell><main className="container-page section-pad"><script type="application/ld+json" dangerouslySetInnerHTML={{ __html: jsonLd(productSchema) }} /><script type="application/ld+json" dangerouslySetInnerHTML={{ __html: jsonLd(breadcrumbSchema) }} /><Link href={collectionHref} className="inline-flex items-center gap-1 text-sm font-bold text-stone-500 hover:text-clay"><ChevronLeft size={17} /> До колекції {product.collection}</Link><div className="mt-7 grid gap-9 lg:grid-cols-2 lg:items-start"><ProductMediaGallery product={product} /><div className="lg:pt-7"><BrandLogo brand={product.brand} className="h-8 max-w-[180px]" /><p className="mt-3 text-xs font-bold uppercase tracking-[.14em] text-clay">Колекція {product.collection}</p><h1 className="heading mt-3">{product.name}</h1><ProductDescription description={product.description} /><p className="mt-7 font-display text-3xl text-clay">{product.price === "Ціна за запитом" ? "Дізнатися ціну" : product.price}</p><div className="mt-8 rounded-2xl bg-sand p-5"><p className="text-sm font-bold">Основна інформація</p><ul className="mt-4 space-y-3">{product.features.map((feature) => <li key={feature} className="flex items-center gap-3 text-sm"><Check size={17} className="text-clay" />{feature}</li>)}</ul></div><ProductSpecifications specs={product.specs} /><div className="mt-7 flex flex-col gap-3 sm:flex-row"><ProductCartButton item={{ slug: product.slug, name: product.name, brand: product.brand, collection: product.collection, image: product.image }} /><ProductLeadButton productSlug={product.slug} productName={product.name} /><a href="tel:+380950729341" className="button-light"><Phone size={17} /> Подзвонити</a><Link href="/contacts" className="button-light">Записатися на замір</Link></div></div></div>{similar.length > 0 && <section className="mt-20"><BrandLogo brand={product.brand} className="h-6 max-w-[150px]" /><h2 className="mt-3 font-display text-4xl">{similarTitle}</h2><div className="mt-8"><ProductGrid products={similar} /></div></section>}</main></SiteShell>;
}
