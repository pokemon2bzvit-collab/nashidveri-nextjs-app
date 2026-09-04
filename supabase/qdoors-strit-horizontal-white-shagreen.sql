-- Q Doors «Стріт Горизонталь»: підтверджене заводське виконання.
-- Джерело: https://qdoors.ua/shop/street-gorizont
-- Перевірено: 04.09.2026.
--
-- УВАГА: офіційна сторінка підтверджує фото саме цього виконання,
-- але прямий URL файлу зображення не публікується стабільно. Тому цей
-- скрипт НЕ підставляє схоже фото й не робить декор доступним для вибору,
-- поки правильний файл не буде додано через адмінку. Це захищає каталог
-- від невідповідності «декор → фото».
-- Скрипт можна запускати повторно.

-- Виправляємо некоректну назву декору на повну заводську.
update public.product_options
set
  label = 'RAL 7021 антрацит + гладь біла шагрень',
  group_label = 'Підтверджені покриття',
  image_path = null,
  is_active = true
where product_slug = 'catalog-55'
  and option_group = 'finish'
  and label = 'Біла шагрень + гладь біла';

-- Уточнюємо опис моделі без прив'язки до єдиного виконання на картці.
update public.products
set description = 'Q Doors Стріт Горизонталь — вхідні двері для приватного будинку. Доступні заводські виконання; актуальну комплектацію та ціну уточнюйте у менеджера.'
where slug = 'catalog-55';

-- Повні характеристики офіційного виконання 7021 антрацит / біла шагрень.
insert into public.product_specs (product_slug, label, value, sort_order)
values
  ('catalog-55', 'Виробник', 'Qdoors, Україна', 100),
  ('catalog-55', 'Серія', 'Стріт', 110),
  ('catalog-55', 'Призначення', 'Вхідні двері для приватного будинку', 120),
  ('catalog-55', 'Підтверджене виконання', 'RAL 7021 антрацит зовні + гладь біла шагрень усередині', 130),
  ('catalog-55', 'Розмір блоку', '850 × 2040 мм або 950 × 2040 мм', 140),
  ('catalog-55', 'Конструкція коробу', 'Гнутий профіль + труба, 140 мм, з терморозривом', 150),
  ('catalog-55', 'Товщина полотна', '100 мм', 160),
  ('catalog-55', 'Товщина металу', '1,5 мм', 170),
  ('catalog-55', 'МДФ-накладки', '16 мм зовні + 16 мм усередині', 180),
  ('catalog-55', 'Тепло- та шумоізоляція', 'Мінеральна вата', 190),
  ('catalog-55', 'Контури ущільнення', '3: 2 на полотні + 1 на коробці', 200),
  ('catalog-55', 'Петлі', '3', 210),
  ('catalog-55', 'Верхній замок', 'Kale, Туреччина', 220),
  ('catalog-55', 'Нижній замок', 'Kale, Туреччина', 230),
  ('catalog-55', 'Циліндр', 'Kale, Туреччина', 240),
  ('catalog-55', 'Ручка', 'Розетка', 250),
  ('catalog-55', 'Додатково', 'Нічна засувка та нержавіючий поріг', 260)
on conflict (product_slug, label) do update
set value = excluded.value,
    sort_order = excluded.sort_order,
    is_active = true;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values (
  'catalog-55',
  'Q Doors',
  'https://qdoors.ua/shop/street-gorizont',
  'Qdoors Стріт 3к ручка 1450 Горизонт / гладь біла шагрень (008), код 1145',
  'verified',
  now(),
  'Офіційна картка підтверджує виконання RAL 7021 антрацит / гладь біла шагрень, характеристики та наявність фото. Для конфігуратора потрібен окремо завантажений правильний файл зображення.'
)
on conflict (product_slug, source_url) do update
set source_name = excluded.source_name,
    source_product_name = excluded.source_product_name,
    verification_status = excluded.verification_status,
    verified_at = excluded.verified_at,
    notes = excluded.notes;
