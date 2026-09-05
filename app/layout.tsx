import type { Metadata } from "next";
import "./globals.css";
import { absoluteUrl, jsonLd, salonAddress, siteName, siteUrl } from "@/lib/site";

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: { default: "Наші двері — двері та вікна в Ужгороді", template: "%s | Наші двері" },
  description: "Вхідні та міжкімнатні двері, вікна, професійний замір і монтаж в Ужгороді. Салон «Наші двері» на вулиці Івана Чендея, 44.",
  alternates: { canonical: "/" },
  openGraph: { type: "website", locale: "uk_UA", url: siteUrl, siteName, title: "Наші двері — двері та вікна в Ужгороді", description: "Вхідні та міжкімнатні двері, вікна, замір і монтаж в Ужгороді.", images: [{ url: "/nashi-dveri-logo-v3.png", alt: "Наші двері" }] },
  // Сайт ще готується до публічного запуску. Перед відкриттям пошуку
  // змінити на { index: true, follow: true } та оновити app/robots.ts.
  robots: { index: false, follow: false },
};

const storeSchema = {
  "@context": "https://schema.org",
  "@type": ["Store", "HomeGoodsStore"],
  "@id": `${siteUrl}/#store`,
  name: siteName,
  description: "Салон вхідних і міжкімнатних дверей та вікон в Ужгороді: підбір, замір, доставка і монтаж.",
  url: siteUrl,
  logo: absoluteUrl("/nashi-dveri-logo-v3.png"),
  image: absoluteUrl("/nashi-dveri-logo-v3.png"),
  telephone: ["+380950729341", "+380688155408"],
  email: "nashidveri.uzh@gmail.com",
  priceRange: "₴₴",
  currenciesAccepted: "UAH",
  paymentAccepted: "Готівка, банківська картка, безготівковий розрахунок",
  areaServed: { "@type": "City", name: "Ужгород" },
  hasMap: "https://www.google.com/maps/search/?api=1&query=вул.+Івана+Чендея,+44,+Ужгород,+88000",
  address: { "@type": "PostalAddress", streetAddress: "вулиця Івана Чендея, 44", addressLocality: "Ужгород", addressRegion: "Закарпатська область", postalCode: "88000", addressCountry: "UA" },
  contactPoint: [
    { "@type": "ContactPoint", telephone: "+380950729341", contactType: "sales", areaServed: "UA", availableLanguage: ["uk"] },
    { "@type": "ContactPoint", telephone: "+380688155408", contactType: "sales", areaServed: "UA", availableLanguage: ["uk"] },
  ],
  openingHoursSpecification: [
    { "@type": "OpeningHoursSpecification", dayOfWeek: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"], opens: "10:00", closes: "18:00" },
    { "@type": "OpeningHoursSpecification", dayOfWeek: "Saturday", opens: "10:00", closes: "15:00" },
  ],
  sameAs: ["https://www.facebook.com/nashidveriuz", "https://www.instagram.com/nashi_dveri_uzh/"],
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="uk"><body><script type="application/ld+json" dangerouslySetInnerHTML={{ __html: jsonLd(storeSchema) }} />{children}</body></html>; }
