-- Публікація офіційної моделі StilDoors Classic.
begin;

do $$
declare official_count integer;
begin
  select count(*) into official_count
  from public.products
  where slug = 'stildoors-classic-carolina-official'
    and brand = 'StilDoors'
    and collection = 'Classic';

  if official_count <> 1 then
    raise exception 'Очікувалась 1 офіційна модель Classic, знайдено % — каталог не змінено', official_count;
  end if;
end $$;

update public.products
set is_available = true, updated_at = now()
where slug = 'stildoors-classic-carolina-official';

commit;

select count(*) as опубліковано
from public.products
where slug = 'stildoors-classic-carolina-official'
  and is_available;
