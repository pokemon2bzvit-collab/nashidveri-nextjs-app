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
