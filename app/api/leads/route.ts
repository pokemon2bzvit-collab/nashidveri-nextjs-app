import { NextResponse } from "next/server";
import { z } from "zod";

const leadSchema = z.object({
  name: z.string().trim().min(2, "Вкажіть ваше ім’я").max(80),
  phone: z.string().regex(/^\+380\d{9}$/, "Вкажіть номер формату +380XXXXXXXXX"),
  contactMethod: z.enum(["phone", "viber", "telegram"]).default("phone"),
  message: z.string().trim().max(1200).optional(),
  requestType: z.enum(["consultation", "measurement", "price_request", "contact_form"]),
  productSlug: z.string().trim().max(180).optional(),
  productName: z.string().trim().max(220).optional(),
  sourcePath: z.string().trim().max(300).optional(),
  consent: z.literal(true),
  website: z.string().max(0).optional(),
});

async function notifyTelegram(payload: z.infer<typeof leadSchema>, request: Request) {
  const token = process.env.TELEGRAM_BOT_TOKEN;
  const chatId = process.env.TELEGRAM_CHAT_ID;
  if (!token || !chatId) return;

  const siteUrl = new URL(request.url).origin;
  const message = [
    "🔔 Нова заявка — Наші двері",
    "",
    `Ім’я: ${payload.name}`,
    `Телефон: ${payload.phone}`,
    `Зв’язок: ${payload.contactMethod === "phone" ? "телефоном" : payload.contactMethod}`,
    `Тип: ${payload.requestType === "measurement" ? "замір" : payload.requestType === "price_request" ? "прорахунок" : payload.requestType === "consultation" ? "консультація" : "повідомлення"}`,
    payload.productName ? `Товари: ${payload.productName}` : "",
    payload.message ? `Коментар: ${payload.message}` : "",
    "",
    `Адмінка: ${siteUrl}/admin/leads`,
  ].filter(Boolean).join("\n").slice(0, 4000);

  try {
    const response = await fetch(`https://api.telegram.org/bot${token}/sendMessage`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ chat_id: chatId, text: message, disable_web_page_preview: true }),
      cache: "no-store",
    });
    if (!response.ok) console.error("Telegram notification error:", await response.text());
  } catch (error) {
    console.error("Telegram notification failed:", error);
  }
}

export async function POST(request: Request) {
  try {
    const payload = leadSchema.parse(await request.json());
    const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
    if (!url || !key) return NextResponse.json({ message: "Сервіс заявок ще не налаштований." }, { status: 503 });

    const response = await fetch(url + "/rest/v1/leads", {
      method: "POST",
      headers: {
        apikey: key,
        Authorization: "Bearer " + key,
        "Content-Type": "application/json",
        Prefer: "return=minimal",
      },
      body: JSON.stringify({
        name: payload.name,
        phone: payload.phone,
        contact_method: payload.contactMethod,
        message: payload.message || null,
        request_type: payload.requestType,
        product_slug: payload.productSlug || null,
        product_name: payload.productName || null,
        source_path: payload.sourcePath || null,
        consent: payload.consent,
      }),
    });

    if (!response.ok) {
      const details = await response.text();
      console.error("Lead save error:", details);
      return NextResponse.json({ message: "Не вдалося зберегти заявку. Спробуйте ще раз або зателефонуйте нам." }, { status: 500 });
    }
    await notifyTelegram(payload, request);
    return NextResponse.json({ ok: true });
  } catch (error) {
    if (error instanceof z.ZodError) return NextResponse.json({ message: error.issues[0]?.message || "Перевірте дані форми." }, { status: 400 });
    return NextResponse.json({ message: "Сталася помилка. Спробуйте ще раз." }, { status: 500 });
  }
}
