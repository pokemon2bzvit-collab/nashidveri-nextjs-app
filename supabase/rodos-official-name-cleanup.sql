-- Другий етап локалізації чистого імпорту Rodos / Rodos Steel.
-- Виправляє російські технічні слова, що залишилися у назвах моделей.
-- Змінює лише товари, створені офіційним імпортером.

begin;

with normalized as (
  select
    slug,
    brand,
    collection,
    trim(
      replace(
        replace(
          replace(
            replace(
              replace(
                replace(
                  name,
                  'Без покраски', 'без фарбування'
                ),
                'Грунт', 'Ґрунт'
              ),
              'Фрезеровка', 'Фрезерування'
            ),
            'со стеклопакетом', 'зі склопакетом'
          ),
          'для улицы', 'для вулиці'
        ),
        'для квартиры', 'для квартири'
      )
    ) as localized_name
  from public.products
  where slug like 'rodos-official-%'
    and brand in ('Rodos', 'Rodos Steel')
)
update public.products as product
set
  name = normalized.localized_name,
  description = case
    when normalized.brand = 'Rodos Steel' then
      'Вхідні двері Rodos Steel ' || normalized.localized_name || ' ' ||
      case normalized.collection
        when 'Квартира' then 'для квартири'
        when 'Вулиця' then 'для приватного будинку'
        else 'для квартири або будинку'
      end ||
      '. Колекція «' || normalized.collection ||
      '». Розмір, комплектацію та актуальну ціну уточнюйте у менеджера.'
    else
      'Міжкімнатні двері Rodos ' || normalized.localized_name ||
      '. Колекція «' || normalized.collection ||
      '». Доступні покриття, розмір і комплектацію уточнюйте у менеджера.'
  end
from normalized
where product.slug = normalized.slug;

-- Контроль: після виконання цей запит має повернути 0 рядків.
select slug, name
from public.products
where slug like 'rodos-official-%'
  and brand in ('Rodos', 'Rodos Steel')
  and (
    name ilike '%Без покраски%'
    or name ilike '%Грунт%'
    or name ilike '%Фрезеровка%'
    or name ilike '%для улицы%'
    or name ilike '%для квартиры%'
    or name ilike '%со стеклопакетом%'
  );

commit;
