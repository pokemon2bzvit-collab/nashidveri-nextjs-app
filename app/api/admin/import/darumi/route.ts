import { NextRequest, NextResponse } from "next/server";

const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

type Fact = { label: string; value: string };

function decode(value: string) { return value.replace(/&nbsp;/gi, " ").replace(/&amp;/gi, "&").replace(/&quot;/gi, '"').replace(/&#039;|&#39;/gi, "'"); }
function toText(html: string) { return decode(html.replace(/<script[\s\S]*?<\/script>/gi, " ").replace(/<style[\s\S]*?<\/style>/gi, " ").replace(/<(?:br|\/p|\/div|\/li|\/h[1-6]|\/tr|\/td)[^>]*>/gi, "\n").replace(/<[^>]+>/g, " ").replace(/[ \t]+/g, " ").replace(/\n\s*\n+/g, "\n").trim()); }
function clean(value: string) { return value.replace(/\s+/g, " ").replace(/^[-–—:\s]+|[-–—:\s]+$/g, "").trim(); }

async function isAdmin(request: NextRequest) {
  const token = request.headers.get("authorization")?.replace(/^Bearer\s+/i, "");
  if (!token || !supabaseUrl || !supabaseKey) return false;
  const response = await fetch(`${supabaseUrl}/auth/v1/user`, { headers: { apikey: supabaseKey, Authorization: `Bearer ${token}` }, cache: "no-store" });
  return response.ok && (await response.json() as { email?: string }).email === adminEmail;
}

function factsFrom(html: string): Fact[] {
  const tableFacts = Array.from(html.matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/gi)).flatMap((row) => {
    const cells = Array.from(row[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)).map((cell) => clean(toText(cell[1])));
    return cells.length > 1 && cells[0] && cells[1] ? [{ label: cells[0].replace(/:$/u, ""), value: cells[1] }] : [];
  });
  const wanted = ["Фабрика", "Модель", "Колір", "Фактура", "Скло", "Колекція", "Вид", "Матеріал", "Покриття", "Інші кольори", "Інші варіанти скла", "Товщина полотна", "Стиль", "Розміри", "Термін виготовлення", "Виробник"];
  const textLines = toText(html).split("\n").map(clean).filter(Boolean);
  const lineFacts = wanted.flatMap((label) => {
    const index = textLines.findIndex((line) => line === label || line.startsWith(label + " "));
    if (index < 0) return [];
    const inline = textLines[index].slice(label.length).replace(/^\s*[:|]\s*/u, "");
    const value = inline || textLines[index + 1] || "";
    return value && value !== label ? [{ label, value }] : [];
  });
  return Array.from(new Map([...tableFacts, ...lineFacts].map((fact) => [fact.label.toLocaleLowerCase("uk-UA"), fact])).values()).slice(0, 25);
}

function imagesFrom(html: string, base: URL, title: string) {
  const titleWords = title.toLocaleLowerCase("uk-UA").replace(/^двері\s+дарумі\s*/u, "").split(/\s+/).slice(0, 2).join(" ");
  const images = Array.from(html.matchAll(/<img[^>]+>/gi)).flatMap((match) => {
    const tag = match[0];
    const source = tag.match(/(?:data-src|data-original|src)=["']([^"']+)["']/i)?.[1];
    const alt = clean(toText(tag.match(/alt=["']([^"']*)["']/i)?.[1] || "")).toLocaleLowerCase("uk-UA");
    if (!source || (!alt.includes("двері дарумі") && !alt.includes(titleWords))) return [];
    try { return [new URL(decode(source), base).toString()]; } catch { return []; }
  });
  const og = html.match(/<meta[^>]+(?:property|name)=["'](?:og:image|twitter:image)["'][^>]+content=["']([^"']+)["']/i)?.[1];
  if (og) try { images.unshift(new URL(decode(og), base).toString()); } catch { /* ignore */ }
  return [...new Set(images)].slice(0, 6);
}

export async function GET(request: NextRequest) {
  if (!(await isAdmin(request))) return NextResponse.json({ message: "Немає доступу до імпорту." }, { status: 401 });
  const raw = request.nextUrl.searchParams.get("url")?.trim() || "";
  let source: URL;
  try { source = new URL(raw); } catch { return NextResponse.json({ message: "Вставте повне посилання на картку Darumi." }, { status: 400 }); }
  if (source.protocol !== "https:" || source.hostname !== "darumi.in.ua" || !source.pathname.startsWith("/dveri/") || source.pathname === "/dveri/") return NextResponse.json({ message: "Дозволені лише картки товарів darumi.in.ua/dveri/." }, { status: 400 });
  try {
    const response = await fetch(source, { headers: { "User-Agent": "Mozilla/5.0 (compatible; NashiDveriCatalog/1.0; +https://nashidveri-uzhhorod.com.ua)", "Accept-Language": "uk-UA,uk;q=0.9" }, next: { revalidate: 86_400 }, signal: AbortSignal.timeout(15_000) });
    if (!response.ok) return NextResponse.json({ message: `Darumi повернув код ${response.status}.` }, { status: 502 });
    const html = await response.text();
    const title = clean(toText(html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i)?.[1] || ""));
    const facts = factsFrom(html);
    if (!title || !facts.length) return NextResponse.json({ message: "Не вдалося знайти назву або характеристики. Перевірте посилання." }, { status: 422 });
    const images = imagesFrom(html, source, title);
    const color = facts.find((fact) => fact.label === "Колір")?.value || "";
    const glass = facts.find((fact) => fact.label === "Скло")?.value || "";
    const coating = facts.find((fact) => fact.label === "Покриття")?.value || "";
    const details = [coating && `покриття ${coating}`, facts.find((fact) => fact.label === "Товщина полотна")?.value && `полотно ${facts.find((fact) => fact.label === "Товщина полотна")?.value}`, facts.find((fact) => fact.label === "Розміри")?.value && `розміри ${facts.find((fact) => fact.label === "Розміри")?.value}`].filter(Boolean).join("; ");
    return NextResponse.json({ sourceUrl: source.toString(), title, facts, images, color, glass, coating, description: `${title} — міжкімнатні двері Darumi для вашого інтер’єру.${details ? ` Основні параметри: ${details}.` : ""} Доступні виконання та актуальну ціну уточнюйте у менеджера.` });
  } catch { return NextResponse.json({ message: "Не вдалося прочитати картку Darumi. Спробуйте пізніше." }, { status: 502 }); }
}
