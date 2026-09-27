-- Відносить усі вже імпортовані моделі Modern, включно з INSIDE, до колекції Modern.
-- Нічого не видаляє: змінюється тільки поле collection.

begin;

do $$
declare
  actual_count integer;
begin
  select count(*) into actual_count
  from public.products
  where brand = 'Rodos'
    and slug in (
      'rodos-official-97swzq', 'rodos-official-127ccdq', 'rodos-official-trylx9', 'rodos-official-vc5cnp',
      'rodos-official-1dki7dw', 'rodos-official-li1t3k', 'rodos-official-pmgy08', 'rodos-official-inav5b',
      'rodos-official-inav58', 'rodos-official-inav59', 'rodos-official-inav56', 'rodos-official-inav57',
      'rodos-official-1ty8k9t', 'rodos-official-8g7otx', 'rodos-official-o1rdgk', 'rodos-official-3mk5zb',
      'rodos-official-vwlh80', 'rodos-official-v4cb9a', 'rodos-official-2bhqfk', 'rodos-official-1ql4zhy',
      'rodos-official-rexzia', 'rodos-official-1yz0ngg', 'rodos-official-1utgp0n', 'rodos-official-14efvk6'
    );

  if actual_count <> 24 then
    raise exception 'Очікувалось 24 моделі Modern, знайдено % — каталог не змінено', actual_count;
  end if;
end $$;

update public.products
set collection = 'Modern'
where brand = 'Rodos'
  and slug in (
    'rodos-official-97swzq', 'rodos-official-127ccdq', 'rodos-official-trylx9', 'rodos-official-vc5cnp',
    'rodos-official-1dki7dw', 'rodos-official-li1t3k', 'rodos-official-pmgy08', 'rodos-official-inav5b',
    'rodos-official-inav58', 'rodos-official-inav59', 'rodos-official-inav56', 'rodos-official-inav57',
    'rodos-official-1ty8k9t', 'rodos-official-8g7otx', 'rodos-official-o1rdgk', 'rodos-official-3mk5zb',
    'rodos-official-vwlh80', 'rodos-official-v4cb9a', 'rodos-official-2bhqfk', 'rodos-official-1ql4zhy',
    'rodos-official-rexzia', 'rodos-official-1yz0ngg', 'rodos-official-1utgp0n', 'rodos-official-14efvk6'
  );

commit;

select collection, count(*) as models
from public.products
where brand = 'Rodos' and collection = 'Modern'
group by collection;
