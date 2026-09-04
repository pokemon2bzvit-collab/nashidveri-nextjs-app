import { NextRequest, NextResponse } from "next/server";

const adminEmail = process.env.NEXT_PUBLIC_ADMIN_EMAIL || "pokemon2bzvit@gmail.com";
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

type QdoorsPreview = {
  sourceUrl: string;
  title: string;
  productCode: string | null;
  description: string;
  images: string[];
  facts: Array<{ label: string; value: string }>;
  finish: string | null;
};

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

function cleanLine(value: string) {
  return value.replace(/\s+/g, " ").replace(/^[-–—:\s]+|[-–—:\s]+$/g, "").trim();
}

function extractHeading(html: string, text: string) {
  const match = html.match(/<h1[^>]*>([\s\S]*?)<\/h1>/i);
  if (match) return cleanLine(toText(match[1]));
  return cleanLine(text.match(/(?:^|\n)([^\n]{3,180})\s*\(008\)/i)?.[1] || "Модель Qdoors");
}

function lineAfter(lines: string[], label: string) {
  const index = lines.findIndex((line) => line.toLocaleLowerCase("uk-UA") === label.toLocaleLowerCase("uk-UA"));
  return index >= 0 ? cleanLine(lines[index + 1] || "") || null : null;
}

function parseQdoorsPage(html: string, sourceUrl: string): QdoorsPreview {
  const text = toText(html);
  const lines = text.split("\n").map(cleanLine).filter(Boolean);
  const rawImages = Array.from(html.matchAll(/https:\/\/e-c\.storage\.googleapis\.com\/res\/[a-f0-9-]+\/(?:original|\d+)/gi)).map((match) => match[0]);
  const images = Array.from(new Set(rawImages.map((url) => url.replace(/\/(?:\d+)$/i, "/original"))));
  const productCode = text.match(/код продукту\s*([0-9]+)/i)?.[1] || null;
  const fields: Array<[string, string]> = [
    ["Бренд", "Виробник"],
    ["серія", "Серія"],
    ["призначення", "Призначення"],
    ["розмір", "Розмір"],
    ["розмір 2", "Розмір 2"],
    ["товщина дверного коробу", "Товщина коробу"],
    ["товщина полотна", "Товщина полотна"],
    ["товщина МДФ накладок", "МДФ-накладки"],
    ["товщина металу", "Товщина металу"],
    ["ущільнювач", "Ущільнювач"],
    ["ручка", "Ручка"],
    ["циліндр", "Циліндр"],
    ["замки", "Замки"],
  ];
  const facts = fields.map(([sourceLabel, targetLabel]) => ({ label: targetLabel, value: lineAfter(lines, sourceLabel) }))
    .filter((item): item is { label: string; value: string } => Boolean(item.value));
  const outerColor = lineAfter(lines, "колір");
  const innerColor = lineAfter(lines, "колір 2");
  const displayedInnerColor = /гладь\s+біла\s+шагрень/iu.test(extractHeading(html, text)) ? "гладь біла шагрень" : innerColor;
  const finish = outerColor && displayedInnerColor ? `RAL ${outerColor.replace(/^RAL\s*/i, "")} + ${displayedInnerColor}` : outerColor || displayedInnerColor;
  if (finish) facts.splice(3, 0, { label: "Підтверджене виконання", value: finish });
  const descriptionStart = text.toLocaleLowerCase("uk-UA").indexOf("опис товару");
  const descriptionEnd = text.toLocaleLowerCase("uk-UA").indexOf("бренд", Math.max(descriptionStart, 0));
  const description = descriptionStart >= 0 && descriptionEnd > descriptionStart
    ? cleanLine(text.slice(descriptionStart, descriptionEnd).replace(/опис товару\s*деталі і характеристики вкладення/iu, ""))
    : "";
  return { sourceUrl, title: extractHeading(html, text), productCode, description, images, facts, finish: finish || null };
}

async function isAdmin(request: NextRequest) {
  const token = request.headers.get("authorization")?.replace(/^Bearer\s+/i, "");
  if (!token || !supabaseUrl || !supabaseKey) return false;
  const response = await fetch(`${supabaseUrl}/auth/v1/user`, {
    headers: { apikey: supabaseKey, Authorization: `Bearer ${token}` },
    cache: "no-store",
  });
  if (!response.ok) return false;
  const user = await response.json() as { email?: string };
  return user.email === adminEmail;
}

export async function GET(request: NextRequest) {
  if (!(await isAdmin(request))) return NextResponse.json({ message: "Немає доступу до імпорту." }, { status: 401 });
  const source = request.nextUrl.searchParams.get("url")?.trim() || "";
  let sourceUrl: URL;
  try {
    sourceUrl = new URL(source);
  } catch {
    return NextResponse.json({ message: "Вставте повне посилання на картку Qdoors." }, { status: 400 });
  }
  if (sourceUrl.protocol !== "https:" || sourceUrl.hostname !== "qdoors.ua" || !sourceUrl.pathname.startsWith("/shop/")) {
    return NextResponse.json({ message: "Дозволені лише посилання формату https://qdoors.ua/shop/…" }, { status: 400 });
  }
  try {
    const response = await fetch(sourceUrl, {
      headers: { "User-Agent": "NashiDveriCatalog/1.0 (+https://nashidveri-nextjs-app.vercel.app)" },
      cache: "no-store",
      signal: AbortSignal.timeout(12_000),
    });
    if (!response.ok) return NextResponse.json({ message: `Qdoors повернув код ${response.status}. Спробуйте пізніше.` }, { status: 502 });
    const preview = parseQdoorsPage(await response.text(), sourceUrl.toString());
    if (!preview.images.length || preview.title === "Модель Qdoors") {
      return NextResponse.json({ message: "Не вдалося прочитати картку. Перевірте, чи це конкретна модель Qdoors." }, { status: 422 });
    }
    return NextResponse.json(preview);
  } catch {
    return NextResponse.json({ message: "Не вдалося з’єднатися з Qdoors. Спробуйте ще раз за хвилину." }, { status: 502 });
  }
}
