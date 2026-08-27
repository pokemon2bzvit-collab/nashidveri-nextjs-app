-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-01/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-87 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-87', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-87-1457.jpg', 1457),
('catalog-87', '{"color":"ясен білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-87-1458.jpg', 1458),
('catalog-87', '{"color":"дуб ciрий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-87-1459.jpg', 1459),
('catalog-87', '{"color":"дуб кремовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-87-1460.jpg', 1460),
('catalog-87', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-87-1461.jpg', 1461),
('catalog-87', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-87-1462.jpg', 1462),
('catalog-87', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-87-1709.jpg', 1709),
('catalog-87', '{"color":"ясен білий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-87-1710.jpg', 1710),
('catalog-87', '{"color":"дуб ciрий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-87-1711.jpg', 1711),
('catalog-87', '{"color":"дуб кремовий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-87-1712.jpg', 1712),
('catalog-87', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-87-1713.jpg', 1713),
('catalog-87', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-87-1714.jpg', 1714)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
