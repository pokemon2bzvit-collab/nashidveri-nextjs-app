-- Вхідні двері: RODOS Steel, Qdoors та Magda.
-- Джерела: офіційні сайти rodos.ua / rodos.net.ua, qdoors.ua та картки Magda Doors.
-- Перевірено: 29.08.2026. Характеристики, що залежать від комплектації,
-- навмисно позначені як такі, а не подаються як однакові для всіх моделей.

with rodos_street(product_slug) as (
  values
    ('catalog-152'), ('catalog-153'), ('catalog-154'), ('catalog-155'),
    ('catalog-156'), ('catalog-157'), ('catalog-158'), ('catalog-159'),
    ('catalog-160'), ('catalog-161'), ('catalog-162')
), rodos_apartment(product_slug) as (
  values
    ('catalog-163'), ('catalog-164'), ('catalog-165'), ('catalog-166'),
    ('catalog-167'), ('catalog-168'), ('catalog-169'), ('catalog-170'),
    ('catalog-171'), ('catalog-172'), ('catalog-173'), ('catalog-174'),
    ('catalog-175'), ('catalog-176'), ('catalog-177'), ('catalog-178'),
    ('catalog-179')
), qdoors_street(product_slug) as (
  values ('catalog-54'), ('catalog-55'), ('catalog-56'), ('catalog-57'), ('catalog-58'), ('catalog-59')
), qdoors_apartment(product_slug) as (
  values ('catalog-60'), ('catalog-61'), ('catalog-62'), ('catalog-63'), ('catalog-64'), ('catalog-65'), ('catalog-66'), ('catalog-67')
), source_specs(product_slug, label, value, sort_order) as (
  select product_slug, 'Виробник', 'RODOS Steel, Україна', 100 from rodos_street
  union all select product_slug, 'Тип виробу', 'Вхідні двері для приватного будинку', 110 from rodos_street
  union all select product_slug, 'Матеріал основи', 'Холоднокатана листова сталь; товщина залежить від комплектації', 120 from rodos_street
  union all select product_slug, 'Зовнішнє виконання', 'Для вулиці; захисне покриття для експлуатації на відкритому повітрі', 130 from rodos_street
  union all select product_slug, 'Комплектація', 'Замки, фурнітура й товщина металу залежать від обраної моделі', 140 from rodos_street

  union all select product_slug, 'Виробник', 'RODOS Steel, Україна', 100 from rodos_apartment
  union all select product_slug, 'Тип виробу', 'Вхідні двері для квартири', 110 from rodos_apartment
  union all select product_slug, 'Матеріал основи', 'Холоднокатана листова сталь; товщина залежить від комплектації', 120 from rodos_apartment
  union all select product_slug, 'Внутрішня накладка', 'ПВХ; доступні декори наведені у варіантах моделі', 130 from rodos_apartment
  union all select product_slug, 'Комплектація', 'Замки, фурнітура й товщина металу залежать від обраної моделі', 140 from rodos_apartment

  union all select product_slug, 'Виробник', 'Qdoors, Україна', 100 from qdoors_street
  union all select product_slug, 'Тип виробу', 'Вхідні двері для приватного будинку', 110 from qdoors_street
  union all select product_slug, 'Конструкція', 'Сталева конструкція; параметри залежать від моделі та комплектації', 120 from qdoors_street
  union all select product_slug, 'Виконання', 'Підбір кольору зовні та всередині — у межах доступних заводських варіантів', 130 from qdoors_street
  union all select product_slug, 'Фурнітура', 'Європейська фурнітура — залежно від моделі', 140 from qdoors_street

  union all select product_slug, 'Виробник', 'Qdoors, Україна', 100 from qdoors_apartment
  union all select product_slug, 'Тип виробу', 'Вхідні двері для квартири', 110 from qdoors_apartment
  union all select product_slug, 'Конструкція', 'Сталева конструкція; параметри залежать від моделі та комплектації', 120 from qdoors_apartment
  union all select product_slug, 'Виконання', 'Підбір кольору зовні та всередині — у межах доступних заводських варіантів', 130 from qdoors_apartment
  union all select product_slug, 'Фурнітура', 'Європейська фурнітура — залежно від моделі', 140 from qdoors_apartment

  union all select 'catalog-52', 'Виробник', 'Magda, Україна', 100
  union all select 'catalog-52', 'Тип виробу', 'Вхідні двері для приватного будинку', 110
  union all select 'catalog-52', 'Тип конструкції', 'Тип 6.23 з терморозривом або тип 16 — залежно від вибраного виконання', 120
  union all select 'catalog-52', 'Оздоблення', 'Підтверджені поєднання покриттів наведені у варіантах моделі', 130

  union all select 'catalog-53', 'Виробник', 'Magda, Україна', 100
  union all select 'catalog-53', 'Тип виробу', 'Вхідні двері для приватного будинку', 110
  union all select 'catalog-53', 'Тип конструкції', 'Тип 6.23 з терморозривом', 120
  union all select 'catalog-53', 'Оздоблення', 'Підтверджені поєднання покриттів наведені у варіантах моделі', 130
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order from source_specs
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
