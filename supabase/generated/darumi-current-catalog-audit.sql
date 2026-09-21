-- Darumi: контрольна звірка перед оновленням каталогу.
-- ЛИШЕ ЧИТАННЯ: цей запит нічого не змінює у базі.
-- Офіційний sitemap Darumi на 2026-09-21: 428 карток-варіантів / 36 моделей.

with darumi_products as (
  select
    product.slug,
    product.name,
    product.collection,
    product.is_available,
    nullif(product.image_path, '') as main_image,
    count(distinct media.id) filter (where media.kind = 'gallery') as gallery_photos,
    count(distinct option_row.id) as options,
    count(distinct source.id) as sources
  from public.products product
  left join public.product_media media on media.product_slug = product.slug
  left join public.product_options option_row on option_row.product_slug = product.slug
  left join public.product_sources source on source.product_slug = product.slug
  where product.brand = 'Darumi'
  group by product.slug, product.name, product.collection, product.is_available, product.image_path
), official_models(model, variant_cards) as (
  values
    ('Annecy', 2), ('Arny', 18), ('Avant', 17), ('Bordo', 18),
    ('Carmen', 2), ('Cascad', 3), ('Christi', 18), ('Columbia', 4),
    ('Darina', 22), ('Edmond', 3), ('Esper', 6), ('Floriana-01', 16),
    ('Galant', 14), ('Helios', 3), ('Leona', 20), ('Madrid', 19),
    ('Marsel', 19), ('Mary', 18), ('Nadin', 3), ('Next', 6),
    ('Plato', 10), ('Plato Line PTL-03', 9), ('Plato Line PTL-04', 9),
    ('Plato Line PTL-05', 7), ('Plato Line PTL-06', 7), ('Ramona', 2),
    ('Rosalia', 24), ('Sabrina', 18), ('Selesta', 24), ('Senator', 7),
    ('Stark', 6), ('Stella', 13), ('Tina', 18), ('Vela', 19),
    ('Versal', 19), ('Violeta', 5)
)
select jsonb_build_object(
  'our_products', (select count(*) from darumi_products),
  'published', (select count(*) from darumi_products where is_available),
  'official_models', (select count(*) from official_models),
  'official_variant_cards', (select sum(variant_cards) from official_models),
  'official_model_list', (select jsonb_agg(jsonb_build_object('model', model, 'variant_cards', variant_cards) order by model) from official_models),
  'our_model_list', (select jsonb_agg(jsonb_build_object(
    'slug', slug,
    'name', name,
    'collection', collection,
    'published', is_available,
    'main_photo', main_image is not null,
    'gallery_photos', gallery_photos,
    'options', options,
    'sources', sources
  ) order by name) from darumi_products)
) as darumi_audit;
