-- RODOS Cortes фарба: підтверджені характеристики колекції.
-- Джерело: офіційні картки Cortes на rodos.net.ua.
-- Перевірено: 29.08.2026. Ціни навмисно не додаються — вони змінюються.

with cortes_models(product_slug) as (
  values
    ('catalog-194'), ('catalog-195'), ('catalog-196'), ('catalog-197'),
    ('catalog-198'), ('catalog-199'), ('catalog-200'), ('catalog-201'),
    ('catalog-202'), ('catalog-203'), ('catalog-204'), ('catalog-205'),
    ('catalog-206'), ('catalog-207'), ('catalog-208'), ('catalog-209'),
    ('catalog-210'), ('catalog-211'), ('catalog-212'), ('catalog-213'),
    ('catalog-214'), ('catalog-215')
), cortes_specs(label, value, sort_order) as (
  values
    ('Виробник', 'RODOS, Україна', 100),
    ('Тип виробу', 'Міжкімнатні двері', 110),
    ('Покриття', 'Пофарбовані двері', 120),
    ('Варіанти кольору', 'Білий мат; доступне фарбування у вибрані кольори RAL', 130)
), model_leaf_types(product_slug, value) as (
  values
    ('catalog-197', 'Глухе'),
    ('catalog-198', 'Напівскло'),
    ('catalog-199', 'Скло'),
    ('catalog-207', 'Глухе'),
    ('catalog-208', 'Напівскло'),
    ('catalog-209', 'Скло'),
    ('catalog-214', 'Глухе'),
    ('catalog-215', 'Напівскло')
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from cortes_models cross join cortes_specs
union all
select product_slug, 'Тип полотна', value, 140
from model_leaf_types
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
