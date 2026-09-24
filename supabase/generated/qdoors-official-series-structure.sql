-- Q Doors: розкладаємо на реальні заводські серії.
-- Не видаляє моделі, фото, характеристики або опції.

begin;

do $$
declare
  qdoors_count integer;
begin
  select count(*) into qdoors_count from public.products where brand = 'Q Doors';
  if qdoors_count <> 14 then
    raise exception 'Очікувалось 14 моделей Q Doors, знайдено % — каталог не змінено', qdoors_count;
  end if;
end $$;

insert into public.catalog_collections (brand_id, name, category, description, is_active, sort_order)
select brand.id, series.name, 'entrance', series.description, true, series.sort_order
from public.catalog_brands brand
cross join (values
  ('Street', 'Вуличні двері Q Doors з посиленою конструкцією, утепленням і атмосферостійкими покриттями.', 10),
  ('Авангард', 'Вхідні двері Q Doors для квартири: сучасні декори, замки та комфорт щоденного користування.', 20),
  ('Преміум', 'Вхідні двері Q Doors для квартири з різними дизайнами та комплектаціями.', 30),
  ('Ультра', 'Посилені вхідні двері Q Doors для квартири з продуманою комплектацією.', 40)
) as series(name, description, sort_order)
where brand.name = 'Q Doors'
on conflict (brand_id, name, category) do update
set description = excluded.description,
    is_active = true,
    sort_order = excluded.sort_order,
    updated_at = now();

with mapping(slug, collection) as (
  values
    ('catalog-54', 'Street'),
    ('catalog-55', 'Street'),
    ('catalog-56', 'Street'),
    ('catalog-57', 'Street'),
    ('catalog-58', 'Street'),
    ('catalog-59', 'Street'),
    ('catalog-60', 'Ультра'),
    ('catalog-61', 'Преміум'),
    ('catalog-62', 'Авангард'),
    ('catalog-63', 'Ультра'),
    ('catalog-64', 'Преміум'),
    ('catalog-65', 'Ультра'),
    ('catalog-66', 'Преміум'),
    ('catalog-67', 'Преміум')
)
update public.products product
set collection = mapping.collection,
    style = 'Серія ' || mapping.collection,
    description = regexp_replace(
      regexp_replace(product.description, 'колекція Вулиця', 'серія Street', 'gi'),
      'колекція Квартира', 'серія ' || mapping.collection, 'gi'
    ),
    features = jsonb_build_array('Фабрика Q Doors', 'Серія ' || mapping.collection),
    updated_at = now()
from mapping
where product.slug = mapping.slug
  and product.brand = 'Q Doors';

commit;

select collection as серія, count(*) as моделей, count(*) filter (where is_available) as опубліковано
from public.products
where brand = 'Q Doors'
group by collection
order by min(sort_order), collection;
