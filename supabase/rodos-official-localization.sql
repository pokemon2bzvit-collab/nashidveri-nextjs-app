-- Локалізація чистого імпорту Rodos / Rodos Steel.
-- Змінює ТІЛЬКИ моделі, створені офіційним імпортером (slug rodos-official-*).
-- Назви моделей та колекції не втрачаються.

begin;

with normalized as (
  select
    slug,
    brand,
    collection,
    trim(
      regexp_replace(
        regexp_replace(
          regexp_replace(
            name,
            '^\s*(Межкомнатная дверь|Міжкімнатні двері)\s+',
            '',
            'i'
          ),
          '^\s*(Входные двери|Вхідні двері)\s+',
          '',
          'i'
        ),
        '^\s*(Двустворчатая дверь|Двостулкові двері)\s+',
        'Двостулкові ',
        'i'
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

-- Перевірка результату перед завершенням.
select brand, collection, name, description
from public.products
where slug like 'rodos-official-%'
  and brand in ('Rodos', 'Rodos Steel')
order by brand, collection, name
limit 30;

commit;
