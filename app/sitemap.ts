import type { MetadataRoute } from "next";
import { getProducts } from "@/lib/catalog";
import { interiorBrands } from "@/lib/interior-brands";
import { entranceBrands } from "@/lib/entrance-brands";
import { absoluteUrl } from "@/lib/site";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const staticPages = ["/", "/catalog", "/mizhkimnatni-dveri", "/vhidni-dveri", "/vikna", "/pro-nas", "/contacts", "/portfolio"];
  const products = await getProducts();
  return [
    // У sitemap вказуємо лише канонічні URL. Не підставляємо поточну дату як
    // lastModified: Google використовує її тільки коли дата правдива.
    ...staticPages.map((path) => ({ url: absoluteUrl(path) })),
    ...interiorBrands.map((brand) => ({ url: absoluteUrl(`/mizhkimnatni-dveri/${brand.slug}`) })),
    ...entranceBrands.map((brand) => ({ url: absoluteUrl(`/vhidni-dveri/${brand.slug}`) })),
    ...products.map((product) => ({ url: absoluteUrl(`/catalog/${product.slug}`) })),
  ];
}
