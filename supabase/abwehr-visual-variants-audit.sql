-- ABWEHR: перевірка декорів, для яких ще немає підтвердженого фото.
-- Лише читає дані: нічого не додає і не змінює.
-- Виконайте в Supabase → SQL Editor → Run та надішліть результат сюди.

with abwehr_products as (
  select p.slug, p.name, p.collection, p.image_path as main_image
  from public.products p
  where p.brand = 'Abwehr'
),
options as (
  select
    o.product_slug,
    string_agg(
      concat_ws(': ', o.group_label, o.label),
      ' • ' order by o.option_group, o.sort_order, o.label
    ) as configured_options
  from public.product_options o
  where o.is_active = true
  group by o.product_slug
),
variants as (
  select
    v.product_slug,
    count(*) filter (where v.is_active) as variant_count,
    count(*) filter (where v.is_active and nullif(trim(v.image_path), '') is not null) as visual_variant_count,
    string_agg(
      concat(v.selections::text, ' → ', v.image_path),
      E'\n' order by v.sort_order
    ) filter (where v.is_active and nullif(trim(v.image_path), '') is not null) as visual_variants
  from public.product_variants v
  group by v.product_slug
)
select
  p.slug,
  p.name,
  p.collection,
  coalesce(o.configured_options, '—') as options,
  coalesce(v.variant_count, 0) as variants,
  coalesce(v.visual_variant_count, 0) as variants_with_photo,
  coalesce(v.visual_variants, '—') as confirmed_variant_photos,
  p.main_image
from abwehr_products p
left join options o on o.product_slug = p.slug
left join variants v on v.product_slug = p.slug
where coalesce(o.configured_options, '') <> ''
order by p.slug;
