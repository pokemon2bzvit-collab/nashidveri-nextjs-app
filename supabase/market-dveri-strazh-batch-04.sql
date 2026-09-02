-- Market Dveri — пакет 04: Страж.
-- Додано лише моделі, назва яких прямо збігається з товарною карткою.
-- Фото ведуть на оригінали Market Dveri; ціни не імпортуються.
-- Скрипт можна безпечно запускати повторно.

update public.products as product
set description = source.description
from (values
  ('catalog-287', 'Страж PROOF Rio-S Loft 1200 — широкі вхідні двері для будинку зі склопакетом. Сталеве полотно 85 мм, сендвіч-МДФ оздоблення, гнутий профіль коробу та три контури примикання забезпечують високий рівень тепло- й шумоізоляції.'),
  ('catalog-288', 'Страж PROOF Rio-S Loft — вхідні двері для будинку в сучасному стилі. Сталеве полотно 85 мм, сендвіч-МДФ оздоблення, гнутий профіль коробу та три контури примикання створюють комфорт у будь-яку пору року.'),
  ('catalog-290', 'Страж PROOF Slim S — вхідні двері для будинку зі склопакетом. Сталеве полотно 85 мм, сендвіч-МДФ оздоблення, гнутий профіль і три контури примикання поєднують сучасний вигляд, тепло- та шумоізоляцію.'),
  ('catalog-291', 'Страж Vega Maxi — вхідні двері для будинку зі склопакетом і ручкою-трубою. Сталеве полотно 85 мм, сендвіч-МДФ оздоблення, три контури примикання та гнутий профіль коробу допомагають зберігати тепло і тишу.'),
  ('catalog-292', 'Страж Standart Mirage — сучасні вхідні двері з МДФ-накладками з обох боків. Полотно 95 мм, метал 1,8 мм, гнутий профіль коробу та три контури примикання забезпечують надійність і комфорт.'),
  ('catalog-293', 'Страж Standart Піраміс — вхідні двері для квартири з МДФ-накладками з обох боків. Полотно 95 мм, метал 1,8 мм, гнутий профіль і три контури примикання забезпечують тепло- та шумоізоляцію.')
) as source(slug, description)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-287', 'main', 'Страж PROOF Rio-S Loft 1200 — антрацит / білий', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/211682/dveri-rio-s-loft-antratsit-belyj-1200-strazh-main.jpg', 0),
  ('catalog-288', 'main', 'Страж PROOF Rio-S Loft — дуб золотий', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/28463/dveri-rio-s-loft-dub-zolotij-strazh-main.jpg', 0),
  ('catalog-290', 'main', 'Страж PROOF Slim S — антрацит', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/27277/dveri-slim-s-antratsit-strazh-main.jpg', 0),
  ('catalog-291', 'main', 'Страж Vega Maxi — дуб 23', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/210481/dveri-vega-maxi-dub-23-strazh-main.jpg', 0),
  ('catalog-292', 'main', 'Страж Standart Mirage', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/22055/dveri-mirage-strazh-main.jpg', 0),
  ('catalog-293', 'main', 'Страж Standart Піраміс', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/22086/dveri-piramis-standart-pljus-strazh-main.jpg', 0)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1 from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);

insert into public.product_specs (product_slug, label, value, sort_order)
values
  ('catalog-287', 'Призначення', 'Для будинку, зі склопакетом', 100),
  ('catalog-287', 'Серія', 'PF Standard Mottura', 110),
  ('catalog-287', 'Розміри блоку', '1200 × 2050 мм', 120),
  ('catalog-287', 'Матеріал фасону', 'Стальний лист', 130),
  ('catalog-287', 'Тип фасону', 'Сендвіч-МДФ', 140),
  ('catalog-287', 'Стиль накладок', 'Модерн', 150),
  ('catalog-287', 'Товщина полотна', '85 мм', 160),
  ('catalog-287', 'Товщина металу', '1,5 мм', 170),
  ('catalog-287', 'Контури примикання', '3 контури', 180),
  ('catalog-287', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-287', 'Теплоізоляція', 'Висока', 200),

  ('catalog-288', 'Призначення', 'Одинарні двері', 100),
  ('catalog-288', 'Серія', 'PF Standard Mottura', 110),
  ('catalog-288', 'Розміри блоку', '860 / 960 × 2050 мм', 120),
  ('catalog-288', 'Матеріал фасону', 'Стальний лист', 130),
  ('catalog-288', 'Тип фасону', 'Сендвіч-МДФ', 140),
  ('catalog-288', 'Стиль накладок', 'Модерн', 150),
  ('catalog-288', 'Товщина полотна', '85 мм', 160),
  ('catalog-288', 'Товщина металу', '1,5 мм', 170),
  ('catalog-288', 'Контури примикання', '3 контури', 180),
  ('catalog-288', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-288', 'Теплоізоляція', 'Висока', 200),

  ('catalog-290', 'Призначення', 'Для будинку, зі склопакетом', 100),
  ('catalog-290', 'Серія', 'PF Standard Mottura', 110),
  ('catalog-290', 'Розміри блоку', '860 / 960 × 2050 мм', 120),
  ('catalog-290', 'Матеріал фасону', 'Стальний лист', 130),
  ('catalog-290', 'Тип фасону', 'Сендвіч-МДФ', 140),
  ('catalog-290', 'Стиль накладок', 'Модерн', 150),
  ('catalog-290', 'Товщина полотна', '85 мм', 160),
  ('catalog-290', 'Товщина металу', '1,5 мм', 170),
  ('catalog-290', 'Контури примикання', '3 контури', 180),
  ('catalog-290', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-290', 'Теплоізоляція', 'Висока', 200),

  ('catalog-291', 'Призначення', 'Для будинку, зі склопакетом', 100),
  ('catalog-291', 'Серія', 'PF Standard Mottura', 110),
  ('catalog-291', 'Розміри блоку', '860 / 960 × 2050 мм', 120),
  ('catalog-291', 'Матеріал фасону', 'Стальний лист', 130),
  ('catalog-291', 'Тип фасону', 'Сендвіч-МДФ', 140),
  ('catalog-291', 'Стиль накладок', 'Модерн', 150),
  ('catalog-291', 'Додатково', 'Ручка-труба', 160),
  ('catalog-291', 'Товщина полотна', '85 мм', 170),
  ('catalog-291', 'Товщина металу', '1,5 мм', 180),
  ('catalog-291', 'Контури примикання', '3 контури', 190),
  ('catalog-291', 'Шумоізоляція', 'Високий рівень', 200),
  ('catalog-291', 'Теплоізоляція', 'Висока', 210),

  ('catalog-292', 'Призначення', 'Одинарні двері', 100),
  ('catalog-292', 'Серія', 'Standard Mottura', 110),
  ('catalog-292', 'Розміри блоку', '860 / 960 × 2050 мм', 120),
  ('catalog-292', 'Матеріал фасону', 'МДФ-накладка', 130),
  ('catalog-292', 'Тип фасону', 'МДФ-МДФ', 140),
  ('catalog-292', 'Стиль накладок', 'Модерн', 150),
  ('catalog-292', 'Товщина полотна', '95 мм', 160),
  ('catalog-292', 'Товщина металу', '1,8 мм', 170),
  ('catalog-292', 'Контури примикання', '3 контури', 180),
  ('catalog-292', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-292', 'Теплоізоляція', 'Висока', 200),

  ('catalog-293', 'Призначення', 'Для квартири', 100),
  ('catalog-293', 'Серія', 'Standard Mottura', 110),
  ('catalog-293', 'Розміри блоку', '860 / 960 × 2050 мм', 120),
  ('catalog-293', 'Матеріал фасону', 'МДФ-накладка', 130),
  ('catalog-293', 'Тип фасону', 'МДФ-МДФ', 140),
  ('catalog-293', 'Стиль накладок', 'Модерн', 150),
  ('catalog-293', 'Товщина полотна', '95 мм', 160),
  ('catalog-293', 'Товщина металу', '1,8 мм', 170),
  ('catalog-293', 'Контури примикання', '3 контури', 180),
  ('catalog-293', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-293', 'Теплоізоляція', 'Висока', 200)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  ('catalog-287', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-rio-s-loft-antracyt-belyj-1200-strazh/', 'Страж Rio-S Loft 1200 — антрацит / білий', 'verified', now(), 'Назва моделі, повне фото та характеристики збігаються.'),
  ('catalog-288', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-rio-s-loft-dub-zolotyj-strazh/', 'Страж Rio-S Loft — дуб золотий', 'verified', now(), 'Назва моделі, повне фото та характеристики збігаються.'),
  ('catalog-290', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-slim-s-antracyt-strazh/', 'Страж Slim S — антрацит', 'verified', now(), 'Назва моделі, повне фото та характеристики збігаються.'),
  ('catalog-291', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-vega-maxi-dub-23-strazh/', 'Страж Vega Maxi — дуб 23', 'verified', now(), 'Назва моделі, повне фото та характеристики збігаються.'),
  ('catalog-292', 'Market Dveri', 'https://market-dveri.ua/uk/mirage-22055/', 'Страж Mirage', 'verified', now(), 'Назва моделі, повне фото та характеристики збігаються.'),
  ('catalog-293', 'Market Dveri', 'https://market-dveri.ua/uk/piramis-standart-plyus-22086/', 'Страж Piramis Standard Plus', 'verified', now(), 'Назва моделі, повне фото та характеристики збігаються.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
