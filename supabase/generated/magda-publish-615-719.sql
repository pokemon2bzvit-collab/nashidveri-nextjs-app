-- Публікація перевірених офіційних моделей Magda 615 та 719.1.
-- Перевірка захищає від випадкової публікації неповних карток.

begin;

do $$
declare
  ready_count integer;
begin
  select count(*) into ready_count
  from public.products p
  where p.slug in ('magda-615-official', 'magda-719-1-official')
    and p.is_available = false
    and exists (
      select 1 from public.product_sources s
      where s.product_slug = p.slug and s.verification_status = 'verified'
    )
    and exists (
      select 1 from public.product_media m
      where m.product_slug = p.slug and m.kind = 'gallery' and m.is_active
    );

  if ready_count <> 2 then
    raise exception 'Очікувалось 2 готові чернетки Magda, знайдено % — каталог не змінено', ready_count;
  end if;
end $$;

update public.products
set is_available = true, updated_at = now()
where slug in ('magda-615-official', 'magda-719-1-official')
  and is_available = false;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-615-official', 'magda-719-1-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
