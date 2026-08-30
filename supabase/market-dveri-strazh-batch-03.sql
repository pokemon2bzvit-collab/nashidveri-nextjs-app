-- Market Dveri — пакет 03: Страж.
-- Фото, описи й перевірені характеристики точних моделей.

update public.products as product
set description = source.description
from (values
  ('catalog-285', 'Страж PROOF Party D 1200 — широкі вхідні двері для приватного будинку. Сталеве полотно 85 мм, сендвіч-МДФ оздоблення, гнутий профіль коробу та три контури примикання забезпечують високий рівень тепло- і шумоізоляції.'),
  ('catalog-286', 'Страж PROOF Party D — вхідні двері для будинку з атмосферостійким віноритовим покриттям. Сталеве полотно 85 мм, сендвіч-МДФ оздоблення та три контури примикання створюють комфорт у будь-яку пору року.'),
  ('catalog-289', 'Страж PROOF Slim S 1200 — широкі вхідні двері для будинку зі склопакетом. Сталеве полотно 85 мм, сендвіч-МДФ оздоблення, гнутий профіль і три контури примикання поєднують сучасний вигляд та ізоляційні властивості.'),
  ('catalog-294', 'Страж Street PF Rio-S — сучасні одинарні вхідні двері зі сталевим полотном і сендвіч-МДФ оздобленням. Полотно 80 мм, три контури примикання та висока тепло- і шумоізоляція роблять модель практичним рішенням для входу.')
) as source(slug, description)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-285', 'main', 'Страж PROOF Party D 1200', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/22041/dveri-party-d-1200-strazh-main.jpg', 0),
  ('catalog-286', 'main', 'Страж PROOF Party D — вінорит антрацит', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/28562/dveri-pruf-party-d-vinorit-antratsit-strazh-main.jpg', 0),
  ('catalog-289', 'main', 'Страж PROOF Slim S 1200 — антрацит', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/28464/dveri-slim-s-1200-antratsit-strazh-main.jpg', 0),
  ('catalog-294', 'main', 'Страж Street PF Rio-S — антрацит пісок / білий', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/29121/dveri-smart-street-pf-rio-s-antratsit-pisok-bilij-strazh-main.jpg', 0)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1 from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);

insert into public.product_specs (product_slug, label, value, sort_order)
values
  ('catalog-285', 'Призначення', 'Для будинку', 100),
  ('catalog-285', 'Серія', 'PF Standard Mottura', 110),
  ('catalog-285', 'Розміри блоку', '1200 × 2050 мм', 120),
  ('catalog-285', 'Матеріал фасону', 'Стальний лист', 130),
  ('catalog-285', 'Тип фасону', 'Сендвіч-МДФ', 140),
  ('catalog-285', 'Стиль накладок', 'Модерн', 150),
  ('catalog-285', 'Товщина полотна', '85 мм', 160),
  ('catalog-285', 'Товщина металу', '1,5 мм', 170),
  ('catalog-285', 'Контури примикання', '3 контури', 180),
  ('catalog-285', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-285', 'Теплоізоляція', 'Висока', 200),

  ('catalog-286', 'Призначення', 'Для будинку', 100),
  ('catalog-286', 'Серія', 'PF Standard Mottura', 110),
  ('catalog-286', 'Розміри блоку', '860 / 960 × 2050 мм', 120),
  ('catalog-286', 'Матеріал фасону', 'Стальний лист', 130),
  ('catalog-286', 'Тип фасону', 'Сендвіч-МДФ', 140),
  ('catalog-286', 'Стиль накладок', 'Модерн', 150),
  ('catalog-286', 'Товщина полотна', '85 мм', 160),
  ('catalog-286', 'Товщина металу', '1,5 мм', 170),
  ('catalog-286', 'Контури примикання', '3 контури', 180),
  ('catalog-286', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-286', 'Теплоізоляція', 'Висока', 200),

  ('catalog-289', 'Призначення', 'Для будинку, зі склопакетом', 100),
  ('catalog-289', 'Серія', 'PF Standard Mottura', 110),
  ('catalog-289', 'Розміри блоку', '1200 × 2050 мм', 120),
  ('catalog-289', 'Матеріал фасону', 'Стальний лист', 130),
  ('catalog-289', 'Тип фасону', 'Сендвіч-МДФ', 140),
  ('catalog-289', 'Стиль накладок', 'Модерн', 150),
  ('catalog-289', 'Товщина полотна', '85 мм', 160),
  ('catalog-289', 'Товщина металу', '1,5 мм', 170),
  ('catalog-289', 'Контури примикання', '3 контури', 180),
  ('catalog-289', 'Шумоізоляція', 'Високий рівень', 190),
  ('catalog-289', 'Теплоізоляція', 'Висока', 200),

  ('catalog-294', 'Призначення', 'Одинарні двері', 100),
  ('catalog-294', 'Розміри блоку', '860 / 960 × 2050 мм', 110),
  ('catalog-294', 'Матеріал фасону', 'Стальний лист', 120),
  ('catalog-294', 'Тип фасону', 'Сендвіч-МДФ', 130),
  ('catalog-294', 'Стиль накладок', 'Модерн', 140),
  ('catalog-294', 'Товщина полотна', '80 мм', 150),
  ('catalog-294', 'Товщина металу', '1 мм', 160),
  ('catalog-294', 'Контури примикання', '3 контури', 170),
  ('catalog-294', 'Шумоізоляція', 'Високий рівень', 180),
  ('catalog-294', 'Теплоізоляція', 'Висока', 190)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
