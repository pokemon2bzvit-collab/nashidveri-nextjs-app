-- Market Dveri — Q Doors: 4 моделі з точним збігом «модель + виконання + фото».
-- Не імпортує ціни. Скрипт можна запускати повторно.

update public.products as product
set description = source.description,
    image_path = source.image_path
from (values
  ('catalog-54', 'Q Doors Стріт Арт — вуличні вхідні двері з терморозривом. Зовнішня металева панель у кольорі антрацит RAL 7021 поєднана з внутрішньою МДФ-панеллю «біле дерево» Vinorit; три контури примикання, полотно 100 мм і ручка-труба.', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/225067/dveri-strit-art-metal-antratsit-7021-farba-mdf-bile-derevo-vinorit-3k-qdoors-main.jpg'),
  ('catalog-59', 'Q Doors Стріт Флай — вуличні вхідні двері з терморозривом. Метал антрацит RAL 7021 зовні та МДФ «біла шагрень» Vinorit всередині; полотно 100 мм, три контури примикання та ручка-труба.', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/225071/dveri-strit-flaj-metal-antratsit-7021-farba-mdf-bila-shagren-vinorit-3k-qdoors-main.jpg'),
  ('catalog-63', 'Q Doors Лаунж — квартирні вхідні двері серії Ultra. Поєднання декорів «оксид темний» і «сірий шифер» з внутрішнім дзеркалом, полотно 95 мм, метал 1,8 мм та замки Securemme.', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218340/dveri-ultra-launzh-ak-oksid-temnij-sirij-shiferplusdzerkalo-qdoors-main.jpg'),
  ('catalog-67', 'Q Doors Тріоні — квартирні вхідні двері серії Premium у виконанні антрацит / біла шагрень. МДФ-накладки, полотно 85 мм, метал 1,5 мм і замки Kale.', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218341/dveri-premium-trioni-ak-antratsit-bila-shagren-qdoors-main.jpg')
) as source(slug, description, image_path)
where product.slug = source.slug;

update public.product_media as media
set image_path = source.image_path,
    label = source.label,
    sort_order = 0,
    is_active = true
from (values
  ('catalog-54','Стріт Арт · антрацит / біле дерево', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/225067/dveri-strit-art-metal-antratsit-7021-farba-mdf-bile-derevo-vinorit-3k-qdoors-main.jpg'),
  ('catalog-59','Стріт Флай · антрацит / біла шагрень', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/225071/dveri-strit-flaj-metal-antratsit-7021-farba-mdf-bila-shagren-vinorit-3k-qdoors-main.jpg'),
  ('catalog-63','Лаунж · оксид темний / сірий шифер', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218340/dveri-ultra-launzh-ak-oksid-temnij-sirij-shiferplusdzerkalo-qdoors-main.jpg'),
  ('catalog-67','Тріоні · антрацит / біла шагрень', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218341/dveri-premium-trioni-ak-antratsit-bila-shagren-qdoors-main.jpg')
) as source(product_slug, label, image_path)
where media.product_slug = source.product_slug and media.kind = 'main';

insert into public.product_media (product_slug, kind, label, image_path, sort_order) values
  ('catalog-54','gallery','Стріт Арт · додатковий ракурс','https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/225067/dveri-strit-art-metal-antratsit-7021-farba-mdf-bile-derevo-vinorit-3k-qdoors-1.jpg',10),
  ('catalog-59','gallery','Стріт Флай · додатковий ракурс','https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/225071/dveri-strit-flaj-metal-antratsit-7021-farba-mdf-bila-shagren-vinorit-3k-qdoors-1.jpg',10),
  ('catalog-63','gallery','Лаунж · додатковий ракурс','https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218340/dveri-ultra-launzh-ak-oksid-temnij-sirij-shiferplusdzerkalo-qdoors-1.jpg',10),
  ('catalog-67','gallery','Тріоні · додатковий ракурс','https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218341/dveri-premium-trioni-ak-antratsit-bila-shagren-qdoors-1.jpg',10)
on conflict (product_slug, kind, image_path) do update
set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, image_path, sort_order) values
  ('catalog-54','finish','Підтверджене виконання','Антрацит RAL 7021 + біле дерево Vinorit','https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/225067/dveri-strit-art-metal-antratsit-7021-farba-mdf-bile-derevo-vinorit-3k-qdoors-main.jpg',10),
  ('catalog-59','finish','Підтверджене виконання','Антрацит RAL 7021 + біла шагрень Vinorit','https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/225071/dveri-strit-flaj-metal-antratsit-7021-farba-mdf-bila-shagren-vinorit-3k-qdoors-main.jpg',10),
  ('catalog-63','finish','Підтверджене виконання','Оксид темний + сірий шифер','https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218340/dveri-ultra-launzh-ak-oksid-temnij-sirij-shiferplusdzerkalo-qdoors-main.jpg',10),
  ('catalog-63','glass','Внутрішня панель','Дзеркало','https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218340/dveri-ultra-launzh-ak-oksid-temnij-sirij-shiferplusdzerkalo-qdoors-main.jpg',10),
  ('catalog-67','finish','Підтверджене виконання','Антрацит + біла шагрень','https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218341/dveri-premium-trioni-ak-antratsit-bila-shagren-qdoors-main.jpg',10)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order) values
  ('catalog-54','{"finish":"Антрацит RAL 7021 + біле дерево Vinorit"}'::jsonb,'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/225067/dveri-strit-art-metal-antratsit-7021-farba-mdf-bile-derevo-vinorit-3k-qdoors-main.jpg',10),
  ('catalog-59','{"finish":"Антрацит RAL 7021 + біла шагрень Vinorit"}'::jsonb,'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/225071/dveri-strit-flaj-metal-antratsit-7021-farba-mdf-bila-shagren-vinorit-3k-qdoors-main.jpg',10),
  ('catalog-63','{"finish":"Оксид темний + сірий шифер","glass":"Дзеркало"}'::jsonb,'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218340/dveri-ultra-launzh-ak-oksid-temnij-sirij-shiferplusdzerkalo-qdoors-main.jpg',10),
  ('catalog-67','{"finish":"Антрацит + біла шагрень"}'::jsonb,'https://market-dveri.ua/image/catalog/product/vhidni-dveri/qdoors/218341/dveri-premium-trioni-ak-antratsit-bila-shagren-qdoors-main.jpg',10)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order) values
  ('catalog-54','Призначення','Для будинку · терморозрив',100),('catalog-54','Розмір блоку','850 / 950 × 2040 мм',110),('catalog-54','Серія','Стріт',120),('catalog-54','Оздоблення','Метал-МДФ',130),('catalog-54','Глибина коробу','140 мм',140),('catalog-54','Товщина полотна','100 мм',150),('catalog-54','Товщина металу','1,5 мм',160),('catalog-54','Верхній замок','Kale 257',170),('catalog-54','Нижній замок','Kale 252',180),('catalog-54','Додатково','Ручка-труба',190),('catalog-54','Конструкція коробу','Гнутий профіль',200),('catalog-54','Контури примикання','3 контури',210),('catalog-54','Шумоізоляція','Високий рівень',220),('catalog-54','Теплоізоляція','Високий рівень',230),
  ('catalog-59','Призначення','Для будинку · терморозрив',100),('catalog-59','Розмір блоку','850 / 950 × 2040 мм',110),('catalog-59','Серія','Стріт',120),('catalog-59','Оздоблення','Метал-МДФ',130),('catalog-59','Глибина коробу','140 мм',140),('catalog-59','Товщина полотна','100 мм',150),('catalog-59','Товщина металу','1,5 мм',160),('catalog-59','Верхній замок','Kale 257',170),('catalog-59','Нижній замок','Kale 252',180),('catalog-59','Додатково','Ручка-труба',190),('catalog-59','Конструкція коробу','Гнутий профіль',200),('catalog-59','Контури примикання','3 контури',210),('catalog-59','Шумоізоляція','Високий рівень',220),('catalog-59','Теплоізоляція','Високий рівень',230),
  ('catalog-63','Призначення','Для квартири',100),('catalog-63','Розмір блоку','850 / 950 × 2040 мм',110),('catalog-63','Серія','Ultra',120),('catalog-63','Оздоблення','МДФ-МДФ',130),('catalog-63','Глибина коробу','130 мм',140),('catalog-63','Товщина полотна','95 мм',150),('catalog-63','Товщина металу','1,8 мм',160),('catalog-63','Верхній замок','Securemme',170),('catalog-63','Нижній замок','Securemme',180),('catalog-63','Додатково','Дзеркало',190),('catalog-63','Конструкція коробу','2 труби',200),('catalog-63','Контури примикання','2 контури',210),('catalog-63','Шумоізоляція','Високий рівень',220),('catalog-63','Теплоізоляція','Високий рівень',230),
  ('catalog-67','Призначення','Для квартири',100),('catalog-67','Розмір блоку','850 / 950 × 2040 мм',110),('catalog-67','Серія','Premium',120),('catalog-67','Оздоблення','МДФ-МДФ',130),('catalog-67','Глибина коробу','115 мм',140),('catalog-67','Товщина полотна','85 мм',150),('catalog-67','Товщина металу','1,5 мм',160),('catalog-67','Верхній замок','Kale 257',170),('catalog-67','Нижній замок','Kale 252',180),('catalog-67','Додатково','Вічко',190),('catalog-67','Конструкція коробу','2 труби',200),('catalog-67','Контури примикання','2 контури',210),('catalog-67','Шумоізоляція','Високий рівень',220),('catalog-67','Теплоізоляція','Високий рівень',230)
on conflict (product_slug, label) do update
set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values
  ('catalog-54','Market Dveri','https://market-dveri.ua/uk/dveri-strit-art-metal-antracyt-7021-farba-mdf-bile-derevo-vinorit-3k-qdoors/','Стріт Арт · антрацит RAL 7021 / біле дерево Vinorit','verified',now(),'Модель, виконання, фото та характеристики збігаються.'),
  ('catalog-59','Market Dveri','https://market-dveri.ua/uk/dveri-strit-flaj-metal-antracyt-7021-farba-mdf-bila-shagren-vinorit-3k-qdoors/','Стріт Флай · антрацит RAL 7021 / біла шагрень Vinorit','verified',now(),'Модель, виконання, фото та характеристики збігаються.'),
  ('catalog-63','Market Dveri','https://market-dveri.ua/uk/dveri-launzh-ak-oksyd-temnyj-siryj-shyfer-dzerkalo-qdoors/','Ultra Лаунж-AK · оксид темний / сірий шифер / дзеркало','verified',now(),'Модель, виконання, фото та характеристики збігаються.'),
  ('catalog-67','Market Dveri','https://market-dveri.ua/uk/dveri-premyum-trioni-ak-antracyt-bila-shagren-qdoors/','Premium Тріоні-AK · антрацит / біла шагрень','verified',now(),'Модель, виконання, фото та характеристики збігаються.')
on conflict (product_slug, source_url) do update
set source_name = excluded.source_name, source_product_name = excluded.source_product_name,
    verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;
