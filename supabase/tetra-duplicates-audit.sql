-- Звірка можливих дублів Papa Carlo Tetra.
-- Безпечний запит: лише читає дані, нічого не змінює.
-- Запустіть у Supabase SQL Editor та надішліть CSV-результат сюди.

with tetra as (
  select
    p.slug,
    p.name,
    p.image_path,
    -- Прирівнюємо кириличну «Т» до латинської «T», щоб знайти T-01 / Т-01.
    lower(regexp_replace(translate(p.name, 'Тт', 'Tt'), '\s+', ' ', 'g')) as model_key,
    (select count(*) from public.product_media m
      where m.product_slug = p.slug and m.is_active = true) as media_count,
    (select count(*) from public.product_specs s
      where s.product_slug = p.slug and s.is_active = true) as specs_count,
    (select count(*) from public.product_options o
      where o.product_slug = p.slug and o.is_active = true) as options_count,
    coalesce((select string_agg(concat(o.group_label, ': ', o.label), ' | ' order by o.option_group, o.sort_order)
      from public.product_options o
      where o.product_slug = p.slug and o.is_active = true), '—') as options,
    coalesce((select string_agg(o.label, ', ' order by o.sort_order)
      from public.product_options o
      where o.product_slug = p.slug and o.is_active = true and o.option_group = 'glass'), '—') as glass_options,
    coalesce((select string_agg(v.selections::text, ' | ' order by v.sort_order)
      from public.product_variants v
      where v.product_slug = p.slug and v.is_active = true), '—') as photo_variants
  from public.products p
  where p.brand = 'Papa Carlo' and p.collection = 'Tetra'
), duplicates as (
  select model_key
  from tetra
  group by model_key
  having count(*) > 1
)
select
  t.model_key as модель,
  t.slug,
  t.name as назва_в_каталозі,
  t.media_count as фото,
  t.options_count as опції,
  t.specs_count as характеристики,
  t.glass_options as скло,
  t.options as усі_опції,
  t.photo_variants as фото_варіанти,
  t.image_path as головне_фото
from tetra t
join duplicates d using (model_key)
order by t.model_key, t.options_count desc, t.media_count desc, t.slug;
