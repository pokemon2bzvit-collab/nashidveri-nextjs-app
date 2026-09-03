import { CategoryPage } from "@/components/category-page";
import type { Metadata } from "next";

export const metadata: Metadata = { title: "Вікна в Ужгороді", description: "Металопластикові й алюмінієві вікна для квартири, будинку та тераси. Підбір, замір, прорахунок і монтаж в Ужгороді.", alternates: { canonical: "/vikna" } };
export default async function WindowsPage() { return <CategoryPage category="windows" />; }
