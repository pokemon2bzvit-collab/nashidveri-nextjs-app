-- Market Dveri — StilDoors: точні додаткові ракурси моделей.
-- Скрипт можна запускати повторно.

insert into public.product_media (product_slug, kind, label, image_path, sort_order) values
  ('catalog-78','gallery','Arizona · додатковий ракурс','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28299/dveri-stildoors-arizona-1.jpg',10),
  ('catalog-80','gallery','Cuba · додатковий ракурс','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212855/dveri-stildoors-cuba-1.jpg',10),
  ('catalog-81','gallery','Florida · ракурс 1','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212854/dveri-stildoors-florida-1.jpg',10),
  ('catalog-81','gallery','Florida · ракурс 2','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212854/dveri-stildoors-florida-2.jpg',11),
  ('catalog-81','gallery','Florida · ракурс 3','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/212854/dveri-stildoors-florida-3.jpg',12),
  ('catalog-82','gallery','London · ракурс 1','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28302/dveri-stildoors-london-1.jpg',10),
  ('catalog-82','gallery','London · ракурс 2','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28302/dveri-stildoors-london-2.jpg',11),
  ('catalog-83','gallery','Mexico · ракурс 1','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28304/dveri-stildoors-mexico-1.jpg',10),
  ('catalog-83','gallery','Mexico · ракурс 2','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28304/dveri-stildoors-mexico-2.jpg',11),
  ('catalog-83','gallery','Mexico · ракурс 3','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28304/dveri-stildoors-mexico-3.jpg',12),
  ('catalog-84','gallery','Slovenia · ракурс 1','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28308/dveri-stildoors-slovenia-1.jpg',10),
  ('catalog-84','gallery','Slovenia · ракурс 2','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/stildoors/28308/dveri-stildoors-slovenia-2.jpg',11)
on conflict (product_slug, kind, image_path) do update
set label = excluded.label, sort_order = excluded.sort_order, is_active = true;
