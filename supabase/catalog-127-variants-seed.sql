-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-13-satin/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-127 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-127', '{"color":"альпійський білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-127-2873.jpg', 2873),
('catalog-127', '{"color":"сірий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-127-2877.jpg', 2877),
('catalog-127', '{"color":"кремовий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-127-4824.jpg', 4824)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
