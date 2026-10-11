-- Atlantic A002–A006: заміна формулювання покриття в уже погоджених описах.
-- A001 вже має «покриття Renolit» і залишається без змін.
-- Якщо поточний опис відрізняється, транзакція не змінить жодної картки.

begin;

do $$
declare
  item record;
  current_description text;
  revised_description text;
begin
  for item in
    select * from (values
      (
        'rodos-official-1osu0nc',
        'Atlantic A002 — міжкімнатні двері Rodos із ПВХ-покриттям. Оберіть глухе полотно, напівскло або варіант зі склом; серед доступних декорів — білий мат, сосна крем і дуб сонома. За покриттям легко доглядати щодня. Допоможемо підібрати розмір і комплектацію та уточнимо актуальну ціну.'
      ),
      (
        'rodos-official-16d044a',
        'Atlantic A003 — міжкімнатні двері Rodos із ПВХ-покриттям. Модель доступна з глухим полотном або напівсклом; для інтер’єру можна підібрати білий мат, сосну крем чи дуб сонома. Покриття невибагливе у щоденному догляді. Підкажемо розмір, комплектацію та актуальну ціну.'
      ),
      (
        'rodos-official-bf2ks0',
        'Atlantic A004 — міжкімнатні двері Rodos із ПВХ-покриттям. Є глухе полотно, напівскло та варіант зі склом, а серед декорів — білий мат, сосна крем і дуб сонома. Оберіть поєднання для свого інтер’єру, а ми допоможемо підібрати розмір, комплектацію й уточнити актуальну ціну.'
      ),
      (
        'rodos-official-1osu0nj',
        'Atlantic A005 — міжкімнатні двері Rodos із ПВХ-покриттям. Оберіть глухе полотно або модель зі склом і відповідний декор — наприклад, білий мат, сосну крем чи дуб сонома. Покриття зручне у повсякденному догляді. Допоможемо уточнити розмір, комплектацію та ціну.'
      ),
      (
        'rodos-official-lnsyln',
        'Atlantic A006 — міжкімнатні двері Rodos із ПВХ-покриттям. Доступні глухе полотно й варіант зі склом, а також світлі декори та текстури дерева, зокрема білий мат, сосна крем і дуб сонома. Допоможемо підібрати виконання під ваш інтер’єр, визначити розмір, комплектацію й актуальну ціну.'
      )
    ) as descriptions(slug, previous_description)
  loop
    revised_description := replace(item.previous_description, 'із ПВХ-покриттям', 'із покриттям Renolit');

    select p.description into current_description
    from public.products p
    where p.slug = item.slug
      and p.brand = 'Rodos'
      and p.collection = 'Atlantic ПВХ';

    if not found or (
      current_description is distinct from item.previous_description
      and current_description is distinct from revised_description
    ) then
      raise exception 'Опис % відрізняється від перевіреної версії — жоден опис не змінено', item.slug;
    end if;

    if current_description is distinct from revised_description then
      update public.products
      set description = revised_description, updated_at = now()
      where slug = item.slug;
    end if;
  end loop;
end $$;

commit;

select slug, name, description
from public.products
where brand = 'Rodos' and collection = 'Atlantic ПВХ' and is_available = true
order by name;
