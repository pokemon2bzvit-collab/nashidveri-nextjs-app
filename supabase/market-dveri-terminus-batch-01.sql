-- Market Dveri — пакет 01: Terminus.
-- Додано лише моделі з точним збігом номера та колекції.
-- Скрипт можна безпечно запускати повторно.

update public.products as product
set description = source.description
from (values
  ('catalog-300', 'Термінус Elit Plus 109 — міжкімнатні двері з ПВХ-покриттям і горизонтальним склом. Фільончаста конструкція, полотно 40 мм, телескопічний погонаж і ущільнювач створюють зручне рішення для сучасного інтер''єру.'),
  ('catalog-301', 'Термінус Elit Plus 111 — міжкімнатні двері з ПВХ-покриттям і горизонтальним склом. Полотно 40 мм, фільончасте наповнення, телескопічний погонаж та можливість підрізки до 20 мм полегшують монтаж.'),
  ('catalog-302', 'Термінус Elit Plus 112 — міжкімнатні двері з ПВХ-покриттям і горизонтальним склом. Фільончаста конструкція, ущільнювач, полотно 40 мм і телескопічний погонаж поєднують сучасний вигляд і практичність.'),
  ('catalog-308', 'Термінус Frezato 29 — фарбовані міжкімнатні двері в сучасному дизайні. МДФ-плити на каркасі, полотно 44 мм, телескопічний або компланарний погонаж і приховані петлі підкреслюють акуратність конструкції.'),
  ('catalog-309', 'Термінус Frezato 704 — фарбовані міжкімнатні двері у стилі модерн. Полотно 44 мм з МДФ-плитами на каркасі, приховані петлі та телескопічний або компланарний погонаж створюють лаконічне рішення для інтер''єру.'),
  ('catalog-321', 'Термінус Frezato 708 — фарбовані міжкімнатні двері у стилі модерн. МДФ-плити на каркасі, полотно 44 мм, приховані петлі та телескопічний або компланарний погонаж дають змогу зібрати сучасний дверний блок.'),
  ('catalog-322', 'Термінус Frezato 714 — фарбовані міжкімнатні двері з полотном 44 мм. МДФ-плити на каркасі, приховані петлі та телескопічний або компланарний погонаж поєднують мінімалістичний дизайн і практичність.'),
  ('catalog-323', 'Термінус Frezato 715 — фарбовані міжкімнатні двері з полотном 44 мм. Конструкція з МДФ-плитами на каркасі, прихованими петлями та телескопічним або компланарним погонажем доповнить сучасний простір.')
) as source(slug, description)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-300', 'main', 'Термінус Elit Plus 109', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24081/dveri-terminus-elit-plus-109-main.jpg', 0),
  ('catalog-301', 'main', 'Термінус Elit Plus 111', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24082/dveri-terminus-elit-plus-111-main.jpg', 0),
  ('catalog-302', 'main', 'Термінус Elit Plus 112', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24083/dveri-terminus-elit-plus-112-main.jpg', 0),
  ('catalog-308', 'main', 'Термінус Frezato 29', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215330/dveri-terminus-frezato-29-main.jpg', 0),
  ('catalog-309', 'main', 'Термінус Frezato 704', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27129/dveri-terminus-frezato-704-main.jpg', 0),
  ('catalog-321', 'main', 'Термінус Frezato 708', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27141/dveri-terminus-frezato-708-main.jpg', 0),
  ('catalog-322', 'main', 'Термінус Frezato 714', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215331/dveri-terminus-frezato-714-main.jpg', 0),
  ('catalog-323', 'main', 'Термінус Frezato 715', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215332/dveri-terminus-frezato-715-main.jpg', 0)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (select 1 from public.product_media as existing where existing.product_slug = media.product_slug and existing.image_path = media.image_path);

insert into public.product_specs (product_slug, label, value, sort_order)
values
  ('catalog-300', 'Покриття', 'ПВХ-плівка', 100), ('catalog-300', 'Наповнення', 'Фільончасті', 110), ('catalog-300', 'Скло', 'Горизонтальне скло', 120), ('catalog-300', 'Стиль', 'Модерн, хай-тек', 130),
  ('catalog-301', 'Покриття', 'ПВХ-плівка', 100), ('catalog-301', 'Наповнення', 'Фільончасті', 110), ('catalog-301', 'Скло', 'Горизонтальне скло', 120), ('catalog-301', 'Стиль', 'Модерн, хай-тек', 130),
  ('catalog-302', 'Покриття', 'ПВХ-плівка', 100), ('catalog-302', 'Наповнення', 'Фільончасті', 110), ('catalog-302', 'Скло', 'Горизонтальне скло', 120), ('catalog-302', 'Стиль', 'Модерн, хай-тек', 130),
  ('catalog-308', 'Покриття', 'Фарба', 100), ('catalog-308', 'Наповнення', 'МДФ-плити на каркасі', 110), ('catalog-308', 'Скло', 'Глухі', 120), ('catalog-308', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-309', 'Покриття', 'Фарба', 100), ('catalog-309', 'Наповнення', 'МДФ-плити на каркасі', 110), ('catalog-309', 'Скло', 'Глухі', 120), ('catalog-309', 'Стиль', 'Модерн, хай-тек', 130),
  ('catalog-321', 'Покриття', 'Фарба', 100), ('catalog-321', 'Наповнення', 'МДФ-плити на каркасі', 110), ('catalog-321', 'Скло', 'Глухі', 120), ('catalog-321', 'Стиль', 'Модерн, хай-тек', 130),
  ('catalog-322', 'Покриття', 'Фарба', 100), ('catalog-322', 'Наповнення', 'МДФ-плити на каркасі', 110), ('catalog-322', 'Скло', 'Глухі', 120), ('catalog-322', 'Стиль', 'Щитові, хай-тек', 130),
  ('catalog-323', 'Покриття', 'Фарба', 100), ('catalog-323', 'Наповнення', 'МДФ-плити на каркасі', 110), ('catalog-323', 'Скло', 'Глухі', 120), ('catalog-323', 'Стиль', 'Щитові, хай-тек', 130)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from unnest(array['catalog-300','catalog-301','catalog-302']) as products(product_slug)
cross join (values
  ('Розміри полотна', '600 / 700 / 800 / 900 мм', 140), ('Висота полотна', '2000 мм', 150), ('Товщина полотна', '40 мм', 160),
  ('Відкривання', 'Розпашні, одностулкові', 170), ('Торець полотна', 'Окутаний без стиків', 180), ('Погонаж', 'Телескопічний', 190),
  ('Можливість підрізки', 'До 20 мм', 200), ('Додатково', 'Ущільнювач', 210), ('Шумоізоляція', 'Середня', 220),
  ('Країна виробник', 'Україна', 230), ('Місто виробник', 'Вінниця', 240)
) as shared(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from unnest(array['catalog-308','catalog-309','catalog-321','catalog-322','catalog-323']) as products(product_slug)
cross join (values
  ('Розміри полотна', '600 / 700 / 800 / 900 мм', 140), ('Висота полотна', '2000 мм', 150), ('Товщина полотна', '44 мм', 160),
  ('Відкривання', 'Розпашні, одностулкові', 170), ('Торець полотна', 'Окутаний без стиків', 180), ('Погонаж', 'Телескопічний, компланарний', 190),
  ('Можливість підрізки', 'Немає', 200), ('Додатково', 'Приховані петлі', 210), ('Шумоізоляція', 'Середня', 220),
  ('Країна виробник', 'Україна', 230), ('Місто виробник', 'Вінниця', 240)
) as shared(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('catalog-300', 'Market Dveri', 'https://market-dveri.ua/uk/109-24081/', 'Terminus Elit Plus 109', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-301', 'Market Dveri', 'https://market-dveri.ua/uk/111-24082/', 'Terminus Elit Plus 111', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-302', 'Market Dveri', 'https://market-dveri.ua/uk/112-24083/', 'Terminus Elit Plus 112', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-308', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-29-terminus/', 'Terminus Frezato 29', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-309', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-704-terminus/', 'Terminus Frezato 704', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-321', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-708-terminus/', 'Terminus Frezato 708', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-322', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-714-terminus/', 'Terminus Frezato 714', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-323', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-715-terminus/', 'Terminus Frezato 715', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;
