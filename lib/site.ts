// Значення у Vercel має бути таким самим. Fallback потрібен, щоб sitemap,
// canonical URL та Schema.org не поверталися до технічного домену Vercel.
export const siteUrl = (process.env.NEXT_PUBLIC_SITE_URL || "https://nashidveri-uzhhorod.com.ua").replace(/\/$/, "");
export const siteName = "Наші двері";
export const salonAddress = "вулиця Івана Чендея, 44, Ужгород, Закарпатська область, 88000";

export const absoluteUrl = (path = "/") => /^https?:\/\//i.test(path) ? path : `${siteUrl}${path.startsWith("/") ? path : `/${path}`}`;

export const jsonLd = (data: unknown) => JSON.stringify(data).replace(/</g, "\\u003c");
