-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-06/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-89 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-89', '{"color":"емаліт білий матовий (ral 9003)"}'::jsonb, 'papa-carlo-catalog-89-1475.jpg', 1475),
('catalog-89', '{"color":"ясен білий"}'::jsonb, 'papa-carlo-catalog-89-1476.jpg', 1476),
('catalog-89', '{"color":"дуб ciрий"}'::jsonb, 'papa-carlo-catalog-89-1477.jpg', 1477),
('catalog-89', '{"color":"дуб кремовий"}'::jsonb, 'papa-carlo-catalog-89-1478.jpg', 1478),
('catalog-89', '{"color":"емаліт світло сірий супермат (ral 7044)"}'::jsonb, 'papa-carlo-catalog-89-1479.jpg', 1479),
('catalog-89', '{"color":"емаліт темно сірий супермат (ral 7016)"}'::jsonb, 'papa-carlo-catalog-89-1480.jpg', 1480)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
