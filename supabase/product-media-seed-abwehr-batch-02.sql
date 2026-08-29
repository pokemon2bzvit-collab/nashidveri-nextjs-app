-- Офіційні додаткові фото ABWEHR: Melany, Mira, Rain, Riviera, Selena, Stella.
-- Джерело: офіційні сторінки моделей на abwehr.com.ua.

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-3', 'gallery', 'Melany — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/g8xtMA0Uq2KcRuqbe8Ncgy1snprQtxtIOBfVRLOl.jpg.webp?v=1771582275', 10),
  ('catalog-3', 'gallery', 'Melany — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/bEE0KtCiZ53BQus0IKeVfcHO0KwHGEWCB1eglZ9y.jpg.webp?v=1771581764', 11),
  ('catalog-4', 'gallery', 'Mira — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/SHh0dyG5P8ihZtJHjesAgmxUjqRDyrfjgyXcPi78.jpg.webp?v=1771580867', 10),
  ('catalog-4', 'gallery', 'Mira — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/8YTRhClJwv571DzYhJIRznq6PZe74qjUWET44hrX.jpg.webp?v=1771578870', 11),
  ('catalog-5', 'gallery', 'Rain — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/m1Q4QDrMEbWm5OAYmfZv8qNi2bTCI8d5DgaksMF5.jpg.webp?v=1771582863', 10),
  ('catalog-5', 'gallery', 'Rain — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/rw7zA3yOBuAa2kU6ybTpV7vI9fRxTQFOHAPyp8Xw.jpg.webp?v=1771583512', 11),
  ('catalog-6', 'gallery', 'Riviera — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/GMjyN8Sr0DDWgJ3VV176iMhi0HstlacP7sbx5JgH.jpg.webp?v=1771579700', 10),
  ('catalog-6', 'gallery', 'Riviera — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/VqNTbRB7dbaRl3ABMEemZHSlEkBLuk19FjatNtCm.jpg.webp?v=1771581227', 11),
  ('catalog-7', 'gallery', 'Selena — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/D35l3eHQu0lEsjZJrsFAY0LQEBwiMMmN6CZOdVj6.jpg.webp?v=1771579355', 10),
  ('catalog-7', 'gallery', 'Selena — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/1oMmzuYiOltOmwppMPWdFG0QyQaQkGEIeCV2Qq8H.jpg.webp?v=1771578171', 11),
  ('catalog-8', 'gallery', 'Stella — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/o28BW94MJgKHJ3nDw79tsYJUQwnNUpPE4cTtkzc5.jpg.webp?v=1771583086', 10),
  ('catalog-8', 'gallery', 'Stella — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/JVZwt63WI3L03o10KbCZc1rAFdq1XuJ2ZqczDRNU.jpg.webp?v=1771580017', 11)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1
  from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);
