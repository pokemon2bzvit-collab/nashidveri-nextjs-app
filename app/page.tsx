"use client";
import { Hero } from "@/components/hero";
import { HomeCategories } from "@/components/home-categories";
import { Process } from "@/components/conversion-sections";
import { Portfolio } from "@/components/portfolio";
import { SiteShell } from "@/components/site-shell";
export default function Home() { return <SiteShell><main><Hero onMeasure={() => window.location.assign("/contacts")} /><HomeCategories /><Process /><Portfolio /></main></SiteShell> }
