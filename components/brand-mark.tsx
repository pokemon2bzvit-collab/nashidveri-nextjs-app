import { DoorOpen } from "lucide-react";

export function BrandMark({ dark = false }: { dark?: boolean }) {
  return <span className="inline-flex items-center gap-2.5" aria-label="Наші двері"><span className="flex h-9 w-9 items-center justify-center rounded-lg bg-[#d8a328] text-[#102d68]"><DoorOpen size={21} strokeWidth={2.4} /></span><span className="font-display text-sm font-black leading-[.9] tracking-[-.06em] sm:text-base"><span className={dark ? "text-white" : "text-[#102d68]"}>НАШІ</span><br /><span className="text-[#d8a328]">ДВЕРІ</span></span></span>;
}
