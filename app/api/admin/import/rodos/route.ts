import { NextRequest, NextResponse } from "next/server";

const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
type Fact = { label: string; value: string };
function decode(value: string) { return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#039;|&#39;/gi, "'"); }
function toText(html: string) { return decode(html.replace(/<script[\s\S]*?<\/script>/gi, " ").replace(/<style[\s\S]*?<\/style>/gi, " ").replace(/<(?:br|\/p|\/div|\/li|\/tr|\/td|\/h[1-6])[^>]*>/gi, "\n").replace(/<[^>]+>/g, " ").replace(/[ \t]+/g, " ").replace(/\n\s*\n+/g, "\n").trim()); }
function clean(value: string) { return value.replace(/\s+/g, " ").trim(); }
function collectionFrom(value: string) { const x = value.toLocaleLowerCase("uk-UA"); if (/grand[- ]?delux|делюкс/.test(x)) return "DELUX"; if (/grand[- ]?lux|гранд люкс/.test(x)) return "LUX"; if (/grand[- ]?paint|гранд пейнт/.test(x)) return "Paint"; if (/atlantic/.test(x)) return "Atlantic ПВХ"; if (/cortes/.test(x)) return "Cortes фарба"; if (/siena/.test(x)) return "Siena фарба"; if (/royal/.test(x)) return "Royal шпон"; if (/loft/.test(x)) return "Loft фарба"; if (/style/.test(x)) return "Style ПВХ"; return "Новинки Rodos"; }
async function isAdmin(request: NextRequest) { const token = request.headers.get("authorization")?.replace(/^Bearer\s+/i, ""); if (!token || !supabaseUrl || !supabaseKey) return false; const response = await fetch(`${supabaseUrl}/auth/v1/user`, { headers: { apikey: supabaseKey, Authorization: `Bearer ${token}` }, cache: "no-store" }); return response.ok && (await response.json() as { email?: string }).email === adminEmail; }
function factsFrom(html: string): Fact[] {
  const section = html.match(/id=["']tab-specification["'][^>]*>([\s\S]*?)(?=<div[^>]+id=["']tab-|$)/i)?.[1] || ""; const result: Fact[] = [];
  for (const row of section.matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)) { const cells = Array.from(row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)).map((cell) => clean(toText(cell[1]))); if (cells.length > 1 && cells[0] && cells[1]) result.push({ label: cells[0].replace(/:$/u, ""), value: cells[1] }); }
  return Array.from(new Map(result.map((fact) => [fact.label.toLocaleLowerCase("uk-UA"), fact])).values()).slice(0, 30);
}
export async function GET(request: NextRequest) {
  if (!(await isAdmin(request))) return NextResponse.json({ message: "Немає доступу до імпорту." }, { status: 401 });
  const raw = request.nextUrl.searchParams.get("url")?.trim() || ""; let source: URL; try { source = new URL(raw); } catch { return NextResponse.json({ message: "Вставте посилання на картку Rodos." }, { status: 400 }); }
  if (source.protocol !== "https:" || !/(^|\.)rodos\.ua$/i.test(source.hostname)) return NextResponse.json({ message: "Дозволені лише картки з rodos.ua." }, { status: 400 });
  try {
    const response = await fetch(source, { headers: { "User-Agent": "NashiDveriCatalog/1.0 (+https://nashidveri-uzhhorod.com.ua)" }, cache: "no-store", signal: AbortSignal.timeout(15_000) }); if (!response.ok) return NextResponse.json({ message: `Rodos повернув код ${response.status}.` }, { status: 502 });
    const html = await response.text(); const body = toText(html); const title = clean(toText(html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i)?.[1] || ""));
    if (!title || !/(?:двер|dver|door)/iu.test(title + " " + source.pathname)) return NextResponse.json({ message: "Це не схоже на картку дверей Rodos." }, { status: 422 });
    const rawImages = Array.from(html.matchAll(/(?:data-zoom-image|data-image|href|src)=["']([^"']*\/image\/[^"']+)["']/gi)).map((item) => new URL(decode(item[1]), source).toString()); const og = html.match(/property=["']og:image["'][^>]*content=["']([^"']+)["']/i)?.[1]; if (og) rawImages.unshift(new URL(decode(og), source).toString());
    const images = Array.from(new Set(rawImages.filter((image) => /\.(?:jpe?g|png|webp)(?:\?|$)/i.test(image)))).slice(0, 10); const descriptionHtml = html.match(/id=["']tab-description["'][^>]*>([\s\S]*?)(?=<div[^>]+id=["']tab-|$)/i)?.[1] || "";
    const description = clean(toText(descriptionHtml)).slice(0, 4000) || `${title} — двері фабрики Rodos. Комплектацію, доступні покриття та актуальну ціну уточнюйте у менеджера.`; const entrance = /вхідн|vhodn|входн/iu.test(title + " " + body);
    return NextResponse.json({ sourceUrl: source.toString(), title, productCode: html.match(/product_id=(\d+)/i)?.[1] || null, description, images, facts: factsFrom(html), brand: entrance ? "Rodos Steel" : "Rodos", category: entrance ? "entrance" : "interior", collection: collectionFrom(title + " " + source.pathname) });
  } catch { return NextResponse.json({ message: "Не вдалося прочитати картку Rodos. Спробуйте ще раз за хвилину." }, { status: 502 }); }
}
