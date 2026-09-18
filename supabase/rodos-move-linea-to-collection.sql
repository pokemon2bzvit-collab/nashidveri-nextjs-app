-- Відносить уже імпортовані моделі Linea до окремої колекції Rodos Linea.
-- Нічого не видаляє: змінюється тільки поле collection у восьми моделях.

begin;

do $$
declare
  actual_count integer;
begin
  select count(*) into actual_count
  from public.products
  where brand = 'Rodos'
    and slug in (
      'rodos-official-9fntu5', 'rodos-official-9fntu6',
      'rodos-official-9fntu7', 'rodos-official-9fntu0',
      'rodos-official-9fntu1', 'rodos-official-9fntu2',
      'rodos-official-9fntu3', 'rodos-official-9fnttw'
    );

  if actual_count <> 8 then
    raise exception 'Очікувалось 8 моделей Linea, знайдено % — каталог не змінено', actual_count;
  end if;
end $$;

update public.products
set collection = 'Linea'
where brand = 'Rodos'
  and slug in (
    'rodos-official-9fntu5', 'rodos-official-9fntu6',
    'rodos-official-9fntu7', 'rodos-official-9fntu0',
    'rodos-official-9fntu1', 'rodos-official-9fntu2',
    'rodos-official-9fntu3', 'rodos-official-9fnttw'
  );

commit;

select collection, count(*) as models
from public.products
where brand = 'Rodos' and collection = 'Linea'
group by collection;
