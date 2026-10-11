-- Rodos Style: описи 10 моделей Style 1–5 і Style 1–5 BLK.
-- Варіанти полотна й декори звірено з
-- supabase/generated/rodos-style-configurations.json.
-- Змінює лише шаблонні описи; при іншому тексті скасовує всі зміни.

begin;

do $$
declare
  item record;
  current_description text;
  template_description text;
  revised_description text;
  unexpected_count integer;
begin
  select count(*) into unexpected_count
  from public.products p
  where p.brand = 'Rodos'
    and p.collection = 'Style ПВХ'
    and p.is_available = true
    and p.slug not in (
      'rodos-official-hxhl5h', 'rodos-official-wrirzx',
      'rodos-official-1rk5v3e', 'rodos-official-wtq2da',
      'rodos-official-1rk5u97', 'rodos-official-wsxm0v',
      'rodos-official-hxhl5j', 'rodos-official-wpnpq0',
      'rodos-official-1rk5pf1', 'rodos-official-wov9dl'
    );

  if unexpected_count > 0 then
    raise exception 'Знайдено % додаткових опублікованих моделей Style — жоден опис не змінено', unexpected_count;
  end if;

  for item in
    select * from (values
      ('rodos-official-hxhl5h', 'Style 1', false, 'сірий дуб, сосна крем і дуб сонома'),
      ('rodos-official-wrirzx', 'Style 1 BLK', true, 'сірий мармур, темна акація та бежевий каштан'),
      ('rodos-official-1rk5v3e', 'Style 2', false, 'сірий дуб, сосна крем і дуб сонома'),
      ('rodos-official-wtq2da', 'Style 2 BLK', true, 'сірий мармур, темна акація та бежевий каштан'),
      ('rodos-official-1rk5u97', 'Style 3', false, 'сірий дуб, крем і дуб сонома'),
      ('rodos-official-wsxm0v', 'Style 3 BLK', true, 'сірий мармур, темна акація та бежевий каштан'),
      ('rodos-official-hxhl5j', 'Style 4', false, 'сірий дуб, крем і дуб сонома'),
      ('rodos-official-wpnpq0', 'Style 4 BLK', true, 'сірий мармур, темна акація та бежевий каштан'),
      ('rodos-official-1rk5pf1', 'Style 5', false, 'сірий дуб, крем і дуб сонома'),
      ('rodos-official-wov9dl', 'Style 5 BLK', true, 'сірий мармур, темна акація та бежевий каштан')
    ) as models(slug, model, is_blk, example_decors)
  loop
    template_description := format(
      'Міжкімнатні двері %s — модель фабрики Rodos для вашого інтер’єру. Детальні характеристики, доступні покриття та актуальну ціну уточнюйте у менеджера.',
      item.model
    );

    if item.is_blk then
      revised_description := format(
        '%s — міжкімнатні двері Rodos у виконанні BLK із покриттям Renolit. Для моделі доступне напівскло та вибір декорів, зокрема %s. Допоможемо підібрати колір, розмір і комплектацію; актуальну ціну уточнюйте у менеджера.',
        item.model, item.example_decors
      );
    else
      revised_description := format(
        '%s — міжкімнатні двері Rodos із покриттям Renolit. Для моделі можна обрати глухе полотно або напівскло; серед декорів — %s. Покриття зручне у щоденному догляді. Допоможемо підібрати розмір, комплектацію та актуальну ціну.',
        item.model, item.example_decors
      );
    end if;

    select p.description into current_description
    from public.products p
    where p.slug = item.slug
      and p.brand = 'Rodos'
      and p.collection = 'Style ПВХ';

    if not found or (
      current_description is distinct from template_description
      and current_description is distinct from revised_description
    ) then
      raise exception 'Опис % відрізняється від шаблону — жоден опис не змінено', item.model;
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
where brand = 'Rodos' and collection = 'Style ПВХ' and is_available = true
order by name;
