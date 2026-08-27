-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-00/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-85 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-85', '{"color":"емаліт білий матовий (ral 9003)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-85-1445.jpg', 1445),
('catalog-85', '{"color":"ясен білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-85-1446.jpg', 1446),
('catalog-85', '{"color":"дуб ciрий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-85-1447.jpg', 1447),
('catalog-85', '{"color":"дуб кремовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-85-1448.jpg', 1448),
('catalog-85', '{"color":"емаліт світло сірий супермат (ral 7044)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-85-1449.jpg', 1449),
('catalog-85', '{"color":"емаліт темно сірий супермат (ral 7016)","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-85-1450.jpg', 1450)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
