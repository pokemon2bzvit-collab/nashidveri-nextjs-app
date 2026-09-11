import { NextRequest, NextResponse } from "next/server";

const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const sitemapUrl = "https://market-dveri.ua/uk/fx-sitemap-uk-ua/";

type Candidate = { url: string; title: string; score: number; confidence: "high" | "possible" };

function decode(value: string) {
  return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#039;|&#39;/gi, "'").replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim();
}

function tokens(value: string) {
  const ignored = new Set(["двері", "дверь", "межкомнатные", "входные", "вхідні", "для", "квартири", "вулиці", "будинку", "rodos", "steel", "модель"]);
  return Array.from(new Set(value.toLocaleLowerCase("uk-UA").replace(/[^a-zа-яіїєґ0-9]+/giu, " ").split(" ").filter((word) => (word.length >= 3 || /\d/u.test(word)) && !ignored.has(word))));
}

async function isAdmin(request: NextRequest) {
  const token = request.headers.get("authorization")?.replace(/^Bearer\s+/i, "");
  if (!token || !supabaseUrl || !supabaseKey) return false;
  const response = await fetch(`${supabaseUrl}/auth/v1/user`, { headers: { apikey: supabaseKey, Authorization: `Bearer ${token}` }, cache: "no-store" });
  return response.ok && (await response.json() as { email?: string }).email === adminEmail;
}

function scoreCandidate(queryTokens: string[], title: string, url: string) {
  const haystack = `${title} ${decodeURIComponent(url)}`.toLocaleLowerCase("uk-UA");
  const matches = queryTokens.filter((token) => haystack.includes(token));
  const score = matches.length * 3 + (matches.length === queryTokens.length ? 4 : 0);
  return { score, confidence: matches.length === queryTokens.length ? "high" as const : "possible" as const };
}

export async function GET(request: NextRequest) {
  if (!(await isAdmin(request))) return NextResponse.json({ message: "Немає доступу до імпорту." }, { status: 401 });
  const name = request.nextUrl.searchParams.get("name")?.trim() || "";
  const brand = request.nextUrl.searchParams.get("brand")?.trim() || "";
  const queryTokens = tokens(`${brand} ${name}`);
  if (!queryTokens.length) return NextResponse.json({ message: "Вкажіть назву моделі для пошуку." }, { status: 400 });

  try {
    const response = await fetch(sitemapUrl, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0; +https://nashidveri-uzhhorod.com.ua)", "Accept-Language": "uk-UA,uk;q=0.9" }, next: { revalidate: 86_400 }, signal: AbortSignal.timeout(15_000) });
    if (!response.ok) return NextResponse.json({ message: `Market Dveri повернув код ${response.status}.` }, { status: 502 });
    const html = await response.text();
    const seen = new Set<string>();
    const candidates: Candidate[] = [];
    for (const match of html.matchAll(/<a[^>]+href=["']([^"']+)["'][^>]*>([\s\S]*?)<\/a>/gi)) {
      const url = new URL(match[1], sitemapUrl).toString();
      if (seen.has(url)) continue;
      const source = new URL(url);
      if (source.hostname !== "market-dveri.ua" || !source.pathname.startsWith("/uk/") || source.pathname === "/uk/") continue;
      seen.add(url);
      const title = decode(match[2]) || decodeURIComponent(source.pathname.split("/").filter(Boolean).at(-1) || "").replace(/-/g, " ");
      const result = scoreCandidate(queryTokens, title, url);
      if (result.score >= 3) candidates.push({ url, title, ...result });
    }
    candidates.sort((left, right) => right.score - left.score || left.title.localeCompare(right.title, "uk"));
    return NextResponse.json({ candidates: candidates.slice(0, 6) });
  } catch {
    return NextResponse.json({ message: "Не вдалося прочитати карту сайту Market Dveri. Спробуйте пізніше." }, { status: 502 });
  }
}
