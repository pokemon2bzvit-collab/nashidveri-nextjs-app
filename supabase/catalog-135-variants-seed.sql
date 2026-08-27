-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-03-satin/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-135 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-135', '{"color":"альпійський білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-135-1704.jpg', 1704),
('catalog-135', '{"color":"чорний матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-135-1866.jpg', 1866),
('catalog-135', '{"color":"сірий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-135-2214.jpg', 2214),
('catalog-135', '{"color":"кремовий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-135-4806.jpg', 4806)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
