-- Market Dveri — Abwehr: 14 точних моделей каталогу.
-- Скрипт безпечно запускати повторно. Ціни не імпортуються.

update public.products as product
set description = source.description
from (values
  ('catalog-1', 'Abwehr Harmonia — вхідні двері для квартири із МДФ-накладками з обох боків. Полотно 100 мм, короб 110 мм, три контури примикання та нижній замок Mottura поєднують захист, тепло й шумоізоляцію.'),
  ('catalog-2', 'Abwehr Limana — сучасні вхідні двері для квартири з МДФ-накладками. Конструкція з полотном 100 мм, коробом 110 мм, трьома контурами примикання та замками Securemme.'),
  ('catalog-3', 'Abwehr Melany — квартирні вхідні двері в стилі модерн. МДФ-накладки з обох боків, гнутий профіль коробу, полотно 100 мм і замки Securemme для щоденного комфорту та безпеки.'),
  ('catalog-4', 'Abwehr Mira — квартирні вхідні двері в стилі модерн із дзеркалом. МДФ-накладки, три контури примикання, полотно 100 мм і замки Securemme.'),
  ('catalog-5', 'Abwehr Rain — вхідні двері для квартири з антрацитовим оздобленням, МДФ-накладками, трьома контурами примикання та замками Securemme.'),
  ('catalog-6', 'Abwehr Riviera — сучасні вхідні двері для квартири з МДФ-накладками світлого декору. Полотно 100 мм, гнутий профіль коробу та замки Kale.'),
  ('catalog-7', 'Abwehr Selena — квартирні вхідні двері з антрацитовим оздобленням і дзеркалом. МДФ-накладки, три контури примикання, полотно 100 мм та замки Securemme.'),
  ('catalog-8', 'Abwehr Stella — сучасні квартирні вхідні двері з МДФ-накладками темного декору. Три контури примикання, полотно 100 мм і замки Securemme.'),
  ('catalog-9', 'Abwehr Avenue — вуличні двері TERMIX із терморозривом. МДФ-накладки, метал 2 мм, полотно 100 мм, три контури примикання та нержавіючий поріг.'),
  ('catalog-10', 'Abwehr Carat — вуличні двері TERMIX із терморозривом і металевим зовнішнім оздобленням. Метал 2 мм, полотно 100 мм, три контури примикання та нержавіючий поріг.'),
  ('catalog-11', 'Abwehr Queen — вуличні двері NEW Bionica з терморозривом, металевим оздобленням LAMPRE та ручкою-трубою. Короб 150 мм, полотно 104 мм і замки Kale.'),
  ('catalog-12', 'Abwehr Revolution — вуличні двері TERMIX із терморозривом, металевим зовнішнім оздобленням і ручкою-трубою. Метал 2 мм, полотно 100 мм та три контури примикання.'),
  ('catalog-13', 'Abwehr Tower 1200 — вуличні двері TERMIX із терморозривом для широкого прорізу 1200 × 2050 мм. Метал 2 мм, полотно 100 мм і три контури примикання.'),
  ('catalog-14', 'Abwehr Tower — вуличні двері TERMIX із терморозривом, МДФ-накладками, металом 2 мм, полотном 100 мм і трьома контурами примикання.')
) as source(slug, description)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order) values
  ('catalog-1', 'main', 'Abwehr Harmonia', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/212624/dveri-city-mg3-ct-546-0-harmonia-abwehr-main.jpg', 0),
  ('catalog-2', 'main', 'Abwehr Limana', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/26734/dveri-megapolis-mg3-443-limana-abwehr-main.jpg', 0),
  ('catalog-3', 'main', 'Abwehr Melany', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/219239/dveri-megapolis-mg3-573-558-melany-abwehr-main.jpg', 0),
  ('catalog-4', 'main', 'Abwehr Mira з дзеркалом', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/212621/dveri-megapolis-mg3-549-544-mira-z-dzerkalom-abwehr-main.jpg', 0),
  ('catalog-5', 'main', 'Abwehr Rain', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/10040/dveri-megapolis-mg3-516-517-rain-abwehr-main.jpg', 0),
  ('catalog-6', 'main', 'Abwehr Riviera', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/219243/dveri-megapolis-mg3-572-0-riviera-abwehr-main.jpg', 0),
  ('catalog-7', 'main', 'Abwehr Selena з дзеркалом', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/219238/dveri-megapolis-mg3-583-544-selena-abwehr-main.jpg', 0),
  ('catalog-8', 'main', 'Abwehr Stella', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/10039/dveri-megapolis-mg3-515-0-stella-abwehr-main.jpg', 0),
  ('catalog-9', 'main', 'Abwehr Avenue', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/211716/dveri-termix-z-termorozrivom-537-avenue-abwehr-main.jpg', 0),
  ('catalog-10', 'main', 'Abwehr Carat', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/219232/dveri-termix-z-termorozrivom-536-carat-abwehr-main.jpg', 0),
  ('catalog-11', 'main', 'Abwehr Queen', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/219231/dveri-new-cottage-z-metalom-lampre-kt-n-lp-5-queen-abwehr-main.jpg', 0),
  ('catalog-12', 'main', 'Abwehr Revolution', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/219233/dveri-termix-z-termorozrivom-revolution-lp-6-abwehr-main.jpg', 0),
  ('catalog-13', 'main', 'Abwehr Tower 1200', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/213631/dveri-termix-z-termorozrivom-tower-527-1200-abwehr-main.jpg', 0),
  ('catalog-14', 'main', 'Abwehr Tower', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/abwehr/210441/dveri-termix-z-termorozrivom-tower-527-abwehr-main.jpg', 0)
on conflict (product_slug, kind, image_path) do update
set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from unnest(array['catalog-1','catalog-2','catalog-3','catalog-4','catalog-5','catalog-6','catalog-7','catalog-8']) as models(product_slug)
cross join (values
  ('Призначення', 'Для квартири', 100),
  ('Розмір блоку', '860 / 960 × 2050 мм', 110),
  ('Оздоблення', 'МДФ-накладки', 120),
  ('Тип оздоблення', 'МДФ-МДФ', 130),
  ('Стиль', 'Модерн', 140),
  ('Відкривання', 'Ліве або праве', 150),
  ('Глибина коробу', '110 мм', 160),
  ('Товщина полотна', '100 мм', 170),
  ('Товщина металу', '1,5 мм', 180),
  ('Конструкція коробу', 'Гнутий профіль', 190),
  ('Контури примикання', '3 контури', 200),
  ('Шумоізоляція', 'Високий рівень', 210),
  ('Теплоізоляція', 'Високий рівень', 220)
) as common(label, value, sort_order)
on conflict (product_slug, label) do update
set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order) values
  ('catalog-1','Нижній замок','Mottura 54.797',230), ('catalog-1','Додатково','Вічко',240),
  ('catalog-2','Верхній замок','Securemme',230), ('catalog-2','Нижній замок','Securemme',240), ('catalog-2','Вага','Від 100 кг',250), ('catalog-2','Додатково','Вічко',260),
  ('catalog-3','Верхній замок','Securemme',230), ('catalog-3','Нижній замок','Securemme',240), ('catalog-3','Додатково','Вічко',250),
  ('catalog-4','Верхній замок','Securemme',230), ('catalog-4','Нижній замок','Securemme',240), ('catalog-4','Додатково','Дзеркало',250),
  ('catalog-5','Верхній замок','Securemme',230), ('catalog-5','Нижній замок','Securemme',240), ('catalog-5','Додатково','Вічко',250),
  ('catalog-6','Верхній замок','Kale 257',230), ('catalog-6','Нижній замок','Kale 252',240), ('catalog-6','Додатково','Вічко',250),
  ('catalog-7','Верхній замок','Securemme',230), ('catalog-7','Нижній замок','Securemme',240), ('catalog-7','Додатково','Дзеркало',250),
  ('catalog-8','Верхній замок','Securemme',230), ('catalog-8','Нижній замок','Securemme',240), ('catalog-8','Додатково','Вічко',250)
on conflict (product_slug, label) do update
set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from unnest(array['catalog-9','catalog-10','catalog-12','catalog-14']) as models(product_slug)
cross join (values
  ('Призначення', 'Для будинку · терморозрив', 100),
  ('Розмір блоку', '860 / 960 × 2050 мм', 110),
  ('Стиль', 'Модерн', 120),
  ('Відкривання', 'Ліве або праве', 130),
  ('Глибина коробу', '115 мм', 140),
  ('Товщина полотна', '100 мм', 150),
  ('Товщина металу', '2 мм', 160),
  ('Верхній замок', 'Kale 257', 170),
  ('Нижній замок', 'Kale 252', 180),
  ('Конструкція коробу', 'Гнутий профіль', 190),
  ('Контури примикання', '3 контури', 200),
  ('Шумоізоляція', 'Високий рівень', 210),
  ('Теплоізоляція', 'Високий рівень', 220),
  ('Сонячна сторона', 'Так', 230)
) as common(label, value, sort_order)
on conflict (product_slug, label) do update
set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order) values
  ('catalog-9','Оздоблення','МДФ-накладки',125), ('catalog-9','Тип оздоблення','МДФ-МДФ',126), ('catalog-9','Додатково','3 петлі, нержавіючий поріг',240),
  ('catalog-10','Оздоблення','Метал і МДФ',125), ('catalog-10','Тип оздоблення','Метал-МДФ',126), ('catalog-10','Додатково','3 петлі, нержавіючий поріг',240),
  ('catalog-12','Оздоблення','Метал і МДФ',125), ('catalog-12','Тип оздоблення','Метал-МДФ',126), ('catalog-12','Додатково','Ручка-труба',240),
  ('catalog-14','Оздоблення','МДФ-накладки',125), ('catalog-14','Тип оздоблення','МДФ-МДФ',126), ('catalog-14','Додатково','3 петлі, нержавіючий поріг',240),
  ('catalog-13','Призначення','Для будинку · терморозрив',100), ('catalog-13','Розмір блоку','1200 × 2050 мм',110), ('catalog-13','Оздоблення','Метал і МДФ',120), ('catalog-13','Тип оздоблення','Метал-МДФ',130), ('catalog-13','Стиль','Модерн',140), ('catalog-13','Відкривання','Ліве або праве',150), ('catalog-13','Глибина коробу','115 мм',160), ('catalog-13','Товщина полотна','100 мм',170), ('catalog-13','Товщина металу','2 мм',180), ('catalog-13','Верхній замок','Kale 257',190), ('catalog-13','Нижній замок','Kale 252',200), ('catalog-13','Додатково','3 петлі, нержавіючий поріг',210), ('catalog-13','Конструкція коробу','Гнутий профіль',220), ('catalog-13','Контури примикання','3 контури',230), ('catalog-13','Шумоізоляція','Високий рівень',240), ('catalog-13','Теплоізоляція','Високий рівень',250), ('catalog-13','Сонячна сторона','Так',260),
  ('catalog-11','Призначення','Для будинку · терморозрив',100), ('catalog-11','Розмір блоку','860 / 960 × 2050 мм',110), ('catalog-11','Оздоблення','Метал і МДФ LAMPRE',120), ('catalog-11','Тип оздоблення','Метал-МДФ',130), ('catalog-11','Стиль','Модерн',140), ('catalog-11','Відкривання','Ліве або праве',150), ('catalog-11','Глибина коробу','150 мм',160), ('catalog-11','Товщина полотна','104 мм',170), ('catalog-11','Товщина металу','2 мм',180), ('catalog-11','Верхній замок','Kale 257',190), ('catalog-11','Нижній замок','Kale 257',200), ('catalog-11','Додатково','Ручка-труба',210), ('catalog-11','Конструкція коробу','Гнутий профіль',220), ('catalog-11','Контури примикання','2 контури',230), ('catalog-11','Шумоізоляція','Високий рівень',240), ('catalog-11','Теплоізоляція','Високий рівень',250), ('catalog-11','Сонячна сторона','Так',260)
on conflict (product_slug, label) do update
set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values
  ('catalog-1','Market Dveri','https://market-dveri.ua/uk/dveri-city-mg3-ct-546-0-harmonia-abwehr/','CITY (MG3-CT) 546/0 Harmonia','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-2','Market Dveri','https://market-dveri.ua/uk/dveri-megapolis-mg3-443-abwehr/','Megapolis (MG3) 443 Limana','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-3','Market Dveri','https://market-dveri.ua/uk/dveri-megapolis-mg3-573-558-melany-abwehr/','Megapolis (MG3) 573/558 Melany','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-4','Market Dveri','https://market-dveri.ua/uk/dveri-megapolis-mg3-549-544-mira-z-dzerkalom-abwehr/','Megapolis (MG3) 549/544 Mira','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-5','Market Dveri','https://market-dveri.ua/uk/dveri-megapolis-mg3-516-517-rain-abwehr/','Megapolis (MG3) 516/517 Rain','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-6','Market Dveri','https://market-dveri.ua/uk/dveri-megapolis-mg3-572-0-riviera-abwehr/','Megapolis (MG3) 572/0 Riviera','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-7','Market Dveri','https://market-dveri.ua/uk/dveri-megapolis-mg3-583-544-selena-abwehr/','Megapolis (MG3) 583/544 Selena','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-8','Market Dveri','https://market-dveri.ua/uk/dveri-megapolis-mg3-515-0-stella-abwehr/','Megapolis (MG3) 515/0 Stella','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-9','Market Dveri','https://market-dveri.ua/uk/dveri-termix-z-termorozryvom-tower-537-abwehr/','TERMIX 537 Avenue','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-10','Market Dveri','https://market-dveri.ua/uk/dveri-termix-z-termorozryvom-536-carat-abwehr/','TERMIX 536 Carat','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-11','Market Dveri','https://market-dveri.ua/uk/dveri-new-cottage-z-metalom-lampre-kt-n-lp-5-queen-abwehr/','NEW Bionica LP-5 Queen','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-12','Market Dveri','https://market-dveri.ua/uk/dveri-termix-z-termorozryvom-revolution-lp-6-abwehr/','TERMIX Revolution LP-6','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-13','Market Dveri','https://market-dveri.ua/uk/dveri-termix-z-termorozryvom-tower-527-1200-abwehr/','TERMIX Tower 527 1200','verified',now(),'Назва моделі, фото та характеристики перевірені.'),
  ('catalog-14','Market Dveri','https://market-dveri.ua/uk/dveri-termix-z-termorozryvom-tower-527-abwehr/','TERMIX Tower 527','verified',now(),'Назва моделі, фото та характеристики перевірені.')
on conflict (product_slug, source_url) do update
set source_name = excluded.source_name, source_product_name = excluded.source_product_name,
    verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;
