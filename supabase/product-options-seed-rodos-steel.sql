-- Базові внутрішні накладки RODOS Steel, підтверджені конструктором RODOS.
-- Це лише стандартні декори; інші кольори та зовнішні накладки — за прорахунком.
-- Окремі зображення для кожного декору виробник не прив'язує до моделі.

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'finish', 'Декор накладки — уточнюйте доступність', finish.label, finish.swatch, finish.sort_order
from public.products as product
cross join (values
  ('Крем', '#ddd3bf', 1),
  ('Сосна крем', '#d5bd8a', 2),
  ('Меранті', '#9b5d3d', 3),
  ('Венге шоколад', '#4a3028', 4),
  ('Дуб сонома', '#b99f78', 5),
  ('Каштан білий', '#d5cfc1', 6)
) as finish(label, swatch, sort_order)
where product.brand = 'Rodos Steel'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
values
  ('catalog-153', 'finish', 'Декор накладки — уточнюйте доступність', 'LTL 6515', 10),
  ('catalog-153', 'finish', 'Декор накладки — уточнюйте доступність', 'LTL 6908', 11),
  ('catalog-172', 'finish', 'Декор накладки — уточнюйте доступність', 'LTL 6515', 10),
  ('catalog-172', 'finish', 'Декор накладки — уточнюйте доступність', 'LTL 6908', 11)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
