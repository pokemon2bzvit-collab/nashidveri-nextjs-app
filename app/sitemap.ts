import type { MetadataRoute } from "next";
import { getProducts } from "@/lib/catalog";
import { interiorBrands } from "@/lib/interior-brands";
import { entranceBrands } from "@/lib/entrance-brands";
import { absoluteUrl } from "@/lib/site";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const staticPages = ["/", "/catalog", "/mizhkimnatni-dveri", "/vhidni-dveri", "/vikna", "/pro-nas", "/contacts", "/portfolio"];
  const products = await getProducts();
  return [
    ...staticPages.map((path) => ({ url: absoluteUrl(path), lastModified: new Date(), changeFrequency: "weekly" as const, priority: path === "/" ? 1 : path === "/catalog" ? 0.9 : 0.7 })),
    ...interiorBrands.map((brand) => ({ url: absoluteUrl(`/mizhkimnatni-dveri/${brand.slug}`), lastModified: new Date(), changeFrequency: "monthly" as const, priority: 0.75 })),
    ...entranceBrands.map((brand) => ({ url: absoluteUrl(`/vhidni-dveri/${brand.slug}`), lastModified: new Date(), changeFrequency: "monthly" as const, priority: 0.75 })),
    ...products.map((product) => ({ url: absoluteUrl(`/catalog/${product.slug}`), lastModified: new Date(), changeFrequency: "monthly" as const, priority: 0.8 })),
  ];
}
