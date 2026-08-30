-- Market Dveri — пакет 01: Страж.
-- Використовуються прямі URL зображень Market Dveri. Джерело фото та технічних даних:
-- https://market-dveri.ua/uk/
-- Ціни свідомо не оновлюються: у каталозі лишається «Ціна за запитом».

update public.products as product
set description = source.description
from (values
  ('catalog-263', 'Страж PROOF Rio-S Loft — вхідні двері в сучасному стилі з сендвіч-МДФ оздобленням. Сталеве полотно 85 мм, гнутий профіль коробу та три контури примикання створюють високий рівень тепло- й шумоізоляції.'),
  ('catalog-264', 'Страж PROOF Slim S — модель для приватного будинку зі склопакетом і сучасним дизайном. Сталеве полотно 85 мм, сендвіч-МДФ оздоблення, гнутий профіль і три контури примикання допомагають зберігати тепло та зменшувати шум.'),
  ('catalog-266', 'Страж PROOF Vega Maxi — вхідні двері для будинку зі склопакетом та акцентом на сучасний дизайн. Сталеве полотно 85 мм, сендвіч-МДФ конструкція, три контури примикання і високий рівень тепло- та шумоізоляції.'),
  ('catalog-269', 'Страж Delica AL Mono — вхідні двері для квартири з МДФ-накладками з обох боків. Полотно товщиною 95 мм, метал 1,8 мм і три контури примикання поєднують сучасний вигляд, тепло- та шумоізоляцію.'),
  ('catalog-270', 'Страж Fusion Vertical — сучасні квартирні двері з МДФ-накладками з обох боків. Полотно 105 мм, метал 1,5 мм і чотири контури примикання забезпечують комфорт, тепло- та шумоізоляцію.'),
  ('catalog-272', 'Страж Slim S Glass-A — сучасні вхідні двері для квартири з декоративним склінням. Сталеве полотно 95 мм, метал 1,8 мм і три контури примикання забезпечують надійність та високий рівень шумоізоляції.'),
  ('catalog-274', 'Страж Tira — сучасні вхідні двері для квартири з МДФ-накладками з обох боків. Полотно 105 мм, метал 1,5 мм і чотири контури примикання допомагають забезпечити тепло та тишу в оселі.')
) as source(slug, description)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-263', 'main', 'Страж PROOF Rio-S Loft — дуб золотий', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/28463/dveri-rio-s-loft-dub-zolotij-strazh-main.jpg', 0),
  ('catalog-264', 'main', 'Страж PROOF Slim S — антрацит', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/27277/dveri-slim-s-antratsit-strazh-main.jpg', 0),
  ('catalog-266', 'main', 'Страж PROOF Vega Maxi — дуб 23', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/210481/dveri-vega-maxi-dub-23-strazh-main.jpg', 0),
  ('catalog-269', 'main', 'Страж Delica AL Mono — антрацит', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/210232/dveri-delica-al-antratsit-strazh-main.jpg', 0),
  ('catalog-270', 'main', 'Страж Fusion Vertical', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/212479/dveri-fusion-vertical-4k-2-kolori-strazh-main.jpg', 0),
  ('catalog-272', 'main', 'Страж Slim S Glass-A', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/210953/dveri-slim-s-glass-a-strazh-main.jpg', 0),
  ('catalog-274', 'main', 'Страж Tira', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/212480/dveri-tira-4k-strazh-main.jpg', 0)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1 from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);

-- Точні характеристики з карток відповідних моделей Market Dveri.
-- Зберігаємо їх окремими полями, щоб вони зручно показувалися на сайті.
insert into public.product_specs (product_slug, label, value, sort_order)
values
  ('catalog-263', 'Призначення', 'Одинарні вхідні двері', 100),
  ('catalog-263', 'Матеріал фасону', 'Стальний лист', 110),
  ('catalog-263', 'Тип фасону', 'Сендвіч-МДФ', 120),
  ('catalog-263', 'Стиль накладок', 'Модерн', 130),
  ('catalog-263', 'Товщина полотна', '85 мм', 140),
  ('catalog-263', 'Товщина металу', '1,5 мм', 150),
  ('catalog-263', 'Контури примикання', '3 контури', 160),
  ('catalog-263', 'Теплоізоляція', 'Висока', 170),
  ('catalog-263', 'Шумоізоляція', 'Високий рівень', 180),

  ('catalog-264', 'Призначення', 'Для будинку, зі склопакетом', 100),
  ('catalog-264', 'Матеріал фасону', 'Стальний лист', 110),
  ('catalog-264', 'Тип фасону', 'Сендвіч-МДФ', 120),
  ('catalog-264', 'Стиль накладок', 'Модерн', 130),
  ('catalog-264', 'Товщина полотна', '85 мм', 140),
  ('catalog-264', 'Товщина металу', '1,5 мм', 150),
  ('catalog-264', 'Контури примикання', '3 контури', 160),
  ('catalog-264', 'Теплоізоляція', 'Висока', 170),
  ('catalog-264', 'Шумоізоляція', 'Високий рівень', 180),

  ('catalog-266', 'Призначення', 'Для будинку, зі склопакетом', 100),
  ('catalog-266', 'Матеріал фасону', 'Стальний лист', 110),
  ('catalog-266', 'Тип фасону', 'Сендвіч-МДФ', 120),
  ('catalog-266', 'Стиль накладок', 'Модерн', 130),
  ('catalog-266', 'Товщина полотна', '85 мм', 140),
  ('catalog-266', 'Товщина металу', '1,5 мм', 150),
  ('catalog-266', 'Контури примикання', '3 контури', 160),
  ('catalog-266', 'Теплоізоляція', 'Висока', 170),
  ('catalog-266', 'Шумоізоляція', 'Високий рівень', 180),

  ('catalog-269', 'Призначення', 'Для квартири', 100),
  ('catalog-269', 'Матеріал фасону', 'МДФ-накладки', 110),
  ('catalog-269', 'Тип фасону', 'МДФ-МДФ', 120),
  ('catalog-269', 'Стиль накладок', 'Модерн', 130),
  ('catalog-269', 'Товщина полотна', '95 мм', 140),
  ('catalog-269', 'Товщина металу', '1,8 мм', 150),
  ('catalog-269', 'Контури примикання', '3 контури', 160),
  ('catalog-269', 'Теплоізоляція', 'Висока', 170),
  ('catalog-269', 'Шумоізоляція', 'Високий рівень', 180),

  ('catalog-270', 'Призначення', 'Для квартири', 100),
  ('catalog-270', 'Матеріал фасону', 'МДФ-накладки', 110),
  ('catalog-270', 'Тип фасону', 'МДФ-МДФ', 120),
  ('catalog-270', 'Стиль накладок', 'Модерн', 130),
  ('catalog-270', 'Товщина полотна', '105 мм', 140),
  ('catalog-270', 'Товщина металу', '1,5 мм', 150),
  ('catalog-270', 'Контури примикання', '4 контури', 160),
  ('catalog-270', 'Теплоізоляція', 'Висока', 170),
  ('catalog-270', 'Шумоізоляція', 'Високий рівень', 180),

  ('catalog-272', 'Призначення', 'Для квартири', 100),
  ('catalog-272', 'Матеріал фасону', 'Стальний лист', 110),
  ('catalog-272', 'Тип фасону', 'Сендвіч-МДФ', 120),
  ('catalog-272', 'Стиль накладок', 'Модерн', 130),
  ('catalog-272', 'Товщина полотна', '95 мм', 140),
  ('catalog-272', 'Товщина металу', '1,8 мм', 150),
  ('catalog-272', 'Контури примикання', '3 контури', 160),
  ('catalog-272', 'Теплоізоляція', 'Висока', 170),
  ('catalog-272', 'Шумоізоляція', 'Високий рівень', 180),

  ('catalog-274', 'Призначення', 'Для квартири', 100),
  ('catalog-274', 'Матеріал фасону', 'МДФ-накладки', 110),
  ('catalog-274', 'Тип фасону', 'МДФ-МДФ', 120),
  ('catalog-274', 'Стиль накладок', 'Модерн', 130),
  ('catalog-274', 'Товщина полотна', '105 мм', 140),
  ('catalog-274', 'Товщина металу', '1,5 мм', 150),
  ('catalog-274', 'Контури примикання', '4 контури', 160),
  ('catalog-274', 'Теплоізоляція', 'Висока', 170),
  ('catalog-274', 'Шумоізоляція', 'Високий рівень', 180)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
