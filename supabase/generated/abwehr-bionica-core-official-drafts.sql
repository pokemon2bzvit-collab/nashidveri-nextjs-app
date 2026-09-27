-- ABWEHR BIONICA COMBO: remaining distinct core designs and one transom execution.
-- No existing product is modified, deleted, or published.

begin;

create temporary table abwehr_bionica_core_models (
  slug text primary key,
  name text not null,
  product_code text not null,
  source_url text not null,
  construction_type text not null,
  main_image text not null
) on commit drop;

insert into abwehr_bionica_core_models values
  ('abwehr-bionica-ufo', 'Abwehr Ufo', '367', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-ufo-komplektaciya-bionica-combo/p1654', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/Kc5nKaJsg6uvTyuUjMY3C5YVk01ehR8VuKPy2QPn.jpg.webp?v=1771580109'),
  ('abwehr-bionica-country', 'Abwehr Country', '501', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-country-komplektaciya-bionica-combo-1/p1407', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/FtthV0xmR8ApIqYsBHR3m6Dh9nAjepMWwy1CkPIl.jpg.webp?v=1771579653'),
  ('abwehr-bionica-olimpia', 'Abwehr Olimpia', 'LP3', 'https://abwehr.com.ua/catalog/dveri-z-termorozrivom-model-olimpia-komplektaciya-bionica-combo/p1155', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/dob4D1m3lsobMtANgn9CebnrZKQJIceewFkd5OfO.jpg.webp?v=1777377952'),
  ('abwehr-bionica-trees', 'Abwehr Trees', 'LP9', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-trees-komplektaciya-bionica-combo-1/p1493', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/kpAhRYTT6NAyjvBzi4xDi3RIM1WwJ9vqTOX21Y6z.jpg.webp?v=1777021930'),
  ('abwehr-bionica-ufo-black-transom', 'Abwehr Ufo Black з фрамугою', '496', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-framugoyu-ta-termorozrivom-model-ufo-black-komplektaciya-bionica-combo-1/p1376', 'Вхідні двері з фрамугою', 'https://abwehr.com.ua/storage/products/images/big/cHs9KqZ6P647GTWBpgB1YEPdvkaitsp4TaFSkc0p.jpg.webp?v=1771581879'),
  ('abwehr-bionica-revolution', 'Abwehr Revolution', 'LP6', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-revolution-komplektaciya-bionica-combo-4/p1725', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/XSVETjz3Fjqx6jEQ567gByuPbp4aHg8Lb0yuWJn9.jpg.webp?v=1787815591');

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  model.slug, 'entrance', 'Abwehr', 'Bionica Combo', model.name,
  'Сталь, МДФ-накладки та заводські атмосферостійкі покриття',
  'Сучасний', 'Заводські декори', 'Ціна за запитом',
  model.name || ' — ' || lower(model.construction_type) || ' колекції Bionica Combo. Терморозрив і три контури ущільнення допомагають підтримувати комфорт у приміщенні; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Колекція Bionica Combo', 'Терморозрив', '3 контури ущільнення'),
  model.main_image, 99999, false
from abwehr_bionica_core_models model
on conflict (slug) do update set
  name = excluded.name, material = excluded.material, style = excluded.style,
  color = excluded.color, description = excluded.description, features = excluded.features,
  image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select model.slug, spec.label, spec.value, spec.sort_order, true
from abwehr_bionica_core_models model
cross join lateral (
  values
    ('Тип конструкції', model.construction_type, 10),
    ('Колекція', 'Bionica Combo', 20),
    ('Призначення', 'Для приватного будинку', 30),
    ('Терморозрив', 'Так', 40),
    ('Контури ущільнення', '3 контури', 50)
) as spec(label, value, sort_order)
on conflict (product_slug, label) do update set
  value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes
)
select model.slug, 'ABWEHR', model.source_url,
  model.name || ' · Bionica Combo · код ' || model.product_code,
  'verified', now(),
  'Офіційна картка виробника: окрема модель Bionica Combo та фотогалерея.'
from abwehr_bionica_core_models model
where not exists (
  select 1 from public.product_sources source
  where source.product_slug = model.slug and source.source_url = model.source_url
);

