"use client";
import { Hero } from "@/components/hero";
import { SiteShell } from "@/components/site-shell";
export default function Home() { return <SiteShell><main><Hero onMeasure={() => window.location.assign("/contacts")} /></main></SiteShell> }
