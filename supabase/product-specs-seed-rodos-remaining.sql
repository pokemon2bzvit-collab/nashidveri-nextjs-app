-- RODOS: решта колекцій (Atlantic, Style, Loft, Siena, Royal).
-- Джерело: офіційний каталог і картки товарів rodos.net.ua.
-- Перевірено: 29.08.2026. Ціни навмисно не додаються — вони змінюються.

with atlantic_models(product_slug) as (
  values
    ('catalog-180'), ('catalog-181'), ('catalog-182'), ('catalog-183'),
    ('catalog-184'), ('catalog-185'), ('catalog-186'), ('catalog-187'),
    ('catalog-188'), ('catalog-189'), ('catalog-190'), ('catalog-191'),
    ('catalog-192'), ('catalog-193')
), style_models(product_slug) as (
  values
    ('catalog-246'), ('catalog-247'), ('catalog-248'), ('catalog-249'),
    ('catalog-250'), ('catalog-251'), ('catalog-252'), ('catalog-253'),
    ('catalog-254'), ('catalog-255')
), loft_paint_models(product_slug) as (
  values
    ('catalog-216'), ('catalog-217'), ('catalog-218'), ('catalog-219'),
    ('catalog-220'), ('catalog-221'), ('catalog-222'), ('catalog-223'),
    ('catalog-224'), ('catalog-225'), ('catalog-226'), ('catalog-227'),
    ('catalog-228'), ('catalog-229'), ('catalog-230'), ('catalog-231'),
    ('catalog-232'), ('catalog-233'), ('catalog-234'), ('catalog-235'),
    ('catalog-236')
), siena_models(product_slug) as (
  values
    ('catalog-240'), ('catalog-241'), ('catalog-242'),
    ('catalog-243'), ('catalog-244'), ('catalog-245')
), royal_models(product_slug) as (
  values ('catalog-238'), ('catalog-239')
), loft_veneer_models(product_slug) as (
  values ('catalog-237')
), source_specs(product_slug, label, value, sort_order) as (
  select product_slug, 'Виробник', 'RODOS, Україна', 100 from atlantic_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from atlantic_models
  union all select product_slug, 'Покриття', 'ПВХ', 120 from atlantic_models

  union all select product_slug, 'Виробник', 'RODOS, Україна', 100 from style_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from style_models
  union all select product_slug, 'Покриття', 'ПВХ', 120 from style_models

  union all select product_slug, 'Виробник', 'RODOS, Україна', 100 from loft_paint_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from loft_paint_models
  union all select product_slug, 'Покриття', 'Пофарбовані двері', 120 from loft_paint_models
  union all select product_slug, 'Варіанти кольору', 'Білий мат; доступне фарбування у вибрані кольори RAL', 130 from loft_paint_models

  union all select product_slug, 'Виробник', 'RODOS, Україна', 100 from siena_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from siena_models
  union all select product_slug, 'Стиль колекції', 'Класичний', 120 from siena_models
  union all select product_slug, 'Покриття', 'Пофарбоване дерев’яне полотно', 130 from siena_models
  union all select product_slug, 'Товщина полотна', '44 мм', 140 from siena_models
  union all select product_slug, 'Доступні розміри полотна', '600 × 2000, 700 × 2000, 800 × 2000 або 900 × 2000 мм; можливе індивідуальне виготовлення', 150 from siena_models

  union all select product_slug, 'Виробник', 'RODOS, Україна', 100 from royal_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from royal_models
  union all select product_slug, 'Покриття', 'Натуральний шпон', 120 from royal_models

  union all select product_slug, 'Виробник', 'RODOS, Україна', 100 from loft_veneer_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from loft_veneer_models
  union all select product_slug, 'Покриття', 'Натуральний шпон', 120 from loft_veneer_models
), model_leaf_types(product_slug, value) as (
  values
    ('catalog-180', 'Скло'), ('catalog-181', 'Глухе'),
    ('catalog-182', 'Глухе'), ('catalog-183', 'Напівскло'),
    ('catalog-184', 'Скло'), ('catalog-185', 'Глухе'),
    ('catalog-186', 'Напівскло'), ('catalog-187', 'Глухе'),
    ('catalog-188', 'Напівскло'), ('catalog-189', 'Скло'),
    ('catalog-190', 'Глухе'), ('catalog-191', 'Скло'),
    ('catalog-192', 'Глухе'), ('catalog-193', 'Скло'),
    ('catalog-216', 'Глухе'), ('catalog-217', 'Глухе'),
    ('catalog-218', 'Глухе'), ('catalog-222', 'Глухе'),
    ('catalog-224', 'Глухе'), ('catalog-232', 'Напівскло'),
    ('catalog-236', 'Глухе'),
    ('catalog-240', 'Скло'), ('catalog-241', 'Глухе'),
    ('catalog-242', 'Скло'), ('catalog-243', 'Глухе'),
    ('catalog-244', 'Скло'), ('catalog-245', 'Глухе'),
    ('catalog-238', 'Скло'), ('catalog-239', 'Глухе')
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from source_specs
union all
select product_slug, 'Тип полотна', value, 200
from model_leaf_types
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
