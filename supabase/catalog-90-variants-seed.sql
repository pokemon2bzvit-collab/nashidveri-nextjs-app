-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-08/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-90 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-90', '{"color":"емаліт білий матовий (ral 9003)"}'::jsonb, 'papa-carlo-catalog-90-1481.jpg', 1481),
('catalog-90', '{"color":"ясен білий"}'::jsonb, 'papa-carlo-catalog-90-1482.jpg', 1482),
('catalog-90', '{"color":"дуб ciрий"}'::jsonb, 'papa-carlo-catalog-90-1483.jpg', 1483),
('catalog-90', '{"color":"дуб кремовий"}'::jsonb, 'papa-carlo-catalog-90-1484.jpg', 1484),
('catalog-90', '{"color":"емаліт світло сірий супермат (ral 7044)"}'::jsonb, 'papa-carlo-catalog-90-1485.jpg', 1485),
('catalog-90', '{"color":"емаліт темно сірий супермат (ral 7016)"}'::jsonb, 'papa-carlo-catalog-90-1486.jpg', 1486)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
