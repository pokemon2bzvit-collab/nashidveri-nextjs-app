-- Terminus: актуальні офіційні назви колекцій.
begin;

update public.products
set collection = 'FREZZATO',
    style = replace(style, 'Frezato', 'FREZZATO'),
    description = replace(description, 'Frezato', 'FREZZATO'),
    features = (
      select jsonb_agg(to_jsonb(replace(item, 'Frezato', 'FREZZATO')))
      from jsonb_array_elements_text(features) as item
    ),
    updated_at = now()
where brand = 'Термінус' and collection = 'Frezato';

update public.products
set collection = 'NEO-CLASSICO',
    style = replace(style, 'Neoclassico', 'NEO-CLASSICO'),
    description = replace(description, 'Neoclassico', 'NEO-CLASSICO'),
    features = (
      select jsonb_agg(to_jsonb(replace(item, 'Neoclassico', 'NEO-CLASSICO')))
      from jsonb_array_elements_text(features) as item
    ),
    updated_at = now()
where brand = 'Термінус' and collection = 'Neoclassico';

update public.catalog_collections as collection
set name = 'FREZZATO', updated_at = now()
from public.catalog_brands as brand
where collection.brand_id = brand.id
  and brand.name = 'Термінус'
  and collection.name = 'Frezato'
  and not exists (
    select 1 from public.catalog_collections as existing
    where existing.brand_id = collection.brand_id
      and existing.category = collection.category
      and existing.name = 'FREZZATO'
  );

update public.catalog_collections as collection
set name = 'NEO-CLASSICO', updated_at = now()
from public.catalog_brands as brand
where collection.brand_id = brand.id
  and brand.name = 'Термінус'
  and collection.name = 'Neoclassico'
  and not exists (
    select 1 from public.catalog_collections as existing
    where existing.brand_id = collection.brand_id
      and existing.category = collection.category
      and existing.name = 'NEO-CLASSICO'
  );

commit;

select collection, count(*) as моделей
from public.products
where brand = 'Термінус'
group by collection
order by collection;
