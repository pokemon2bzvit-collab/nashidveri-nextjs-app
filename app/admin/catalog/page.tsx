import { AdminDashboard } from "@/components/admin-dashboard";

export const metadata = { title: "Товари — Адмінка «Наші двері»", robots: { index: false, follow: false } };

export default function AdminCatalogPage() {
  return <AdminDashboard />;
}
