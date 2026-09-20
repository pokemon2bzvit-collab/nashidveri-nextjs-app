-- Публікація 6 офіційних моделей StilDoors LOFT.
begin;
do $$ declare official_count integer; begin
  select count(*) into official_count from public.products where brand='StilDoors' and collection='LOFT' and slug like 'stildoors-loft-%-official';
  if official_count <> 6 then raise exception 'Очікувалось 6 офіційних моделей LOFT, знайдено % — каталог не змінено', official_count; end if;
end $$;
update public.products set is_available=true,updated_at=now() where brand='StilDoors' and collection='LOFT' and slug like 'stildoors-loft-%-official';
commit;
select count(*) as опубліковано from public.products where brand='StilDoors' and collection='LOFT' and slug like 'stildoors-loft-%-official' and is_available;
