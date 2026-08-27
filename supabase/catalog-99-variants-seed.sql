-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-64/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-99 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-99', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-99-1607.jpg', 1607),
('catalog-99', '{"color":"ясен білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-99-1608.jpg', 1608),
('catalog-99', '{"color":"дуб ciрий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-99-1609.jpg', 1609),
('catalog-99', '{"color":"дуб кремовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-99-1610.jpg', 1610),
('catalog-99', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-99-1611.jpg', 1611),
('catalog-99', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-99-1612.jpg', 1612),
('catalog-99', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-99-1805.jpg', 1805),
('catalog-99', '{"color":"ясен білий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-99-1806.jpg', 1806),
('catalog-99', '{"color":"дуб ciрий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-99-1807.jpg', 1807),
('catalog-99', '{"color":"дуб кремовий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-99-1808.jpg', 1808),
('catalog-99', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-99-1809.jpg', 1809),
('catalog-99', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-99-1810.jpg', 1810)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
