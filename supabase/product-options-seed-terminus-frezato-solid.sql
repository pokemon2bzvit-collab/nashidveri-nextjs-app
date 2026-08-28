-- Пакет Термінус: Frezato та Solid.
-- Дані звірені з актуальним каталогом виробника.

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Колір емалі', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Біла емаль', '#f5f4ef', 1),
  ('Сіра емаль', '#969696', 2),
  ('Крема емаль', '#d8cbb5', 3)
) as color(label, swatch, sort_order)
where product.brand = 'Термінус' and product.collection = 'Frezato'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Декор полотна', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Аквамарин', '#4e9aa3', 1),
  ('Аляска', '#d2d6d3', 2),
  ('Антрацит', '#343a3e', 3),
  ('Арктика', '#f4f4ef', 4),
  ('Білий', '#f7f6f1', 5),
  ('Магнолія', '#d7d0bf', 6),
  ('Малахіт', '#346a57', 7),
  ('Оливін', '#a4a875', 8),
  ('Онікс', '#25272a', 9),
  ('Сапфір', '#244c80', 10),
  ('Сахара', '#b59b74', 11),
  ('Сірий', '#8c8e8d', 12),
  ('Тундра', '#68766c', 13)
) as color(label, swatch, sort_order)
where product.brand = 'Термінус' and product.collection = 'Solid'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
select product.slug, 'edge', 'Алюмінієвий профіль торця', edge.label, edge.sort_order
from public.products as product
cross join (values
  ('Чорний', 1),
  ('Сірий', 2)
) as edge(label, sort_order)
where product.brand = 'Термінус' and product.collection = 'Solid'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
