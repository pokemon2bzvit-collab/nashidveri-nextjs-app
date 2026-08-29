-- RODOS Grand Paint: підтверджені характеристики колекції.
-- Джерело: офіційні картки Grand Paint на rodos.net.ua.
-- Перевірено: 29.08.2026. Ціни навмисно не додаються — вони змінюються.

with paint_models(product_slug) as (
  values
    ('catalog-40'), ('catalog-41'), ('catalog-42'), ('catalog-43'),
    ('catalog-44'), ('catalog-45'), ('catalog-46'), ('catalog-47'),
    ('catalog-48'), ('catalog-49'), ('catalog-50'), ('catalog-51')
), paint_specs(label, value, sort_order) as (
  values
    ('Лінійка виробника', 'RODOS Grand', 100),
    ('Тип виробу', 'Міжкімнатні двері', 110),
    ('Стиль колекції', 'Гранж', 120),
    ('Покриття', 'Пофарбоване дерев’яне полотно', 130),
    ('Товщина полотна', '44 мм', 140),
    ('Доступні розміри полотна', '600 × 2000, 700 × 2000, 800 × 2000 або 900 × 2000 мм; можливе індивідуальне виготовлення', 150),
    ('Система погонажу', 'Коробка Paint + 38/38, білий матовий акрил; лиштва Basic R2', 160)
), solid_models(product_slug) as (
  values
    ('catalog-40'), ('catalog-44'), ('catalog-45'), ('catalog-46'),
    ('catalog-47'), ('catalog-49'), ('catalog-50'), ('catalog-51')
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from paint_models cross join paint_specs
union all
select product_slug, 'Тип полотна', 'Глухе', 170
from solid_models
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
