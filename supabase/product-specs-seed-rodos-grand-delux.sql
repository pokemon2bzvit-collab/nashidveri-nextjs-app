-- RODOS Grand DELUX: підтверджені характеристики колекції.
-- Джерело: офіційні картки товарів і каталог RODOS Grand DELUX на rodos.net.ua.
-- Перевірено: 29.08.2026. Ціни навмисно не додаються — вони змінюються.

with delux_models(product_slug) as (
  values
    ('catalog-15'), ('catalog-16'), ('catalog-17'), ('catalog-18'),
    ('catalog-19'), ('catalog-20'), ('catalog-21'), ('catalog-22'),
    ('catalog-23'), ('catalog-24'), ('catalog-25'), ('catalog-26'),
    ('catalog-27'), ('catalog-28'), ('catalog-29')
), delux_specs(label, value, sort_order) as (
  values
    ('Лінійка виробника', 'RODOS Grand', 100),
    ('Тип виробу', 'Міжкімнатні двері', 110),
    ('Покриття', 'ПВХ Renolit, Німеччина', 120),
    ('Доступні розміри полотна', '600 × 2000, 700 × 2000, 800 × 2000 або 900 × 2000 мм', 130),
    ('Система погонажу', 'Коробка Delux + 38/80/2000; лиштва та добірні елементи Delux', 140)
), model_leaf_types(product_slug, value) as (
  values
    ('catalog-15', 'Глухе'),
    ('catalog-16', 'Напівскло'),
    ('catalog-17', 'Напівскло'),
    ('catalog-19', 'Глухе'),
    ('catalog-20', 'Глухе'),
    ('catalog-28', 'Напівскло'),
    ('catalog-29', 'Глухе')
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from delux_models cross join delux_specs
union all
select product_slug, 'Тип полотна', value, 150
from model_leaf_types
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
