-- ABWEHR: read-only audit before synchronising the official catalogue.
-- This query changes nothing. Run it in Supabase SQL Editor and send back the result.

with abwehr_products as (
  select
    product.slug,
    product.name,
    product.collection,
    product.is_available,
    product.image_path,
    count(distinct source.id) filter (where source.source_name = 'ABWEHR') as official_sources,
    count(distinct media.id) filter (where media.kind = 'gallery') as gallery_photos,
    count(distinct option_row.id) filter (where option_row.is_active) as active_options,
    count(distinct variant.id) filter (where variant.is_active and variant.image_path is not null) as exact_variant_photos
  from public.products product
  left join public.product_sources source on source.product_slug = product.slug
  left join public.product_media media on media.product_slug = product.slug
  left join public.product_options option_row on option_row.product_slug = product.slug
  left join public.product_variants variant on variant.product_slug = product.slug
  where product.brand = 'Abwehr'
  group by product.slug, product.name, product.collection, product.is_available, product.image_path
)
select
  slug,
  name as модель,
  collection as поточна_колекція,
  is_available as опубліковано,
  (image_path is not null) as має_головне_фото,
  official_sources as офіційних_джерел,
  gallery_photos as фото_в_галереї,
  active_options as активних_опцій,
  exact_variant_photos as точних_фото_варіантів
from abwehr_products
order by collection nulls last, name;

-- The table above is the audit result. Its rows can be saved as CSV before import.
