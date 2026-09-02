-- Market Dveri — Terminus Neoclassico: варіанти полотна ПГ / ПО.
-- Для кожного перемикача використано лише окреме фото відповідної моделі.
-- Скрипт можна безпечно запускати повторно.

update public.products as product
set description = format(
  'Термінус Neoclassico %s — міжкімнатні двері з ПВХ-покриттям у неокласичному стилі. Фільончаста конструкція, полотно 40 мм, телескопічний погонаж та ущільнювач поєднують класичний дизайн і практичність. Оберіть доступний варіант полотна ПГ або ПО, щоб переглянути точне фото.',
  source.model
)
from (values
  ('catalog-341', '401'), ('catalog-342', '402'), ('catalog-343', '404'), ('catalog-344', '601'),
  ('catalog-345', '602'), ('catalog-346', '603'), ('catalog-347', '604'), ('catalog-348', '605'),
  ('catalog-349', '606'), ('catalog-350', '607'), ('catalog-351', '608'), ('catalog-352', '609')
) as source(slug, model)
where product.slug = source.slug;

insert into public.product_options (product_slug, option_group, group_label, label, image_path, sort_order)
values
  ('catalog-341', 'configuration', 'Варіант полотна', 'ПГ', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27843/dveri-terminus-neoclassico-401-pg-main.jpg', 1),
  ('catalog-342', 'configuration', 'Варіант полотна', 'ПГ', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27844/dveri-terminus-neoclassico-402-pg-main.jpg', 1),
  ('catalog-342', 'configuration', 'Варіант полотна', 'ПО', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27845/dveri-terminus-neoclassico-402-po-main.jpg', 2),
  ('catalog-343', 'configuration', 'Варіант полотна', 'ПГ', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24079/dveri-terminus-neoclassico-404-pg-main.jpg', 1),
  ('catalog-343', 'configuration', 'Варіант полотна', 'ПО', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24080/dveri-terminus-neoclassico-404-po-main.jpg', 2),
  ('catalog-344', 'configuration', 'Варіант полотна', 'ПО', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27841/dveri-terminus-neoclassico-601-po-main.jpg', 1),
  ('catalog-345', 'configuration', 'Варіант полотна', 'ПО', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27842/dveri-terminus-neoclassico-602-po-main.jpg', 1),
  ('catalog-346', 'configuration', 'Варіант полотна', 'ПО', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27293/dveri-terminus-neoclassico-603-po-main.png', 1),
  ('catalog-347', 'configuration', 'Варіант полотна', 'ПО', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27294/dveri-terminus-neoclassico-604-po-main.png', 1),
  ('catalog-348', 'configuration', 'Варіант полотна', 'ПГ', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27295/dveri-terminus-neoclassico-605-pg-main.png', 1),
  ('catalog-349', 'configuration', 'Варіант полотна', 'ПГ', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27296/dveri-terminus-neoclassico-606-pg-main.png', 1),
  ('catalog-349', 'configuration', 'Варіант полотна', 'ПО', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27297/dveri-terminus-neoclassico-606-po-main.png', 2),
  ('catalog-350', 'configuration', 'Варіант полотна', 'ПО', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215335/dveri-terminus-neoclassico-607-po-main.jpg', 1),
  ('catalog-351', 'configuration', 'Варіант полотна', 'ПГ', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215336/dveri-terminus-neoclassico-608-pg-main.jpg', 1),
  ('catalog-351', 'configuration', 'Варіант полотна', 'ПО', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215337/dveri-terminus-neoclassico-608-po-main.jpg', 2),
  ('catalog-352', 'configuration', 'Варіант полотна', 'ПГ', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215338/dveri-terminus-neoclassico-609-pg-main.jpg', 1),
  ('catalog-352', 'configuration', 'Варіант полотна', 'ПО', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215339/dveri-terminus-neoclassico-609-po-main.jpg', 2)
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label, image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
  ('catalog-341', '{"configuration":"ПГ"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27843/dveri-terminus-neoclassico-401-pg-main.jpg', 1),
  ('catalog-342', '{"configuration":"ПГ"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27844/dveri-terminus-neoclassico-402-pg-main.jpg', 1),
  ('catalog-342', '{"configuration":"ПО"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27845/dveri-terminus-neoclassico-402-po-main.jpg', 2),
  ('catalog-343', '{"configuration":"ПГ"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24079/dveri-terminus-neoclassico-404-pg-main.jpg', 1),
  ('catalog-343', '{"configuration":"ПО"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24080/dveri-terminus-neoclassico-404-po-main.jpg', 2),
  ('catalog-344', '{"configuration":"ПО"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27841/dveri-terminus-neoclassico-601-po-main.jpg', 1),
  ('catalog-345', '{"configuration":"ПО"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27842/dveri-terminus-neoclassico-602-po-main.jpg', 1),
  ('catalog-346', '{"configuration":"ПО"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27293/dveri-terminus-neoclassico-603-po-main.png', 1),
  ('catalog-347', '{"configuration":"ПО"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27294/dveri-terminus-neoclassico-604-po-main.png', 1),
  ('catalog-348', '{"configuration":"ПГ"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27295/dveri-terminus-neoclassico-605-pg-main.png', 1),
  ('catalog-349', '{"configuration":"ПГ"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27296/dveri-terminus-neoclassico-606-pg-main.png', 1),
  ('catalog-349', '{"configuration":"ПО"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27297/dveri-terminus-neoclassico-606-po-main.png', 2),
  ('catalog-350', '{"configuration":"ПО"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215335/dveri-terminus-neoclassico-607-po-main.jpg', 1),
  ('catalog-351', '{"configuration":"ПГ"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215336/dveri-terminus-neoclassico-608-pg-main.jpg', 1),
  ('catalog-351', '{"configuration":"ПО"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215337/dveri-terminus-neoclassico-608-po-main.jpg', 2),
  ('catalog-352', '{"configuration":"ПГ"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215338/dveri-terminus-neoclassico-609-pg-main.jpg', 1),
  ('catalog-352', '{"configuration":"ПО"}'::jsonb, 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215339/dveri-terminus-neoclassico-609-po-main.jpg', 2)
on conflict (product_slug, selections) do update set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select product_slug, 'main', 'Термінус Neoclassico — базове виконання', image_path, 0
from (values
  ('catalog-341', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27843/dveri-terminus-neoclassico-401-pg-main.jpg'),
  ('catalog-342', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27844/dveri-terminus-neoclassico-402-pg-main.jpg'),
  ('catalog-343', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24079/dveri-terminus-neoclassico-404-pg-main.jpg'),
  ('catalog-344', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27841/dveri-terminus-neoclassico-601-po-main.jpg'),
  ('catalog-345', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27842/dveri-terminus-neoclassico-602-po-main.jpg'),
  ('catalog-346', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27293/dveri-terminus-neoclassico-603-po-main.png'),
  ('catalog-347', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27294/dveri-terminus-neoclassico-604-po-main.png'),
  ('catalog-348', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27295/dveri-terminus-neoclassico-605-pg-main.png'),
  ('catalog-349', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27296/dveri-terminus-neoclassico-606-pg-main.png'),
  ('catalog-350', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215335/dveri-terminus-neoclassico-607-po-main.jpg'),
  ('catalog-351', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215336/dveri-terminus-neoclassico-608-pg-main.jpg'),
  ('catalog-352', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215338/dveri-terminus-neoclassico-609-pg-main.jpg')
) as media(product_slug, image_path)
where not exists (select 1 from public.product_media as existing where existing.product_slug = media.product_slug and existing.image_path = media.image_path);

insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from unnest(array['catalog-341','catalog-342','catalog-343','catalog-344','catalog-345','catalog-346','catalog-347','catalog-348','catalog-349','catalog-350','catalog-351','catalog-352']) as products(product_slug)
cross join (values
  ('Покриття', 'ПВХ-плівка', 100), ('Наповнення', 'Фільончасті', 110), ('Стиль', 'Неокласика', 120),
  ('Розміри полотна', '600 / 700 / 800 / 900 мм', 130), ('Висота полотна', '2000 мм', 140), ('Товщина полотна', '40 мм', 150),
  ('Відкривання', 'Розпашні, одностулкові', 160), ('Торець полотна', 'Окутаний без стиків', 170),
  ('Погонаж', 'Телескопічний', 180), ('Можливість підрізки', 'До 20 мм', 190), ('Додатково', 'Ущільнювач', 200),
  ('Шумоізоляція', 'Середня', 210), ('Країна виробник', 'Україна', 220), ('Місто виробник', 'Вінниця', 230)
) as shared(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;
