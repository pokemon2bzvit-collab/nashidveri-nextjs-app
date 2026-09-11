import { KfdImporter } from "@/components/kfd-importer";

export const metadata = { title: "Імпорт KFD — Адмінка «Наші двері»", robots: { index: false, follow: false } };

export default function KfdImportPage() {
  return <KfdImporter />;
}
