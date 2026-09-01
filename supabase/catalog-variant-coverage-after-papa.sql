-- Звіт покриття конфігуратора після пакетів Papa Carlo.
-- Виконайте у Supabase SQL Editor і надішліть експорт CSV обох результатів.

with option_products as (
  select distinct product_slug
  from public.product_options
  where is_active = true
),
visual_variants as (
  select distinct product_slug
  from public.product_variants
  where is_active = true
    and image_path is not null
    and btrim(image_path) <> ''
)
select
  p.brand as "Фабрика",
  p.collection as "Колекція",
  count(*) as "Моделей",
  count(*) filter (where o.product_slug is not null) as "Моделей з декорами",
  count(*) filter (where v.product_slug is not null) as "Моделей з фото декору",
  count(*) filter (where o.product_slug is not null and v.product_slug is null) as "Потрібні фото декорів",
  count(*) filter (where v.product_slug is not null) * 100.0 / nullif(count(*), 0) as "Покриття, %"
from public.products p
left join option_products o on o.product_slug = p.slug
left join visual_variants v on v.product_slug = p.slug
group by p.brand, p.collection
order by "Потрібні фото декорів" desc, "Моделей" desc, p.brand, p.collection;

with option_products as (
  select distinct product_slug
  from public.product_options
  where is_active = true
),
visual_variants as (
  select distinct product_slug
  from public.product_variants
  where is_active = true
    and image_path is not null
    and btrim(image_path) <> ''
)
select
  p.slug as "Slug",
  p.brand as "Фабрика",
  p.collection as "Колекція",
  p.name as "Модель",
  count(distinct po.id) filter (where po.is_active = true) as "Декорів",
  count(distinct pv.id) filter (where pv.is_active = true and pv.image_path is not null and btrim(pv.image_path) <> '') as "Варіантів з фото"
from public.products p
join option_products o on o.product_slug = p.slug
left join visual_variants v on v.product_slug = p.slug
left join public.product_options po on po.product_slug = p.slug
left join public.product_variants pv on pv.product_slug = p.slug
where v.product_slug is null
group by p.slug, p.brand, p.collection, p.name
order by p.brand, p.collection, p.name;
