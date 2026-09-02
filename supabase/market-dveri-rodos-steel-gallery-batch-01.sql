-- Market Dveri — Rodos Steel: перевірені додаткові ракурси.
-- Скрипт можна запускати повторно.

insert into public.product_media (product_slug, kind, label, image_path, sort_order) values
  ('catalog-172','gallery','Rodos Steel F 124 · ракурс 1','https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/226130/dveri-stz-f-124-rodos-steel-1.jpg',10),
  ('catalog-172','gallery','Rodos Steel F 124 · ракурс 2','https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/226130/dveri-stz-f-124-rodos-steel-2.jpg',11),
  ('catalog-176','gallery','Rodos Steel F 141 · ракурс 1','https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/226126/dveri-stz-f-141-rodos-steel-1.jpg',10),
  ('catalog-176','gallery','Rodos Steel F 141 · ракурс 2','https://market-dveri.ua/image/catalog/product/vhidni-dveri/rodos-steel/226126/dveri-stz-f-141-rodos-steel-2.jpg',11)
on conflict (product_slug, kind, image_path) do update
set label = excluded.label, sort_order = excluded.sort_order, is_active = true;
