import { Contacts, OpeningHours } from "@/components/contacts";
import { SiteShell } from "@/components/site-shell";
import type { Metadata } from "next";

export const metadata: Metadata = { title: "Контакти салону дверей в Ужгороді", description: "Салон «Наші двері»: вул. Івана Чендея, 44, Ужгород. Телефони, карта, консультація, замір і прорахунок дверей та вікон.", alternates: { canonical: "/contacts" } };
export default function ContactsPage() { return <SiteShell><main><Contacts /><OpeningHours /></main></SiteShell> }
