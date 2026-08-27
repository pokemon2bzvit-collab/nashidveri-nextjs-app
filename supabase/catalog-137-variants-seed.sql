-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-18-blk/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-137 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-137', '{"color":"альпійський білий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-137-5377.jpg', 5377),
('catalog-137', '{"color":"сірий матовий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-137-5381.jpg', 5381),
('catalog-137', '{"color":"кремовий матовий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-137-5383.jpg', 5383)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
