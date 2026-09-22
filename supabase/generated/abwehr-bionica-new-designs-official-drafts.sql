-- ABWEHR BIONICA COMBO: additional distinct designs as hidden drafts.
-- No existing product is modified, deleted, or published.

begin;

create temporary table abwehr_bionica_new_designs (
  slug text primary key, name text not null, product_code text not null,
  source_url text not null, construction_type text not null, main_image text not null
) on commit drop;

insert into abwehr_bionica_new_designs values
  ('abwehr-bionica-zariela', 'Abwehr Zariela', '303', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-zariela-komplektaciya-bionica-combo/p1325', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/XuA50WvpSXJ7T9i77g8JYaK8DtK5J796XakqKhRy.jpg.webp?v=1771581444'),
  ('abwehr-bionica-zariela-glass', 'Abwehr Zariela Glass', '303', 'https://abwehr.com.ua/catalog/vhidni-dveri-zi-sklom-model-zariela-glass-komplektaciya-bionica-combo-1/p1555', 'Вхідні двері зі склопакетом для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/2VMhwzqfvo6bIK2yYq1liyAY8DXi2RQrC4jlAqeR.jpg.webp?v=1771578237'),
  ('abwehr-bionica-fortezza', 'Abwehr Fortezza', '463', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-fortezza-komplektaciya-bionica-combo/p1613', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/9e5uCJSCOVpxXvGEcv4FVLl59JJrGYCiApTia4JA.jpg.webp?v=1771578992'),
  ('abwehr-bionica-fortezza-glass', 'Abwehr Fortezza Glass', '463', 'https://abwehr.com.ua/catalog/vhidni-dveri-zi-sklom-model-fortezza-komplektaciya-bionica-combo/p1138', 'Вхідні двері зі склопакетом для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/3f9ZjjTPLEkCqfliCCwp55gRYoSNj9YOzbJx1DUj.jpg.webp?v=1771578352'),
  ('abwehr-bionica-riverton', 'Abwehr Riverton', 'LP13', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-pokrittyam-lampre-model-riverton-komplektaciya-bionica-combo/p1576', 'Вхідні двері з покриттям Lampre', 'https://abwehr.com.ua/storage/products/images/big/vJyX6Qiga7e07Ypeo1MWI2tRvQp0Qzl8dq7Bj6SB.jpg.webp?v=1771583875'),
  ('abwehr-bionica-siena-1200', 'Abwehr Siena 1200', '560', 'https://abwehr.com.ua/catalog/vhidni-polutorni-dveri-model-siena-komplektaciya-bionica-combo-1200/p1404', 'Напівторастулкові двері 1200 мм', 'https://abwehr.com.ua/storage/products/images/big/IYINoR2xZuMrPC47nzFpew4ZwUn1W2pnY9hM7sJd.jpg.webp?v=1771579930');

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select model.slug, 'entrance', 'Abwehr', 'Bionica Combo', model.name,
  'Сталь, МДФ-накладки та заводські атмосферостійкі покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом',
  model.name || ' — ' || lower(model.construction_type) || ' колекції Bionica Combo. Терморозрив і три контури ущільнення допомагають підтримувати комфорт у приміщенні; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Колекція Bionica Combo', 'Терморозрив', '3 контури ущільнення'), model.main_image, 99999, false
