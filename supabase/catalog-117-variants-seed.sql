-- Фото з офіційної сторінки Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-st-34/
-- Завантажте вміст папки tmp\papa-carlo-variants\catalog-117 у bucket catalog-images, зберігши шлях variants/papa-carlo/catalog-117.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
('catalog-117', '{"color":"емаліт білий матовий (ral 9003)","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-117/2414.jpg', 2414),
('catalog-117', '{"color":"емаліт білий матовий (ral 9003)","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-117/2415.jpg', 2415),
('catalog-117', '{"color":"ясен білий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-117/2416.jpg', 2416),
('catalog-117', '{"color":"ясен білий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-117/2417.jpg', 2417),
('catalog-117', '{"color":"дуб ciрий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-117/2418.jpg', 2418),
('catalog-117', '{"color":"дуб ciрий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-117/2419.jpg', 2419),
('catalog-117', '{"color":"дуб кремовий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-117/2420.jpg', 2420),
('catalog-117', '{"color":"дуб кремовий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-117/2421.jpg', 2421),
('catalog-117', '{"color":"емаліт світло сірий супермат (ral 7044)","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-117/2422.jpg', 2422),
('catalog-117', '{"color":"емаліт світло сірий супермат (ral 7044)","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-117/2423.jpg', 2423),
('catalog-117', '{"color":"емаліт темно сірий супермат (ral 7016)","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-117/2424.jpg', 2424),
('catalog-117', '{"color":"емаліт темно сірий супермат (ral 7016)","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-117/2425.jpg', 2425),
('catalog-117', '{"color":"бетон сiрий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-117/2426.jpg', 2426),
('catalog-117', '{"color":"бетон сiрий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-117/2427.jpg', 2427),
('catalog-117', '{"color":"сірий матовий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-117/2428.jpg', 2428),
('catalog-117', '{"color":"сірий матовий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-117/2429.jpg', 2429),
('catalog-117', '{"color":"кремовий матовий","edge":"торець кромка алюмiнiй сiрий"}'::jsonb, 'variants/papa-carlo/catalog-117/5008.jpg', 5008),
('catalog-117', '{"color":"кремовий матовий","edge":"торець кромка алюмiнiй чорний"}'::jsonb, 'variants/papa-carlo/catalog-117/5009.jpg', 5009)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;
