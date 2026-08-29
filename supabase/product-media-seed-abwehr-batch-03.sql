-- Офіційні додаткові фото ABWEHR: Avenue, Carat, Queen, Revolution, Tower 1200, Tower.
-- Джерело: офіційні сторінки моделей на abwehr.com.ua.

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-9', 'gallery', 'Avenue — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/pe1EiHVp9cIiq4V68KGleOrQpYH4F2KHArWQRCkm.jpg.webp?v=1771583277', 10),
  ('catalog-9', 'gallery', 'Avenue — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/cl2EIUFam1y6EP5LESWUEO6d1X0tqJgqBuM0PlcP.jpg.webp?v=1771581921', 11),
  ('catalog-10', 'gallery', 'Carat — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/2Ognt7p9I4fne2HhBHl0wXRHht3rQYjaHJuu8TZX.jpg.webp?v=1771578226', 10),
  ('catalog-10', 'gallery', 'Carat — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/SvoHiaCj8Z6SKPAPWQLcwD9CNXdD6yYiAZggxt1m.jpg.webp?v=1771580944', 11),
  ('catalog-11', 'gallery', 'Queen — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/OHakuY8lESXnqGHdEx7VmxT9SnAs7lEbrj2QywF7.jpg.webp?v=1775199547', 10),
  ('catalog-11', 'gallery', 'Queen — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/B0BYlPPhu0y50rHDJdkkECJvp3gkugc6hYRoNYAK.jpg.webp?v=1775199550', 11),
  ('catalog-12', 'gallery', 'Revolution — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/0nJyCNIijLcVgn3YvBWn1jaYbkA0r9wSQncM5XQ3.jpg.webp?v=1771578082', 10),
  ('catalog-12', 'gallery', 'Revolution — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/iSfzrB2NFsA7AZX8EAo7f1WHV1kMx3wxSLAQVKTM.jpg.webp?v=1771582504', 11),
  ('catalog-13', 'gallery', 'Tower 1200 — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/nma1sSFoEdFVrbNZfK5Pxo31orcH0tDSX8x1xgUO.jpg.webp?v=1777289620', 10),
  ('catalog-13', 'gallery', 'Tower 1200 — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/StzAAY3cBtvd8fM5FVAetEnltY0dhjRFnfkR8epZ.jpg.webp?v=1777289627', 11),
  ('catalog-14', 'gallery', 'Tower — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/CyZGGuwbvCrEbhWJyEYF12DEHVUhBclHLyx54u34.jpg.webp?v=1773838265', 10),
  ('catalog-14', 'gallery', 'Tower — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/d0bZxm0MTGOPsixlDcQrIdrpFiXnw4UbmN79Jd0e.jpg.webp?v=1773838264', 11)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1
  from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);
