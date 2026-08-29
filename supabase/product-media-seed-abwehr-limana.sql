-- Офіційні додаткові фото ABWEHR Limana (Megapolis Kale).
-- Джерело: abwehr.com.ua, сторінка моделі Limana, код 443.

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-2', 'gallery', 'Limana — фронтальний вигляд', 'https://abwehr.com.ua/storage/products/images/big/toqMIxhvSYzvG67IZ452KmWOcPMJ6ycm8EKuYbxW.jpg.webp?v=1771583738', 10),
  ('catalog-2', 'gallery', 'Limana — додатковий вигляд', 'https://abwehr.com.ua/storage/products/images/big/qpj8Lb57t5daZHabgxickmQmlwK3vNUdTnngACFB.jpg.webp?v=1771583408', 11)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1
  from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);
