-- Палітри колекцій StilDoors, підтверджені офіційним каталогом виробника.
-- Доступність конкретного кольору для певної моделі уточнюється у менеджера.
-- Фото не перемикається: виробник не публікує мапи «колір → зображення».

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'color', 'Палітра Presto — уточнюйте доступність', color.label, color.swatch, color.sort_order
from public.products as product
cross join (values
  ('Біла емаль RAL 9003', '#f5f4ef', 1),
  ('Світло-сірий RAL 7047', '#c5c6c3', 2),
  ('Сірий RAL 7036', '#7c7d7a', 3),
  ('Тауп', '#aa9c8d', 4),
  ('Шампань RAL 1013', '#e5d7bd', 5),
  ('Антрацит RAL 7016', '#3b4145', 6)
) as color(label, swatch, sort_order)
where product.brand = 'StilDoors' and product.collection = 'Presto'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
select product.slug, 'finish', 'Палітра Stil — уточнюйте доступність', finish.label, finish.swatch, finish.sort_order
from public.products as product
cross join (values
  ('Дрім вуд', '#9a8068', 1),
  ('Кремове дерево', '#d5bd93', 2),
  ('Сандал', '#bba88b', 3),
  ('Біле дерево', '#e5e1d7', 4),
  ('Венге преміум', '#4b352a', 5),
  ('Італійський горіх', '#744b32', 6),
  ('Вільха класична', '#965b3d', 7),
  ('Горіх золотий', '#a66d35', 8),
  ('Трюфель', '#655044', 9)
) as finish(label, swatch, sort_order)
where product.brand = 'StilDoors' and product.collection = 'Stil'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;
