-- Market Dveri — пакет 02: Страж.
-- Фото, опис і характеристики лише для моделей із точним збігом назви.
-- Джерело: https://market-dveri.ua/uk/

update public.products as product
set description = source.description
from (values
  ('catalog-275', 'Страж Vodaria — вхідні двері зі складської колекції. Модель доступна у розмірах 860 × 2050 або 960 × 2050 мм та має високий рівень тепло- і шумоізоляції.'),
  ('catalog-279', 'Страж Florence — сучасні вхідні двері для квартири з МДФ-накладками з обох боків. Полотно 105 мм, метал 1,8 мм і чотири контури примикання забезпечують надійність, тепло та тишу.'),
  ('catalog-281', 'Страж Prestige Delica AL Mono — квартирні двері з МДФ-накладками з обох боків у сучасному стилі. Полотно 95 мм, метал 1,8 мм, гнутий профіль коробу та три контури примикання.'),
  ('catalog-282', 'Страж Prestige Matrix — сучасні вхідні двері для квартири з МДФ-накладками. Полотно 80 мм, метал 1,8 мм, гнутий профіль коробу та три контури примикання допомагають забезпечити тепло- і шумоізоляцію.')
) as source(slug, description)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-275', 'main', 'Страж Vodaria', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/23881/dveri-vodaria-strazh-main.jpg', 0),
  ('catalog-279', 'main', 'Страж Florence — 2 кольори', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/212478/dveri-florence-4k-2-kolori-strazh-main.jpg', 0),
  ('catalog-281', 'main', 'Страж Prestige Delica AL Mono', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/210231/dveri-delica-al-beton-temnij-7806-al-black-bila-emal-vg-strazh-main.jpg', 0),
  ('catalog-282', 'main', 'Страж Prestige Matrix', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/27276/dveri-prestizh-lux-matrix-mussonne-derevo-softtach-soft-milk-straj-main.jpg', 0)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1 from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);

insert into public.product_specs (product_slug, label, value, sort_order)
values
  ('catalog-275', 'Висота блоку', '2050 мм', 100),
  ('catalog-275', 'Ширина блоку', '860 або 960 мм', 110),
  ('catalog-275', 'Шумоізоляція', 'Високий рівень', 120),
  ('catalog-275', 'Теплоізоляція', 'Висока', 130),
  ('catalog-275', 'Цінова категорія', 'Оптимальний вибір', 140),

  ('catalog-279', 'Призначення', 'Для квартири', 100),
  ('catalog-279', 'Серія', 'Standard Mottura', 110),
  ('catalog-279', 'Розміри блоку', '860 / 960 × 2050 мм', 120),
  ('catalog-279', 'Матеріал фасону', 'МДФ-накладка', 130),
  ('catalog-279', 'Тип фасону', 'МДФ-МДФ', 140),
  ('catalog-279', 'Стиль накладок', 'Модерн', 150),
  ('catalog-279', 'Товщина полотна', '105 мм', 160),
  ('catalog-279', 'Товщина металу', '1,8 мм', 170),
  ('catalog-279', 'Контури примикання', '4 контури', 180),
  ('catalog-279', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-279', 'Теплоізоляція', 'Висока', 200),

  ('catalog-281', 'Призначення', 'Для квартири', 100),
  ('catalog-281', 'Серія', 'Standard Mottura', 110),
  ('catalog-281', 'Розміри блоку', '860 / 960 × 2050 мм', 120),
  ('catalog-281', 'Матеріал фасону', 'МДФ-накладка', 130),
  ('catalog-281', 'Тип фасону', 'МДФ-МДФ', 140),
  ('catalog-281', 'Стиль накладок', 'Модерн', 150),
  ('catalog-281', 'Товщина полотна', '95 мм', 160),
  ('catalog-281', 'Товщина металу', '1,8 мм', 170),
  ('catalog-281', 'Контури примикання', '3 контури', 180),
  ('catalog-281', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-281', 'Теплоізоляція', 'Висока', 200),

  ('catalog-282', 'Призначення', 'Для квартири', 100),
  ('catalog-282', 'Серія', 'PF Standard Mottura', 110),
  ('catalog-282', 'Розміри блоку', '860 / 960 × 2050 мм', 120),
  ('catalog-282', 'Матеріал фасону', 'МДФ-накладка', 130),
  ('catalog-282', 'Тип фасону', 'МДФ-МДФ', 140),
  ('catalog-282', 'Стиль накладок', 'Модерн', 150),
  ('catalog-282', 'Товщина полотна', '80 мм', 160),
  ('catalog-282', 'Товщина металу', '1,8 мм', 170),
  ('catalog-282', 'Контури примикання', '3 контури', 180),
  ('catalog-282', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-282', 'Теплоізоляція', 'Висока', 200)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
