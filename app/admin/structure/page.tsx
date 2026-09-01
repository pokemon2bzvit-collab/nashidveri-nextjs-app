import { AdminRouteGuard } from "@/components/admin-route-guard";
import { CatalogManagement } from "@/components/catalog-management";

export const metadata = { title: "Структура каталогу — Адмінка «Наші двері»", robots: { index: false, follow: false } };

export default function AdminStructurePage() {
  return <AdminRouteGuard><div><p className="text-xs font-bold uppercase tracking-[.16em] text-clay">Фабрики та колекції</p><h1 className="mt-2 font-display text-4xl">Структура каталогу</h1><p className="mt-2 text-sm leading-6 text-stone-600">Тут можна додати або відредагувати фабрику, колекцію та базові дані товарів.</p><CatalogManagement /></div></AdminRouteGuard>;
}
