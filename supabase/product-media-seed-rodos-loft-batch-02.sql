-- Офіційні додаткові фото RODOS, колекція Loft (продовження).
-- Джерело: офіційний каталог RODOS, rodos.md.

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-229', 'gallery', 'Rodos Loft Olimpia 2 — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/274/izobrazhenie-2024-05-28-124640069.png', 10),
  ('catalog-229', 'gallery', 'Rodos Loft Olimpia 2 — додатковий вигляд', 'https://www.rodos.md/assets/images/products/274/olimpia-2-gluhoe-belmat-1659359340-2000x2000.jpg', 11),
  ('catalog-230', 'gallery', 'Rodos Loft Olimpia 3 — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/275/izobrazhenie-2024-05-28-124925480.png', 10),
  ('catalog-230', 'gallery', 'Rodos Loft Olimpia 3 — додатковий вигляд', 'https://www.rodos.md/assets/images/products/275/olimpia-3-gluhoe-1015-1659362207-2000x2000.jpg', 11),
  ('catalog-232', 'gallery', 'Rodos Loft Porto 2 — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/56/8.jpg', 10),
  ('catalog-232', 'gallery', 'Rodos Loft Porto 2 — додатковий вигляд', 'https://www.rodos.md/assets/images/products/56/porto-2.jpg', 11),
  ('catalog-233', 'gallery', 'Rodos Loft Porto 3 — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/155/porto-3.jpg', 10),
  ('catalog-233', 'gallery', 'Rodos Loft Porto 3 — додатковий вигляд', 'https://www.rodos.md/assets/images/products/155/cortes-porto3.jpg', 11),
  ('catalog-234', 'gallery', 'Rodos Loft Porto — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/286/porto-1.jpg', 10),
  ('catalog-234', 'gallery', 'Rodos Loft Porto — додатковий вигляд', 'https://www.rodos.md/assets/images/products/286/dveri-cortes-porto-rodos-belaya-emal-steklo-satin.jpg', 11),
  ('catalog-236', 'gallery', 'Rodos Loft Wave V — вигляд моделі', 'https://www.rodos.md/assets/images/products/62/loft-wave-v-%D0%B1%D0%B5%D0%BB%D1%8B%D0%B9-%D0%BC%D0%B0%D1%82-21151.jpg', 10)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1
  from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);
