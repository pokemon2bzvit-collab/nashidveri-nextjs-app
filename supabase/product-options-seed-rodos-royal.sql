-- RODOS Royal: шпоновані двері Avalon.
-- Палітра тонування підтверджена каталогом RODOS для колекції Royal.

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Тонування шпону', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Дуб білий', '#d5c7af', 1),
  ('Горіх', '#76523c', 2),
  ('Палісандр', '#432d28', 3),
  ('LTL 6112', '#82634c', 4),
  ('LTL 6403', '#72523e', 5),
  ('LTL 6515', '#3f3029', 6),
  ('LTL 6908', '#5f4639', 7),
  ('LTL 6721', '#a58a6c', 8)
) as color(label, swatch, sort_order)
where product.brand = 'Rodos' and product.collection = 'Royal шпон'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;
