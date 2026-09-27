-- Публікація 7 офіційних моделей StilDoors Simpli Loft.
begin;

do $$
declare official_count integer;
begin
  select count(*) into official_count
  from public.products
  where brand = 'StilDoors'
    and collection = 'Simpli Loft'
    and slug like 'stildoors-simpli-loft-%-official';

  if official_count <> 7 then
    raise exception 'Очікувалось 7 офіційних моделей Simpli Loft, знайдено % — каталог не змінено', official_count;
  end if;
end $$;

update public.products
set is_available = true, updated_at = now()
where brand = 'StilDoors'
  and collection = 'Simpli Loft'
  and slug like 'stildoors-simpli-loft-%-official';

commit;

select count(*) as опубліковано
from public.products
where brand = 'StilDoors'
  and collection = 'Simpli Loft'
  and slug like 'stildoors-simpli-loft-%-official'
  and is_available;
