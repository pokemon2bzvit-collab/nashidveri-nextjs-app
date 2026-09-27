-- Q Doors: публікація шести перевірених моделей серії «Авангард».

begin;

do $$
declare
  model_count integer;
begin
  select count(*) into model_count
  from public.products
  where slug in (
    'qdoors-avangard-converse-ak-official',
    'qdoors-avangard-horizontal-al-official',
    'qdoors-avangard-bacardi-official',
    'qdoors-avangard-tiffani-official',
    'qdoors-avangard-trino-official',
    'qdoors-avangard-galant-ak-official'
  )
    and brand = 'Q Doors'
    and collection = 'Авангард';

  if model_count <> 6 then
    raise exception 'Очікувалось 6 моделей Q Doors Авангард, знайдено % — каталог не змінено', model_count;
  end if;
end $$;

update public.products
set is_available = true,
    updated_at = now()
where slug in (
  'qdoors-avangard-converse-ak-official',
  'qdoors-avangard-horizontal-al-official',
  'qdoors-avangard-bacardi-official',
  'qdoors-avangard-tiffani-official',
  'qdoors-avangard-trino-official',
  'qdoors-avangard-galant-ak-official'
)
  and brand = 'Q Doors';

commit;

select
  collection as серія,
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано
from public.products
where slug in (
  'qdoors-avangard-converse-ak-official',
  'qdoors-avangard-horizontal-al-official',
  'qdoors-avangard-bacardi-official',
  'qdoors-avangard-tiffani-official',
  'qdoors-avangard-trino-official',
  'qdoors-avangard-galant-ak-official'
)
group by collection;
