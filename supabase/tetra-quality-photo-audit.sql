-- Papa Carlo Tetra: аудит потенційних дублів і фото декорів / скла.
-- Тільки читання: не приховує та не змінює товари.

with tetra as (
  select
    p.slug,
    p.name,
    p.is_available,
    p.image_path,
    lower(regexp_replace(translate(p.name, 'Тт', 'Tt'), '\s+', ' ', 'g')) as model_key
  from public.products p
  where p.brand = 'Papa Carlo'
    and p.collection = 'Tetra'
), duplicate_keys as (
  select model_key
  from tetra
  group by model_key
  having count(*) > 1
), duplicate_rows as (
  select
    'Потенційний дубль'::text as issue,
    t.slug,
    t.name,
    case when t.is_available then 'показується' else 'прихована' end as status,
    t.model_key as item,
    concat(
      'Фото: ', (select count(*) from public.product_media m where m.product_slug = t.slug and m.is_active),
      '; характеристики: ', (select count(*) from public.product_specs s where s.product_slug = t.slug and s.is_active),
      '; опції: ', (select count(*) from public.product_options o where o.product_slug = t.slug and o.is_active)
    ) as details,
    t.image_path
  from tetra t
  join duplicate_keys d using (model_key)
), missing_color_photo as (
  select
    'Декор без точного фото'::text as issue,
    t.slug,
    t.name,
    case when t.is_available then 'показується' else 'прихована' end as status,
    o.label as item,
    'У конфігураторі є декор, але немає активного варіанта з фото саме для нього.' as details,
    t.image_path
  from tetra t
  join public.product_options o
    on o.product_slug = t.slug
   and o.is_active = true
   and o.option_group = 'color'
  where not exists (
    select 1
    from public.product_variants v
    where v.product_slug = t.slug
      and v.is_active = true
      and nullif(v.image_path, '') is not null
      and v.selections ->> 'color' = o.label
  )
), missing_glass_photo as (
  select
    'Скло без точного фото'::text as issue,
    t.slug,
    t.name,
    case when t.is_available then 'показується' else 'прихована' end as status,
    o.label as item,
    'У конфігураторі є варіант скла, але немає активного варіанта з фото саме для нього.' as details,
    t.image_path
  from tetra t
  join public.product_options o
    on o.product_slug = t.slug
   and o.is_active = true
   and o.option_group = 'glass'
  where not exists (
    select 1
    from public.product_variants v
    where v.product_slug = t.slug
      and v.is_active = true
      and nullif(v.image_path, '') is not null
      and v.selections ->> 'glass' = o.label
  )
)
select * from duplicate_rows
union all
select * from missing_color_photo
union all
select * from missing_glass_photo
order by issue, name, item, slug;
