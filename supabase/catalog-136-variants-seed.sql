-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-12/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-136 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-136', '{"color":"альпійський білий"}'::jsonb, 'papa-carlo-catalog-136-2959.jpg', 2959),
('catalog-136', '{"color":"сірий матовий"}'::jsonb, 'papa-carlo-catalog-136-2961.jpg', 2961),
('catalog-136', '{"color":"кремовий матовий"}'::jsonb, 'papa-carlo-catalog-136-4835.jpg', 4835)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
