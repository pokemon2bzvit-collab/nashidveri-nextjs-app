-- Rodos Woodmix: українські назви й описи карток.
do $$
begin
  if (select count(*) from public.products where slug in ('rodos-official-xhloa4', 'rodos-official-zps1ju')) <> 2 then
    raise exception 'Не знайдено обидві моделі Woodmix — каталог не змінено';
  end if;
end $$;

begin;

update public.products
set
  name = 'Rodos Woodmix Master',
  description = 'Rodos Woodmix Master — міжкімнатні двері колекції Woodmix для сучасного інтер’єру. Доступні глухе та напівскляне виконання; комплектацію й актуальну ціну уточнюйте у менеджера.'
where slug = 'rodos-official-xhloa4';

update public.products
set
  name = 'Rodos Woodmix Praktic',
  description = 'Rodos Woodmix Praktic — міжкімнатні двері колекції Woodmix для практичного щоденного користування. Доступні глухе та напівскляне виконання; комплектацію й актуальну ціну уточнюйте у менеджера.'
where slug = 'rodos-official-zps1ju';

commit;

select slug, name, description
from public.products
where slug in ('rodos-official-xhloa4', 'rodos-official-zps1ju')
order by name;
