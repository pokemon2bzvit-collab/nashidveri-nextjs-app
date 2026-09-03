-- Market Dveri — Страж: точні додаткові ракурси моделей.
-- Скрипт можна запускати повторно.

insert into public.product_media (product_slug, kind, label, image_path, sort_order) values
  ('catalog-288','gallery','PROOF Rio-S Loft · ракурс 1','https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/28463/dveri-rio-s-loft-dub-zolotij-strazh-1.jpg',10),
  ('catalog-288','gallery','PROOF Rio-S Loft · ракурс 2','https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/28463/dveri-rio-s-loft-dub-zolotij-strazh-2.jpg',11),
  ('catalog-290','gallery','PROOF Slim S · додатковий ракурс','https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/27277/dveri-slim-s-antratsit-strazh-1.jpg',10),
  ('catalog-291','gallery','ROOF Vega Maxi · додатковий ракурс','https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/210481/dveri-vega-maxi-dub-23-strazh-1.jpg',10),
  ('catalog-292','gallery','Standart Mirage · додатковий ракурс','https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/22055/dveri-mirage-strazh-1.jpg',10)
on conflict (product_slug, kind, image_path) do update
set label = excluded.label, sort_order = excluded.sort_order, is_active = true;
