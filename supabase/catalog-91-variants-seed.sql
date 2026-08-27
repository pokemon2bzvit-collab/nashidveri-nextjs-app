-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-10/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-91 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-91', '{"color":"емаліт білий матовий (ral 9003)"}'::jsonb, 'papa-carlo-catalog-91-1487.jpg', 1487),
('catalog-91', '{"color":"ясен білий"}'::jsonb, 'papa-carlo-catalog-91-1488.jpg', 1488),
('catalog-91', '{"color":"дуб ciрий"}'::jsonb, 'papa-carlo-catalog-91-1489.jpg', 1489),
('catalog-91', '{"color":"дуб кремовий"}'::jsonb, 'papa-carlo-catalog-91-1490.jpg', 1490),
('catalog-91', '{"color":"емаліт світло сірий супермат (ral 7044)"}'::jsonb, 'papa-carlo-catalog-91-1491.jpg', 1491),
('catalog-91', '{"color":"емаліт темно сірий супермат (ral 7016)"}'::jsonb, 'papa-carlo-catalog-91-1492.jpg', 1492)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
