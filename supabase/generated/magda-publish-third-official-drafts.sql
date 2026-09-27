-- Magda: публікація 501.1 і 543.1 після перевірки джерел та галереї.

do $$
declare ready_count integer;
begin
  select count(*) into ready_count
  from (
    select p.slug
    from public.products p
    left join public.product_sources s on s.product_slug = p.slug
      and s.verification_status = 'verified' and s.source_url ilike '%magda.com.ua%'
    left join public.product_media m on m.product_slug = p.slug
      and m.kind = 'gallery' and m.is_active
    where p.slug in ('magda-501-1-official','magda-543-1-official') and not p.is_available
    group by p.slug
    having count(distinct s.id) >= 1 and count(distinct m.id) >= 2
  ) ready;
  if ready_count <> 2 then
    raise exception 'Очікувалось 2 готові чернетки Magda, знайдено % — каталог не змінено', ready_count;
  end if;
end $$;

update public.products
set is_available = true, updated_at = now()
where slug in ('magda-501-1-official','magda-543-1-official') and not is_available;

select collection as "колекція", count(*) as "моделей", count(*) filter (where is_available) as "опубліковано"
from public.products
where slug in ('magda-501-1-official','magda-543-1-official')
group by collection;
