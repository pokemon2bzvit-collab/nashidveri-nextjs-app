-- Термінус Neoclassico: 4 офіційні декори та скління колекції.

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Колір полотна', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Білий', '#f5f4ef', 1),
  ('Сірий', '#8a8d8d', 2),
  ('Магнолія', '#d9d1bf', 3),
  ('Антрацит', '#30363a', 4)
) as color(label, swatch, sort_order)
where product.brand = 'Термінус' and product.collection = 'Neoclassico'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;
