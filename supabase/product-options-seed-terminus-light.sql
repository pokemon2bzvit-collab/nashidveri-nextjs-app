-- Термінус Light: офіційна палітра покриттів колекції.
-- Включає деревоподібні, однотонні та фактурні декори для моделей ПК-01–ПК-17.

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Декор покриття', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Дуб перлинний', '#b9a889', 1),
  ('Дуб класичний', '#957553', 2),
  ('Дуб античний', '#725139', 3),
  ('Дуб вулканічний', '#4b3b33', 4),
  ('Білий матовий', '#f4f3ee', 5),
  ('Сірий', '#949494', 6),
  ('Магнолія', '#d7d0bf', 7),
  ('Антрацит', '#32383c', 8),
  ('Зефір', '#eee5d8', 9),
  ('Карамель', '#a77b56', 10),
  ('Пекан', '#7b5339', 11)
) as color(label, swatch, sort_order)
where product.brand = 'Термінус' and product.collection = 'Light'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;
