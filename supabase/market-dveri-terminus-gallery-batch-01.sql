-- Market Dveri — Terminus: перевірені додаткові ракурси моделей.
-- Додає лише фото галереї. Скрипт можна запускати повторно.

insert into public.product_media (product_slug, kind, label, image_path, sort_order) values
  ('catalog-300','gallery','Elit Plus 109 · ракурс 1','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24081/dveri-terminus-elit-plus-109-1.jpg',10),
  ('catalog-300','gallery','Elit Plus 109 · ракурс 2','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24081/dveri-terminus-elit-plus-109-2.jpg',11),
  ('catalog-301','gallery','Elit Plus 111 · ракурс 1','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24082/dveri-terminus-elit-plus-111-1.jpg',10),
  ('catalog-301','gallery','Elit Plus 111 · ракурс 2','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24082/dveri-terminus-elit-plus-111-2.jpg',11),
  ('catalog-302','gallery','Elit Plus 112 · ракурс 1','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24083/dveri-terminus-elit-plus-112-1.jpg',10),
  ('catalog-302','gallery','Elit Plus 112 · ракурс 2','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/24083/dveri-terminus-elit-plus-112-2.jpg',11),
  ('catalog-308','gallery','Frezato 29 · додатковий ракурс','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215330/dveri-terminus-frezato-29-1.jpg',10),
  ('catalog-322','gallery','Frezato 714 · ракурс 1','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215331/dveri-terminus-frezato-714-1.jpg',10),
  ('catalog-322','gallery','Frezato 714 · ракурс 2','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215331/dveri-terminus-frezato-714-2.jpg',11),
  ('catalog-323','gallery','Frezato 715 · ракурс 1','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215332/dveri-terminus-frezato-715-1.jpg',10),
  ('catalog-323','gallery','Frezato 715 · ракурс 2','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215332/dveri-terminus-frezato-715-2.jpg',11)
on conflict (product_slug, kind, image_path) do update
set label = excluded.label, sort_order = excluded.sort_order, is_active = true;
