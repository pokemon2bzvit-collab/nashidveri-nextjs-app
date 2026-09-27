-- Звірка офіційного T-18 і наявного T-00F.
-- Нічого не змінює. Виконайте та надішліть CSV-результати.

-- 1. Основні дані, фото та статус публікації.
select
  p.slug,
  p.name,
  p.collection,
  p.is_available,
  p.image_path,
  p.description
from public.products p
where p.brand = 'Papa Carlo'
  and p.slug in ('papa-carlo-t-18-official')
  or (p.brand = 'Papa Carlo' and p.name ilike '%T-00F%')
order by p.name, p.slug;

-- 2. Характеристики обох моделей.
select
  p.slug,
  p.name,
  s.label,
  s.value,
  s.sort_order
from public.products p
left join public.product_specs s
  on s.product_slug = p.slug
 and s.is_active = true
where p.brand = 'Papa Carlo'
  and (p.slug = 'papa-carlo-t-18-official' or p.name ilike '%T-00F%')
order by p.name, s.sort_order, s.label;

-- 3. Усі фото — так буде видно, чи T-00F є окремим виконанням.
select
  p.slug,
  p.name,
  m.kind,
  m.label,
  m.image_path,
  m.sort_order
from public.products p
left join public.product_media m
  on m.product_slug = p.slug
 and m.is_active = true
where p.brand = 'Papa Carlo'
  and (p.slug = 'papa-carlo-t-18-official' or p.name ilike '%T-00F%')
order by p.name, m.kind, m.sort_order;
