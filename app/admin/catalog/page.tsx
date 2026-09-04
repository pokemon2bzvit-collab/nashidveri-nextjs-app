import { Suspense } from "react";
import { AdminDashboard } from "@/components/admin-dashboard";

export const metadata = { title: "Товари — Адмінка «Наші двері»", robots: { index: false, follow: false } };

export default function AdminCatalogPage() {
  return <Suspense fallback={<main className="grid min-h-screen place-items-center bg-stone-50 text-sm text-stone-500">Завантажуємо адмінку…</main>}><AdminDashboard /></Suspense>;
}
