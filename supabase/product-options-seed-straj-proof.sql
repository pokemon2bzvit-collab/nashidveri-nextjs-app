-- STRAJ Proof: підтверджені декори вуличної серії.
-- Покриття Vinorit (ПВХ) стійке до УФ-випромінювання та атмосферних впливів.

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
select product.slug, 'finish', 'Зовнішнє покриття', 'Віноріт (ПВХ)', 1
from public.products as product
where product.brand = 'Страж'
  and (product.name ilike '%proof%' or product.name ilike '%party%')
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Декор Віноріт — уточнюйте доступність', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('PF антрацит сірий (пісок)', '#55575a', 1),
  ('PF дуб 23', '#8c6746', 2),
  ('PF дуб полярний', '#c3ad8c', 3),
  ('PF венге світлий DL', '#76533d', 4),
  ('PF венге темний DL', '#412e27', 5),
  ('PF дуб золотий DL', '#b78446', 6),
  ('PF дуб сірий', '#7a746a', 7),
  ('PF дуб сонома', '#b39a72', 8),
  ('PF дуб темний', '#5a3c29', 9),
  ('PF дуб світлий', '#c5a97c', 10),
  ('PF горіх коньячний', '#76452b', 11)
) as color(label, swatch, sort_order)
where product.brand = 'Страж'
  and (product.name ilike '%proof%' or product.name ilike '%party%')
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;
