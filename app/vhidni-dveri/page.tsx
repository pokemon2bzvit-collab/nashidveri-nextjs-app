import { EntranceBrands } from "@/components/entrance-brands";
import { SiteShell } from "@/components/site-shell";
import type { Metadata } from "next";

export const metadata: Metadata = { title: "Вхідні двері в Ужгороді", description: "Вхідні двері для квартири й будинку: Abwehr, Magda, Страж, Rodos Steel та інші фабрики. Безкоштовний замір і монтаж в Ужгороді.", alternates: { canonical: "/vhidni-dveri" } };

export default function EntranceDoorsPage() { return <SiteShell><main><EntranceBrands /></main></SiteShell>; }
