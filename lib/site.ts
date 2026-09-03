export const siteUrl = (process.env.NEXT_PUBLIC_SITE_URL || "https://nashidveri-nextjs-app.vercel.app").replace(/\/$/, "");
export const siteName = "Наші двері";
export const salonAddress = "вулиця Івана Чендея, 44, Ужгород, Закарпатська область, 88000";

export const absoluteUrl = (path = "/") => /^https?:\/\//i.test(path) ? path : `${siteUrl}${path.startsWith("/") ? path : `/${path}`}`;

export const jsonLd = (data: unknown) => JSON.stringify(data).replace(/</g, "\\u003c");
