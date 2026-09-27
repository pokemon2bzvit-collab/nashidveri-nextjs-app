-- Публікація офіційного каталогу KORFAD.
-- Безпечно: змінює лише KORFAD і зупиниться, якщо в каталозі не рівно 42 моделі-чернетки.

begin;

do $$
declare
  total_models integer;
  published_models integer;
begin
  select
    count(*),
    count(*) filter (where is_available)
  into total_models, published_models
  from public.products
  where brand = 'KORFAD';

  if total_models <> 42 then
    raise exception 'Очікувалось 42 моделей KORFAD, знайдено % — публікацію скасовано', total_models;
  end if;

  if published_models <> 0 then
    raise exception 'Очікувалось 0 уже опублікованих моделей KORFAD, знайдено % — публікацію скасовано', published_models;
  end if;
end $$;

update public.products
set is_available = true,
    updated_at = now()
where brand = 'KORFAD'
  and is_available = false;

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  count(*) filter (where not is_available) as чернеток,
  count(distinct collection) as колекцій
from public.products
where brand = 'KORFAD';
