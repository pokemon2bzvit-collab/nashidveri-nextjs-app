-- Аудит галерей Q Doors. Лише перевірка, без жодних змін у базі.

with qdoors as (
  select
    p.slug,
    p.name,
    p.collection,
    p.is_available,
    count(m.id) filter (where m.kind = 'gallery' and m.is_active) as активних_фото_в_галереї,
    count(s.id) filter (where s.verification_status = 'verified') as офіційних_джерел
  from public.products p
  left join public.product_media m on m.product_slug = p.slug
  left join public.product_sources s on s.product_slug = p.slug
  where p.brand = 'Q Doors'
  group by p.slug, p.name, p.collection, p.is_available
)
select
  slug,
  name as модель,
  collection as серія,
  is_available as опубліковано,
  активних_фото_в_галереї,
  офіційних_джерел,
  case
    when активних_фото_в_галереї >= 2 then 'Готово'
    when активних_фото_в_галереї = 1 then 'Додати ще фото'
    else 'Немає галереї'
  end as стан
from qdoors
order by
  case when активних_фото_в_галереї >= 2 then 1 else 0 end,
  collection,
  name;

-- Короткий підсумок за серіями.
with qdoors as (
  select
    p.collection,
    p.is_available,
    count(m.id) filter (where m.kind = 'gallery' and m.is_active) as gallery_count
  from public.products p
  left join public.product_media m on m.product_slug = p.slug
  where p.brand = 'Q Doors'
  group by p.slug, p.collection, p.is_available
)
select
  collection as серія,
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  count(*) filter (where gallery_count >= 2) as з_двома_і_більше_фото,
  count(*) filter (where gallery_count < 2) as треба_доповнити
from qdoors
group by collection
order by collection;
