-- Q Doors: публікація трьох перевірених моделей серії «Ультра».

begin;

do $$
declare
  model_count integer;
begin
  select count(*) into model_count
  from public.products
  where slug in (
    'qdoors-ultra-flash-official',
    'qdoors-ultra-cross-ak-official',
    'qdoors-ultra-frost-official'
  )
    and brand = 'Q Doors'
    and collection = 'Ультра';

  if model_count <> 3 then
    raise exception 'Очікувалось 3 моделі Q Doors Ультра, знайдено % — каталог не змінено', model_count;
  end if;
end $$;

update public.products
set is_available = true,
    updated_at = now()
where slug in (
  'qdoors-ultra-flash-official',
  'qdoors-ultra-cross-ak-official',
  'qdoors-ultra-frost-official'
)
  and brand = 'Q Doors';

commit;

select
  collection as серія,
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано
from public.products
where slug in (
  'qdoors-ultra-flash-official',
  'qdoors-ultra-cross-ak-official',
  'qdoors-ultra-frost-official'
)
group by collection;
