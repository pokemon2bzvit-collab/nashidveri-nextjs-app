-- RODOS Style: ПВХ-покриття Renolit та LG Hausys.
-- Колекція має понад 10 декорів; нижче — декори, зазначені у каталозі Style.

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Декор ПВХ — уточнюйте доступність', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('ПВХ білий мат', '#f5f4ef', 1),
  ('Темно-сірий', '#53565a', 2),
  ('Венге шоколадний', '#3d2b23', 3),
  ('Акація темна', '#6d4c3a', 4),
  ('Сірий дуб', '#817b70', 5),
  ('Дуб шале графіт', '#565049', 6),
  ('Дуб сонома', '#ad9570', 7),
  ('Каштан білий', '#d1c1a7', 8),
  ('Каштан беж', '#b89a78', 9),
  ('Каштан сірий', '#8c8479', 10),
  ('Крем', '#d8cdb5', 11),
  ('Мармур сірий', '#969896', 12),
  ('Сосна браш Braun', '#7a5137', 13),
  ('Сосна браш Cobalt', '#35556e', 14),
  ('Сосна браш Mint', '#8ca99d', 15)
) as color(label, swatch, sort_order)
where product.brand = 'Rodos' and product.collection = 'Style ПВХ'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;
