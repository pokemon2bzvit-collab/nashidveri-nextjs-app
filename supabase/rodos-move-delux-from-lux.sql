-- Виправлення структури каталогу Rodos.
-- Три моделі Grand Delux були помилково віднесені до колекції LUX.
-- Скрипт змінює лише поле collection у цих трьох моделях.

begin;

do $$
declare
  expected_count integer := 3;
  actual_count integer;
begin
  select count(*)
    into actual_count
  from public.products
  where brand = 'Rodos'
    and slug in (
      'rodos-official-1cds1t5',
      'rodos-official-1j5jj7u',
      'rodos-official-13xts2z'
    );

  if actual_count <> expected_count then
    raise exception 'Очікувалось % моделей Grand Delux, знайдено % — каталог не змінено', expected_count, actual_count;
  end if;
end $$;

update public.products
set collection = 'DELUX'
where brand = 'Rodos'
  and slug in (
    'rodos-official-1cds1t5',
    'rodos-official-1j5jj7u',
    'rodos-official-13xts2z'
  );

commit;

select collection, count(*) as models
from public.products
where brand = 'Rodos'
  and collection in ('DELUX', 'LUX')
group by collection
order by collection;
