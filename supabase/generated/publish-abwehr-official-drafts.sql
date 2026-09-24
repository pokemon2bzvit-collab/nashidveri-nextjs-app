-- Publish every currently hidden Abwehr product.
-- Other brands and already published products remain untouched.
begin;

update public.products
set is_available = true,
    updated_at = now()
where brand = 'Abwehr'
  and is_available = false;

commit;

select
  count(*) as моделей_abwehr,
  count(*) filter (where is_available) as опубліковано,
  count(*) filter (where not is_available) as ще_приховано
from public.products
where brand = 'Abwehr';
