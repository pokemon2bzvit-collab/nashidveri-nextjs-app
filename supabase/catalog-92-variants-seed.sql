-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-11/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-92 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-92', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-92-1493.jpg', 1493),
('catalog-92', '{"color":"ясен білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-92-1494.jpg', 1494),
('catalog-92', '{"color":"дуб ciрий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-92-1495.jpg', 1495),
('catalog-92', '{"color":"дуб кремовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-92-1496.jpg', 1496),
('catalog-92', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-92-1497.jpg', 1497),
('catalog-92', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-92-1498.jpg', 1498)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
