-- Пошук T-00F у всіх товарах Papa Carlo.
-- Нічого не змінює.

select
  p.slug,
  p.name,
  p.collection,
  p.is_available,
  p.image_path,
  p.created_at,
  p.updated_at
from public.products p
where p.brand = 'Papa Carlo'
  and (
    p.name ilike '%00%'
    or p.slug ilike '%00%'
    or p.name ilike '%t-%'
    or p.name ilike '%т-%'
  )
order by p.collection, p.name, p.slug;
