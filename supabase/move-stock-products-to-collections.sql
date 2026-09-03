-- Виправлення помилкової колекції «Склад».
-- Переміщує лише перевірені моделі за серіями виробників.
-- Скрипт можна запускати повторно. Наприкінці він покаже контрольний результат.

with moves(slug, collection) as (
  values
    -- Abwehr: TERMIX / Bionica — моделі для вулиці.
    ('catalog-9','Вулиця'),('catalog-10','Вулиця'),('catalog-11','Вулиця'),
    ('catalog-12','Вулиця'),('catalog-13','Вулиця'),('catalog-14','Вулиця'),

    -- Papa Carlo: серії визначаються за префіксом моделі.
    ('catalog-138','Milenium'),
    ('catalog-139','Plato'),('catalog-140','Plato'),('catalog-141','Plato'),
    ('catalog-142','Plato'),('catalog-143','Plato'),
    ('catalog-144','iDoors'),('catalog-145','iDoors'),
    ('catalog-146','Tetra'),('catalog-147','Tetra'),('catalog-148','Tetra'),
    ('catalog-149','Tetra'),('catalog-150','Tetra'),('catalog-151','Tetra'),

    -- Страж: PROOF / Street — вулиця; Prestige, Standart та інші — квартира.
    ('catalog-277','Квартира'),('catalog-278','Квартира'),('catalog-279','Квартира'),
    ('catalog-280','Квартира'),('catalog-281','Квартира'),('catalog-282','Квартира'),
    ('catalog-283','Квартира'),
    ('catalog-284','Вулиця'),('catalog-285','Вулиця'),('catalog-286','Вулиця'),
    ('catalog-287','Вулиця'),('catalog-288','Вулиця'),('catalog-289','Вулиця'),
    ('catalog-290','Вулиця'),('catalog-291','Вулиця'),
    ('catalog-292','Квартира'),('catalog-293','Квартира'),('catalog-294','Вулиця')
)
update public.products as product
set collection = moves.collection,
    style = 'Колекція ' || moves.collection,
    features = (
      select coalesce(jsonb_agg(item), '[]'::jsonb)
      from (
        select value as item
        from jsonb_array_elements_text(product.features) as value
        where value <> 'Колекція Склад'
        union all
        select 'Колекція ' || moves.collection
      ) as feature_items
    ),
    description = regexp_replace(
      product.description,
      'колекція Склад',
      'колекція ' || moves.collection,
      'gi'
    )
from moves
where product.slug = moves.slug and product.collection = 'Склад';

-- Додаємо нові колекції до довідника адмінки (якщо їх ще не було).
insert into public.catalog_collections (brand_id, name, category)
select brands.id, products.collection, products.category
from public.products as products
join public.catalog_brands as brands on brands.name = products.brand
where products.slug in (
  'catalog-9','catalog-10','catalog-11','catalog-12','catalog-13','catalog-14',
  'catalog-138','catalog-139','catalog-140','catalog-141','catalog-142','catalog-143',
  'catalog-144','catalog-145','catalog-146','catalog-147','catalog-148','catalog-149',
  'catalog-150','catalog-151',
  'catalog-277','catalog-278','catalog-279','catalog-280','catalog-281','catalog-282',
  'catalog-283','catalog-284','catalog-285','catalog-286','catalog-287','catalog-288',
  'catalog-289','catalog-290','catalog-291','catalog-292','catalog-293','catalog-294'
)
group by brands.id, products.collection, products.category
on conflict (brand_id, name, category) do nothing;

-- Прибираємо «Склад» із довідника лише коли в ньому справді не лишилося товарів.
delete from public.catalog_collections as catalog_collection
where catalog_collection.name = 'Склад'
  and not exists (
    select 1
    from public.products as product
    where product.brand = (
      select brand.name from public.catalog_brands as brand where brand.id = catalog_collection.brand_id
    )
      and product.category = catalog_collection.category
      and product.collection = 'Склад'
  );

-- Контроль: очікувано 0 рядків у «Складі» і 38 переміщених позицій нижче.
select brand, collection, count(*) as models
from public.products
where slug in (
  'catalog-9','catalog-10','catalog-11','catalog-12','catalog-13','catalog-14',
  'catalog-138','catalog-139','catalog-140','catalog-141','catalog-142','catalog-143',
  'catalog-144','catalog-145','catalog-146','catalog-147','catalog-148','catalog-149',
  'catalog-150','catalog-151',
  'catalog-277','catalog-278','catalog-279','catalog-280','catalog-281','catalog-282',
  'catalog-283','catalog-284','catalog-285','catalog-286','catalog-287','catalog-288',
  'catalog-289','catalog-290','catalog-291','catalog-292','catalog-293','catalog-294'
)
group by brand, collection
order by brand, collection;

select brand, name as product_name
from public.products
where collection = 'Склад'
order by brand, name;
