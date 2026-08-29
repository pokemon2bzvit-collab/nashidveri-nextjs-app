-- Papa Carlo Style: підтверджені спільні параметри колекції.
-- Джерела: офіційна сторінка Papa Carlo «Style» та новина «Нова колекція STYLE».
-- Перевірено: 29.08.2026.

with style_models(product_slug) as (
  values
    ('catalog-111'), ('catalog-112'), ('catalog-113'), ('catalog-114'),
    ('catalog-115'), ('catalog-116'), ('catalog-117'), ('catalog-118')
), style_specs(label, value, sort_order) as (
  values
    ('Дизайн колекції', 'Сучасний класичний і мінімалістичний', 100),
    ('Конструкція полотна', 'Щитове полотно з фрезеруванням', 110),
    ('Покриття', 'Декоративна плівка RENOLIT на основі поліпропілену, Німеччина', 120),
    ('Система короба', 'Компланарний або прихований короб', 130),
    ('Варіанти торця полотна', 'Анодований алюмінієвий профіль або кромка ABC', 140),
    ('Гарантія виробника', '5 років', 150)
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from style_models cross join style_specs
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
