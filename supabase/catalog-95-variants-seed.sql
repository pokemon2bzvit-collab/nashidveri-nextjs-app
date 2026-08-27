-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-16/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-95 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-95', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-95-1511.jpg', 1511),
('catalog-95', '{"color":"ясен білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-95-1512.jpg', 1512),
('catalog-95', '{"color":"дуб ciрий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-95-1513.jpg', 1513),
('catalog-95', '{"color":"дуб кремовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-95-1514.jpg', 1514),
('catalog-95', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-95-1515.jpg', 1515),
('catalog-95', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-95-1516.jpg', 1516),
('catalog-95', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-95-1727.jpg', 1727),
('catalog-95', '{"color":"ясен білий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-95-1728.jpg', 1728),
('catalog-95', '{"color":"дуб ciрий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-95-1729.jpg', 1729),
('catalog-95', '{"color":"дуб кремовий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-95-1730.jpg', 1730),
('catalog-95', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-95-1731.jpg', 1731),
('catalog-95', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-95-1732.jpg', 1732)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
