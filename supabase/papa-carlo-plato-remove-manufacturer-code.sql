-- Прибирає службовий код виробника лише з карток Papa Carlo / Plato.
delete from public.product_specs
where label = 'Код виробника'
  and product_slug in (
    select slug
    from public.products
    where brand = 'Papa Carlo'
      and collection = 'Plato'
  );

select count(*) as кодів_що_залишилось
from public.product_specs
where label = 'Код виробника'
  and product_slug in (
    select slug
    from public.products
    where brand = 'Papa Carlo'
      and collection = 'Plato'
  );
