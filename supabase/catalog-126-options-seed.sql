-- Варіанти, підтверджені офіційною сторінкою Papa Carlo: https://papa-carlo.com.ua/ua/dverne-polotno-t-11-blk/
-- Потрібна таблиця product_options (див. product-options-migration.sql).

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
values
('catalog-126', 'color', 'Колір полотна', 'альпійський білий', null, null, 0),
('catalog-126', 'color', 'Колір полотна', 'сірий матовий', null, null, 1),
('catalog-126', 'color', 'Колір полотна', 'кремовий матовий', null, null, 2),
('catalog-126', 'glass', 'Скло', 'скло чорне', null, null, 0)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
