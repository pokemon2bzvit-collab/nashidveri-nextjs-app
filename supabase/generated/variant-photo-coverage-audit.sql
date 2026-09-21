-- Контроль точних фото для конфігуратора.
-- ЛИШЕ ЧИТАННЯ: цей запит нічого не змінює.
-- Модель готова до режиму «як у Rodos», якщо кожна її опція має
-- точне фото, а кожен варіант містить значення для всіх груп опцій.

with active_options as (
  select product_slug, option_group, label
  from public.product_options
  where is_active = true
), option_groups as (
  select distinct product_slug, option_group
  from active_options
), active_variants as (
  select product_slug, selections, image_path
  from public.product_variants
  where is_active = true
    and nullif(image_path, '') is not null
), option_coverage as (
  select
    option_row.product_slug,
    count(*) as options_total,
    count(*) filter (where not exists (
      select 1
      from active_variants variant_row
      where variant_row.product_slug = option_row.product_slug
        and variant_row.selections ->> option_row.option_group = option_row.label
    )) as options_without_photo
  from active_options option_row
  group by option_row.product_slug
), variant_coverage as (
  select
    variant_row.product_slug,
    count(*) as variants_total,
    count(*) filter (where exists (
      select 1
      from option_groups group_row
      where group_row.product_slug = variant_row.product_slug
        and not (variant_row.selections ? group_row.option_group)
    )) as incomplete_variant_values
  from active_variants variant_row
  group by variant_row.product_slug
), model_audit as (
  select
    product.brand,
    product.collection,
    product.slug,
    product.name,
    coalesce(option_coverage.options_total, 0) as options_total,
    coalesce(variant_coverage.variants_total, 0) as photos_total,
    coalesce(option_coverage.options_without_photo, 0) as options_without_photo,
    coalesce(variant_coverage.incomplete_variant_values, 0) as incomplete_variant_values,
    case
      when coalesce(option_coverage.options_total, 0) > 0
       and coalesce(variant_coverage.variants_total, 0) > 0
       and coalesce(option_coverage.options_without_photo, 0) = 0
       and coalesce(variant_coverage.incomplete_variant_values, 0) = 0
      then true else false
    end as ready_for_instant_picker
  from public.products product
  left join option_coverage on option_coverage.product_slug = product.slug
  left join variant_coverage on variant_coverage.product_slug = product.slug
  where product.is_available = true
)
select
  brand,
  count(*) filter (where options_total > 0) as models_with_options,
  count(*) filter (where ready_for_instant_picker) as ready_models,
  count(*) filter (where options_total > 0 and not ready_for_instant_picker) as needs_exact_photos,
  coalesce(sum(options_without_photo), 0) as missing_option_photos
from model_audit
group by brand
order by needs_exact_photos desc, brand;
