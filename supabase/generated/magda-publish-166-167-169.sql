-- Публікація перевірених офіційних Фмоделей Magda 166, 167 і 169.

begin;

do $$
declare ready_count integer;
begin
  select count(*) into ready_count
  from public.products p
  where p.slug in ('magda-166-official', 'magda-167-official', 'magda-169-official')
    and p.is_available = false
    and exists (select 1 from public.product_sources s where s.product_slug = p.slug and s.verification_status = 'verified')
    and exists (select 1 from public.product_media m where m.product_slug = p.slug and m.kind = 'gallery' and m.is_active);
  if ready_count <> 3 then
    raise exception 'Очікувалось 3 готові чернетки Magda, знайдено % — каталог не змінено', ready_count;
  end if;
end $$;

update public.products
set is_available = true, updated_at = now()
where slug in ('magda-166-official', 'magda-167-official', 'magda-169-official')
  and is_available = false;

commit;

select slug, name as "модель", collection as "колекція", is_available as "опубліковано"
from public.products
where slug in ('magda-166-official', 'magda-167-official', 'magda-169-official')
order by name;
