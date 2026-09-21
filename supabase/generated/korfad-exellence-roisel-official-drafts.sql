begin;

create temporary table k(color_name text, opening text, image_url text, source_url text, sort_position int) on commit drop;

insert into k values
  ('Біла емаль', 'OUTSIDE', 'https://korfad.com.ua/content/images/27/835x1800l80mc0/dverne-polotno-roisel-800-kh-2000-bila-emal-chorne-sklo-32750321082560.webp', 'https://korfad.com.ua/dverne-polotno-roisel-800-kh-2000-bila-emal-chorne-sklo/', 1),
  ('Біла емаль', 'INSIDE', 'https://korfad.com.ua/content/images/32/835x1800l80mc0/dverne-polotno-roisel-800-kh-2010-bila-emal-inside-75159288210692.webp', 'https://korfad.com.ua/dverne-polotno-roisel-800-kh-2010-bila-emal-inside/', 2),
  ('RAL 1013 Шампань', 'OUTSIDE', 'https://korfad.com.ua/content/images/42/835x1800l80mc0/13243351944493.webp', 'https://korfad.com.ua/dverne-polotno-roisel-800-kh-2000-ral-1013-shampan-chorne-sklo/', 3),
  ('RAL 1013 Шампань', 'INSIDE', 'https://korfad.com.ua/content/images/47/835x1800l80mc0/52903170561775.webp', 'https://korfad.com.ua/dverne-polotno-roisel-800-kh-2012-ral-1013-shampan-inside-chorne-sklo/', 4),
  ('RAL 7036 Сірий', 'OUTSIDE', 'https://korfad.com.ua/content/images/23/835x1800l80mc0/37861212798720.webp', 'https://korfad.com.ua/dverne-polotno-roisel-800-kh-2000-ral-7036-siryi-chorne-sklo/', 5),
  ('RAL 7036 Сірий', 'INSIDE', 'https://korfad.com.ua/content/images/28/835x1800l80mc0/64323164538172.webp', 'https://korfad.com.ua/dverne-polotno-roisel-800-kh-2012-ral-7036-siryi-inside-chorne-sklo/', 6),
  ('RAL 7047 Світло Сірий', 'OUTSIDE', 'https://korfad.com.ua/content/images/31/835x1800l80mc0/19522679220758.webp', 'https://korfad.com.ua/dverne-polotno-roisel-800-kh-2000-ral-7047-svitlo-siryi-chorne-sklo/', 7),
  ('RAL 7047 Світло Сірий', 'INSIDE', 'https://korfad.com.ua/content/images/36/835x1800l80mc0/92343273253896.webp', 'https://korfad.com.ua/dverne-polotno-roisel-800-kh-2012-ral-7047-svitlo-siryi-inside-chorne-sklo/', 8),
  ('Тауп', 'OUTSIDE', 'https://korfad.com.ua/content/images/33/835x1800l80mc0/43096784037876.webp', 'https://korfad.com.ua/dverne-polotno-roisel-800-kh-2000-taup-chorne-sklo/', 9),
  ('Тауп', 'INSIDE', 'https://korfad.com.ua/content/images/38/835x1800l80mc0/21372555594800.webp', 'https://korfad.com.ua/dverne-polotno-roisel-800-kh-2012-taup-inside-chorne-sklo/', 10);

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  'korfad-ex-roisel', 'interior', 'KORFAD', 'EXELLENCE', 'KORFAD ROISEL',
  'Фарбоване покриття', 'Сучасний', 'Заводські кольори RAL', 'Ціна за запитом',
  'KORFAD ROISEL — фарбовані міжкімнатні двері колекції EXELLENCE з чорним склом. Доступні у підтверджених заводських кольорах RAL та виконаннях OUTSIDE / INSIDE.',
  jsonb_build_array('Фабрика KORFAD', 'Колекція EXELLENCE', 'Чорне скло'),
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
select 'korfad-ex-roisel', 'color', 'Колір', color_name, min(sort_position)
from k
group by color_name
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
values
  ('korfad-ex-roisel', 'configuration', 'Відкривання', 'OUTSIDE', 10),
  ('korfad-ex-roisel', 'configuration', 'Відкривання', 'INSIDE', 20)
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select
  'korfad-ex-roisel',
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
  'korfad-ex-roisel', 'KORFAD', source_url,
  'KORFAD ROISEL — ' || color_name || ' ' || opening,
  'verified', now(), 'Офіційна картка варіанту, чорне скло'
from k
where not exists (
  select 1 from public.product_sources existing
  where existing.product_slug = 'korfad-ex-roisel' and existing.source_url = k.source_url
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (
    select count(*) from public.product_variants
    where product_slug = 'korfad-ex-roisel' and is_active
  ) as фото_варіантів
from public.products
where slug = 'korfad-ex-roisel';
