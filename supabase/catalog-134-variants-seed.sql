-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-02-satin/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-134 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-134', '{"color":"альпійський білий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-134-1702.jpg', 1702),
('catalog-134', '{"color":"чорний матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-134-1864.jpg', 1864),
('catalog-134', '{"color":"сірий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-134-2210.jpg', 2210),
('catalog-134', '{"color":"кремовий матовий","glass":"скло сатин 2х сторонній"}'::jsonb, 'papa-carlo-catalog-134-4804.jpg', 4804)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
