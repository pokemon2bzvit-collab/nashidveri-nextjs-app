-- Оновлення описів шести моделей Rodos Atlantic ПВХ (A001–A006).
-- Варіанти полотна й декори звірені з локальним знімком офіційних карток:
-- supabase/generated/rodos-atlantic-official-configurations.json
-- Зупиняється без змін, якщо картка відсутня або її опис відредаговано окремо.

begin;

do $$
declare
  item record;
  previous_description text;
  template_description text;
  unexpected_count integer;
begin
  select count(*) into unexpected_count
  from public.products p
  where p.brand = 'Rodos'
    and p.collection = 'Atlantic ПВХ'
    and p.is_available = true
    and p.slug not in (
      'rodos-official-1osu0nf', 'rodos-official-1osu0nc',
      'rodos-official-16d044a', 'rodos-official-bf2ks0',
      'rodos-official-1osu0nj', 'rodos-official-lnsyln'
    );

  if unexpected_count > 0 then
    raise exception 'Знайдено % додаткових опублікованих моделей Atlantic ПВХ — жоден опис не змінено', unexpected_count;
  end if;

  for item in
    select * from (values
      (
        'rodos-official-1osu0nf', 'Atlantic A001',
        'Atlantic A001 — міжкімнатні двері Rodos із покриттям Renolit. Для моделі можна обрати глухе полотно або варіант зі склом і підібрати колір під інтер’єр: білий мат, сосна крем чи дуб сонома. Покриття Renolit зручне у щоденному догляді. Допоможемо визначити потрібний розмір, комплектацію та актуальну ціну.',
        'Atlantic A001 — міжкімнатні двері Rodos із ПВХ-покриттям. Для моделі можна обрати глухе полотно або варіант зі склом і підібрати колір під інтер’єр: білий мат, сосна крем чи дуб сонома. ПВХ-покриття зручне у щоденному догляді. Допоможемо визначити потрібний розмір, комплектацію та актуальну ціну.'
      ),
      (
        'rodos-official-1osu0nc', 'Atlantic A002',
        'Atlantic A002 — міжкімнатні двері Rodos із ПВХ-покриттям. Оберіть глухе полотно, напівскло або варіант зі склом; серед доступних декорів — білий мат, сосна крем і дуб сонома. За покриттям легко доглядати щодня. Допоможемо підібрати розмір і комплектацію та уточнимо актуальну ціну.',
        'Rodos Atlantic A002 — міжкімнатні двері з ПВХ-покриттям Renolit (Німеччина). Модель доступна з глухим полотном, частковим склінням або скляною вставкою; серед декорів є світлі відтінки та текстури дерева.'
      ),
      (
        'rodos-official-16d044a', 'Atlantic A003',
        'Atlantic A003 — міжкімнатні двері Rodos із ПВХ-покриттям. Модель доступна з глухим полотном або напівсклом; для інтер’єру можна підібрати білий мат, сосну крем чи дуб сонома. Покриття невибагливе у щоденному догляді. Підкажемо розмір, комплектацію та актуальну ціну.',
        null
      ),
      (
        'rodos-official-bf2ks0', 'Atlantic A004',
        'Atlantic A004 — міжкімнатні двері Rodos із ПВХ-покриттям. Є глухе полотно, напівскло та варіант зі склом, а серед декорів — білий мат, сосна крем і дуб сонома. Оберіть поєднання для свого інтер’єру, а ми допоможемо підібрати розмір, комплектацію й уточнити актуальну ціну.',
        null
      ),
      (
        'rodos-official-1osu0nj', 'Atlantic A005',
        'Atlantic A005 — міжкімнатні двері Rodos із ПВХ-покриттям. Оберіть глухе полотно або модель зі склом і відповідний декор — наприклад, білий мат, сосну крем чи дуб сонома. Покриття зручне у повсякденному догляді. Допоможемо уточнити розмір, комплектацію та ціну.',
        null
      ),
      (
        'rodos-official-lnsyln', 'Atlantic A006',
        'Atlantic A006 — міжкімнатні двері Rodos із ПВХ-покриттям. Доступні глухе полотно й варіант зі склом, а також світлі декори та текстури дерева, зокрема білий мат, сосна крем і дуб сонома. Допоможемо підібрати виконання під ваш інтер’єр, визначити розмір, комплектацію й актуальну ціну.',
        null
      )
    ) as descriptions(slug, model, new_description, earlier_description)
  loop
    select p.description into previous_description
    from public.products p
    where p.slug = item.slug
      and p.brand = 'Rodos'
      and p.collection = 'Atlantic ПВХ';

    if not found then
      raise exception 'Модель % не знайдена в колекції Atlantic ПВХ — жоден опис не змінено', item.model;
    end if;

    template_description := format(
      'Міжкімнатні двері %s — модель фабрики Rodos для вашого інтер’єру. Детальні характеристики, доступні покриття та актуальну ціну уточнюйте у менеджера.',
      item.model
    );

    if previous_description is distinct from template_description
       and previous_description is distinct from item.earlier_description
       and previous_description is distinct from item.new_description then
      raise exception 'Опис % уже змінено вручну — жоден опис не змінено', item.model;
    end if;

    if previous_description is distinct from item.new_description then
      update public.products
      set description = item.new_description, updated_at = now()
      where slug = item.slug;
    end if;
  end loop;
end $$;

commit;

select slug, name, description
from public.products
where brand = 'Rodos' and collection = 'Atlantic ПВХ'
order by name;
