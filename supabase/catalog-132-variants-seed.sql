-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-00f/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-132 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-132', '{"color":"альпійський білий"}'::jsonb, 'papa-carlo-catalog-132-5534.jpg', 5534),
('catalog-132', '{"color":"сірий матовий"}'::jsonb, 'papa-carlo-catalog-132-5535.jpg', 5535),
('catalog-132', '{"color":"кремовий матовий"}'::jsonb, 'papa-carlo-catalog-132-5536.jpg', 5536)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
