begin;

create temporary table k(glass_name text, image_url text, source_url text, sort_position int) on commit drop;

insert into k values
  ('Скло сатин', 'https://korfad.com.ua/content/images/3/835x1800l80mc0/dverne-polotno-monarch-glass-800-kh-2000-bila-emal-sklo-satyn-76039504751042.webp', 'https://korfad.com.ua/dverne-polotno-monarch-glass-800-kh-2000-bila-emal-sklo-satyn/', 1),
  ('Ромб прозорий', 'https://korfad.com.ua/content/images/2/835x1800l80mc0/dverne-polotno-monarch-glass-800-kh-2000-maliunok-romb-prozoryi-24393468289047.webp', 'https://korfad.com.ua/dverne-polotno-monarch-glass-800-kh-2000-maliunok-romb-prozoryi/', 2);

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  'korfad-ex-monarch-glass', 'interior', 'KORFAD', 'EXELLENCE', 'KORFAD MONARCH GLASS',
  'Фарбоване покриття', 'Сучасний', 'Варіанти зі склом', 'Ціна за запитом',
  'KORFAD MONARCH GLASS — фарбовані міжкімнатні двері колекції EXELLENCE з горизонтальним склінням. Офіційно підтверджені виконання: скло сатин і прозорий ромб.',
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
select 'korfad-ex-monarch-glass', 'glass', 'Варіант скла', glass_name, sort_position
from k
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select
  'korfad-ex-monarch-glass',
  jsonb_build_object('glass', glass_name),
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
  'korfad-ex-monarch-glass', 'KORFAD', source_url,
  'KORFAD MONARCH GLASS — ' || glass_name,
  'verified', now(), 'Офіційна картка варіанту'
from k
where not exists (
  select 1 from public.product_sources existing
  where existing.product_slug = 'korfad-ex-monarch-glass' and existing.source_url = k.source_url
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (
    select count(*) from public.product_variants
    where product_slug = 'korfad-ex-monarch-glass' and is_active
  ) as фото_варіантів
from public.products
where slug = 'korfad-ex-monarch-glass';
