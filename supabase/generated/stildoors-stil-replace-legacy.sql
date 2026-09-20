-- StilDoors Stil: чиста заміна старих карток офіційними.
-- Потрібні 8 чернеток зі stildoors-stil-*-official.
-- Якщо кількість не збігається, транзакція зупиниться без змін.

begin;

do $$
declare
  official_count integer;
  legacy_count integer;
begin
  select count(*) into official_count
  from public.products
  where brand = 'StilDoors'
    and collection = 'Stil'
    and slug like 'stildoors-stil-%-official';

  if official_count <> 8 then
    raise exception 'Очікувалось 8 офіційних моделей Stil, знайдено % — каталог не змінено', official_count;
  end if;

  select count(*) into legacy_count
  from public.products
  where brand = 'StilDoors'
    and collection = 'Stil'
    and slug not like 'stildoors-stil-%-official';

  if legacy_count <> 7 then
    raise exception 'Очікувалось 7 старих моделей Stil, знайдено % — каталог не змінено', legacy_count;
  end if;
end $$;

create table public.catalog_backup_stildoors_stil_20260920_01 as
select *
from public.products
where brand = 'StilDoors'
  and collection = 'Stil'
  and slug not like 'stildoors-stil-%-official';

delete from public.products
where brand = 'StilDoors'
  and collection = 'Stil'
  and slug not like 'stildoors-stil-%-official';

update public.products
set is_available = true,
    updated_at = now()
where brand = 'StilDoors'
  and collection = 'Stil'
  and slug like 'stildoors-stil-%-official';

commit;

select
  count(*) filter (where slug like 'stildoors-stil-%-official') as офіційних_моделей,
  count(*) filter (where slug not like 'stildoors-stil-%-official') as старих_моделей,
  count(*) filter (where is_available) as опубліковано
from public.products
where brand = 'StilDoors'
  and collection = 'Stil';
