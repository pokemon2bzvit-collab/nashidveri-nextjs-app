-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-01-satin/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-133 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-133', '{"color":"альпійський білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-133-1700.jpg', 1700),
('catalog-133', '{"color":"чорний матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-133-1862.jpg', 1862),
('catalog-133', '{"color":"сірий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-133-2206.jpg', 2206),
('catalog-133', '{"color":"кремовий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-133-4801.jpg', 4801)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
