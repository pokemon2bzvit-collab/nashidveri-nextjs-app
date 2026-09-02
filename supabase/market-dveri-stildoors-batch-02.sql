-- Market Dveri — пакет 02: StilDoors.
-- Додано тільки моделі з точним збігом назви. Скрипт можна запускати повторно.

update public.products as product
set description = source.description
from (values
  ('catalog-73', 'StilDoors Grazia — фарбовані міжкімнатні двері для сучасного інтер''єру. Дерев''яний каркас із МДФ-плитами, полотно 40 мм, телескопічний погонаж і ущільнювач поєднують лаконічний вигляд та комфорт.'),
  ('catalog-74', 'StilDoors Karyon — фарбовані міжкімнатні двері у стилі хай-тек. Дерев''яний каркас з МДФ-плитами, висока шумоізоляція та можливість підрізки полотна до 20 мм полегшують встановлення.'),
  ('catalog-75', 'StilDoors Palladio — фарбовані міжкімнатні двері з сучасним рівним дизайном. Полотно 40 мм, телескопічний погонаж, ущільнювач і висока шумоізоляція створюють практичне рішення для житлових кімнат.'),
  ('catalog-76', 'StilDoors Toledo — фарбовані міжкімнатні двері для стриманого сучасного інтер''єру. Дерев''яний каркас з МДФ-плитами, полотно 40 мм і телескопічний погонаж дають змогу зібрати акуратний дверний блок.'),
  ('catalog-77', 'StilDoors Wilton — фарбовані міжкімнатні двері з чорним склом. Дерев''яний каркас із МДФ-плитами, полотно 40 мм, ущільнювач і телескопічний погонаж поєднують виразний вигляд та комфорт.'),
  ('catalog-82', 'StilDoors London — міжкімнатні двері з ПВХ-покриттям і вертикальним склом. Фільончаста конструкція, полотно 40 мм, телескопічний погонаж і висока шумоізоляція підходять для сучасних інтер''єрів.'),
  ('catalog-83', 'StilDoors Mexico — міжкімнатні двері з ПВХ-покриттям і горизонтальним склом. Полотно 40 мм, ущільнювач, телескопічний погонаж і можливість підрізки до 20 мм створюють зручне рішення для ремонту.'),
  ('catalog-84', 'StilDoors Slovenia — міжкімнатні двері з ПВХ-покриттям і горизонтальним склом. Фільончаста конструкція, полотно 40 мм, ущільнювач та висока шумоізоляція поєднують сучасний дизайн і практичність.')
) as source(slug, description)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-73', 'main', 'StilDoors Grazia', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212995/dveri-stildoors-grazia-main.jpg', 0),
  ('catalog-74', 'main', 'StilDoors Karyon', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212988/dveri-stildoors-karyon-main.jpg', 0),
  ('catalog-75', 'main', 'StilDoors Palladio', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212996/dveri-stildoors-palladio-main.jpg', 0),
  ('catalog-76', 'main', 'StilDoors Toledo', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212994/dveri-stildoors-toledo-main.jpg', 0),
  ('catalog-77', 'main', 'StilDoors Wilton', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212989/dveri-stildoors-wilton-main.jpg', 0),
  ('catalog-82', 'main', 'StilDoors London', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28302/dveri-stildoors-london-main.jpg', 0),
  ('catalog-83', 'main', 'StilDoors Mexico', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28304/dveri-stildoors-mexico-main.jpg', 0),
  ('catalog-84', 'main', 'StilDoors Slovenia', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28308/dveri-stildoors-slovenia-main.jpg', 0)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (select 1 from public.product_media as existing where existing.product_slug = media.product_slug and existing.image_path = media.image_path);

insert into public.product_specs (product_slug, label, value, sort_order)
values
  ('catalog-73', 'Покриття', 'Фарба', 100), ('catalog-73', 'Наповнення', 'Дерев''яний каркас + МДФ-плити', 110), ('catalog-73', 'Скло', 'Глухі', 120), ('catalog-73', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-74', 'Покриття', 'Фарба', 100), ('catalog-74', 'Наповнення', 'Дерев''яний каркас + МДФ-плити', 110), ('catalog-74', 'Скло', 'Глухі', 120), ('catalog-74', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-75', 'Покриття', 'Фарба', 100), ('catalog-75', 'Наповнення', 'Дерев''яний каркас + МДФ-плити', 110), ('catalog-75', 'Скло', 'Глухі', 120), ('catalog-75', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-76', 'Покриття', 'Фарба', 100), ('catalog-76', 'Наповнення', 'Дерев''яний каркас + МДФ-плити', 110), ('catalog-76', 'Скло', 'Глухі', 120), ('catalog-76', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-77', 'Покриття', 'Фарба', 100), ('catalog-77', 'Наповнення', 'Дерев''яний каркас + МДФ-плити', 110), ('catalog-77', 'Скло', 'Чорне скло', 120), ('catalog-77', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-82', 'Покриття', 'ПВХ-плівка', 100), ('catalog-82', 'Наповнення', 'Фільончасті', 110), ('catalog-82', 'Скло', 'Вертикальне скло', 120), ('catalog-82', 'Стиль', 'Модерн, хай-тек', 130),
  ('catalog-83', 'Покриття', 'ПВХ-плівка', 100), ('catalog-83', 'Наповнення', 'Фільончасті', 110), ('catalog-83', 'Скло', 'Горизонтальне скло', 120), ('catalog-83', 'Стиль', 'Модерн, хай-тек', 130),
  ('catalog-84', 'Покриття', 'ПВХ-плівка', 100), ('catalog-84', 'Наповнення', 'Фільончасті', 110), ('catalog-84', 'Скло', 'Горизонтальне скло', 120), ('catalog-84', 'Стиль', 'Модерн, хай-тек', 130)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from unnest(array['catalog-73','catalog-74','catalog-75','catalog-76','catalog-77','catalog-82','catalog-83','catalog-84']) as products(product_slug)
cross join (values
  ('Розміри полотна', '600 / 700 / 800 / 900 мм', 140), ('Висота полотна', '2000 мм', 150), ('Товщина полотна', '40 мм', 160),
  ('Відкривання', 'Розпашні, одностулкові', 170), ('Торець полотна', 'Окутаний без стиків', 180), ('Погонаж', 'Телескопічний', 190),
  ('Можливість підрізки', 'До 20 мм', 200), ('Додатково', 'Ущільнювач', 210), ('Шумоізоляція', 'Висока', 220),
  ('Країна виробник', 'Україна', 230), ('Місто виробник', 'Корюківка', 240)
) as shared(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('catalog-73', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-grazia-stildoors/', 'StilDoors Grazia', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-74', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-karyon-stildoors/', 'StilDoors Karyon', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-75', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-palladio-stildoors/', 'StilDoors Palladio', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-76', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-toledo-stildoors/', 'StilDoors Toledo', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-77', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-wilton-stildoors/', 'StilDoors Wilton', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-82', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-london-stildoors/', 'StilDoors London', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-83', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-mexico-stildoors/', 'StilDoors Mexico', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.'),
  ('catalog-84', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-slovenia-stildoors/', 'StilDoors Slovenia', 'verified', now(), 'Назва моделі, фото та характеристики збігаються.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;
