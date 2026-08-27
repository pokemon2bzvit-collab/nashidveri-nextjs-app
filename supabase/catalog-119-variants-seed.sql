-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-04/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-119 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-119', '{"color":"альпійський білий"}'::jsonb, 'papa-carlo-catalog-119-1706.jpg', 1706),
('catalog-119', '{"color":"сірий матовий"}'::jsonb, 'papa-carlo-catalog-119-2218.jpg', 2218),
('catalog-119', '{"color":"кремовий матовий"}'::jsonb, 'papa-carlo-catalog-119-4808.jpg', 4808)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
