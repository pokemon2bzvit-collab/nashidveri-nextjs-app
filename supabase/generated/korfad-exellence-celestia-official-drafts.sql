begin;

create temporary table k(color_name text, opening text, image_url text, sort_position int) on commit drop;

insert into k values
  ('Біла емаль', 'OUTSIDE', 'https://korfad.com.ua/content/images/17/278x600l80mc0/dverne-polotno-celestia-800-kh-2000-bila-emal-80541857998667.webp', 1),
  ('Біла емаль', 'INSIDE', 'https://korfad.com.ua/content/images/22/278x600l80mc0/dverne-polotno-celestia-800-kh-2010-bila-emal-inside-19722460909497.webp', 2),
  ('RAL 1013 Шампань', 'OUTSIDE', 'https://korfad.com.ua/content/images/27/278x600l80mc0/61908040792063.webp', 3),
  ('RAL 1013 Шампань', 'INSIDE', 'https://korfad.com.ua/content/images/32/278x600l80mc0/36538053167404.webp', 4),
  ('RAL 7036 Сірий', 'OUTSIDE', 'https://korfad.com.ua/content/images/8/278x600l80mc0/57219401530717.webp', 5),
  ('RAL 7036 Сірий', 'INSIDE', 'https://korfad.com.ua/content/images/13/278x600l80mc0/38465634934527.webp', 6),
  ('RAL 7047 Світло Сірий', 'OUTSIDE', 'https://korfad.com.ua/content/images/16/278x600l80mc0/76603340921043.webp', 7),
  ('RAL 7047 Світло Сірий', 'INSIDE', 'https://korfad.com.ua/content/images/21/278x600l80mc0/66168620929467.webp', 8),
  ('Тауп', 'OUTSIDE', 'https://korfad.com.ua/content/images/18/278x600l80mc0/42245276862491.webp', 9),
  ('Тауп', 'INSIDE', 'https://korfad.com.ua/content/images/23/278x600l80mc0/55646500011200.webp', 10);

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  'korfad-ex-celestia', 'interior', 'KORFAD', 'EXELLENCE', 'KORFAD CELESTIA',
  'Фарбоване покриття', 'Сучасний', 'Заводські кольори RAL', 'Ціна за запитом',
  'KORFAD CELESTIA — фарбовані міжкімнатні двері колекції EXELLENCE. Підтверджені заводські кольори RAL та виконання OUTSIDE / INSIDE.',
  jsonb_build_array('Фабрика KORFAD', 'Колекція EXELLENCE'),
  min(image_url), 99999, false
from k
on conflict (slug) do update set
  name = excluded.name,
  material = excluded.material,
  style = excluded.style,
  color = excluded.color,
  description = excluded.description,
  features = excluded.features,
  image_path = excluded.image_path;

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
select 'korfad-ex-celestia', 'color', 'Колір', color_name, min(sort_position)
from k
group by color_name
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
values
  ('korfad-ex-celestia', 'configuration', 'Відкривання', 'OUTSIDE', 10),
  ('korfad-ex-celestia', 'configuration', 'Відкривання', 'INSIDE', 20)
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select
  'korfad-ex-celestia',
  jsonb_build_object('color', color_name, 'configuration', opening),
  image_url,
  sort_position,
  true
from k
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (
    select count(*)
    from public.product_variants
    where product_slug = 'korfad-ex-celestia' and is_active
  ) as фото_варіантів
from public.products
where slug = 'korfad-ex-celestia';
