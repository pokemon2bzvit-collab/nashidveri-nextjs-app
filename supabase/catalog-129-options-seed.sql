-- Варіанти, підтверджені офіційною сторінкою Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-15-satin/
-- Потрібна таблиця product_options (див. product-options-migration.sql).

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
values
('catalog-129', 'color', 'Колір полотна', 'альпійський білий', null, null, 0),
('catalog-129', 'color', 'Колір полотна', 'сірий матовий', null, null, 1),
('catalog-129', 'color', 'Колір полотна', 'кремовий матовий', null, null, 2),
('catalog-129', 'glass', 'Скло', 'скло сатин 2х сторонній', null, null, 0)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
