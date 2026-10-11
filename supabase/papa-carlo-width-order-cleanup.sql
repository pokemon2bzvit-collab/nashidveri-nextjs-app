-- Упорядкувати ширини полотна Papa Carlo за зростанням.
-- Для висоти 2000 мм прибрати зайве уточнення про замовлення.
-- Інші значення висоти (2004–2012 мм) залишити без змін.
begin;

update public.product_specs as spec
set value = replace(
  replace(
    spec.value,
    'ширина: 710 мм, 810 мм, 610 мм, 910 мм',
    'ширина: 610, 710, 810 або 910 мм'
  ),
  'ширина: 710 мм, 810 мм, 610 мм',
  'ширина: 610, 710 або 810 мм'
)
from public.products as product
where spec.product_slug = product.slug
  and product.brand = 'Papa Carlo'
  and spec.label = 'Розміри полотна'
  and (
    spec.value like 'ширина: 710 мм, 810 мм, 610 мм, 910 мм%'
    or spec.value like 'ширина: 710 мм, 810 мм, 610 мм;%'
  );

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
