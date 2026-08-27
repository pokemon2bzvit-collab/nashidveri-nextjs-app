-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-st-33/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-116 у bucket catalog-images, зберігши шлях variants/papa-carlo/catalog-116.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-116', '{"color":"емаліт білий матовий (ral 9003)","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-116/2398.jpg', 2398),
('catalog-116', '{"color":"емаліт білий матовий (ral 9003)","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-116/2399.jpg', 2399),
('catalog-116', '{"color":"ясен білий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-116/2400.jpg', 2400),
('catalog-116', '{"color":"ясен білий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-116/2401.jpg', 2401),
('catalog-116', '{"color":"дуб ciрий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-116/2402.jpg', 2402),
('catalog-116', '{"color":"дуб ciрий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-116/2403.jpg', 2403),
('catalog-116', '{"color":"дуб кремовий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-116/2404.jpg', 2404),
('catalog-116', '{"color":"дуб кремовий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-116/2405.jpg', 2405),
('catalog-116', '{"color":"емаліт світло сірий супермат (ral 7044)","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-116/2406.jpg', 2406),
('catalog-116', '{"color":"емаліт світло сірий супермат (ral 7044)","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-116/2407.jpg', 2407),
('catalog-116', '{"color":"емаліт темно сірий супермат (ral 7016)","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-116/2408.jpg', 2408),
('catalog-116', '{"color":"емаліт темно сірий супермат (ral 7016)","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-116/2409.jpg', 2409),
('catalog-116', '{"color":"бетон сiрий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-116/2410.jpg', 2410),
('catalog-116', '{"color":"бетон сiрий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-116/2411.jpg', 2411),
('catalog-116', '{"color":"сірий матовий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-116/2412.jpg', 2412),
('catalog-116', '{"color":"сірий матовий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-116/2413.jpg', 2413),
('catalog-116', '{"color":"кремовий матовий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-116/5006.jpg', 5006),
('catalog-116', '{"color":"кремовий матовий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-116/5007.jpg', 5007)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
