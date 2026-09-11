import { NextRequest, NextResponse } from "next/server";

const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

type Fact = { label: string; value: string };

function decode(value: string) {
  return value
    .replace(/&nbsp;/gi, " ")
    .replace(/&amp;/gi, "&")
    .replace(/&quot;/gi, '"')
    .replace(/&#039;|&#39;/gi, "'")
    .replace(/&lt;/gi, "<")
    .replace(/&gt;/gi, ">");
}

function toText(html: string) {
  return decode(html
    .replace(/<script[\s\S]*?<\/script>/gi, " ")
    .replace(/<style[\s\S]*?<\/style>/gi, " ")
    .replace(/<(?:br|\/p|\/div|\/li|\/h[1-6]|\/section|\/tr|\/td)[^>]*>/gi, "\n")
    .replace(/<[^>]+>/g, " ")
    .replace(/\r/g, "")
    .replace(/[ \t]+/g, " ")
    .replace(/\n\s*\n+/g, "\n")
    .trim());
}

function clean(value: string) {
  return value.replace(/\s+/g, " ").replace(/^[-–—:\s]+|[-–—:\s]+$/g, "").trim();
}

function translate(value: string) {
  return value
    .replace(/^Глубина рами$/iu, "Глибина коробки")
    .replace(/^Коллекція$/iu, "Колекція")
    .replace(/^Матеріал фасону$/iu, "Матеріал накладок")
    .replace(/^Тип фасону$/iu, "Тип накладок")
    .replace(/^Колір фасону$/iu, "Колір накладок")
    .replace(/^Стиль МДФ накладок$/iu, "Стиль МДФ-накладок")
    .replace(/^Контур примикання$/iu, "Контури ущільнення")
    .replace(/^В квартиру$/iu, "Для квартири")
    .replace(/^На заказ$/iu, "На замовлення")
    .replace(/^Левое, Правое$/iu, "Ліве, праве")
    .replace(/^Высокий$/iu, "Високий")
    .replace(/^Высокая$/iu, "Висока")
    .trim();
}

function factsFrom(html: string): Fact[] {
  const rows = Array.from(html.matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)).flatMap((row) => {
    const cells = Array.from(row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)).map((cell) => clean(toText(cell[1])));
    return cells.length >= 2 && cells[0] && cells[1] ? [{ label: translate(cells[0].replace(/:$/u, "")), value: translate(cells[1]) }] : [];
  });
  return Array.from(new Map(rows.map((fact) => [fact.label.toLocaleLowerCase("uk-UA"), fact])).values()).slice(0, 30);
}

function descriptionFor(title: string, facts: Fact[]) {
  const byLabel = (label: string) => facts.find((fact) => fact.label === label)?.value;
  const purpose = byLabel("Призначення")?.toLocaleLowerCase("uk-UA");
  const location = purpose?.includes("квартир") ? "для квартири" : purpose?.includes("будин") || purpose?.includes("вулиц") ? "для приватного будинку" : "для вашого простору";
  const leaf = byLabel("Товщина полотна");
  const steel = byLabel("Товщина металу");
  const box = byLabel("Глибина коробки");
  const parts = [leaf ? `полотно ${leaf}` : "", steel ? `сталь ${steel}` : "", box ? `коробка ${box}` : ""].filter(Boolean);
  return `${title} — двері ${location}. ${parts.length ? `Основні параметри: ${parts.join(", ")}. ` : ""}Комплектацію, декори та актуальну ціну уточнюйте у менеджера.`;
}

function imageFrom(html: string, baseUrl: URL) {
  const meta = html.match(/<meta[^>]+(?:property|name)=["'](?:og:image|twitter:image)["'][^>]+content=["']([^"']+)["']/i)
    || html.match(/<meta[^>]+content=["']([^"']+)["'][^>]+(?:property|name)=["'](?:og:image|twitter:image)["']/i);
  const raw = meta?.[1]
    || html.match(/<img[^>]+(?:data-src|data-original|src)=["']([^"']+)["'][^>]*>/i)?.[1];
  if (!raw) return null;
  try { return new URL(decode(raw), baseUrl).toString(); } catch { return null; }
}

async function isAdmin(request: NextRequest) {
  const token = request.headers.get("authorization")?.replace(/^Bearer\s+/i, "");
  if (!token || !supabaseUrl || !supabaseKey) return false;
  const response = await fetch(`${supabaseUrl}/auth/v1/user`, { headers: { apikey: supabaseKey, Authorization: `Bearer ${token}` }, cache: "no-store" });
  return response.ok && (await response.json() as { email?: string }).email === adminEmail;
}

export async function GET(request: NextRequest) {
  if (!(await isAdmin(request))) return NextResponse.json({ message: "Немає доступу до імпорту." }, { status: 401 });
  const raw = request.nextUrl.searchParams.get("url")?.trim() || "";
  let source: URL;
  try { source = new URL(raw); } catch { return NextResponse.json({ message: "Вставте повне посилання на картку Market Dveri." }, { status: 400 }); }
  if (source.protocol !== "https:" || !/(^|\.)market-dveri\.ua$/iu.test(source.hostname) || !/\/uk\//u.test(source.pathname)) {
    return NextResponse.json({ message: "Дозволені лише українські картки товарів Market Dveri." }, { status: 400 });
  }
  try {
    const response = await fetch(source, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0; +https://nashidveri-uzhhorod.com.ua)", "Accept-Language": "uk-UA,uk;q=0.9" }, next: { revalidate: 86_400 }, signal: AbortSignal.timeout(15_000) });
    if (!response.ok) return NextResponse.json({ message: `Market Dveri повернув код ${response.status}.` }, { status: 502 });
    const html = await response.text();
    const title = clean(toText(html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i)?.[1] || ""));
    const facts = factsFrom(html);
    if (!title || !facts.length) return NextResponse.json({ message: "Не вдалося знайти характеристики. Перевірте, чи це конкретна картка товару." }, { status: 422 });
    return NextResponse.json({ sourceUrl: source.toString(), title, facts, description: descriptionFor(title, facts), image: imageFrom(html, source) });
  } catch {
    return NextResponse.json({ message: "Не вдалося прочитати картку Market Dveri. Спробуйте пізніше." }, { status: 502 });
  }
}
