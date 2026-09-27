-- Q Doors: публікація шести перевірених моделей серії «Преміум».

begin;

do $$
declare
  draft_count integer;
begin
  select count(*) into draft_count
  from public.products
  where slug in (
    'qdoors-premium-tracey-m-official',
    'qdoors-premium-horizontal-official',
    'qdoors-premium-accent-official',
    'qdoors-premium-combi-ak-official',
    'qdoors-premium-vertical-ak-official',
    'qdoors-premium-provans-official'
  )
    and brand = 'Q Doors'
    and collection = 'Преміум';

  if draft_count <> 6 then
    raise exception 'Очікувалось 6 моделей Q Doors Преміум, знайдено % — каталог не змінено', draft_count;
  end if;
end $$;

update public.products
set is_available = true,
    updated_at = now()
where slug in (
  'qdoors-premium-tracey-m-official',
  'qdoors-premium-horizontal-official',
  'qdoors-premium-accent-official',
  'qdoors-premium-combi-ak-official',
  'qdoors-premium-vertical-ak-official',
  'qdoors-premium-provans-official'
)
  and brand = 'Q Doors';

commit;

select
  collection as серія,
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано
from public.products
where slug in (
  'qdoors-premium-tracey-m-official',
  'qdoors-premium-horizontal-official',
  'qdoors-premium-accent-official',
  'qdoors-premium-combi-ak-official',
  'qdoors-premium-vertical-ak-official',
  'qdoors-premium-provans-official'
)
group by collection;
