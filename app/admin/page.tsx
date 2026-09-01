import { AdminOverview } from "@/components/admin-overview";

export const metadata = { title: "Адмінка — Наші двері", robots: { index: false, follow: false } };

export default function AdminPage() {
  return <AdminOverview />;
}
