-- Papa Carlo Tetra: пошук підтверджених варіантів чорного скла та їхніх фото.
-- Тільки читання.

with tetra as (
  select p.slug, p.name, p.is_available, p.image_path
  from public.products p
  where p.brand = 'Papa Carlo'
    and p.collection = 'Tetra'
), matches as (
  select
    t.slug,
    t.name,
    t.is_available,
    'Назва моделі'::text as source,
    t.name::text as value,
    t.image_path
  from tetra t
  where t.name ~* 'чорн|black|blk'

  union all

  select
    t.slug,
    t.name,
    t.is_available,
    'Опція конфігуратора'::text as source,
    concat(o.group_label, ': ', o.label),
    coalesce(o.image_path, t.image_path)
  from tetra t
  join public.product_options o
    on o.product_slug = t.slug
   and o.is_active = true
  where concat(o.group_label, ' ', o.label) ~* 'чорн|black|blk'

  union all

  select
    t.slug,
    t.name,
    t.is_available,
    'Характеристика'::text as source,
    concat(s.label, ': ', s.value),
    t.image_path
  from tetra t
  join public.product_specs s
    on s.product_slug = t.slug
   and s.is_active = true
  where concat(s.label, ' ', s.value) ~* 'чорн|black|blk'
)
select distinct slug, name, is_available, source, value, image_path
from matches
order by name, source, value;
