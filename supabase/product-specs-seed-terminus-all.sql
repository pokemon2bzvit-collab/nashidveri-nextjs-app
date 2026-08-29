-- TERMINUS: характеристики всіх колекцій із поточного каталогу.
-- Джерело: офіційний каталог TERMINUS.UA.
-- Перевірено: 29.08.2026. Ціни навмисно не додаються — вони змінюються.

with frezato_models(product_slug) as (
  values
    ('catalog-303'), ('catalog-304'), ('catalog-305'), ('catalog-306'),
    ('catalog-307'), ('catalog-308'), ('catalog-309'), ('catalog-310'),
    ('catalog-311'), ('catalog-312'), ('catalog-313'), ('catalog-314'),
    ('catalog-315'), ('catalog-316'), ('catalog-317'), ('catalog-318'),
    ('catalog-319'), ('catalog-320'), ('catalog-321'), ('catalog-322'),
    ('catalog-323')
), light_models(product_slug) as (
  values
    ('catalog-324'), ('catalog-325'), ('catalog-326'), ('catalog-327'),
    ('catalog-328'), ('catalog-329'), ('catalog-330'), ('catalog-331'),
    ('catalog-332'), ('catalog-333'), ('catalog-334'), ('catalog-335'),
    ('catalog-336'), ('catalog-337'), ('catalog-338'), ('catalog-339'),
    ('catalog-340')
), neo_models(product_slug) as (
  values
    ('catalog-341'), ('catalog-342'), ('catalog-343'), ('catalog-344'),
    ('catalog-345'), ('catalog-346'), ('catalog-347'), ('catalog-348'),
    ('catalog-349'), ('catalog-350'), ('catalog-351'), ('catalog-352')
), solid_models(product_slug) as (
  values
    ('catalog-353'), ('catalog-354'), ('catalog-355'), ('catalog-356'),
    ('catalog-357'), ('catalog-358'), ('catalog-359'), ('catalog-360'),
    ('catalog-361'), ('catalog-362'), ('catalog-363')
), caro_models(product_slug) as (
  values ('catalog-295'), ('catalog-296'), ('catalog-297'), ('catalog-298'), ('catalog-299')
), elit_plus_models(product_slug) as (
  values ('catalog-300'), ('catalog-301'), ('catalog-302')
), source_specs(product_slug, label, value, sort_order) as (
  select product_slug, 'Виробник', 'TERMINUS, Україна', 100 from frezato_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from frezato_models
  union all select product_slug, 'Покриття', 'Емаль на водній основі', 120 from frezato_models
  union all select product_slug, 'Конструкція полотна', 'Щитове полотно: зрощена соснова рейка та сотове наповнення', 130 from frezato_models
  union all select product_slug, 'Погонаж', 'Зовнішня компланарна лиштва та внутрішня телескопічна', 140 from frezato_models
  union all select product_slug, 'Доступні розміри полотна', '400, 600, 700, 800 або 900 × 2000 мм', 150 from frezato_models
  union all select product_slug, 'Гарантія виробника', '5 років', 160 from frezato_models
  union all select product_slug, 'Тип полотна', 'Глухе', 170 from frezato_models

  union all select product_slug, 'Виробник', 'TERMINUS, Україна', 100 from light_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from light_models
  union all select product_slug, 'Стиль колекції', 'Мінімалізм', 120 from light_models
  union all select product_slug, 'Покриття', 'Плівкове', 130 from light_models
  union all select product_slug, 'Варіанти оздоблення', 'Виконання зі вставкою чорного скла або алюмінієвим молдингом — залежно від моделі', 140 from light_models

  union all select product_slug, 'Виробник', 'TERMINUS, Україна', 100 from neo_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from neo_models
  union all select product_slug, 'Стиль колекції', 'Сучасна класика', 120 from neo_models
  union all select product_slug, 'Покриття', 'Поліпропілен або Nanoflex', 130 from neo_models
  union all select product_slug, 'Властивості покриття', 'Стійке до подряпин, легких ударів і вологи', 140 from neo_models

  union all select product_slug, 'Виробник', 'TERMINUS, Україна', 100 from solid_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from solid_models
  union all select product_slug, 'Стиль колекції', 'Мінімалізм і модерн', 120 from solid_models
  union all select product_slug, 'Покриття', 'ПВХ', 130 from solid_models
  union all select product_slug, 'Конструкція полотна', 'Щитове полотно', 140 from solid_models

  union all select product_slug, 'Виробник', 'TERMINUS, Україна', 100 from caro_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from caro_models
  union all select product_slug, 'Колекція', 'Преміальна серія CARO', 120 from caro_models
  union all select product_slug, 'Стиль колекції', 'Класичний', 130 from caro_models
  union all select product_slug, 'Конструкція полотна', 'Каркасно-фільончаста: зрощений брус хвойних порід і МДФ-фільонки', 140 from caro_models
  union all select product_slug, 'Оздоблення', 'Натуральний шпон дуба, ясена або американського горіха', 150 from caro_models
  union all select product_slug, 'Додаткові опції', 'Нестандартний розмір, розсувна система, фабрична врізка фурнітури', 160 from caro_models

  union all select product_slug, 'Виробник', 'TERMINUS, Україна', 100 from elit_plus_models
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from elit_plus_models
  union all select product_slug, 'Стиль колекції', 'Хай-тек', 120 from elit_plus_models
  union all select product_slug, 'Конструкція полотна', 'Збірна конструкція з підвищеною міцністю фільонок', 130 from elit_plus_models
  union all select product_slug, 'Покриття', 'Однотонне поліпропіленове RENOLIT, Німеччина', 140 from elit_plus_models
  union all select product_slug, 'Варіанти кольору', 'Білий, сірий, магнолія або антрацит', 150 from elit_plus_models
  union all select product_slug, 'Скло', 'Залежить від моделі; товщина скла 4 мм', 160 from elit_plus_models
), model_leaf_types(product_slug, value) as (
  values
    ('catalog-341', 'Глухе'), ('catalog-342', 'Глухе'),
    ('catalog-344', 'Засклене'), ('catalog-345', 'Засклене'),
    ('catalog-346', 'Засклене'), ('catalog-347', 'Засклене'),
    ('catalog-348', 'Глухе'), ('catalog-350', 'Засклене'),
    ('catalog-300', 'Засклене'), ('catalog-301', 'Глухе')
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
