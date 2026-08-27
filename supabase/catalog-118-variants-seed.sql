-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-st-35/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-118 у bucket catalog-images, зберігши шлях variants/papa-carlo/catalog-118.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-118', '{"color":"емаліт білий матовий (ral 9003)","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-118/2430.jpg', 2430),
('catalog-118', '{"color":"емаліт білий матовий (ral 9003)","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-118/2431.jpg', 2431),
('catalog-118', '{"color":"ясен білий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-118/2432.jpg', 2432),
('catalog-118', '{"color":"ясен білий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-118/2433.jpg', 2433),
('catalog-118', '{"color":"дуб ciрий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-118/2434.jpg', 2434),
('catalog-118', '{"color":"дуб ciрий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-118/2435.jpg', 2435),
('catalog-118', '{"color":"дуб кремовий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-118/2436.jpg', 2436),
('catalog-118', '{"color":"дуб кремовий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-118/2437.jpg', 2437),
('catalog-118', '{"color":"емаліт світло сірий супермат (ral 7044)","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-118/2438.jpg', 2438),
('catalog-118', '{"color":"емаліт світло сірий супермат (ral 7044)","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-118/2439.jpg', 2439),
('catalog-118', '{"color":"емаліт темно сірий супермат (ral 7016)","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-118/2440.jpg', 2440),
('catalog-118', '{"color":"емаліт темно сірий супермат (ral 7016)","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-118/2441.jpg', 2441),
('catalog-118', '{"color":"бетон сiрий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-118/2442.jpg', 2442),
('catalog-118', '{"color":"бетон сiрий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-118/2443.jpg', 2443),
('catalog-118', '{"color":"сірий матовий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-118/2444.jpg', 2444),
('catalog-118', '{"color":"сірий матовий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-118/2445.jpg', 2445),
('catalog-118', '{"color":"кремовий матовий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-118/5010.jpg', 5010),
('catalog-118', '{"color":"кремовий матовий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-118/5011.jpg', 5011)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
