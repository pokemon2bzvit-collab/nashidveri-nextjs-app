"use client";
import { useState } from "react";
import { Footer } from "./contacts";
import { Header } from "./header";
import { MeasureModal } from "./measure-modal";
import { MobileBar } from "./mobile-bar";
import { CartDrawer } from "./cart-drawer";
import { CartProvider } from "./cart-provider";
export function SiteShell({ children }: { children: React.ReactNode }) { const [modal, setModal] = useState(false); return <CartProvider><Header onMeasure={() => setModal(true)} />{children}<Footer /><MobileBar /><CartDrawer /><MeasureModal open={modal} onClose={() => setModal(false)} /></CartProvider>; }
