-- RODOS Siena: фарбовані класичні двері.
-- Підтверджено каталогом RODOS: білий мат або фарбування за RAL;
-- додатково доступне патинування золотом чи сріблом.

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Колір фарбування RAL', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Білий мат', '#f5f3eb', 1),
  ('RAL 1013', '#e8e1c9', 2),
  ('RAL 1015', '#e6d9bd', 3),
  ('RAL 1019', '#a99c82', 4),
  ('RAL 4001', '#8b7e8c', 5),
  ('RAL 5010', '#1d4f91', 6),
  ('RAL 5012', '#3b83bd', 7),
  ('RAL 5014', '#61728a', 8),
  ('RAL 5022', '#1e2a44', 9),
  ('RAL 5024', '#6f92a2', 10),
  ('RAL 6019', '#b8d8c5', 11),
  ('RAL 7037', '#7f8583', 12),
  ('RAL 7040', '#9da1a0', 13),
  ('RAL 7047', '#d1d1cb', 14),
  ('RAL 8014', '#4e352d', 15),
  ('RAL 9001', '#f5edda', 16),
  ('RAL 9004', '#252627', 17),
  ('RAL 9010', '#f7f7f2', 18)
) as color(label, swatch, sort_order)
where product.brand = 'Rodos' and product.collection = 'Siena фарба'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
select product.slug, 'finish', 'Патина', patina.label, patina.sort_order
from public.products as product
cross join (values
  ('Без патини', 1),
  ('Патина золото', 2),
  ('Патина срібло', 3)
) as patina(label, sort_order)
where product.brand = 'Rodos' and product.collection = 'Siena фарба'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
