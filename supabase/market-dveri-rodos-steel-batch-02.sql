-- Market Dveri — пакет 02: Rodos Steel.
-- Моделі F-124 і F-150 зіставлено окремо за призначенням: квартира / будинок.
-- Фото ведуть на оригінали Market Dveri; ціни не імпортуються.
-- Скрипт можна безпечно запускати повторно.

update public.products as product
set description = source.description
from (values
  ('catalog-153', 'Rodos Steel Line Street F 124 — вхідні двері для приватного будинку в стилі модерн. МДФ-накладки з обох боків, гнутий профіль коробу, два контури примикання та замки Securemme поєднують захист, тепло- й шумоізоляцію.'),
  ('catalog-159', 'Rodos Steel Line Street F 150 — вхідні двері для будинку зі склопакетом і вічком. Полотно 88 мм, метал 1,5 мм, МДФ-накладки та два контури примикання створюють сучасний і практичний вхід.'),
  ('catalog-172', 'Rodos Steel F 124 — преміальні вхідні двері для квартири з МДФ-накладками з обох боків. Полотно 107 мм, метал 1,8 мм, три контури примикання й замки Securemme забезпечують надійність, тишу та тепло.')
) as source(slug, description)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-153', 'main', 'Rodos Steel Line Street F 124', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/229530/dveri-rodos-steel-line-street-f-124-main.jpg', 0),
  ('catalog-159', 'main', 'Rodos Steel Line Street F 150', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/229541/dveri-rodos-steel-line-street-f-150-main.jpg', 0),
  ('catalog-172', 'main', 'Rodos Steel STZ F 124', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/226130/dveri-stz-f-124-rodos-steel-main.jpg', 0)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1 from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);

insert into public.product_specs (product_slug, label, value, sort_order)
values
  ('catalog-153', 'Призначення', 'Для будинку', 100),
  ('catalog-153', 'Серія', 'Line Street', 110),
  ('catalog-153', 'Доступні розміри', '880 / 960 × 2050 мм', 120),
  ('catalog-153', 'Оздоблення', 'МДФ-накладки з обох боків', 130),
  ('catalog-153', 'Стиль', 'Модерн', 140),
  ('catalog-153', 'Глибина коробу', '96 мм', 150),
  ('catalog-153', 'Товщина полотна', '88 мм', 160),
  ('catalog-153', 'Товщина металу', '1,5 мм', 170),
  ('catalog-153', 'Верхній замок', 'Securemme', 180),
  ('catalog-153', 'Нижній замок', 'Securemme', 190),
  ('catalog-153', 'Додатково', 'Вічко', 200),
  ('catalog-153', 'Конструкція коробу', 'Гнутий профіль', 210),
  ('catalog-153', 'Контури примикання', '2 контури', 220),
  ('catalog-153', 'Шумоізоляція', 'Високий рівень', 230),
  ('catalog-153', 'Теплоізоляція', 'Висока', 240),
  ('catalog-153', 'Сонячна сторона', 'Так', 250),

  ('catalog-159', 'Призначення', 'Для будинку', 100),
  ('catalog-159', 'Серія', 'Line Street', 110),
  ('catalog-159', 'Доступні розміри', '880 / 960 × 2050 мм', 120),
  ('catalog-159', 'Оздоблення', 'МДФ-накладки з обох боків', 130),
  ('catalog-159', 'Стиль', 'Модерн', 140),
  ('catalog-159', 'Глибина коробу', '96 мм', 150),
  ('catalog-159', 'Товщина полотна', '88 мм', 160),
  ('catalog-159', 'Товщина металу', '1,5 мм', 170),
  ('catalog-159', 'Верхній замок', 'Securemme', 180),
  ('catalog-159', 'Нижній замок', 'Securemme', 190),
  ('catalog-159', 'Додатково', 'Вічко, склопакет', 200),
  ('catalog-159', 'Конструкція коробу', 'Гнутий профіль', 210),
  ('catalog-159', 'Контури примикання', '2 контури', 220),
  ('catalog-159', 'Шумоізоляція', 'Високий рівень', 230),
  ('catalog-159', 'Теплоізоляція', 'Висока', 240),
  ('catalog-159', 'Сонячна сторона', 'Так', 250),

  ('catalog-172', 'Призначення', 'Для квартири', 100),
  ('catalog-172', 'Серія', 'Склад RS', 110),
  ('catalog-172', 'Доступні розміри', '880 / 960 × 2050 мм', 120),
  ('catalog-172', 'Оздоблення', 'МДФ-накладки з обох боків', 130),
  ('catalog-172', 'Стиль', 'Модерн', 140),
  ('catalog-172', 'Глибина коробу', '111 мм', 150),
  ('catalog-172', 'Товщина полотна', '107 мм', 160),
  ('catalog-172', 'Товщина металу', '1,8 мм', 170),
  ('catalog-172', 'Верхній замок', 'Securemme', 180),
  ('catalog-172', 'Нижній замок', 'Securemme', 190),
  ('catalog-172', 'Додатково', 'Вічко', 200),
  ('catalog-172', 'Конструкція коробу', 'Гнутий профіль', 210),
  ('catalog-172', 'Контури примикання', '3 контури', 220),
  ('catalog-172', 'Шумоізоляція', 'Високий рівень', 230),
  ('catalog-172', 'Теплоізоляція', 'Висока', 240)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  ('catalog-153', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-rodos-steel-line-street-f-124/', 'Rodos Steel Line Street F-124', 'verified', now(), 'Код F, бренд, призначення для будинку, фото та характеристики збігаються.'),
  ('catalog-159', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-rodos-steel-line-street-f-150/', 'Rodos Steel Line Street F-150', 'verified', now(), 'Код F, бренд, призначення для будинку, фото та характеристики збігаються.'),
  ('catalog-172', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-stz-f-124-rodos-steel/', 'Rodos Steel STZ F-124', 'verified', now(), 'Код F, бренд, призначення для квартири, фото та характеристики збігаються; префікс STZ збережено у назві джерела.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
