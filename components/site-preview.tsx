"use client";

import { useState } from "react";
import { ExternalLink, Monitor, RefreshCw, Smartphone, Tablet } from "lucide-react";
import { AdminRouteGuard } from "@/components/admin-route-guard";

const modes = [
  { id: "mobile", title: "Телефон", width: "390px", icon: <Smartphone size={17} /> },
  { id: "tablet", title: "Планшет", width: "768px", icon: <Tablet size={17} /> },
  { id: "desktop", title: "ПК", width: "100%", icon: <Monitor size={17} /> },
] as const;

function SitePreviewContent() {
  const [mode, setMode] = useState<(typeof modes)[number]["id"]>("mobile");
  const [revision, setRevision] = useState(0);
  const current = modes.find((item) => item.id === mode)!;
  return <section className="space-y-5"><div className="rounded-3xl bg-ink px-5 py-8 text-white sm:px-8"><p className="text-xs font-bold uppercase tracking-[.16em] text-sand">Контроль вигляду</p><h1 className="mt-2 font-display text-4xl">Перегляд сайту</h1><p className="mt-3 max-w-2xl text-sm leading-6 text-white/70">Перевіряйте реальну публічну версію сайту перед відкриттям або після будь-яких змін.</p><div className="mt-5 flex flex-wrap gap-2">{modes.map((item) => <button key={item.id} onClick={() => setMode(item.id)} className={"inline-flex items-center gap-2 rounded-xl border px-3 py-2.5 text-sm font-bold transition " + (mode === item.id ? "border-white bg-white text-ink" : "border-white/30 bg-transparent text-white hover:bg-white/10")}>{item.icon}{item.title}</button>)}<button onClick={() => setRevision((value) => value + 1)} className="inline-flex items-center gap-2 rounded-xl border border-white/30 px-3 py-2.5 text-sm font-bold hover:bg-white/10"><RefreshCw size={16} /> Оновити</button><a href="/" target="_blank" rel="noreferrer" className="inline-flex items-center gap-2 rounded-xl border border-white/30 px-3 py-2.5 text-sm font-bold hover:bg-white/10">У новій вкладці <ExternalLink size={16} /></a></div></div><div className="rounded-2xl border bg-stone-200 p-3 shadow-inner sm:p-5"><div className="mx-auto overflow-hidden rounded-[1.75rem] border-8 border-stone-800 bg-white shadow-2xl transition-[max-width] duration-300" style={{ maxWidth: current.width }}><div className="flex h-7 items-center gap-1.5 bg-stone-800 px-4"><i className="size-2 rounded-full bg-red-400" /><i className="size-2 rounded-full bg-amber-300" /><i className="size-2 rounded-full bg-green-400" /></div><iframe key={revision} title={`Перегляд: ${current.title}`} src="/" className="h-[72dvh] min-h-[560px] w-full bg-white" /></div><p className="mx-auto mt-4 max-w-3xl text-center text-xs leading-5 text-stone-500">Це реальна версія, яку бачить покупець. Якщо технічний режим увімкнено, тут також відобразиться повідомлення про технічні роботи.</p></div></section>;
}
export function SitePreview() { return <AdminRouteGuard><SitePreviewContent /></AdminRouteGuard>; }