create temporary table abwehr_bionica_core_gallery (
  product_slug text not null,
  image_path text not null,
  sort_order integer not null
) on commit drop;

insert into abwehr_bionica_core_gallery values
  ('abwehr-bionica-ufo', 'https://abwehr.com.ua/storage/products/images/big/Kc5nKaJsg6uvTyuUjMY3C5YVk01ehR8VuKPy2QPn.jpg.webp?v=1771580109', 1),
  ('abwehr-bionica-ufo', 'https://abwehr.com.ua/storage/products/images/big/zFbzTYwrLtl43tLZD19llAkwdiSqOT0ywt2SQYjr.jpg.webp?v=1771584261', 2),
  ('abwehr-bionica-ufo', 'https://abwehr.com.ua/storage/products/images/big/qQnG9sSQCilTLekVYrNY4gezgJDhD446nZVP7mVw.jpg.webp?v=1771583361', 3),
  ('abwehr-bionica-ufo', 'https://abwehr.com.ua/storage/products/images/big/ukIDBmPemwgakmMD1asa9a4YBR4tL6K7I4Vm0dKw.jpg.webp?v=1771583826', 4),
  ('abwehr-bionica-ufo', 'https://abwehr.com.ua/storage/products/images/big/Igpdsch48yT6zapyw8WVyAinc8v5Hhyx7wSyDYU3.jpg.webp?v=1771579938', 5),
  ('abwehr-bionica-country', 'https://abwehr.com.ua/storage/products/images/big/FtthV0xmR8ApIqYsBHR3m6Dh9nAjepMWwy1CkPIl.jpg.webp?v=1771579653', 1),
  ('abwehr-bionica-country', 'https://abwehr.com.ua/storage/products/images/big/SZ7E8a3fXDcvNYTf4Nj87FGipmKvW7AGqiSTP9sX.jpg.webp?v=1771580902', 2),
  ('abwehr-bionica-country', 'https://abwehr.com.ua/storage/products/images/big/ciAyTFg3LF54TblCBdFfv6IR2UdYNLYwKiPsqqHp.jpg.webp?v=1771581919', 3),
  ('abwehr-bionica-country', 'https://abwehr.com.ua/storage/products/images/big/YaFc7MALRivsZ8cQ770o2XmZwxdtt2JKEgYg9aOp.jpg.webp?v=1771581507', 4),
  ('abwehr-bionica-country', 'https://abwehr.com.ua/storage/products/images/big/HwfKvg296ShuYQQzRBi8zMjUXiGJR44ZkmrhcqWp.jpg.webp?v=1771579875', 5),
  ('abwehr-bionica-olimpia', 'https://abwehr.com.ua/storage/products/images/big/dob4D1m3lsobMtANgn9CebnrZKQJIceewFkd5OfO.jpg.webp?v=1777377952', 1),
  ('abwehr-bionica-olimpia', 'https://abwehr.com.ua/storage/products/images/big/b2rw58JJoVOPz5UCU5a0c8jAJgNtIIDFgfz9eR3Z.jpg.webp?v=1771581744', 2),
  ('abwehr-bionica-olimpia', 'https://abwehr.com.ua/storage/products/images/big/3NT2vOK2GKlQAyHlZfc3P3JD8Xw7E2gv5YOncxhp.jpg.webp?v=1771578324', 3),
  ('abwehr-bionica-olimpia', 'https://abwehr.com.ua/storage/products/images/big/fCI33yMmCKOD78nzOqBwq5m8dxM0sXHvFovMeUNr.jpg.webp?v=1771582172', 4),
  ('abwehr-bionica-olimpia', 'https://abwehr.com.ua/storage/products/images/big/6ITF2mT7MCZ9Bf10qzy9vS3mjh4eQX1Nmcj6LzyN.jpg.webp?v=1771578643', 5),
  ('abwehr-bionica-trees', 'https://abwehr.com.ua/storage/products/images/big/kpAhRYTT6NAyjvBzi4xDi3RIM1WwJ9vqTOX21Y6z.jpg.webp?v=1777021930', 1),
  ('abwehr-bionica-trees', 'https://abwehr.com.ua/storage/products/images/big/wkxQQtFG3et7vKtfVRVPCBlgA6ctphCN5O6PQCYp.jpg.webp?v=1771584019', 2),
  ('abwehr-bionica-trees', 'https://abwehr.com.ua/storage/products/images/big/deOHwEMdvLnkPXtFyHzEiurk0CMIMQHPnyO4LzLX.jpg.webp?v=1771582026', 3),
  ('abwehr-bionica-trees', 'https://abwehr.com.ua/storage/products/images/big/8b0DNBzHUdgXvRRMAvwBS1plSoitkkE3Gs7LwcRY.jpg.webp?v=1771578876', 4),
  ('abwehr-bionica-trees', 'https://abwehr.com.ua/storage/products/images/big/U8cHgebgO2s3sPKZrBpAj3pd6K1KAAJx12gY2NXw.jpg.webp?v=1771581069', 5),
  ('abwehr-bionica-ufo-black-transom', 'https://abwehr.com.ua/storage/products/images/big/cHs9KqZ6P647GTWBpgB1YEPdvkaitsp4TaFSkc0p.jpg.webp?v=1771581879', 1),
  ('abwehr-bionica-ufo-black-transom', 'https://abwehr.com.ua/storage/products/images/big/fG6VP7FEo4k6PwcanHGXa5P6nmYyJgGMTzKHSf6M.jpg.webp?v=1771582177', 2),
  ('abwehr-bionica-ufo-black-transom', 'https://abwehr.com.ua/storage/products/images/big/tPbmTk9a9fsEdCHYbdM57ppsa3jF8RDmanNwYZv6.jpg.webp?v=1771583686', 3),
  ('abwehr-bionica-ufo-black-transom', 'https://abwehr.com.ua/storage/products/images/big/djwUg3LTcV1aYbjPZNS3Xg90NWEtsj29Hxe3VotP.jpg.webp?v=1771582034', 4),
  ('abwehr-bionica-ufo-black-transom', 'https://abwehr.com.ua/storage/products/images/big/f4Tz2gTC5ohAAZEg1F5H48gIunRLboXLCdsnXRPm.jpg.webp?v=1771582160', 5),
  ('abwehr-bionica-revolution', 'https://abwehr.com.ua/storage/products/images/big/XSVETjz3Fjqx6jEQ567gByuPbp4aHg8Lb0yuWJn9.jpg.webp?v=1787815591', 1),
  ('abwehr-bionica-revolution', 'https://abwehr.com.ua/storage/products/images/big/fLeEi8ed1LD1dO3SryB4unl6J6OuHCfAE2JvhG0J.jpg.webp?v=1787816349', 2),
  ('abwehr-bionica-revolution', 'https://abwehr.com.ua/storage/products/images/big/DGWqfD6gThUtOM8CSJGNOV2Q5PyRc0FgieYfYKMK.jpg.webp?v=1787815593', 3),
  ('abwehr-bionica-revolution', 'https://abwehr.com.ua/storage/products/images/big/iKAvc2NEt6VjQudhuAylifdpIbJZsuiIjQh03qGd.jpg.webp?v=1787815591', 4),
  ('abwehr-bionica-revolution', 'https://abwehr.com.ua/storage/products/images/big/djaK2r0rINlxVWY3bMCHESI2VdxDMtEgW8yj9GnY.jpg.webp?v=1787815591', 5);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0
from abwehr_bionica_core_models model
where not exists (
  select 1 from public.product_media media
  where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image
);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select product_slug, 'gallery', 'Офіційне фото ' || sort_order, image_path, sort_order
from abwehr_bionica_core_gallery gallery
where not exists (
  select 1 from public.product_media media
  where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug in (
    'abwehr-bionica-ufo', 'abwehr-bionica-country', 'abwehr-bionica-olimpia',
    'abwehr-bionica-trees', 'abwehr-bionica-ufo-black-transom', 'abwehr-bionica-revolution'
  ) and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in (
  'abwehr-bionica-ufo', 'abwehr-bionica-country', 'abwehr-bionica-olimpia',
  'abwehr-bionica-trees', 'abwehr-bionica-ufo-black-transom', 'abwehr-bionica-revolution'
);
