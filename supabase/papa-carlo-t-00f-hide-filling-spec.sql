-- Приховати лише характеристику «Наповнення — Фільонка МДФ 8 мм»
-- у картці Papa Carlo T-00F. Інші моделі Tetra не змінюються.
begin;

update public.product_specs
set is_active = false
where product_slug = 'catalog-132'
  and label = 'Наповнення'
  and value = 'Фільонка МДФ 8 мм'
  and is_active = true;

commit;

select product_slug, label, value, is_active
from public.product_specs
where product_slug = 'catalog-132'
  and label = 'Наповнення';
