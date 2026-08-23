"use client";
import { Calculator } from "@/components/calculator";
import { Contacts } from "@/components/contacts";
import { Hero } from "@/components/hero";
import { HomeCategories } from "@/components/home-categories";
import { FinalCta, Process, TrustBar } from "@/components/conversion-sections";
import { Portfolio } from "@/components/portfolio";
import { ProductCatalog } from "@/components/product-catalog";
import { SiteShell } from "@/components/site-shell";
export default function Home() { return <SiteShell><main><Hero onMeasure={() => document.getElementById("calculator")?.scrollIntoView({ behavior: "smooth" })} /><TrustBar /><HomeCategories /><ProductCatalog onOrder={() => document.getElementById("calculator")?.scrollIntoView({ behavior: "smooth" })} /><Process /><Calculator /><Portfolio /><FinalCta /><Contacts /></main></SiteShell> }
