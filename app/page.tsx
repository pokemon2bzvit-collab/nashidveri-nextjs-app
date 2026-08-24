"use client";
import { Hero } from "@/components/hero";
import { HomeCategories } from "@/components/home-categories";
import { FinalCta, Process, TrustBar } from "@/components/conversion-sections";
import { Portfolio } from "@/components/portfolio";
import { SiteShell } from "@/components/site-shell";
export default function Home() { return <SiteShell><main><Hero onMeasure={() => window.location.assign("/contacts")} /><TrustBar /><HomeCategories /><Process /><Portfolio /><FinalCta /></main></SiteShell> }
