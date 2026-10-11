-- Залишити в характеристиці Papa Carlo лише підтверджену висоту 2000 мм.
-- Інші висоти (наприклад, 2012 мм) не змінюються.
begin;

update public.product_specs as spec
set value = replace(
  replace(
    spec.value,
    '; висота: Будь-який (під замовлення), 2000 мм',
    '; висота: 2000 мм'
  ),
  '; висота: 2000 мм, можливий нестандартний розмір під замовлення',
  '; висота: 2000 мм'
)
from public.products as product
where spec.product_slug = product.slug
  and product.brand = 'Papa Carlo'
  and spec.label = 'Розміри полотна'
  and (
    spec.value like '%; висота: Будь-який (під замовлення), 2000 мм%'
    or spec.value like '%; висота: 2000 мм, можливий нестандартний розмір під замовлення%'
  );

commit;

select product.collection, product.name, spec.value as "Розміри полотна"
from public.product_specs as spec
join public.products as product on product.slug = spec.product_slug
where product.brand = 'Papa Carlo'
  and spec.label = 'Розміри полотна'
  and spec.is_active
order by product.collection, product.name;
