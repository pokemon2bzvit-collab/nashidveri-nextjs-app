begin;

create temporary table k(opening text, image_url text, source_url text, sort_position int) on commit drop;

insert into k values
  ('OUTSIDE', 'https://korfad.com.ua/content/images/42/835x1800l80mc0/dverne-polotno-monarch-800-kh-2000-bila-emal-89038452786169.webp', 'https://korfad.com.ua/dverne-polotno-monarch-800-kh-2000-bila-emal/', 1),
  ('INSIDE', 'https://korfad.com.ua/content/images/47/835x1800l80mc0/dverne-polotno-monarch-800-kh-2010-bila-emal-inside-51623843549610.webp', 'https://korfad.com.ua/dverne-polotno-monarch-800-kh-2010-bila-emal-inside/', 2);

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  'korfad-ex-monarch', 'interior', 'KORFAD', 'EXELLENCE', 'KORFAD MONARCH',
  'Фарбоване покриття', 'Сучасний', 'Біла емаль', 'Ціна за запитом',
  'KORFAD MONARCH — фарбовані міжкімнатні двері колекції EXELLENCE у білому емалевому покритті. Доступні у підтверджених виконаннях OUTSIDE / INSIDE.',
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
values ('korfad-ex-monarch', 'configuration', 'Відкривання', 'OUTSIDE', 10),
       ('korfad-ex-monarch', 'configuration', 'Відкривання', 'INSIDE', 20)
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select
  'korfad-ex-monarch',
  jsonb_build_object('configuration', opening),
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
  'korfad-ex-monarch', 'KORFAD', source_url,
  'KORFAD MONARCH — Біла емаль ' || opening,
  'verified', now(), 'Офіційна картка варіанту'
from k
where not exists (
  select 1 from public.product_sources existing
  where existing.product_slug = 'korfad-ex-monarch' and existing.source_url = k.source_url
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (
    select count(*) from public.product_variants
    where product_slug = 'korfad-ex-monarch' and is_active
  ) as фото_варіантів
from public.products
where slug = 'korfad-ex-monarch';
