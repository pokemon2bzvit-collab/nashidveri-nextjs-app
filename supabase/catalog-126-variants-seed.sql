-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-11-blk/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-126 у корінь bucket catalog-images.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-126', '{"color":"альпійський білий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-126-2861.jpg', 2861),
('catalog-126', '{"color":"сірий матовий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-126-2865.jpg', 2865),
('catalog-126', '{"color":"кремовий матовий","glass":"скло чорне"}'::jsonb, 'papa-carlo-catalog-126-4822.jpg', 4822)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
