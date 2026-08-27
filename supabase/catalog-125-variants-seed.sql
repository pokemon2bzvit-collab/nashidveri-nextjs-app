-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-10-satin/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-125 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-125', '{"color":"альпійський білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-125-2836.jpg', 2836),
('catalog-125', '{"color":"сірий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-125-2840.jpg', 2840),
('catalog-125', '{"color":"кремовий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-125-4819.jpg', 4819)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
