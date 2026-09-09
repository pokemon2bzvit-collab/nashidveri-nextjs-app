import { NextRequest, NextResponse } from "next/server";

const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

function decode(value: string) { return value.replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/<[^>]+>/g, "").trim(); }
function collectionFrom(value: string) {
  const text = value.toLocaleLowerCase("uk-UA");
  if (/grand[- ]?delux|делюкс/.test(text)) return "DELUX";
  if (/grand[- ]?lux|гранд люкс/.test(text)) return "LUX";
  if (/grand[- ]?paint|гранд пейнт/.test(text)) return "Paint";
  if (/atlantic/.test(text)) return "Atlantic ПВХ";
  if (/cortes/.test(text)) return "Cortes фарба";
  if (/siena/.test(text)) return "Siena фарба";
  if (/royal/.test(text)) return "Royal шпон";
  if (/loft/.test(text)) return "Loft фарба";
  if (/style/.test(text)) return "Style ПВХ";
  return "Новинки Rodos";
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
    const response = await fetch("https://rodos.ua/sitemap.xml", { headers: { "User-Agent": "NashiDveriCatalog/1.0 (+https://nashidveri-uzhhorod.com.ua)" }, cache: "no-store", signal: AbortSignal.timeout(20_000) });
    if (!response.ok) return NextResponse.json({ message: `Rodos повернув код ${response.status}.` }, { status: 502 });
    const seen = new Set<string>();
    const products = Array.from((await response.text()).matchAll(/<url>([\s\S]*?)<\/url>/gi)).flatMap((match) => {
      const block = match[1]; const url = decode(block.match(/<loc>([\s\S]*?)<\/loc>/i)?.[1] || "");
      const title = decode(block.match(/<image:title>([\s\S]*?)<\/image:title>/i)?.[1] || block.match(/<image:caption>([\s\S]*?)<\/image:caption>/i)?.[1] || "");
      const image = decode(block.match(/<image:loc>([\s\S]*?)<\/image:loc>/i)?.[1] || "");
      if (!url || !title || !/(?:двер|dver|door)/iu.test(url + " " + title) || seen.has(url)) return [];
      seen.add(url); const entrance = /вхідн|vhodn|входн/iu.test(url + " " + title);
      return [{ url, title, image: image || null, brand: entrance ? "Rodos Steel" : "Rodos", category: entrance ? "entrance" : "interior", collection: collectionFrom(url + " " + title) }];
    });
    return products.length ? NextResponse.json({ products }) : NextResponse.json({ message: "У sitemap Rodos не знайдено карток дверей." }, { status: 422 });
  } catch { return NextResponse.json({ message: "Не вдалося з’єднатися з Rodos. Спробуйте ще раз за хвилину." }, { status: 502 }); }
}
