-- Базові характеристики для всього каталогу.
-- Використовує лише вже підтверджені дані з products і product_options:
-- категорію, доступні декори, покриття, скло, кромки та комплектації.
-- Точні конструктивні параметри (товщина, замки, утеплення) додаються
-- окремими seed-файлами після перевірки в офіційного виробника.

insert into public.product_specs (product_slug, label, value, sort_order)
select
  slug,
  'Категорія',
  case category
    when 'interior' then 'Міжкімнатні двері'
    when 'entrance' then 'Вхідні двері'
    when 'windows' then 'Віконні системи'
  end,
  500
from public.products
where is_available = true
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;

with option_groups as (
  select
    product_slug,
    option_group,
    array_agg(label order by sort_order, label) as labels
  from public.product_options
  where is_active = true
  group by product_slug, option_group
), normalized as (
  select
    product_slug,
    case option_group
      when 'color' then 'Доступні декори'
      when 'finish' then 'Покриття'
      when 'glass' then 'Варіанти скла'
      when 'edge' then 'Кромка'
      when 'configuration' then 'Комплектація'
    end as label,
    case
      when cardinality(labels) > 6
        then array_to_string(labels[1:6], ', ') || ' + ще ' || (cardinality(labels) - 6)
      else array_to_string(labels, ', ')
    end as value,
    case option_group
      when 'color' then 510
      when 'finish' then 520
      when 'glass' then 530
      when 'edge' then 540
      when 'configuration' then 550
    end as sort_order
  from option_groups
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from normalized
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
