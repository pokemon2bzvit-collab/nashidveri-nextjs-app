"use client";

import { createClient } from "@supabase/supabase-js";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

export const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";

export function getSupabaseBrowserClient() {
  if (!url || !key) throw new Error("Додайте NEXT_PUBLIC_SUPABASE_URL та NEXT_PUBLIC_SUPABASE_ANON_KEY у Vercel.");
  return createClient(url, key, {
    auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true },
  });
}
