-- Моделі Papa Carlo та Magda, у яких є декори/опції, але ще немає
-- підтвердженого зображення для конфігуратора.
-- Лише читає дані: нічого не додає і не змінює.

with option_summary as (
  select
    o.product_slug,
    string_agg(
      concat_ws(': ', o.group_label, o.label),
      ' • ' order by o.option_group, o.sort_order, o.label
    ) as options
  from public.product_options o
  where o.is_active = true
  group by o.product_slug
),
visual_variant_summary as (
  select
    v.product_slug,
    count(*) filter (
      where v.is_active
        and (
          v.image_path ~ '^https?://'
          or exists (
            select 1
            from storage.objects file
            where file.bucket_id = 'catalog-images'
              and file.name = v.image_path
          )
        )
    ) as visual_variants
  from public.product_variants v
  group by v.product_slug
)
select
  p.slug,
  p.brand,
  p.collection,
  p.name,
  os.options,
  coalesce(vs.visual_variants, 0) as confirmed_variant_photos,
  p.image_path as main_image
from public.products p
join option_summary os on os.product_slug = p.slug
left join visual_variant_summary vs on vs.product_slug = p.slug
where p.brand in ('Papa Carlo', 'Magda')
  and coalesce(vs.visual_variants, 0) = 0
order by p.brand, p.collection, p.name;
