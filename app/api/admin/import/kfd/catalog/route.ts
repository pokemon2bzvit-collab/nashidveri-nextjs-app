import { NextRequest, NextResponse } from "next/server";

const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const catalogUrl = "https://market-dveri.ua/uk/kfd/";

async function isAdmin(request: NextRequest) {
  const token = request.headers.get("authorization")?.replace(/^Bearer\s+/i, "");
  if (!token || !supabaseUrl || !supabaseKey) return false;
  const response = await fetch(`${supabaseUrl}/auth/v1/user`, { headers: { apikey: supabaseKey, Authorization: `Bearer ${token}` }, cache: "no-store" });
  return response.ok && (await response.json() as { email?: string }).email === adminEmail;
}

function clean(value: string) {
  return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&#039;|&#39;/gi, "'").replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim();
}

export async function GET(request: NextRequest) {
  if (!(await isAdmin(request))) return NextResponse.json({ message: "Немає доступу до імпорту." }, { status: 401 });
  try {
    const pages = await Promise.all(Array.from({ length: 4 }, async (_, index) => {
      const url = index ? `${catalogUrl}?page=${index + 1}` : catalogUrl;
      const response = await fetch(url, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0; +https://nashidveri-uzhhorod.com.ua)", "Accept-Language": "uk-UA,uk;q=0.9" }, next: { revalidate: 86_400 }, signal: AbortSignal.timeout(15_000) });
      if (!response.ok) throw new Error(`Market Dveri повернув код ${response.status}.`);
      return response.text();
    }));
    const found = new Map<string, { url: string; title: string }>();
    for (const html of pages) {
      for (const match of html.matchAll(/<a[^>]+href=["']([^"']+)["'][^>]*>([\s\S]*?)<\/a>/gi)) {
        const url = new URL(match[1], catalogUrl);
        const title = clean(match[2]);
        if (url.hostname !== "market-dveri.ua" || !url.pathname.startsWith("/uk/") || url.pathname === "/uk/kfd/" || !/двері\s+kfd|kfd\s+\S/iu.test(title)) continue;
        found.set(url.toString(), { url: url.toString(), title });
      }
    }
    const products = [...found.values()].sort((left, right) => left.title.localeCompare(right.title, "uk"));
    if (!products.length) return NextResponse.json({ message: "Не знайдено карток KFD. Спробуйте пізніше." }, { status: 422 });
    return NextResponse.json({ products });
  } catch (error) {
    return NextResponse.json({ message: error instanceof Error ? error.message : "Не вдалося відкрити каталог KFD." }, { status: 502 });
  }
}
