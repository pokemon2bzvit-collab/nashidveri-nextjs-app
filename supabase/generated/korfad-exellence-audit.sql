-- Лише перевірка: цей запит нічого не змінює у базі.
select
  p.name as модель,
  p.slug,
  case when p.is_available then 'опублікована' else 'чернетка' end as статус,
  count(v.id) filter (where v.is_active) as фото_варіантів,
  count(distinct o.id) filter (where o.is_active) as опцій
from public.products p
left join public.product_variants v on v.product_slug = p.slug
left join public.product_options o on o.product_slug = p.slug
where p.brand = 'KORFAD'
  and p.collection = 'EXELLENCE'
group by p.name, p.slug, p.is_available
order by p.name;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  count(*) filter (where not is_available) as чернеток,
  (
    select count(*) from public.product_variants v
    join public.products p on p.slug = v.product_slug
    where p.brand = 'KORFAD'
      and p.collection = 'EXELLENCE'
      and v.is_active
  ) as точних_фото_варіантів
from public.products
where brand = 'KORFAD'
  and collection = 'EXELLENCE';
