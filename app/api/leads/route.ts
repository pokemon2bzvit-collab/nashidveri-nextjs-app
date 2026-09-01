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
    return NextResponse.json({ ok: true });
  } catch (error) {
    if (error instanceof z.ZodError) return NextResponse.json({ message: error.issues[0]?.message || "Перевірте дані форми." }, { status: 400 });
    return NextResponse.json({ message: "Сталася помилка. Спробуйте ще раз." }, { status: 500 });
  }
}
