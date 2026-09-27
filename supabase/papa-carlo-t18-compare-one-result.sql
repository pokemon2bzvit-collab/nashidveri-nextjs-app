-- T-18 і T-00F: одна зведена таблиця для експорту CSV у Supabase.
-- Нічого не змінює.

with compared_products as (
  select p.*
  from public.products p
  where p.brand = 'Papa Carlo'
    and p.collection = 'Tetra'
    and (
      p.slug = 'papa-carlo-t-18-official'
      or p.name ilike '%T-00F%'
      or p.slug ilike '%t-00f%'
    )
), details as (
  select
    p.slug,
    p.name,
    p.is_available,
    'Основне'::text as section,
    'Головне фото'::text as label,
    p.image_path as value,
    0 as position
  from compared_products p

  union all

  select
    p.slug,
    p.name,
    p.is_available,
    'Характеристика'::text as section,
    s.label,
    s.value,
    100 + s.sort_order as position
  from compared_products p
  join public.product_specs s
    on s.product_slug = p.slug
   and s.is_active = true

  union all

  select
    p.slug,
    p.name,
    p.is_available,
    'Фото'::text as section,
    coalesce(m.label, m.kind),
    m.image_path,
    1000 + m.sort_order as position
  from compared_products p
  join public.product_media m
    on m.product_slug = p.slug
   and m.is_active = true
)
select slug, name, is_available, section, label, value
from details
order by name, position, label;
