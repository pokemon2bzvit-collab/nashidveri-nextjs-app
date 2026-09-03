import type { Metadata } from "next";
import "./globals.css";
import { absoluteUrl, jsonLd, salonAddress, siteName, siteUrl } from "@/lib/site";

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: { default: "Наші двері — двері та вікна в Ужгороді", template: "%s | Наші двері" },
  description: "Вхідні та міжкімнатні двері, вікна, професійний замір і монтаж в Ужгороді. Салон «Наші двері» на вулиці Івана Чендея, 44.",
  alternates: { canonical: "/" },
  openGraph: { type: "website", locale: "uk_UA", url: siteUrl, siteName, title: "Наші двері — двері та вікна в Ужгороді", description: "Вхідні та міжкімнатні двері, вікна, замір і монтаж в Ужгороді.", images: [{ url: "/nashi-dveri-logo-v3.png", alt: "Наші двері" }] },
  robots: { index: true, follow: true },
};

const storeSchema = {
  "@context": "https://schema.org",
  "@type": "Store",
  name: siteName,
  description: "Салон вхідних і міжкімнатних дверей та вікон в Ужгороді.",
  url: siteUrl,
  logo: absoluteUrl("/nashi-dveri-logo-v3.png"),
  image: absoluteUrl("/nashi-dveri-logo-v3.png"),
  telephone: ["+380950729341", "+380688155408"],
  email: "nashidveri.uzh@gmail.com",
  address: { "@type": "PostalAddress", streetAddress: "вулиця Івана Чендея, 44", addressLocality: "Ужгород", addressRegion: "Закарпатська область", postalCode: "88000", addressCountry: "UA" },
  sameAs: ["https://www.facebook.com/nashidveriuz", "https://www.instagram.com/nashi_dveri_uzh/"],
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="uk"><body><script type="application/ld+json" dangerouslySetInnerHTML={{ __html: jsonLd(storeSchema) }} />{children}</body></html>; }
