import { NextRequest, NextResponse } from "next/server";

const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const catalogUrl = "https://darumi.in.ua/dveri/";

function clean(value: string) {
  return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim();
}

async function isAdmin(request: NextRequest) {
  const token = request.headers.get("authorization")?.replace(/^Bearer\s+/i, "");
  if (!token || !supabaseUrl || !supabaseKey) return false;
  const response = await fetch(`${supabaseUrl}/auth/v1/user`, { headers: { apikey: supabaseKey, Authorization: `Bearer ${token}` }, cache: "no-store" });
  return response.ok && (await response.json() as { email?: string }).email === adminEmail;
}

export async function GET(request: NextRequest) {
  if (!(await isAdmin(request))) return NextResponse.json({ message: "Немає доступу до імпорту." }, { status: 401 });
  try {
    // Каталог показує моделі поступово. Зчитуємо сторінки невеликими пакетами,
    // щоб не створювати зайве навантаження на сайт виробника.
    const pages = Array.from({ length: 27 }, (_, index) => index ? `${catalogUrl}?page=${index + 1}` : catalogUrl);
    const found = new Map<string, { url: string; title: string }>();
    for (let offset = 0; offset < pages.length; offset += 3) {
      const results = await Promise.all(pages.slice(offset, offset + 3).map(async (url) => {
        const response = await fetch(url, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0; +https://nashidveri-uzhhorod.com.ua)", "Accept-Language": "uk-UA,uk;q=0.9" }, next: { revalidate: 86_400 }, signal: AbortSignal.timeout(15_000) });
        return response.ok ? response.text() : "";
      }));
      for (const html of results) {
        for (const match of html.matchAll(/<a[^>]+href=["']([^"']+)["'][^>]*>([\s\S]*?)<\/a>/gi)) {
          const url = new URL(match[1], catalogUrl);
          const title = clean(match[2]);
          if (url.hostname !== "darumi.in.ua" || !url.pathname.startsWith("/dveri/") || url.pathname === "/dveri/" || !/^двері\s+дарумі\s+/iu.test(title)) continue;
          found.set(url.toString(), { url: url.toString(), title });
        }
      }
    }
    const products = [...found.values()].sort((left, right) => left.title.localeCompare(right.title, "uk"));
    if (!products.length) return NextResponse.json({ message: "Не знайдено карток Darumi. Спробуйте пізніше." }, { status: 422 });
    return NextResponse.json({ products });
  } catch (error) {
    return NextResponse.json({ message: error instanceof Error ? error.message : "Не вдалося відкрити каталог Darumi." }, { status: 502 });
  }
}
