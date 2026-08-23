"use client";
import { useState } from "react";
import { Footer } from "./contacts";
import { Header } from "./header";
import { MeasureModal } from "./measure-modal";
import { MobileBar } from "./mobile-bar";
export function SiteShell({ children }: { children: React.ReactNode }) { const [modal, setModal] = useState(false); return <><Header onMeasure={() => setModal(true)} />{children}<Footer /><MobileBar /><MeasureModal open={modal} onClose={() => setModal(false)} /></>; }
