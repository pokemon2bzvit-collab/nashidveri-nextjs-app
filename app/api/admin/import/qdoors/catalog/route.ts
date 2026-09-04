import { NextRequest, NextResponse } from "next/server";

const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

function decode(value: string) {
  return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#x2f;|&#47;/gi, "/").replace(/&#039;|&#39;/gi, "'");
}
function textFromHtml(value: string) {
  return decode(value.replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim());
}
async function isAdmin(request: NextRequest) {
  const token = request.headers.get("authorization")?.replace(/^Bearer\s+/i, "");
  if (!token || !supabaseUrl || !supabaseKey) return false;
  const response = await fetch(`${supabaseUrl}/auth/v1/user`, { headers: { apikey: supabaseKey, Authorization: `Bearer ${token}` }, cache: "no-store" });
  if (!response.ok) return false;
  const user = await response.json() as { email?: string };
  return user.email === adminEmail;
}

export async function GET(request: NextRequest) {
  if (!(await isAdmin(request))) return NextResponse.json({ message: "Немає доступу до імпорту." }, { status: 401 });
  const source = request.nextUrl.searchParams.get("url")?.trim() || "https://qdoors.ua/shop";
  let sourceUrl: URL;
  try { sourceUrl = new URL(/^https?:\/\//i.test(source) ? source : "https://" + source); } catch { return NextResponse.json({ message: "Вставте URL каталогу Qdoors." }, { status: 400 }); }
  if (sourceUrl.hostname === "www.qdoors.ua") sourceUrl.hostname = "qdoors.ua";
  if (sourceUrl.hostname === "qdoors.ua" && sourceUrl.pathname === "/") sourceUrl.pathname = "/shop";
  if (sourceUrl.protocol !== "https:" || sourceUrl.hostname !== "qdoors.ua" || !sourceUrl.pathname.startsWith("/shop")) {
    return NextResponse.json({ message: "Дозволені лише сторінки каталогу qdoors.ua/shop…" }, { status: 400 });
  }
  try {
    const response = await fetch(sourceUrl, { headers: { "User-Agent": "NashiDveriCatalog/1.0 (+https://nashidveri-nextjs-app.vercel.app)" }, cache: "no-store", signal: AbortSignal.timeout(12_000) });
    if (!response.ok) return NextResponse.json({ message: `Qdoors повернув код ${response.status}.` }, { status: 502 });
    const html = await response.text();
    const candidates = new Map<string, { url: string; title: string }>();
    for (const match of html.matchAll(/<a\b[^>]*href=["']([^"']+)["'][^>]*>([\s\S]*?)<\/a>/gi)) {
      try {
        const url = new URL(match[1], sourceUrl).toString();
        const parsed = new URL(url);
        const title = textFromHtml(match[2]);
        if (parsed.hostname !== "qdoors.ua" || !parsed.pathname.startsWith("/shop/") || parsed.pathname.startsWith("/shop/cat/") || !title || title.length < 3 || title.length > 180) continue;
        candidates.set(url, { url, title });
      } catch { /* Ignore malformed catalog links. */ }
    }
    const products = Array.from(candidates.values()).slice(0, 120);
    if (!products.length) return NextResponse.json({ message: "На цій сторінці не знайдено карток моделей. Спробуйте https://qdoors.ua/shop або сторінку серії." }, { status: 422 });
    return NextResponse.json({ sourceUrl: sourceUrl.toString(), products });
  } catch {
    return NextResponse.json({ message: "Не вдалося з’єднатися з Qdoors. Спробуйте ще раз за хвилину." }, { status: 502 });
  }
}
