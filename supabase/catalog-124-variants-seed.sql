-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-09-satin/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-124 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-124', '{"color":"альпійський білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-124-2824.jpg', 2824),
('catalog-124', '{"color":"сірий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-124-2828.jpg', 2828),
('catalog-124', '{"color":"кремовий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-124-4817.jpg', 4817)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
