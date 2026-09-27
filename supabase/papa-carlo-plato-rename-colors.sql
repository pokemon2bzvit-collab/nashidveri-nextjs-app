-- Зрозуміла назва характеристики для клієнта.
update public.product_specs
set label = 'Декор'
where label in ('Доступні декори', 'Колір')
  and product_slug in (
    select slug
    from public.products
    where brand = 'Papa Carlo'
      and collection = 'Plato'
  );

select label, count(*) as моделей
from public.product_specs
where label = 'Декор'
  and product_slug in (
    select slug
    from public.products
    where brand = 'Papa Carlo'
      and collection = 'Plato'
  )
group by label;
