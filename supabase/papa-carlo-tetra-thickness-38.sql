-- За рішенням магазину показувати 38 мм для всіх моделей Papa Carlo Tetra.
begin;

update public.product_specs as spec
set value = '38 мм'
from public.products as product
where spec.product_slug = product.slug
  and product.brand = 'Papa Carlo'
  and product.collection = 'Tetra'
  and spec.label = 'Товщина полотна'
  and spec.value is distinct from '38 мм';

commit;

select count(distinct product.slug) as tetra_models,
       count(spec.product_slug) filter (where spec.is_active) as active_thickness_specs,
       count(spec.product_slug) filter (where spec.is_active and spec.value <> '38 мм') as active_not_38_mm
from public.products as product
left join public.product_specs as spec
  on spec.product_slug = product.slug and spec.label = 'Товщина полотна'
where product.brand = 'Papa Carlo' and product.collection = 'Tetra';
