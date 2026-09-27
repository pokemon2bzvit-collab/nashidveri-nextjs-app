-- Публікація 5 офіційних моделей StilDoors Rondo.
begin;

do $$
declare official_count integer;
begin
  select count(*) into official_count
  from public.products
  where brand = 'StilDoors'
    and collection = 'Rondo'
    and slug like 'stildoors-rondo-%-official';
  if official_count <> 5 then
    raise exception 'Очікувалось 5 офіційних моделей Rondo, знайдено % — каталог не змінено', official_count;
  end if;
end $$;

update public.products
set is_available = true, updated_at = now()
where brand = 'StilDoors'
  and collection = 'Rondo'
  and slug like 'stildoors-rondo-%-official';

commit;

select count(*) as опубліковано
from public.products
where brand = 'StilDoors'
  and collection = 'Rondo'
  and slug like 'stildoors-rondo-%-official'
  and is_available;
