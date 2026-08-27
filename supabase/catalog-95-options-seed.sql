-- Варіанти, підтверджені офіційною сторінкою Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-ml-16/
-- Потрібна таблиця product_options (див. product-options-migration.sql).

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
values
('catalog-95', 'color', 'Колір полотна', 'емаліт білий матовий (ral 9003)', null, null, 0),
('catalog-95', 'color', 'Колір полотна', 'емаліт темно сірий супермат (ral 7016)', null, null, 1),
('catalog-95', 'color', 'Колір полотна', 'емаліт світло сірий супермат (ral 7044)', null, null, 2),
('catalog-95', 'color', 'Колір полотна', 'дуб ciрий', null, null, 3),
('catalog-95', 'color', 'Колір полотна', 'дуб кремовий', null, null, 4),
('catalog-95', 'color', 'Колір полотна', 'ясен білий', null, null, 5),
('catalog-95', 'glass', 'Скло', 'скло сатин 2х сторонній', null, null, 0),
('catalog-95', 'glass', 'Скло', 'скло чорне', null, null, 1)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
