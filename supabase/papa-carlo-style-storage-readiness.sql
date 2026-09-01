-- Перевірка готовності варіантів Papa Carlo Style (ST-04, 25, 26, 33, 34, 35).
-- Лише читає дані: нічого не додає і не змінює.
-- Показує, чи вже виконано SQL з варіантами та скільки з їхніх фото знайдено у Storage.

with style_models as (
  select unnest(array[
    'catalog-113', 'catalog-114', 'catalog-115',
    'catalog-116', 'catalog-117', 'catalog-118'
  ]) as product_slug
),
variant_counts as (
  select
    v.product_slug,
    count(*) filter (where v.is_active) as variant_rows,
    count(*) filter (
      where v.is_active
        and exists (
          select 1
          from storage.objects file
          where file.bucket_id = 'catalog-images'
            and file.name = v.image_path
        )
    ) as photos_in_storage
  from public.product_variants v
  group by v.product_slug
)
select
  p.slug,
  p.name,
  coalesce(vc.variant_rows, 0) as configured_variants,
  coalesce(vc.photos_in_storage, 0) as available_variant_photos,
  case
    when coalesce(vc.variant_rows, 0) = 0 then 'Потрібно виконати variants-seed.sql'
    when coalesce(vc.photos_in_storage, 0) = 0 then 'Потрібно завантажити фото у Storage'
    when vc.photos_in_storage < vc.variant_rows then 'Частина фото ще не завантажена'
    else 'Готово'
  end as next_step
from style_models model
join public.products p on p.slug = model.product_slug
left join variant_counts vc on vc.product_slug = model.product_slug
order by p.slug;
