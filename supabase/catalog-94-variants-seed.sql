-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-14/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-94 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-94', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-94-1505.jpg', 1505),
('catalog-94', '{"color":"ясен білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-94-1506.jpg', 1506),
('catalog-94', '{"color":"дуб ciрий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-94-1507.jpg', 1507),
('catalog-94', '{"color":"дуб кремовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-94-1508.jpg', 1508),
('catalog-94', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-94-1509.jpg', 1509),
('catalog-94', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-94-1510.jpg', 1510),
('catalog-94', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-94-1721.jpg', 1721),
('catalog-94', '{"color":"ясен білий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-94-1722.jpg', 1722),
('catalog-94', '{"color":"дуб ciрий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-94-1723.jpg', 1723),
('catalog-94', '{"color":"дуб кремовий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-94-1724.jpg', 1724),
('catalog-94', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-94-1725.jpg', 1725),
('catalog-94', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-94-1726.jpg', 1726)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
