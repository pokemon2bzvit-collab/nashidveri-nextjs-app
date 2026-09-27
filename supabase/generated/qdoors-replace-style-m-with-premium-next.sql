-- Q Doors: публікує актуальну «Преміум Некст» і приховує застарілу «Стиль M».
-- Дані старої картки не видаляються.

begin;

do $$
begin
  if not exists (
    select 1
    from public.products
    where slug = 'qdoors-premium-next-official'
      and brand = 'Q Doors'
      and collection = 'Преміум'
  ) then
    raise exception 'Не знайдено чернетку Q Doors Преміум Некст — каталог не змінено';
  end if;

  if not exists (
    select 1
    from public.products
    where slug = 'catalog-66'
      and brand = 'Q Doors'
  ) then
    raise exception 'Не знайдено стару картку Q Doors Стиль M (catalog-66) — каталог не змінено';
  end if;
end $$;

update public.products
set is_available = true,
    updated_at = now()
where slug = 'qdoors-premium-next-official';

update public.products
set is_available = false,
    updated_at = now()
where slug = 'catalog-66'
  and brand = 'Q Doors';

commit;

-- Має повернути один опублікований Некст і одну приховану стару картку.
select
  slug,
  name as модель,
  collection as серія,
  is_available as опубліковано
from public.products
where slug in ('qdoors-premium-next-official', 'catalog-66')
order by is_available desc, name;
