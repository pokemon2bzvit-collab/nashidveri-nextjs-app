-- Приховати характеристику «Наповнення» для всіх моделей Papa Carlo.
-- Інші характеристики й товари інших фабрик не змінюються.
begin;

update public.product_specs as spec
set is_active = false
from public.products as product
where spec.product_slug = product.slug
  and product.brand = 'Papa Carlo'
  and trim(spec.label) = 'Наповнення'
  and spec.is_active = true;

commit;

select count(*) as active_papa_carlo_filling_specs
from public.product_specs as spec
join public.products as product on product.slug = spec.product_slug
where product.brand = 'Papa Carlo'
  and trim(spec.label) = 'Наповнення'
  and spec.is_active = true;
