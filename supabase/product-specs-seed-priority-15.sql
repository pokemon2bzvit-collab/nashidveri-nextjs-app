-- Пріоритетний пакет характеристик для 15 моделей із неповними даними.
-- Джерела: офіційні техописи Papa Carlo (Milenium, Plato, Tetra, iDoors)
-- та офіційна картка Abwehr Harmonia City. Перевірено 01.09.2026.
-- Файл не видаляє дані: додає або оновлює лише наведені параметри.

-- Abwehr Harmonia, комплектація City.
insert into public.product_specs (product_slug, label, value, sort_order) values
  ('catalog-1', 'Комплектація', 'City', 10),
  ('catalog-1', 'Призначення', 'Вхідні в квартиру', 20),
  ('catalog-1', 'Товщина полотна', '100 мм', 30),
  ('catalog-1', 'Товщина короба', '110 мм', 40),
  ('catalog-1', 'Утеплення полотна і короба', 'Мінеральна вата', 50),
  ('catalog-1', 'Шумоізоляція', 'Висока, до 44 дБ', 60),
  ('catalog-1', 'Петлі', '3 петлі з кулькою', 70),
  ('catalog-1', 'Антизрізи', '2', 80),
  ('catalog-1', 'Терморозрив', 'Немає', 90)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

-- Papa Carlo ML-62c — модель колекції Milenium.
with models(product_slug) as (values ('catalog-138')),
specs(label, value, sort_order) as (
  values
    ('Базова колекція', 'Milenium', 100),
    ('Дизайн колекції', 'Сучасний і класичний', 110),
    ('Покриття', 'Декоративна плівка RENOLIT на основі поліпропілену, Німеччина', 120),
    ('Система короба', 'Компланарний короб', 130)
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order from models cross join specs
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

-- Papa Carlo PLATO-01, 04, 07, 21, 24 — моделі колекції Plato.
with models(product_slug) as (values ('catalog-139'), ('catalog-140'), ('catalog-141'), ('catalog-142'), ('catalog-143')),
specs(label, value, sort_order) as (
  values
    ('Базова колекція', 'Plato', 100),
    ('Дизайн колекції', 'Сучасний мінімалістичний', 110),
    ('Покриття', 'Декоративна плівка RENOLIT на основі поліпропілену, Німеччина', 120),
    ('Система короба', 'Компланарний або прихований короб', 130),
    ('Варіанти торця полотна', 'Анодований алюмінієвий профіль або кромка ABC', 140)
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order from models cross join specs
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

-- Papa Carlo Prime-AL та Prime-AL INSIDE — приховані двері iDoors.
with model_specs(product_slug, label, value, sort_order) as (
  values
    ('catalog-144', 'Базова колекція', 'iDoors — прихований монтаж', 100),
    ('catalog-144', 'Відкривання', 'Зворотне (INSIDE)', 110),
    ('catalog-144', 'Покриття', 'Плівка RENOLIT під фарбування', 120),
    ('catalog-144', 'Товщина полотна', '46 мм', 130),
    ('catalog-144', 'Торець полотна', 'Анодований алюмінієвий профіль', 140),
    ('catalog-144', 'Короб', 'Прихованого монтажу з анодованого алюмінію', 150),
    ('catalog-144', 'Гарантія виробника', '5 років', 160),
    ('catalog-145', 'Базова колекція', 'iDoors — прихований монтаж', 100),
    ('catalog-145', 'Відкривання', 'Пряме', 110),
    ('catalog-145', 'Покриття', 'Плівка RENOLIT під фарбування', 120),
    ('catalog-145', 'Товщина полотна', '42 мм', 130),
    ('catalog-145', 'Торець полотна', 'Анодований алюмінієвий профіль', 140),
    ('catalog-145', 'Короб', 'Прихованого монтажу з анодованого алюмінію', 150),
    ('catalog-145', 'Гарантія виробника', '5 років', 160)
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order from model_specs
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

-- Papa Carlo T-01, T-02, T-03, T-04, T-12, T-14 — моделі колекції Tetra.
with models(product_slug) as (values ('catalog-146'), ('catalog-147'), ('catalog-148'), ('catalog-149'), ('catalog-150'), ('catalog-151')),
specs(label, value, sort_order) as (
  values
    ('Базова колекція', 'Tetra', 100),
    ('Покриття', 'Декоративне ПВХ-покриття німецького виробництва', 110),
    ('Гарантія виробника', '2 роки', 120),
    ('Стандартна ширина полотна', '610, 710, 810 або 910 мм', 130),
    ('Нестандартний розмір', 'Можливий під замовлення', 140),
    ('Система короба', 'Компланарний короб TTR', 150),
    ('Петлі', 'Накладні «метелик» — 3 шт. або приховані ANSELMI — 2 шт.', 160),
    ('Сумісні замки', 'AGB Polaris або Buonelle магнітний', 170)
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order from models cross join specs
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;
