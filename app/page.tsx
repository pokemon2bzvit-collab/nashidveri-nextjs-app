"use client";
import { useState } from "react";
import { Calculator } from "@/components/calculator";
import { Contacts, Footer } from "@/components/contacts";
import { Header } from "@/components/header";
import { Hero } from "@/components/hero";
import { MeasureModal } from "@/components/measure-modal";
import { MobileBar } from "@/components/mobile-bar";
import { Portfolio } from "@/components/portfolio";
import { ProductCatalog } from "@/components/product-catalog";
export default function Home() { const [modal, setModal] = useState(false); return <><Header onMeasure={() => setModal(true)} /><main><Hero onMeasure={() => setModal(true)} /><ProductCatalog onOrder={() => setModal(true)} /><Calculator /><Portfolio /><Contacts /></main><Footer /><MobileBar /><MeasureModal open={modal} onClose={() => setModal(false)} /></> }
