-- Публікація 8 офіційних моделей StilDoors Solara.
begin;
do $$
declare official_count integer;
begin
  select count(*) into official_count from public.products
  where brand='StilDoors' and collection='Solara' and slug like 'stildoors-solara-%-official';
  if official_count <> 8 then
    raise exception 'Очікувалось 8 офіційних моделей Solara, знайдено % — каталог не змінено', official_count;
  end if;
end $$;
update public.products set is_available=true,updated_at=now()
where brand='StilDoors' and collection='Solara' and slug like 'stildoors-solara-%-official';
commit;
select count(*) as опубліковано from public.products
where brand='StilDoors' and collection='Solara' and slug like 'stildoors-solara-%-official' and is_available;
