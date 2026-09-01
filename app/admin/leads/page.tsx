import { AdminRouteGuard } from "@/components/admin-route-guard";
import { LeadsDashboard } from "@/components/leads-dashboard";

export const metadata = { title: "Заявки — Адмінка «Наші двері»", robots: { index: false, follow: false } };

export default function AdminLeadsPage() {
  return <AdminRouteGuard><div><p className="text-xs font-bold uppercase tracking-[.16em] text-clay">Звернення клієнтів</p><h1 className="mt-2 font-display text-4xl">Заявки</h1><p className="mt-2 text-sm leading-6 text-stone-600">Відкривайте нові звернення, телефонуйте клієнтам і змінюйте статус роботи.</p><LeadsDashboard /></div></AdminRouteGuard>;
}
