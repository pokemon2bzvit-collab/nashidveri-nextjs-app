-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-714/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-100 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-100', '{"color":"емаліт білий матовий (ral 9003)"}'::jsonb, 'papa-carlo-catalog-100-2753.jpg', 2753),
('catalog-100', '{"color":"ясен білий"}'::jsonb, 'papa-carlo-catalog-100-2754.jpg', 2754),
('catalog-100', '{"color":"дуб ciрий"}'::jsonb, 'papa-carlo-catalog-100-2755.jpg', 2755),
('catalog-100', '{"color":"дуб кремовий"}'::jsonb, 'papa-carlo-catalog-100-2756.jpg', 2756),
('catalog-100', '{"color":"емаліт світло сірий супермат (ral 7044)"}'::jsonb, 'papa-carlo-catalog-100-2757.jpg', 2757),
('catalog-100', '{"color":"емаліт темно сірий супермат (ral 7016)"}'::jsonb, 'papa-carlo-catalog-100-2758.jpg', 2758)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
