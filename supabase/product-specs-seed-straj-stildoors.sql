-- Характеристики моделей Страж і StilDoors з поточного каталогу.
-- Джерела: опис серії Страж PROOF та офіційний каталог StilDoors.
-- Перевірено: 29.08.2026. Значення, що залежать від конкретної моделі або
-- комплектації, прямо позначені в тексті.

with straj_proof_street(product_slug) as (
  values
    ('catalog-256'), ('catalog-257'), ('catalog-258'), ('catalog-259'),
    ('catalog-260'), ('catalog-261'), ('catalog-262'), ('catalog-263'),
    ('catalog-264'), ('catalog-265'), ('catalog-266'), ('catalog-267')
), straj_apartment(product_slug) as (
  values
    ('catalog-268'), ('catalog-269'), ('catalog-270'), ('catalog-271'),
    ('catalog-272'), ('catalog-273'), ('catalog-274'), ('catalog-275'), ('catalog-276')
), straj_stock(product_slug) as (
  values
    ('catalog-277'), ('catalog-278'), ('catalog-279'), ('catalog-280'),
    ('catalog-281'), ('catalog-282'), ('catalog-283'), ('catalog-284'),
    ('catalog-285'), ('catalog-286'), ('catalog-287'), ('catalog-288'),
    ('catalog-289'), ('catalog-290'), ('catalog-291'), ('catalog-292'),
    ('catalog-293'), ('catalog-294')
), stildoors_presto(product_slug) as (
  values
    ('catalog-68'), ('catalog-69'), ('catalog-70'), ('catalog-71'), ('catalog-72'),
    ('catalog-73'), ('catalog-74'), ('catalog-75'), ('catalog-76'), ('catalog-77')
), stildoors_stil(product_slug) as (
  values ('catalog-78'), ('catalog-79'), ('catalog-80'), ('catalog-81'), ('catalog-82'), ('catalog-83'), ('catalog-84')
), source_specs(product_slug, label, value, sort_order) as (
  select product_slug, 'Виробник', 'Страж, Україна', 100 from straj_proof_street
  union all select product_slug, 'Тип виробу', 'Вхідні двері для приватного будинку', 110 from straj_proof_street
  union all select product_slug, 'Серія', 'PROOF', 120 from straj_proof_street
  union all select product_slug, 'Зовнішнє покриття', 'ПВХ Vinorit — атмосферостійке виконання для зовнішніх дверей', 130 from straj_proof_street
  union all select product_slug, 'Конструкція', 'Сталева конструкція; точні параметри залежать від моделі', 140 from straj_proof_street

  union all select product_slug, 'Виробник', 'Страж, Україна', 100 from straj_apartment
  union all select product_slug, 'Тип виробу', 'Вхідні двері для квартири', 110 from straj_apartment
  union all select product_slug, 'Конструкція', 'Сталева конструкція; точні параметри залежать від моделі та комплектації', 120 from straj_apartment
  union all select product_slug, 'Оздоблення', 'Доступні декори та скління — у варіантах конкретної моделі', 130 from straj_apartment

  union all select product_slug, 'Виробник', 'Страж, Україна', 100 from straj_stock
  union all select product_slug, 'Тип виробу', 'Вхідні двері', 110 from straj_stock
  union all select product_slug, 'Доступність', 'Складська модель; наявність і точну комплектацію уточнюйте у менеджера', 120 from straj_stock
  union all select product_slug, 'Конструкція', 'Сталева конструкція; параметри залежать від серії та моделі', 130 from straj_stock

  union all select product_slug, 'Виробник', 'StilDoors, Україна', 100 from stildoors_presto
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from stildoors_presto
  union all select product_slug, 'Колекція', 'Presto', 120 from stildoors_presto
  union all select product_slug, 'Покриття', 'Фарбоване', 130 from stildoors_presto
  union all select product_slug, 'Конструкція полотна', 'Щитова; товщина полотна 40 мм', 140 from stildoors_presto
  union all select product_slug, 'Доступні розміри', '600, 700, 800 або 900 × 2000 мм', 150 from stildoors_presto
  union all select product_slug, 'Скло / молдинг', 'Залежить від моделі', 160 from stildoors_presto

  union all select product_slug, 'Виробник', 'StilDoors, Україна', 100 from stildoors_stil
  union all select product_slug, 'Тип виробу', 'Міжкімнатні двері', 110 from stildoors_stil
  union all select product_slug, 'Колекція', 'Stil', 120 from stildoors_stil
  union all select product_slug, 'Покриття', 'Ламіноване', 130 from stildoors_stil
  union all select product_slug, 'Призначення', 'Житлові та комерційні інтер’єри', 140 from stildoors_stil
  union all select product_slug, 'Скло / декор', 'Залежить від моделі', 150 from stildoors_stil
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order from source_specs
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
