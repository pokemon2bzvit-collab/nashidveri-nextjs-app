import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = { title: "Наші двері — двері та вікна в Ужгороді", description: "Бюджетні і брендові двері Ужгород. Вхідні, міжкімнатні двері та вікна." };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="uk"><body>{children}</body></html>; }
