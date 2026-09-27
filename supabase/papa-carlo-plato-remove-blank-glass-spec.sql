-- «Глухі» не є корисною характеристикою для покупця.
-- Дані про реальне скло або дзеркало на моделях зі вставками зберігаються.
delete from public.product_specs
where label = 'Наявність скла'
  and lower(trim(value)) = 'глухі'
  and product_slug in (
    select slug
    from public.products
    where brand = 'Papa Carlo'
      and collection = 'Plato'
  );

select value, count(*) as моделей
from public.product_specs
where label = 'Наявність скла'
  and product_slug in (
    select slug
    from public.products
    where brand = 'Papa Carlo'
      and collection = 'Plato'
  )
group by value
order by value;
