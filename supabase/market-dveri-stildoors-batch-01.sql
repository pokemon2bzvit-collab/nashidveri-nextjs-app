-- Market Dveri — пакет 01: StilDoors.
-- Додано тільки моделі з точним збігом назви. Окремі фото чорного скла
-- не додаються як декори, бо їхня сумісність з поточною комплектацією не підтверджена.
-- Скрипт можна безпечно запускати повторно.

update public.products as product
set description = source.description
from (values
  ('catalog-68', 'StilDoors Aura — фарбовані міжкімнатні двері в сучасному лаконічному дизайні. Дерев''яний каркас із МДФ-плитами, полотно 40 мм та телескопічний погонаж створюють практичне рішення для житлового інтер''єру.'),
  ('catalog-69', 'StilDoors Avanti — фарбовані міжкімнатні двері з гладким сучасним дизайном. Дерев''яний каркас, МДФ-плити, висока шумоізоляція та можливість підрізки полотна до 20 мм полегшують підбір для ремонту.'),
  ('catalog-70', 'StilDoors Diamond — фарбовані міжкімнатні двері у стриманому хай-тек стилі. Фільончасте наповнення, полотно 40 мм, телескопічний погонаж і ущільнювач забезпечують комфорт у щоденному користуванні.'),
  ('catalog-71', 'StilDoors Elegante — фарбовані міжкімнатні двері для сучасного інтер''єру. Дерев''яний каркас з МДФ-плитами, полотно 40 мм та висока шумоізоляція поєднують акуратний вигляд і практичність.'),
  ('catalog-72', 'StilDoors Fargo — фарбовані міжкімнатні двері у стилі хай-тек. Фільончаста конструкція, ущільнювач, телескопічний погонаж і можливість підрізки полотна до 20 мм допомагають точно адаптувати модель до отвору.'),
  ('catalog-78', 'StilDoors Arizona — міжкімнатні двері з ПВХ-покриттям і вертикальним склом. Полотно 40 мм, телескопічний погонаж та ущільнювач роблять модель практичним рішенням для сучасного простору.'),
  ('catalog-80', 'StilDoors Cuba — міжкімнатні двері з ПВХ-покриттям і горизонтальним склом. Фільончаста конструкція, полотно 40 мм, телескопічний погонаж та висока шумоізоляція створюють комфортний вибір для оселі.'),
  ('catalog-81', 'StilDoors Florida — міжкімнатні двері з ПВХ-покриттям і горизонтальним склом. Полотно 40 мм, ущільнювач, телескопічний погонаж і можливість підрізки допомагають адаптувати модель до вашого інтер''єру.')
) as source(slug, description)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-68', 'main', 'StilDoors Aura', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212993/dveri-stildoors-aura-main.jpg', 0),
  ('catalog-69', 'main', 'StilDoors Avanti', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212990/dveri-stildoors-avanti-main.jpg', 0),
  ('catalog-70', 'main', 'StilDoors Diamond', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212997/dveri-stildoors-diamond-main.jpg', 0),
  ('catalog-71', 'main', 'StilDoors Elegante', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212992/dveri-stildoors-elegante-main.jpg', 0),
  ('catalog-72', 'main', 'StilDoors Fargo', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212991/dveri-stildoors-fargo-main.jpg', 0),
  ('catalog-78', 'main', 'StilDoors Arizona', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28299/dveri-stildoors-arizona-main.jpg', 0),
  ('catalog-80', 'main', 'StilDoors Cuba', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212855/dveri-stildoors-cuba-main.jpg', 0),
  ('catalog-81', 'main', 'StilDoors Florida', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212854/dveri-stildoors-florida-main.jpg', 0)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1 from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);

insert into public.product_specs (product_slug, label, value, sort_order)
values
  ('catalog-68', 'Покриття', 'Фарба', 100), ('catalog-68', 'Наповнення', 'Дерев''яний каркас + МДФ-плити', 110), ('catalog-68', 'Скло', 'Глухі', 120), ('catalog-68', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-69', 'Покриття', 'Фарба', 100), ('catalog-69', 'Наповнення', 'Дерев''яний каркас + МДФ-плити', 110), ('catalog-69', 'Скло', 'Глухі', 120), ('catalog-69', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-70', 'Покриття', 'Фарба', 100), ('catalog-70', 'Наповнення', 'Фільончасті', 110), ('catalog-70', 'Скло', 'Глухі', 120), ('catalog-70', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-71', 'Покриття', 'Фарба', 100), ('catalog-71', 'Наповнення', 'Дерев''яний каркас + МДФ-плити', 110), ('catalog-71', 'Скло', 'Глухі', 120), ('catalog-71', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-72', 'Покриття', 'Фарба', 100), ('catalog-72', 'Наповнення', 'Фільончасті', 110), ('catalog-72', 'Скло', 'Глухі', 120), ('catalog-72', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-78', 'Покриття', 'ПВХ-плівка', 100), ('catalog-78', 'Наповнення', 'Фільончасті', 110), ('catalog-78', 'Скло', 'Вертикальне скло', 120), ('catalog-78', 'Стиль', 'Модерн, хай-тек', 130),
  ('catalog-80', 'Покриття', 'ПВХ-плівка', 100), ('catalog-80', 'Наповнення', 'Фільончасті', 110), ('catalog-80', 'Скло', 'Горизонтальне скло', 120), ('catalog-80', 'Стиль', 'Модерн, хай-тек', 130),
  ('catalog-81', 'Покриття', 'ПВХ-плівка', 100), ('catalog-81', 'Наповнення', 'Фільончасті', 110), ('catalog-81', 'Скло', 'Горизонтальне скло', 120), ('catalog-81', 'Стиль', 'Модерн, хай-тек', 130)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from unnest(array['catalog-68','catalog-69','catalog-70','catalog-71','catalog-72','catalog-78','catalog-80','catalog-81']) as products(product_slug)
cross join (values
  ('Розміри полотна', '600 / 700 / 800 / 900 мм', 140),
  ('Висота полотна', '2000 мм', 150),
  ('Товщина полотна', '40 мм', 160),
  ('Відкривання', 'Розпашні, одностулкові', 170),
  ('Торець полотна', 'Окутаний без стиків', 180),
  ('Погонаж', 'Телескопічний', 190),
  ('Можливість підрізки', 'До 20 мм', 200),
  ('Додатково', 'Ущільнювач', 210),
  ('Шумоізоляція', 'Висока', 220),
  ('Країна виробник', 'Україна', 230),
  ('Місто виробник', 'Корюківка', 240)
) as shared(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('catalog-68', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-aura-stildoors/', 'StilDoors Aura', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-69', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-avanti-stildoors/', 'StilDoors Avanti', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-70', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-diamond-stildoors/', 'StilDoors Diamond', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-71', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-elegante-stildoors/', 'StilDoors Elegante', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-72', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-fargo-stildoors/', 'StilDoors Fargo', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-78', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-arizona-stildoors/', 'StilDoors Arizona', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-80', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-cuba-stildoors/', 'StilDoors Cuba', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-81', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-florida-stildoors/', 'StilDoors Florida', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;
