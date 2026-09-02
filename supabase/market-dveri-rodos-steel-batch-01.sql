-- Market Dveri — пакет 01: Rodos Steel.
-- Додано лише квартирні моделі, для яких код F і призначення збігаються.
-- Фото ведуть на оригінали Market Dveri; ціни не імпортуються.
-- Скрипт можна безпечно запускати повторно.

update public.products as product
set description = source.description
from (values
  ('catalog-170', 'Rodos Steel Line F 121 — вхідні двері для квартири в сучасному стилі. МДФ-накладки з обох боків, гнутий профіль коробу, два контури примикання та замки Securemme поєднують надійність, тепло- й шумоізоляцію.'),
  ('catalog-171', 'Rodos Steel Line F 122 — вхідні двері для квартири з темним МДФ-декором. Полотно 88 мм, метал 1,5 мм, гнутий профіль коробу й два контури примикання забезпечують комфорт і захист.'),
  ('catalog-175', 'Rodos Steel Line F 136 — сучасні вхідні двері для квартири з вічком. МДФ-накладки з обох боків, полотно 88 мм, два контури примикання та замки Securemme створюють надійне рішення для оселі.'),
  ('catalog-176', 'Rodos Steel F 141 — преміальні вхідні двері для квартири з МДФ-накладками з обох боків. Полотно 107 мм, метал 1,8 мм, три контури примикання та замки Securemme забезпечують високий рівень тиші й тепла.'),
  ('catalog-177', 'Rodos Steel Line F 154 — вхідні двері для квартири у стилі модерн. Конструкція з МДФ-накладками, гнутим профілем коробу, двома контурами примикання та замками Securemme розрахована на комфортну щоденну експлуатацію.')
) as source(slug, description)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-170', 'main', 'Rodos Steel Line F 121', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/229521/dveri-rodos-steel-line-f-121-main.jpg', 0),
  ('catalog-171', 'main', 'Rodos Steel Line F 122', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/229522/dveri-rodos-steel-line-f-122-main.jpg', 0),
  ('catalog-175', 'main', 'Rodos Steel Line F 136', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/229524/dveri-rodos-steel-line-f-136-main.jpg', 0),
  ('catalog-176', 'main', 'Rodos Steel STZ F 141', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/226126/dveri-stz-f-141-rodos-steel-main.jpg', 0),
  ('catalog-177', 'main', 'Rodos Steel Line F 154', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/229528/dveri-rodos-steel-line-f-154-main.jpg', 0)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1 from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);

insert into public.product_specs (product_slug, label, value, sort_order)
values
  ('catalog-170', 'Призначення', 'Для квартири', 100),
  ('catalog-170', 'Серія', 'Line', 110),
  ('catalog-170', 'Доступні розміри', '880 / 960 × 2050 мм', 120),
  ('catalog-170', 'Оздоблення', 'МДФ-накладки з обох боків', 130),
  ('catalog-170', 'Стиль', 'Модерн', 140),
  ('catalog-170', 'Глибина коробу', '96 мм', 150),
  ('catalog-170', 'Товщина полотна', '88 мм', 160),
  ('catalog-170', 'Товщина металу', '1,5 мм', 170),
  ('catalog-170', 'Верхній замок', 'Securemme', 180),
  ('catalog-170', 'Нижній замок', 'Securemme', 190),
  ('catalog-170', 'Конструкція коробу', 'Гнутий профіль', 200),
  ('catalog-170', 'Контури примикання', '2 контури', 210),
  ('catalog-170', 'Шумоізоляція', 'Високий рівень', 220),
  ('catalog-170', 'Теплоізоляція', 'Висока', 230),
  ('catalog-170', 'Сонячна сторона', 'Так', 240),

  ('catalog-171', 'Призначення', 'Для квартири', 100),
  ('catalog-171', 'Серія', 'Line', 110),
  ('catalog-171', 'Доступні розміри', '880 / 960 × 2050 мм', 120),
  ('catalog-171', 'Оздоблення', 'МДФ-накладки з обох боків', 130),
  ('catalog-171', 'Стиль', 'Модерн', 140),
  ('catalog-171', 'Глибина коробу', '96 мм', 150),
  ('catalog-171', 'Товщина полотна', '88 мм', 160),
  ('catalog-171', 'Товщина металу', '1,5 мм', 170),
  ('catalog-171', 'Верхній замок', 'Securemme', 180),
  ('catalog-171', 'Нижній замок', 'Securemme', 190),
  ('catalog-171', 'Конструкція коробу', 'Гнутий профіль', 200),
  ('catalog-171', 'Контури примикання', '2 контури', 210),
  ('catalog-171', 'Шумоізоляція', 'Високий рівень', 220),
  ('catalog-171', 'Теплоізоляція', 'Висока', 230),
  ('catalog-171', 'Сонячна сторона', 'Так', 240),

  ('catalog-175', 'Призначення', 'Для квартири', 100),
  ('catalog-175', 'Серія', 'Line', 110),
  ('catalog-175', 'Доступні розміри', '880 / 960 × 2050 мм', 120),
  ('catalog-175', 'Оздоблення', 'МДФ-накладки з обох боків', 130),
  ('catalog-175', 'Стиль', 'Модерн', 140),
  ('catalog-175', 'Глибина коробу', '96 мм', 150),
  ('catalog-175', 'Товщина полотна', '88 мм', 160),
  ('catalog-175', 'Товщина металу', '1,5 мм', 170),
  ('catalog-175', 'Верхній замок', 'Securemme', 180),
  ('catalog-175', 'Нижній замок', 'Securemme', 190),
  ('catalog-175', 'Додатково', 'Вічко', 200),
  ('catalog-175', 'Конструкція коробу', 'Гнутий профіль', 210),
  ('catalog-175', 'Контури примикання', '2 контури', 220),
  ('catalog-175', 'Шумоізоляція', 'Високий рівень', 230),
  ('catalog-175', 'Теплоізоляція', 'Висока', 240),
  ('catalog-175', 'Сонячна сторона', 'Так', 250),

  ('catalog-176', 'Призначення', 'Для квартири', 100),
  ('catalog-176', 'Серія', 'Склад RS', 110),
  ('catalog-176', 'Доступні розміри', '880 / 960 × 2050 мм', 120),
  ('catalog-176', 'Оздоблення', 'МДФ-накладки з обох боків', 130),
  ('catalog-176', 'Стиль', 'Модерн', 140),
  ('catalog-176', 'Глибина коробу', '111 мм', 150),
  ('catalog-176', 'Товщина полотна', '107 мм', 160),
  ('catalog-176', 'Товщина металу', '1,8 мм', 170),
  ('catalog-176', 'Верхній замок', 'Securemme', 180),
  ('catalog-176', 'Нижній замок', 'Securemme', 190),
  ('catalog-176', 'Додатково', 'Вічко', 200),
  ('catalog-176', 'Конструкція коробу', 'Гнутий профіль', 210),
  ('catalog-176', 'Контури примикання', '3 контури', 220),
  ('catalog-176', 'Шумоізоляція', 'Високий рівень', 230),
  ('catalog-176', 'Теплоізоляція', 'Висока', 240),

  ('catalog-177', 'Призначення', 'Для квартири', 100),
  ('catalog-177', 'Серія', 'Line', 110),
  ('catalog-177', 'Доступні розміри', '880 / 960 × 2050 мм', 120),
  ('catalog-177', 'Оздоблення', 'МДФ-накладки з обох боків', 130),
  ('catalog-177', 'Стиль', 'Модерн', 140),
  ('catalog-177', 'Глибина коробу', '96 мм', 150),
  ('catalog-177', 'Товщина полотна', '88 мм', 160),
  ('catalog-177', 'Товщина металу', '1,5 мм', 170),
  ('catalog-177', 'Верхній замок', 'Securemme', 180),
  ('catalog-177', 'Нижній замок', 'Securemme', 190),
  ('catalog-177', 'Конструкція коробу', 'Гнутий профіль', 200),
  ('catalog-177', 'Контури примикання', '2 контури', 210),
  ('catalog-177', 'Шумоізоляція', 'Високий рівень', 220),
  ('catalog-177', 'Теплоізоляція', 'Висока', 230),
  ('catalog-177', 'Сонячна сторона', 'Так', 240)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  ('catalog-170', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-rodos-steel-line-f-121/', 'Rodos Steel Line F-121', 'verified', now(), 'Код F, бренд, призначення для квартири, фото та характеристики збігаються.'),
  ('catalog-171', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-rodos-steel-line-f-122/', 'Rodos Steel Line F-122', 'verified', now(), 'Код F, бренд, призначення для квартири, фото та характеристики збігаються.'),
  ('catalog-175', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-rodos-steel-line-f-136/', 'Rodos Steel Line F-136', 'verified', now(), 'Код F, бренд, призначення для квартири, фото та характеристики збігаються.'),
  ('catalog-176', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-stz-f-141-rodos-steel/', 'Rodos Steel STZ F-141', 'verified', now(), 'Код F, бренд, призначення для квартири, фото та характеристики збігаються; префікс STZ збережено у назві джерела.'),
  ('catalog-177', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-rodos-steel-line-f-154/', 'Rodos Steel Line F-154', 'verified', now(), 'Код F, бренд, призначення для квартири, фото та характеристики збігаються.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
