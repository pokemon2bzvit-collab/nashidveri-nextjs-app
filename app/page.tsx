"use client";
import { Hero } from "@/components/hero";
import { HomeCategories } from "@/components/home-categories";
import { SiteShell } from "@/components/site-shell";
export default function Home() { return <SiteShell><main><Hero onMeasure={() => window.location.assign("/contacts")} /><HomeCategories /></main></SiteShell> }
