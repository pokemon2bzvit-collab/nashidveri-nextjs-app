-- Тільки читання. Один рядок на модель Rodos з поточними характеристиками.
-- Виконати в SQL Editor та експортувати результат у CSV.
select
  p.slug,
  p.brand,
  p.collection,
  p.name,
  p.description,
  p.image_path,
  coalesce((
    select jsonb_agg(to_jsonb(s) order by s.sort_order, s.label)
    from public.product_specs s
    where s.product_slug = p.slug
  ), '[]'::jsonb) as specifications,
  coalesce((
    select jsonb_agg(to_jsonb(src))
    from public.product_sources src
    where src.product_slug = p.slug
  ), '[]'::jsonb) as sources
from public.products p
where p.brand = 'Rodos'
order by p.collection, p.name, p.slug;
