-- Papa Carlo Tetra: переносить фото зі старих дублів у конфігуратор головної моделі.
-- Безпечно: працює ЛИШЕ коли в головної моделі рівно один варіант скла.
-- Старі записи не приховує й не видаляє.

begin;

create temporary table tetra_confirmed_glass_photo_map on commit preserve rows as
with tetra as (
  select
    p.slug,
    p.name,
    p.image_path,
    lower(regexp_replace(translate(p.name, 'Тт', 'Tt'), '\s+', ' ', 'g')) as model_key,
    (select count(*) from public.product_options o where o.product_slug = p.slug and o.is_active = true) as option_count,
    (select count(*) from public.product_specs s where s.product_slug = p.slug and s.is_active = true) as spec_count,
    (select count(*) from public.product_media m where m.product_slug = p.slug and m.is_active = true) as media_count
  from public.products p
  where p.brand = 'Papa Carlo'
    and p.collection = 'Tetra'
), ranked as (
  select
    t.*,
    row_number() over (
      partition by model_key
      order by option_count desc, spec_count desc, media_count desc, slug
    ) as position
  from tetra t
), targets as (
  select r.*
  from ranked r
  where r.position = 1
    and (select count(*) from ranked same_name where same_name.model_key = r.model_key) > 1
), sources as (
  select r.*
  from ranked r
  where r.position > 1
)
select distinct on (target.slug, glass.label)
  target.slug as product_slug,
  source.slug as source_slug,
  target.name as product_name,
  glass.label as glass_label,
  source.image_path
from targets target
join sources source on source.model_key = target.model_key
join lateral (
  select o.label
  from public.product_options o
  where o.product_slug = target.slug
    and o.is_active = true
    and o.option_group = 'glass'
  order by o.sort_order, o.label
  limit 1
) glass on true
where source.image_path is not null
  and source.image_path <> ''
  and source.image_path is distinct from target.image_path
  and (select count(*) from public.product_options o
       where o.product_slug = target.slug
         and o.is_active = true
         and o.option_group = 'glass') = 1
order by target.slug, glass.label, source.slug;

-- Фото застосовується до опції скла як мініатюра у конфігураторі.
update public.product_options option_row
set image_path = map.image_path
from tetra_confirmed_glass_photo_map map
where option_row.product_slug = map.product_slug
  and option_row.option_group = 'glass'
  and option_row.label = map.glass_label;

-- Те саме фото застосовується після вибору скла.
insert into public.product_variants (
  product_slug, selections, image_path, sort_order, is_active
)
select
  product_slug,
  jsonb_build_object('glass', glass_label),
  image_path,
  90,
  true
from tetra_confirmed_glass_photo_map
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

-- Фото також лишається в галереї основної моделі.
insert into public.product_media (
  product_slug, kind, label, image_path, sort_order, is_active
)
select
  product_slug,
  'gallery',
  'Фото варіанта: ' || glass_label,
  image_path,
  90,
  true
from tetra_confirmed_glass_photo_map
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = true;

commit;

select
  product_name as модель,
  glass_label as скло,
  source_slug as фото_взято_з,
  image_path as фото
from tetra_confirmed_glass_photo_map
order by product_name;
