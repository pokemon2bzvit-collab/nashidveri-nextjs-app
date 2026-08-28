-- Підтверджені варіанти виконання колекцій RODOS Grand.
-- Джерела: rodos.ua та офіційні картки дилерів RODOS.
-- Скрипт безпечний для повторного запуску: дублікати не створюються.
-- Фото полотна не змінюємо, бо виробник не дає підтвердженої відповідності
-- «колір → окреме фото» для кожної моделі.

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Колір полотна', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Темно-сірий', '#55565a', 1),
  ('Дрімвуд сірий', '#8a8179', 2),
  ('Клен білий', '#d9cfbb', 3),
  ('Дрімвуд темний', '#4d4139', 4),
  ('Світло-сірий', '#b9b8b4', 5),
  ('Беж', '#d2bfa4', 6),
  ('Сосна крем', '#d9c29d', 7),
  ('ПВХ білий мат', '#f3f1ea', 8)
) as color(label, swatch, sort_order)
where product.brand = 'Grand' and product.collection = 'DELUX'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Колір полотна', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Білий мат', '#f4f2eb', 1),
  ('Ламеціо', '#bcae9b', 2),
  ('Мадагаскар', '#694936', 3),
  ('Небраска', '#6d6259', 4),
  ('Нордік', '#c9c5b9', 5),
  ('Шервуд', '#765847', 6)
) as color(label, swatch, sort_order)
where product.brand = 'Grand' and product.collection = 'LUX'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Колір фарбування', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Білий мат', '#f4f2eb', 1),
  ('RAL / NCS на замовлення', null, 2)
) as color(label, swatch, sort_order)
where product.brand = 'Grand' and product.collection = 'Paint'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;
