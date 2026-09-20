-- Публікація 2 офіційних моделей StilDoors Riko.
begin;

do $$
declare official_count integer;
begin
  select count(*) into official_count
  from public.products
  where brand = 'StilDoors'
    and collection = 'Riko'
    and slug like 'stildoors-riko-%-official';
  if official_count <> 2 then
    raise exception 'Очікувалось 2 офіційні моделі Riko, знайдено % — каталог не змінено', official_count;
  end if;
end $$;

update public.products
set is_available = true, updated_at = now()
where brand = 'StilDoors'
  and collection = 'Riko'
  and slug like 'stildoors-riko-%-official';

commit;

select count(*) as опубліковано
from public.products
where brand = 'StilDoors'
  and collection = 'Riko'
  and slug like 'stildoors-riko-%-official'
  and is_available;
