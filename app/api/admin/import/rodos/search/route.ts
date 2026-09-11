import { NextRequest, NextResponse } from "next/server";

const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const sitemapUrl = "https://rodos.ua/index.php?route=extension/feed/google_sitemap";

type Candidate = { url: string; title: string; score: number; confidence: "high" | "possible" };

function decode(value: string) { return value.replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/<[^>]+>/g, "").trim(); }
function tokens(value: string) {
  const ignored = new Set(["rodos", "steel", "двері", "дверь", "межкомнатные", "входные", "вхідні", "для", "квартири", "вулиці", "будинку", "модель"]);
  return Array.from(new Set(value.toLocaleLowerCase("uk-UA").replace(/[^a-zа-яіїєґ0-9]+/giu, " ").split(" ").filter((word) => (word.length >= 3 || /\d/u.test(word)) && !ignored.has(word))));
}
async function isAdmin(request: NextRequest) {
  const token = request.headers.get("authorization")?.replace(/^Bearer\s+/i, "");
  if (!token || !supabaseUrl || !supabaseKey) return false;
  const response = await fetch(`${supabaseUrl}/auth/v1/user`, { headers: { apikey: supabaseKey, Authorization: `Bearer ${token}` }, cache: "no-store" });
  return response.ok && (await response.json() as { email?: string }).email === adminEmail;
}

export async function GET(request: NextRequest) {
  if (!(await isAdmin(request))) return NextResponse.json({ message: "Немає доступу до імпорту." }, { status: 401 });
  const name = request.nextUrl.searchParams.get("name")?.trim() || "";
  const queryTokens = tokens(name);
  if (!queryTokens.length) return NextResponse.json({ message: "Вкажіть назву моделі для пошуку." }, { status: 400 });
  try {
    const response = await fetch(sitemapUrl, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0; +https://nashidveri-uzhhorod.com.ua)", Accept: "application/xml,text/xml,*/*", "Accept-Language": "uk-UA,uk;q=0.9" }, next: { revalidate: 3600 }, signal: AbortSignal.timeout(20_000) });
    if (!response.ok) return NextResponse.json({ message: `Rodos повернув код ${response.status}.` }, { status: 502 });
    const candidates = Array.from((await response.text()).matchAll(/<url>([\s\S]*?)<\/url>/gi)).flatMap((match) => {
      const block = match[1]; const url = decode(block.match(/<loc>([\s\S]*?)<\/loc>/i)?.[1] || "");
      const title = decode(block.match(/<image:title>([\s\S]*?)<\/image:title>/i)?.[1] || block.match(/<image:caption>([\s\S]*?)<\/image:caption>/i)?.[1] || "");
      if (!url || !title || !/(?:двер|dver|door)/iu.test(url + " " + title)) return [];
      const haystack = `${title} ${decodeURIComponent(url)}`.toLocaleLowerCase("uk-UA");
      const matches = queryTokens.filter((token) => haystack.includes(token));
      if (!matches.length) return [];
      const confidence = matches.length === queryTokens.length ? "high" as const : "possible" as const;
      return [{ url, title, score: matches.length * 3 + (confidence === "high" ? 4 : 0), confidence }];
    }).sort((left, right) => right.score - left.score || left.title.localeCompare(right.title, "uk"));
    return NextResponse.json({ candidates: candidates.slice(0, 6) });
  } catch {
    return NextResponse.json({ message: "Не вдалося прочитати карту сайту Rodos. Спробуйте ще раз за хвилину." }, { status: 502 });
  }
}
