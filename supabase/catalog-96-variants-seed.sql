-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-20/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-96 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-96', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-96-1517.jpg', 1517),
('catalog-96', '{"color":"ясен білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-96-1518.jpg', 1518),
('catalog-96', '{"color":"дуб ciрий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-96-1519.jpg', 1519),
('catalog-96', '{"color":"дуб кремовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-96-1520.jpg', 1520),
('catalog-96', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-96-1521.jpg', 1521),
('catalog-96', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-96-1522.jpg', 1522)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
