-- Papa Carlo Plato: підтверджені спільні параметри колекції.
-- Джерела: офіційні сторінки Papa Carlo «Plato», «Короба» та «Матеріали».
-- Перевірено: 29.08.2026.

with plato_models(product_slug) as (
  values
    ('catalog-102'), ('catalog-103'), ('catalog-104'),
    ('catalog-105'), ('catalog-106'), ('catalog-107'),
    ('catalog-108'), ('catalog-109'), ('catalog-110')
), plato_specs(label, value, sort_order) as (
  values
    ('Дизайн колекції', 'Сучасний мінімалістичний', 100),
    ('Покриття', 'Декоративна плівка RENOLIT на основі поліпропілену, Німеччина', 110),
    ('Система короба', 'Компланарний або прихований короб', 120),
    ('Варіанти торця полотна', 'Анодований алюмінієвий профіль або кромка ABC', 130)
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from plato_models cross join plato_specs
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
