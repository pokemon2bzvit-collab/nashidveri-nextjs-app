-- Короткі описи Papa Carlo / Plato без дублювання технічного блоку.
with plato as (
  select
    p.slug,
    p.name,
    max(s.value) filter (where s.label = 'Матеріал покриття') as covering
  from public.products p
  left join public.product_specs s on s.product_slug = p.slug
  where p.brand = 'Papa Carlo'
    and p.collection = 'Plato'
  group by p.slug, p.name
)
update public.products p
set description = concat_ws(' ',
  plato.name || ' — міжкімнатні двері колекції Plato' ||
    case
      when plato.covering ilike '%Renolit%' then ' з поліпропіленовим покриттям Renolit (Німеччина).'
      when plato.covering is not null and plato.covering <> '' then ' з покриттям ' || lower(plato.covering) || '.'
      else '.'
    end,
  'Модель поєднує елегантний дизайн і стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні.',
  'Доступні різні кольори та варіанти оздоблення для вашого інтер''єру.',
  'Актуальну комплектацію й ціну уточнюйте у менеджера.'
)
from plato
where p.slug = plato.slug;

select name, description
from public.products
where brand = 'Papa Carlo'
  and collection = 'Plato'
order by name
limit 3;
