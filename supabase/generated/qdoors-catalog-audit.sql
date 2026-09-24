-- Q Doors: безпечна інвентаризація перед оновленням каталогу.
-- Нічого не змінює.

with qdoors_products as (
  select p.slug, p.name, p.collection, p.is_available, p.image_path,
         count(distinct source.source_url) filter (where source.source_name ilike '%qdoors%') as official_sources,
         count(distinct media.id) filter (where media.kind = 'gallery' and media.is_active) as gallery_photos,
         count(distinct option_row.id) filter (where option_row.is_active) as options,
         count(distinct variant_row.id) filter (where variant_row.is_active and coalesce(variant_row.image_path, '') <> '') as exact_variant_photos,
         count(distinct spec.id) filter (where spec.is_active) as specs
  from public.products p
  left join public.product_sources source on source.product_slug = p.slug
  left join public.product_media media on media.product_slug = p.slug
  left join public.product_options option_row on option_row.product_slug = p.slug
  left join public.product_variants variant_row on variant_row.product_slug = p.slug
  left join public.product_specs spec on spec.product_slug = p.slug
  where p.brand = 'Q Doors'
  group by p.slug, p.name, p.collection, p.is_available, p.image_path
)
select
  slug,
  name as модель,
  collection as поточна_колекція,
  is_available as опубліковано,
  (coalesce(image_path, '') <> '') as має_головне_фото,
  official_sources as офіційних_джерел,
  gallery_photos as фото_в_галереї,
  options as активних_опцій,
  exact_variant_photos as точних_фото_варіантів,
  specs as характеристик
from qdoors_products
order by is_available desc, collection, name;

with qdoors_products as (
  select p.slug, p.is_available,
         count(distinct source.source_url) filter (where source.source_name ilike '%qdoors%') as official_sources,
         count(distinct variant_row.id) filter (where variant_row.is_active and coalesce(variant_row.image_path, '') <> '') as exact_variant_photos
  from public.products p
  left join public.product_sources source on source.product_slug = p.slug
  left join public.product_variants variant_row on variant_row.product_slug = p.slug
  where p.brand = 'Q Doors'
  group by p.slug, p.is_available
)
select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  count(*) filter (where not is_available) as чернеток,
  count(*) filter (where official_sources > 0) as з_офіційним_джерелом,
  count(*) filter (where exact_variant_photos > 0) as з_точними_фото_варіантів
from qdoors_products;