from abwehr_bionica_new_designs model
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select model.slug, spec.label, spec.value, spec.sort_order, true
from abwehr_bionica_new_designs model
cross join lateral (values
  ('Тип конструкції', model.construction_type, 10),
  ('Колекція', 'Bionica Combo', 20),
  ('Призначення', 'Для приватного будинку', 30),
  ('Терморозрив', 'Так', 40),
  ('Контури ущільнення', '3 контури', 50)
) as spec(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select model.slug, 'ABWEHR', model.source_url, model.name || ' · Bionica Combo · код ' || model.product_code,
  'verified', now(), 'Офіційна картка виробника: окрема модель Bionica Combo та фотогалерея.'
from abwehr_bionica_new_designs model
where not exists (select 1 from public.product_sources source where source.product_slug = model.slug and source.source_url = model.source_url);

create temporary table abwehr_bionica_new_designs_gallery (product_slug text not null, image_path text not null, sort_order integer not null) on commit drop;

insert into abwehr_bionica_new_designs_gallery values
  ('abwehr-bionica-zariela', 'https://abwehr.com.ua/storage/products/images/big/XuA50WvpSXJ7T9i77g8JYaK8DtK5J796XakqKhRy.jpg.webp?v=1771581444', 1), ('abwehr-bionica-zariela', 'https://abwehr.com.ua/storage/products/images/big/2ZuXp16nAd8LWpC2HbB633a1frtrZBL25QcP8ZR1.jpg.webp?v=1771578245', 2), ('abwehr-bionica-zariela', 'https://abwehr.com.ua/storage/products/images/big/lN5EUAXhXCxdrTT6AUpWZkraQM2FMTAvNOMzUvQR.jpg.webp?v=1771582798', 3), ('abwehr-bionica-zariela', 'https://abwehr.com.ua/storage/products/images/big/UuWgeL08tGQqS8WANm9ahQ9Q9dNyxuVlP5LFnMaw.jpg.webp?v=1771581138', 4), ('abwehr-bionica-zariela', 'https://abwehr.com.ua/storage/products/images/big/HI2clSGLz60ukJb6qomub0EzyKBQFsPQvNvTY1PD.jpg.webp?v=1771579809', 5),
  ('abwehr-bionica-zariela-glass', 'https://abwehr.com.ua/storage/products/images/big/2VMhwzqfvo6bIK2yYq1liyAY8DXi2RQrC4jlAqeR.jpg.webp?v=1771578237', 1), ('abwehr-bionica-zariela-glass', 'https://abwehr.com.ua/storage/products/images/big/RSRewfiVTwi8pMdOyvGblKlcMdcv0KTsuGysS7IF.jpg.webp?v=1771580779', 2), ('abwehr-bionica-zariela-glass', 'https://abwehr.com.ua/storage/products/images/big/6w6V2UvixTgh1pmIya5v7l2stEjt37Bvn28kFb0c.jpg.webp?v=1771578711', 3), ('abwehr-bionica-zariela-glass', 'https://abwehr.com.ua/storage/products/images/big/UtoEeuT02CXfJFIR66Cbj66VHbdeUIjOmdGDyDyH.jpg.webp?v=1771581137', 4), ('abwehr-bionica-zariela-glass', 'https://abwehr.com.ua/storage/products/images/big/KLtZF9kAKdMAOkvLjv8taSxY96JgIcRGcjcPBgdd.jpg.webp?v=1771580083', 5),
  ('abwehr-bionica-fortezza', 'https://abwehr.com.ua/storage/products/images/big/9e5uCJSCOVpxXvGEcv4FVLl59JJrGYCiApTia4JA.jpg.webp?v=1771578992', 1), ('abwehr-bionica-fortezza', 'https://abwehr.com.ua/storage/products/images/big/gN4RPmMMZCF3pYXJicUEFLOr7eSZ0GesxeC3DKH9.jpg.webp?v=1771582294', 2), ('abwehr-bionica-fortezza', 'https://abwehr.com.ua/storage/products/images/big/VD0MRU4UOzLbXjFon1f9cMHUXkublZ6tyoKZ6WB9.jpg.webp?v=1771581170', 3), ('abwehr-bionica-fortezza', 'https://abwehr.com.ua/storage/products/images/big/NCCFrSTA1vgpfq9DY57jpxih3bZg4uvLURhmETLl.jpg.webp?v=1771580351', 4), ('abwehr-bionica-fortezza', 'https://abwehr.com.ua/storage/products/images/big/7Tma0T9fxxqwY8JPV99uVyZdCnOEeyNk05qhjmsU.jpg.webp?v=1771578765', 5),
  ('abwehr-bionica-fortezza-glass', 'https://abwehr.com.ua/storage/products/images/big/3f9ZjjTPLEkCqfliCCwp55gRYoSNj9YOzbJx1DUj.jpg.webp?v=1771578352', 1), ('abwehr-bionica-fortezza-glass', 'https://abwehr.com.ua/storage/products/images/big/ZldikBiloMBRPdKAmTtHxz9KqjjTpczBtFOjSXEK.jpg.webp?v=1771581613', 2), ('abwehr-bionica-fortezza-glass', 'https://abwehr.com.ua/storage/products/images/big/hBylKumnHt29lYgCdmAObIBdIhsezRrSfp8ugWE8.jpg.webp?v=1771582372', 3), ('abwehr-bionica-fortezza-glass', 'https://abwehr.com.ua/storage/products/images/big/nGBbq2oxDliAB9yUvTx6iLszXdQygGdtH6ucQveO.jpg.webp?v=1771582997', 4), ('abwehr-bionica-fortezza-glass', 'https://abwehr.com.ua/storage/products/images/big/BTrP5IpBbGqq1vHtLGR2vucSXUYwY4OhTQTauwme.jpg.webp?v=1771579200', 5),
  ('abwehr-bionica-riverton', 'https://abwehr.com.ua/storage/products/images/big/vJyX6Qiga7e07Ypeo1MWI2tRvQp0Qzl8dq7Bj6SB.jpg.webp?v=1771583875', 1), ('abwehr-bionica-riverton', 'https://abwehr.com.ua/storage/products/images/big/1OEuuKDDwJdWxwJGQH8Ah7nPrfX3595b7NETSvYA.jpg.webp?v=1771578131', 2), ('abwehr-bionica-riverton', 'https://abwehr.com.ua/storage/products/images/big/3bImyRVi5WfFspmXhFDp4uP1AVGOHayhrZNtVWhI.jpg.webp?v=1771578348', 3), ('abwehr-bionica-riverton', 'https://abwehr.com.ua/storage/products/images/big/iIb9LjQRu6i86nzgPe1BNEQalgEmvO2dmD3XQGcC.jpg.webp?v=1771582482', 4), ('abwehr-bionica-riverton', 'https://abwehr.com.ua/storage/products/images/big/ZJUqt3mXU3HdX4lvAirbyubue4qytIp6qEzNxd4y.jpg.webp?v=1771581576', 5),
  ('abwehr-bionica-siena-1200', 'https://abwehr.com.ua/storage/products/images/big/IYINoR2xZuMrPC47nzFpew4ZwUn1W2pnY9hM7sJd.jpg.webp?v=1771579930', 1), ('abwehr-bionica-siena-1200', 'https://abwehr.com.ua/storage/products/images/big/sYT79F6QEihWNADJYZCMU6YTxV2gid7NkYz5D3jG.jpg.webp?v=1771583584', 2), ('abwehr-bionica-siena-1200', 'https://abwehr.com.ua/storage/products/images/big/tmGP4V70W8TLPC4xmGGoWVD2eOYojAxvlVzioglD.jpg.webp?v=1771583732', 3), ('abwehr-bionica-siena-1200', 'https://abwehr.com.ua/storage/products/images/big/if1CtDA3hstULyzc7ld61uvowgL4HgkpgyWLE0Z2.jpg.webp?v=1771582523', 4), ('abwehr-bionica-siena-1200', 'https://abwehr.com.ua/storage/products/images/big/qZDrzRm9e0xDYywbCTBwj9APV7Bktaf4YccsAsKy.jpg.webp?v=1771583379', 5);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0 from abwehr_bionica_new_designs model
where not exists (select 1 from public.product_media media where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select product_slug, 'gallery', 'Офіційне фото ' || sort_order, image_path, sort_order from abwehr_bionica_new_designs_gallery gallery
where not exists (select 1 from public.product_media media where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path);

commit;

select count(*) as моделей, count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug in ('abwehr-bionica-zariela', 'abwehr-bionica-zariela-glass', 'abwehr-bionica-fortezza', 'abwehr-bionica-fortezza-glass', 'abwehr-bionica-riverton', 'abwehr-bionica-siena-1200') and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in ('abwehr-bionica-zariela', 'abwehr-bionica-zariela-glass', 'abwehr-bionica-fortezza', 'abwehr-bionica-fortezza-glass', 'abwehr-bionica-riverton', 'abwehr-bionica-siena-1200');
