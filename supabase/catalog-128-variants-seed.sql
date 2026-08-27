-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-14/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-128 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-128', '{"color":"альпійський білий"}'::jsonb, 'papa-carlo-catalog-128-2963.jpg', 2963),
('catalog-128', '{"color":"сірий матовий"}'::jsonb, 'papa-carlo-catalog-128-2965.jpg', 2965),
('catalog-128', '{"color":"кремовий матовий"}'::jsonb, 'papa-carlo-catalog-128-4836.jpg', 4836)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
