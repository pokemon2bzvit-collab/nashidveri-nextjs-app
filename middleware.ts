import { NextRequest, NextResponse } from "next/server";

const maintenancePage = `<!doctype html>
<html lang="uk">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>Наші двері — технічні роботи</title>
    <style>
      *{box-sizing:border-box} body{margin:0;min-height:100vh;display:grid;place-items:center;background:#f7f5f1;color:#20201e;font-family:Arial,sans-serif;padding:24px}.card{max-width:560px;text-align:center;background:#fff;border:1px solid #e8e3dc;border-radius:28px;padding:48px 32px;box-shadow:0 18px 55px rgba(42,34,25,.08)}.mark{width:54px;height:54px;margin:0 auto 26px;border-radius:18px;background:#b66a36;color:white;display:grid;place-items:center;font-size:26px}h1{font-family:Georgia,serif;font-size:clamp(30px,6vw,44px);line-height:1.05;margin:0 0 18px}p{margin:0;color:#6e6962;font-size:17px;line-height:1.6}.phone{display:inline-block;margin-top:26px;color:#20201e;font-weight:700;text-decoration:none}.note{font-size:13px;margin-top:16px}
    </style>
  </head>
  <body><main class="card"><div class="mark">▯</div><h1>Сайт оновлюється</h1><p>Ми тимчасово проводимо технічні роботи, щоб зробити каталог зручнішим.</p><a class="phone" href="tel:+380950729341">+38 (095) 072-93-41</a><p class="note">Дякуємо за розуміння. Незабаром повернемося.</p></main></body>
</html>`;

export function middleware(request: NextRequest) {
  if (process.env.MAINTENANCE_MODE !== "true") return NextResponse.next();

  const { pathname } = request.nextUrl;
  // Адміністратор і внутрішні API залишаються доступними під час робіт.
  if (pathname.startsWith("/admin") || pathname.startsWith("/api")) return NextResponse.next();

  return new NextResponse(maintenancePage, {
    status: 503,
    headers: {
      "content-type": "text/html; charset=utf-8",
      "cache-control": "no-store, max-age=0",
      "retry-after": "3600",
      "x-robots-tag": "noindex, nofollow",
    },
  });
}

export const config = { matcher: "/:path*" };
