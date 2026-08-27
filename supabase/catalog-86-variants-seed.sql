-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-00f/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-86 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-86', '{"color":"емаліт білий матовий (ral 9003)"}'::jsonb, 'papa-carlo-catalog-86-1451.jpg', 1451),
('catalog-86', '{"color":"ясен білий"}'::jsonb, 'papa-carlo-catalog-86-1452.jpg', 1452),
('catalog-86', '{"color":"дуб ciрий"}'::jsonb, 'papa-carlo-catalog-86-1453.jpg', 1453),
('catalog-86', '{"color":"дуб кремовий"}'::jsonb, 'papa-carlo-catalog-86-1454.jpg', 1454),
('catalog-86', '{"color":"емаліт світло сірий супермат (ral 7044)"}'::jsonb, 'papa-carlo-catalog-86-1455.jpg', 1455),
('catalog-86', '{"color":"емаліт темно сірий супермат (ral 7016)"}'::jsonb, 'papa-carlo-catalog-86-1456.jpg', 1456)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
