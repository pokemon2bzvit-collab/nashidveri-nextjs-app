-- Публікація 4 офіційних моделей StilDoors DELUXE.
-- Зупиниться без змін, якщо кількість не збігається.

begin;

do $$
declare
  official_count integer;
begin
  select count(*) into official_count
  from public.products
  where brand = 'StilDoors'
    and collection = 'DELUXE'
    and slug like 'stildoors-deluxe-%-official';

  if official_count <> 4 then
    raise exception 'Очікувалось 4 офіційні моделі DELUXE, знайдено % — каталог не змінено', official_count;
  end if;
end $$;

update public.products
set is_available = true,
    updated_at = now()
where brand = 'StilDoors'
  and collection = 'DELUXE'
  and slug like 'stildoors-deluxe-%-official';

commit;

select count(*) as опубліковано
from public.products
where brand = 'StilDoors'
  and collection = 'DELUXE'
  and slug like 'stildoors-deluxe-%-official'
  and is_available;
