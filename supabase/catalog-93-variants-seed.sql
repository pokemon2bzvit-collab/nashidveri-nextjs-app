-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-12/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-93 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-93', '{"color":"емаліт білий матовий (ral 9003)"}'::jsonb, 'papa-carlo-catalog-93-1499.jpg', 1499),
('catalog-93', '{"color":"ясен білий"}'::jsonb, 'papa-carlo-catalog-93-1500.jpg', 1500),
('catalog-93', '{"color":"дуб ciрий"}'::jsonb, 'papa-carlo-catalog-93-1501.jpg', 1501),
('catalog-93', '{"color":"дуб кремовий"}'::jsonb, 'papa-carlo-catalog-93-1502.jpg', 1502),
('catalog-93', '{"color":"емаліт світло сірий супермат (ral 7044)"}'::jsonb, 'papa-carlo-catalog-93-1503.jpg', 1503),
('catalog-93', '{"color":"емаліт темно сірий супермат (ral 7016)"}'::jsonb, 'papa-carlo-catalog-93-1504.jpg', 1504)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
