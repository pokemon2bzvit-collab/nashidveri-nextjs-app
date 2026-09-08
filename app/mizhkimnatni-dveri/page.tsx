import { InteriorBrands } from "@/components/interior-brands";
import { SiteShell } from "@/components/site-shell";
import type { Metadata } from "next";

export const metadata: Metadata = { title: "Міжкімнатні двері в Ужгороді", description: "Міжкімнатні двері сучасного й класичного дизайну: Papa Carlo, Rodos, Термінус та StilDoors. Підбір, замір і монтаж в Ужгороді.", alternates: { canonical: "/mizhkimnatni-dveri" } };

export default function InteriorDoorsPage() { return <SiteShell><main><InteriorBrands /></main></SiteShell>; }
