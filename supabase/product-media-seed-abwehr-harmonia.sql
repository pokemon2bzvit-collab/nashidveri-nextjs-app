-- Офіційні додаткові фото ABWEHR Harmonia (Megapolis Kale).
-- Джерело: abwehr.com.ua, сторінка моделі Harmonia, код 546.
-- Залишаємо головним локальне фото з catalog-images; це додаткові кадри галереї.

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-1', 'gallery', 'Harmonia — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/u7FeMxQJvT7EeNpt2NylYajG8UOr3c1AA2pCaMFf.jpg.webp?v=1783405588', 10),
  ('catalog-1', 'gallery', 'Harmonia — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/ae7C4AKisOrxBx1KXyE8mGz7svhdSAGx8TdnZW75.jpg.webp?v=1783405593', 11)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1
  from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);
