begin;

create temporary table k(color_name text, opening text, image_url text, source_url text, sort_position int) on commit drop;

insert into k values
  ('Біла емаль', 'OUTSIDE', 'https://korfad.com.ua/content/images/27/835x1800l80mc0/dverne-polotno-infinity-800-kh-2000-bila-emal-57812840452730.webp', 'https://korfad.com.ua/dverne-polotno-infinity-800-kh-2000-bila-emal/', 1),
  ('Біла емаль', 'INSIDE', 'https://korfad.com.ua/content/images/32/835x1800l80mc0/dverne-polotno-infinity-800-kh-2010-bila-emal-inside-34503612622085.webp', 'https://korfad.com.ua/dverne-polotno-infinity-800-kh-2010-bila-emal-inside/', 2),
  ('RAL 1013 Шампань', 'OUTSIDE', 'https://korfad.com.ua/content/images/37/835x1800l80mc0/56736595156715.webp', 'https://korfad.com.ua/dverne-polotno-infinity-800-kh-2000-ral-1013-shampan/', 3),
  ('RAL 1013 Шампань', 'INSIDE', 'https://korfad.com.ua/content/images/42/835x1800l80mc0/32816169579220.webp', 'https://korfad.com.ua/dverne-polotno-infinity-800-kh-2012-ral-1013-shampan-inside/', 4),
  ('RAL 7036 Сірий', 'OUTSIDE', 'https://korfad.com.ua/content/images/18/835x1800l80mc0/44123572048196.webp', 'https://korfad.com.ua/dverne-polotno-infinity-800-kh-2000-ral-7036-siryi/', 5),
  ('RAL 7036 Сірий', 'INSIDE', 'https://korfad.com.ua/content/images/23/835x1800l80mc0/47897518246343.webp', 'https://korfad.com.ua/dverne-polotno-infinity-800-kh-2012-ral-7036-siryi-inside/', 6),
  ('RAL 7047 Світло Сірий', 'OUTSIDE', 'https://korfad.com.ua/content/images/26/835x1800l80mc0/39009965622962.webp', 'https://korfad.com.ua/dverne-polotno-infinity-800-kh-2000-ral-7047-svitlo-siryi/', 7),
  ('RAL 7047 Світло Сірий', 'INSIDE', 'https://korfad.com.ua/content/images/31/835x1800l80mc0/91327638010981.webp', 'https://korfad.com.ua/dverne-polotno-infinity-800-kh-2012-ral-7047-svitlo-siryi-inside/', 8),
  ('Тауп', 'OUTSIDE', 'https://korfad.com.ua/content/images/28/835x1800l80mc0/58116780456131.webp', 'https://korfad.com.ua/dverne-polotno-infinity-800-kh-2000-taup/', 9),
  ('Тауп', 'INSIDE', 'https://korfad.com.ua/content/images/33/835x1800l80mc0/86584670242821.webp', 'https://korfad.com.ua/dverne-polotno-infinity-800-kh-2012-taup-inside/', 10);

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  'korfad-ex-infinity', 'interior', 'KORFAD', 'EXELLENCE', 'KORFAD INFINITY',
  'Фарбоване покриття', 'Сучасний', 'Заводські кольори RAL', 'Ціна за запитом',
  'KORFAD INFINITY — фарбовані міжкімнатні двері колекції EXELLENCE. Доступні у підтверджених заводських кольорах RAL та виконаннях OUTSIDE / INSIDE.',
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
select 'korfad-ex-infinity', 'color', 'Колір', color_name, min(sort_position)
from k
group by color_name
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
values
  ('korfad-ex-infinity', 'configuration', 'Відкривання', 'OUTSIDE', 10),
  ('korfad-ex-infinity', 'configuration', 'Відкривання', 'INSIDE', 20)
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select
  'korfad-ex-infinity',
  jsonb_build_object('color', color_name, 'configuration', opening),
  image_url,
  sort_position,
  true
from k
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes
)
select
  'korfad-ex-infinity', 'KORFAD', source_url,
  'KORFAD INFINITY — ' || color_name || ' ' || opening,
  'verified', now(), 'Офіційна картка варіанту'
from k
where not exists (
  select 1
  from public.product_sources existing
  where existing.product_slug = 'korfad-ex-infinity'
    and existing.source_url = k.source_url
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (
    select count(*)
    from public.product_variants
    where product_slug = 'korfad-ex-infinity' and is_active
  ) as фото_варіантів
from public.products
where slug = 'korfad-ex-infinity';
