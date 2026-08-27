-- Підтверджені декори Terminus з офіційних описів колекцій Caro та Elit Plus.
-- Спочатку виконайте product-options-migration.sql, потім цей файл у Supabase → SQL Editor.
-- Цей seed можна запускати повторно: дублікати не створяться.

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'finish', 'Декор / шпон', decor.label, decor.swatch, decor.sort_order
from public.products as product
cross join (values
  ('Дуб Даймонд', '#9b7c56', 1),
  ('Дуб Браун', '#5b402c', 2),
  ('Ясен білий — емаль', '#f1eee5', 3),
  ('Ясен Crema — емаль', '#d7c3a0', 4),
  ('Американський горіх', '#6a4634', 5)
) as decor(label, swatch, sort_order)
where product.brand = 'Термінус' and product.collection = 'Caro'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Колір полотна', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Білий', '#f5f4ef', 1),
  ('Сірий', '#8a8d8d', 2),
  ('Магнолія', '#d9d1bf', 3),
  ('Антрацит', '#30363a', 4)
) as color(label, swatch, sort_order)
where product.brand = 'Термінус' and product.collection = 'Elit plus'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
values
  ('catalog-295', 'glass', 'Тип скла', '03 / КДТ · прозоре', 1),
  ('catalog-295', 'glass', 'Тип скла', '05 / КДТ · прозоре', 2),
  ('catalog-295', 'glass', 'Тип скла', '09 / МТ2БТ · бронза', 3),
  ('catalog-295', 'glass', 'Тип скла', '03 / КДС · сатин', 4),
  ('catalog-295', 'glass', 'Тип скла', '05 / КДС · сатин', 5),
  ('catalog-295', 'glass', 'Тип скла', '09 / МТ2БС · бронза сатин', 6),
  ('catalog-296', 'glass', 'Тип скла', '13 / КДТ · прозоре', 1),
  ('catalog-296', 'glass', 'Тип скла', '13 / КДС · сатин', 2),
  ('catalog-297', 'glass', 'Тип скла', '21 / КДТ · прозоре', 1),
  ('catalog-297', 'glass', 'Тип скла', '21 / КДС · сатин', 2),
  ('catalog-297', 'glass', 'Тип скла', '05 / КДТ · прозоре', 3),
  ('catalog-297', 'glass', 'Тип скла', '05 / КДС · сатин', 4),
  ('catalog-298', 'glass', 'Тип скла', '08 / КДТ · прозоре', 1),
  ('catalog-298', 'glass', 'Тип скла', '08 / КДС · сатин', 2),
  ('catalog-299', 'glass', 'Тип скла', '27 / Т', 1),
  ('catalog-299', 'glass', 'Тип скла', '27 / С', 2),
  ('catalog-299', 'glass', 'Тип скла', '13 / КДТ · прозоре', 3),
  ('catalog-299', 'glass', 'Тип скла', '13 / КДС · сатин', 4)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
select product.slug, 'glass', 'Тип скла', glass.label, glass.sort_order
from public.products as product
cross join (values
  ('Сатин світлий', 1),
  ('Сатин бронза', 2)
) as glass(label, sort_order)
where product.brand = 'Термінус' and product.collection = 'Elit plus'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
