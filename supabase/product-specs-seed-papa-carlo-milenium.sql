-- Papa Carlo Milenium: підтверджені спільні параметри колекції.
-- Джерело: офіційна сторінка Papa Carlo «Millenium».
-- Перевірено: 29.08.2026.

with milenium_models(product_slug) as (
  values
    ('catalog-85'), ('catalog-86'), ('catalog-87'), ('catalog-88'),
    ('catalog-89'), ('catalog-90'), ('catalog-91'), ('catalog-92'),
    ('catalog-93'), ('catalog-94'), ('catalog-95'), ('catalog-96'),
    ('catalog-97'), ('catalog-98'), ('catalog-99'), ('catalog-100'),
    ('catalog-101')
), milenium_specs(label, value, sort_order) as (
  values
    ('Дизайн колекції', 'Сучасний і класичний', 100),
    ('Покриття', 'Декоративна плівка RENOLIT на основі поліпропілену, Німеччина', 110),
    ('Система короба', 'Компланарний короб', 120)
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from milenium_models cross join milenium_specs
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
