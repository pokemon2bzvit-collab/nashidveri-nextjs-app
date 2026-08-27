-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-02/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-88 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-88', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-88-1463.jpg', 1463),
('catalog-88', '{"color":"ясен білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-88-1464.jpg', 1464),
('catalog-88', '{"color":"дуб ciрий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-88-1465.jpg', 1465),
('catalog-88', '{"color":"дуб кремовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-88-1466.jpg', 1466),
('catalog-88', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-88-1467.jpg', 1467),
('catalog-88', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-88-1468.jpg', 1468),
('catalog-88', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-88-1715.jpg', 1715),
('catalog-88', '{"color":"ясен білий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-88-1716.jpg', 1716),
('catalog-88', '{"color":"дуб ciрий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-88-1717.jpg', 1717),
('catalog-88', '{"color":"дуб кремовий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-88-1718.jpg', 1718),
('catalog-88', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-88-1719.jpg', 1719),
('catalog-88', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-88-1720.jpg', 1720)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
