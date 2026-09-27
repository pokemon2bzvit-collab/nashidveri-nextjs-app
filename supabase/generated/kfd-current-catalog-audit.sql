-- KFD: контрольна звірка перед оновленням каталогу.
-- ЛИШЕ ЧИТАННЯ: цей запит нічого не змінює у базі.
-- Він покаже, які саме старі KFD-моделі є на сайті, їх джерела,
-- кількість фото та варіантів. За цим списком звіримо каталог з KORFAD.

with kfd_products as (
  select
    product.slug,
    product.name,
    product.collection,
    product.is_available,
    nullif(trim(product.image_path), '') is not null as main_photo,
    count(distinct media.id) filter (where media.kind = 'gallery') as gallery_photos,
    count(distinct option_row.id) filter (where option_row.is_active) as options,
    count(distinct variant_row.id) filter (
      where variant_row.is_active
        and nullif(trim(variant_row.image_path), '') is not null
    ) as variants_with_photo,
    count(distinct source.id) as sources,
    min(source.source_url) filter (where source.source_url is not null) as sample_source
  from public.products product
  left join public.product_media media on media.product_slug = product.slug
  left join public.product_options option_row on option_row.product_slug = product.slug
  left join public.product_variants variant_row on variant_row.product_slug = product.slug
  left join public.product_sources source on source.product_slug = product.slug
  where product.brand = 'KFD'
  group by product.slug, product.name, product.collection, product.is_available, product.image_path
)
select jsonb_build_object(
  'models', (select count(*) from kfd_products),
  'published', (select count(*) from kfd_products where is_available),
  'models_with_exact_variant_photos', (
    select count(*) from kfd_products where variants_with_photo > 0
  ),
  'catalog', (
    select jsonb_agg(jsonb_build_object(
      'slug', slug,
      'name', name,
      'collection', collection,
      'published', is_available,
      'main_photo', main_photo,
      'gallery_photos', gallery_photos,
      'options', options,
      'variants_with_photo', variants_with_photo,
      'sources', sources,
      'sample_source', sample_source
    ) order by name)
    from kfd_products
  )
) as kfd_audit;
