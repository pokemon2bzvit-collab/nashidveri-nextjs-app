"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

const links = [
  ["/admin", "Огляд"],
  ["/admin/catalog", "Товари"],
  ["/admin/leads", "Заявки"],
  ["/admin/importers", "Імпорт"],
  ["/admin/preview", "Перегляд сайту"],
  ["/admin/structure", "Фабрики й колекції"],
];

export function AdminNavigation() {
  const pathname = usePathname();
  return <nav aria-label="Розділи адмінки" className="order-3 grid w-full grid-cols-3 gap-1 text-sm font-semibold lg:order-none lg:flex lg:w-auto">
    {links.map(([href, label]) => {
      const active = href === "/admin" ? pathname === href : href === "/admin/importers"
        ? ["/admin/importers", "/admin/rodos-import", "/admin/sitemaps"].includes(pathname)
        : pathname.startsWith(href);
      return <Link key={href} href={href} aria-current={active ? "page" : undefined}
        className={"flex min-h-11 items-center justify-center rounded-xl px-2 py-2 text-center text-xs transition focus-visible:outline focus-visible:outline-2 focus-visible:outline-clay sm:text-sm " + (active ? "bg-sand text-ink" : "text-stone-600 hover:bg-stone-100")}>{label}</Link>;
    })}
  </nav>;
}
