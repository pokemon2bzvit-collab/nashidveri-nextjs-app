-- ABWEHR FRAME: first five standalone designs as hidden drafts.
-- No current product is modified, deleted, or published.

begin;

create temporary table abwehr_frame_models (
  slug text primary key,
  name text not null,
  product_code text not null,
  source_url text not null,
  main_image text not null
) on commit drop;

insert into abwehr_frame_models values
  ('abwehr-frame-adriatica', 'Abwehr Adriatica', '999', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-model-adriatica-komplektaciya-frame-1/p1618', 'https://abwehr.com.ua/storage/products/images/big/HdgHy2ZY2BRISnb9x5aXO7NxeVieG4EdTrOpyN6b.jpg.webp?v=1771579840'),
  ('abwehr-frame-leavia', 'Abwehr Leavia', '188', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-model-leavia-komplektaciya-frame/p1457', 'https://abwehr.com.ua/storage/products/images/big/xn6ljdkvzSSka7AYBmzBgbzTHZyh3xzbXxJjBzzA.jpg.webp?v=1771584133'),
  ('abwehr-frame-simpli', 'Abwehr Simpli', '0', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-ta-dotyaguvachem-model-simpli-komplektaciya-frame/p1486', 'https://abwehr.com.ua/storage/products/images/big/28RFERW3wujmbbpLHJTRX9hIc96mcd2aeSPlWVjS.jpg.webp?v=1771578199'),
  ('abwehr-frame-scandi', 'Abwehr Scandi', '498', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-model-scandi-komplektaciya-frame-1/p1392', 'https://abwehr.com.ua/storage/products/images/big/l0jbsaPwenSJX1v9nKFjOJyFfQ0WqOv5387PXSJC.jpg.webp?v=1771582753'),
  ('abwehr-frame-ufo-black', 'Abwehr Ufo Black', '496', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-model-ufo-black-komplektaciya-frame/p1363', 'https://abwehr.com.ua/storage/products/images/big/ewOfWCq2gv9WhXv71H1ZZk0RNcYo2TXP1hbTvWBx.jpg.webp?v=1771582147');

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  model.slug,
  'entrance',
  'Abwehr',
  'Frame',
  model.name,
  'Сталь, вологостійкий МДФ та заводські покриття',
  'Сучасний',
  'Заводські декори',
  'Ціна за запитом',
  model.name || ' — нестандартні вхідні двері Abwehr колекції Frame для приватного будинку. Рамкова конструкція, терморозрив і можливість підібрати розмір, фрамугу та декор дають змогу адаптувати модель під конкретний проріз. Актуальну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Колекція Frame', 'Індивідуальний розмір', 'Терморозрив'),
  model.main_image,
  99999,
  false
from abwehr_frame_models model
on conflict (slug) do update set
  name = excluded.name,
  material = excluded.material,
  style = excluded.style,
  color = excluded.color,
  description = excluded.description,
  features = excluded.features,
  image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select model.slug, spec.label, spec.value, spec.sort_order, true
from abwehr_frame_models model
cross join (
  values
    ('Розмір дверного блоку', 'Індивідуальний розмір під замовлення', 10),
    ('Колекція', 'Frame', 20),
    ('Призначення', 'Для приватного будинку', 30),
    ('Терморозрив', 'Так', 40),
    ('Товщина полотна', '100 мм', 50),
    ('Товщина короба', '133 мм', 60),
    ('МДФ-накладки', 'Вологостійкий МДФ 16 мм', 70)
) as spec(label, value, sort_order)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes
)
select
  model.slug,
  'ABWEHR',
  model.source_url,
  model.name || ' · Frame · код ' || model.product_code,
  'verified',
  now(),
  'Офіційна картка виробника: модель Frame, базові технічні параметри та фотогалерея.'
from abwehr_frame_models model
where not exists (
  select 1 from public.product_sources source
  where source.product_slug = model.slug and source.source_url = model.source_url
);

create temporary table abwehr_frame_gallery (
  product_slug text not null,
  image_path text not null,
  sort_order integer not null
) on commit drop;

insert into abwehr_frame_gallery values
  ('abwehr-frame-adriatica', 'https://abwehr.com.ua/storage/products/images/big/HdgHy2ZY2BRISnb9x5aXO7NxeVieG4EdTrOpyN6b.jpg.webp?v=1771579840', 1),
  ('abwehr-frame-adriatica', 'https://abwehr.com.ua/storage/products/images/big/JTc7N40zliN3vWd35Ro8cbxVUhxnfvHYBN7RmY6L.jpg.webp?v=1771580012', 2),
  ('abwehr-frame-adriatica', 'https://abwehr.com.ua/storage/products/images/big/tgkF8HRzTucJOjL9zQLvD1O9BJMvxSFwNmfrXfs3.jpg.webp?v=1771583721', 3),
  ('abwehr-frame-adriatica', 'https://abwehr.com.ua/storage/products/images/big/crvb6pr3z71aDRkqfbMVKnfOHhlqX2HtPiEpEM5R.jpg.webp?v=1771581934', 4),
  ('abwehr-frame-adriatica', 'https://abwehr.com.ua/storage/products/images/big/x4RrPYQbH9tj0npfNcVWd2SPxukEG2cBCLhFjJzQ.jpg.webp?v=1771584054', 5),
  ('abwehr-frame-leavia', 'https://abwehr.com.ua/storage/products/images/big/xn6ljdkvzSSka7AYBmzBgbzTHZyh3xzbXxJjBzzA.jpg.webp?v=1771584133', 1),
  ('abwehr-frame-leavia', 'https://abwehr.com.ua/storage/products/images/big/dFItCczla1BYzAiRQlpzFPHqRKKpTd1YdAePrQ40.jpg.webp?v=1771581984', 2),
  ('abwehr-frame-leavia', 'https://abwehr.com.ua/storage/products/images/big/d4uug5rXtw1asMJ2s8P5jUTcRt1hrRDnwfW5wkxo.jpg.webp?v=1771581959', 3),
  ('abwehr-frame-leavia', 'https://abwehr.com.ua/storage/products/images/big/VUSmwNZFgVpyoBl7SCaOYVVPyrFC1ATQOYZ16n92.jpg.webp?v=1771581193', 4),
  ('abwehr-frame-leavia', 'https://abwehr.com.ua/storage/products/images/big/eBoL3mCZ7lv6uQzmF9ASbHrkqSAvx8Uj2TpbrEuk.jpg.webp?v=1771582081', 5),
  ('abwehr-frame-simpli', 'https://abwehr.com.ua/storage/products/images/big/28RFERW3wujmbbpLHJTRX9hIc96mcd2aeSPlWVjS.jpg.webp?v=1771578199', 1),
  ('abwehr-frame-simpli', 'https://abwehr.com.ua/storage/products/images/big/BLGVbNIhFjElSVf1EwRDYbQQdbTPtXoAYCtpk9xo.jpg.webp?v=1771579183', 2),
  ('abwehr-frame-simpli', 'https://abwehr.com.ua/storage/products/images/big/E7c5E7c300gm9Q5ivjJXHBN8ngOOq4deyRUnUQam.jpg.webp?v=1771579469', 3),
  ('abwehr-frame-simpli', 'https://abwehr.com.ua/storage/products/images/big/7P4Tgm58cCqk4fJJP95HIqLv7DjbrhcpILBULQOE.jpg.webp?v=1771578761', 4),
  ('abwehr-frame-simpli', 'https://abwehr.com.ua/storage/products/images/big/3txPp6fArzfNv8uXSrSNdtI5GOD2pLrifpZFWNhz.jpg.webp?v=1771578373', 5),
  ('abwehr-frame-scandi', 'https://abwehr.com.ua/storage/products/images/big/l0jbsaPwenSJX1v9nKFjOJyFfQ0WqOv5387PXSJC.jpg.webp?v=1771582753', 1),
  ('abwehr-frame-scandi', 'https://abwehr.com.ua/storage/products/images/big/qdPIAhcobAUumdE7nr9Qw5tt2ghFj8lLle1rhqJJ.jpg.webp?v=1771583386', 2),
  ('abwehr-frame-scandi', 'https://abwehr.com.ua/storage/products/images/big/c9Vyx3QoIgiRLlqcR9FqX1GHHvOUTAjDAKHIcTNR.jpg.webp?v=1771581863', 3),
  ('abwehr-frame-scandi', 'https://abwehr.com.ua/storage/products/images/big/bgor5Ak6tcWEUO52TTmlp1z7ZqGAMwKtos604xZi.jpg.webp?v=1771581810', 4),
  ('abwehr-frame-scandi', 'https://abwehr.com.ua/storage/products/images/big/Rd6Hk1iBKAkEymzQxhM6ZBT7pT9EgYqsBGSsjWwn.jpg.webp?v=1771580794', 5),
  ('abwehr-frame-ufo-black', 'https://abwehr.com.ua/storage/products/images/big/ewOfWCq2gv9WhXv71H1ZZk0RNcYo2TXP1hbTvWBx.jpg.webp?v=1771582147', 1),
  ('abwehr-frame-ufo-black', 'https://abwehr.com.ua/storage/products/images/big/roq1oYs44uDlnG3u6D9ac0AfweOgtPkDV3yL08i1.jpg.webp?v=1771583495', 2),
  ('abwehr-frame-ufo-black', 'https://abwehr.com.ua/storage/products/images/big/ACl6cJr7aT6U0ZzM6hR3Wh0Da4VHMEfbglg7MJoi.jpg.webp?v=1771579053', 3),
  ('abwehr-frame-ufo-black', 'https://abwehr.com.ua/storage/products/images/big/ZFnFLfMkJkR62TwxHXtmNv5oHiYZHAdHEp4x0giW.jpg.webp?v=1771581571', 4),
  ('abwehr-frame-ufo-black', 'https://abwehr.com.ua/storage/products/images/big/6F1b0HOHBcxbhDqmNpOQa9wXXL1JjEtKixV2F1W0.jpg.webp?v=1771578637', 5);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0
from abwehr_frame_models model
where not exists (
  select 1 from public.product_media media
  where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image
);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select product_slug, 'gallery', 'Офіційне фото ' || sort_order, image_path, sort_order
from abwehr_frame_gallery gallery
where not exists (
  select 1 from public.product_media media
  where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug like 'abwehr-frame-%' and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in (
  'abwehr-frame-adriatica',
  'abwehr-frame-leavia',
  'abwehr-frame-simpli',
  'abwehr-frame-scandi',
  'abwehr-frame-ufo-black'
);
