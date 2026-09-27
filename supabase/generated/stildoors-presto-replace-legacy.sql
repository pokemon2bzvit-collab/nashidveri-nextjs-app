-- StilDoors Presto: чиста заміна старих карток офіційними.
-- Перед запуском має бути 11 прихованих чернеток зі stildoors-presto-*-official.
-- Файл зупиниться без змін, якщо кількість не збігається.
-- Пов'язані записи старих товарів (фото, варіанти, характеристики, джерела)
-- видаляться каскадно. Файли Supabase Storage не видаляються.

begin;

do $$
declare
  official_count integer;
  legacy_count integer;
begin
  select count(*) into official_count
  from public.products
  where brand = 'StilDoors'
    and collection = 'Presto'
    and slug like 'stildoors-presto-%-official';

  if official_count <> 11 then
    raise exception 'Очікувалось 11 офіційних моделей Presto, знайдено % — каталог не змінено', official_count;
  end if;

  select count(*) into legacy_count
  from public.products
  where brand = 'StilDoors'
    and collection = 'Presto'
    and slug not like 'stildoors-presto-%-official';

  if legacy_count <> 10 then
    raise exception 'Очікувалось 10 старих моделей Presto, знайдено % — каталог не змінено', legacy_count;
  end if;
end $$;

create table public.catalog_backup_stildoors_presto_20260920_01 as
select *
from public.products
where brand = 'StilDoors'
  and collection = 'Presto'
  and slug not like 'stildoors-presto-%-official';

delete from public.products
where brand = 'StilDoors'
  and collection = 'Presto'
  and slug not like 'stildoors-presto-%-official';

update public.products
set is_available = true,
    updated_at = now()
where brand = 'StilDoors'
  and collection = 'Presto'
  and slug like 'stildoors-presto-%-official';

commit;

-- Має повернути: 11 офіційних моделей, 0 старих, 11 опубліковано.
select
  count(*) filter (where slug like 'stildoors-presto-%-official') as офіційних_моделей,
  count(*) filter (where slug not like 'stildoors-presto-%-official') as старих_моделей,
  count(*) filter (where is_available) as опубліковано
from public.products
where brand = 'StilDoors'
  and collection = 'Presto';
