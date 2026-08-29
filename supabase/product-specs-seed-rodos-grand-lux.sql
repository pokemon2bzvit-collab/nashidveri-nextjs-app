-- RODOS Grand LUX: підтверджені характеристики колекції.
-- Джерело: офіційні картки Grand Lux на rodos.net.ua.
-- Перевірено: 29.08.2026. Ціни навмисно не додаються — вони змінюються.

with lux_models(product_slug) as (
  values
    ('catalog-30'), ('catalog-31'), ('catalog-32'), ('catalog-33'),
    ('catalog-34'), ('catalog-35'), ('catalog-36'), ('catalog-37'),
    ('catalog-38'), ('catalog-39')
), lux_specs(label, value, sort_order) as (
  values
    ('Лінійка виробника', 'RODOS Grand', 100),
    ('Тип виробу', 'Міжкімнатні двері', 110),
    ('Стиль колекції', 'Гранж', 120),
    ('Покриття', 'ПВХ Renolit, Німеччина', 130),
    ('Конструкція полотна', 'Два соснові євробруси, МДФ-елементи та дві ламіновані МДФ-плити', 140),
    ('Товщина полотна', '44 мм', 150),
    ('Система погонажу', 'Коробка Lux + 38/38; лиштва та добірні елементи Lux', 160)
), model_leaf_types(product_slug, value) as (
  values
    ('catalog-30', 'Напівскло'),
    ('catalog-39', 'Напівскло')
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from lux_models cross join lux_specs
union all
select product_slug, 'Тип полотна', value, 170
from model_leaf_types
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
