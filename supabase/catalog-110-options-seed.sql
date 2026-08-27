-- Варіанти, підтверджені офіційною сторінкою Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-pl-32/
-- Потрібна таблиця product_options (див. product-options-migration.sql).

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
values
('catalog-110', 'color', 'Колір полотна', 'емаліт білий матовий (ral 9003)', null, null, 0),
('catalog-110', 'color', 'Колір полотна', 'емаліт темно сірий супермат (ral 7016)', null, null, 1),
('catalog-110', 'color', 'Колір полотна', 'емаліт світло сірий супермат (ral 7044)', null, null, 2),
('catalog-110', 'color', 'Колір полотна', 'дуб ciрий', null, null, 3),
('catalog-110', 'color', 'Колір полотна', 'дуб кремовий', null, null, 4),
('catalog-110', 'color', 'Колір полотна', 'ясен білий', null, null, 5),
('catalog-110', 'color', 'Колір полотна', 'бетон сiрий', null, null, 6),
('catalog-110', 'color', 'Колір полотна', 'сірий матовий', null, null, 7),
('catalog-110', 'color', 'Колір полотна', 'кремовий матовий', null, null, 8),
('catalog-110', 'edge', 'Кромка / торець', 'торець кромка алюмiнiй сiрий', null, null, 0),
('catalog-110', 'edge', 'Кромка / торець', 'торець кромка алюмiнiй чорний', null, null, 1),
('catalog-110', 'edge', 'Кромка / торець', 'торець кромка ABC у колір полотна', null, null, 2),
('catalog-110', 'edge', 'Кромка / торець', 'торець кромка ABC чорна', null, null, 3),
('catalog-110', 'edge', 'Кромка / торець', 'торець кромка ABC золота', null, null, 4)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
