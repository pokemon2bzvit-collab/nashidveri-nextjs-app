-- Публікація другої частини дев’ятої сторінки Magda.

begin;

do $$
declare ready_count integer;
begin
  select count(*) into ready_count
  from public.products p
  where p.slug in ('magda-806-1-official','magda-645-official','magda-535-1-official','magda-110-official','magda-542-1-official','magda-539-1-official')
    and p.is_available = false
    and exists (select 1 from public.product_sources s where s.product_slug = p.slug and s.verification_status = 'verified')
    and exists (select 1 from public.product_media m where m.product_slug = p.slug and m.kind = 'gallery' and m.is_active);
  if ready_count <> 6 then
    raise exception 'Очікувалось 6 готових чернеток Magda, знайдено % — каталог не змінено', ready_count;
  end if;
end $$;

update public.products
set is_available = true, updated_at = now()
where slug in ('magda-806-1-official','magda-645-official','magda-535-1-official','magda-110-official','magda-542-1-official','magda-539-1-official')
  and is_available = false;

commit;

select slug, name as "модель", collection as "колекція", is_available as "опубліковано"
from public.products
where slug in ('magda-806-1-official','magda-645-official','magda-535-1-official','magda-110-official','magda-542-1-official','magda-539-1-official')
order by name;
