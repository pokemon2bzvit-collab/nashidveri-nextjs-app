"use client";
import { Contacts } from "@/components/contacts";
import { Hero } from "@/components/hero";
import { HomeCategories } from "@/components/home-categories";
import { SiteShell } from "@/components/site-shell";
export default function Home() { return <SiteShell><main><Hero onMeasure={() => document.getElementById("contacts")?.scrollIntoView({ behavior: "smooth" })} /><HomeCategories /><Contacts /></main></SiteShell> }
