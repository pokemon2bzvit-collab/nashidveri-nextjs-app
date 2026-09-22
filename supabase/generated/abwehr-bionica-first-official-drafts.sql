-- ABWEHR BIONICA COMBO: first six distinct designs as hidden drafts.
-- Different colours and repeated offer cards are deliberately not imported as products.
-- No existing product is modified, deleted, or published.

begin;

create temporary table abwehr_bionica_models (
  slug text primary key,
  name text not null,
  product_code text not null,
  source_url text not null,
  door_type text not null,
  main_image text not null
) on commit drop;

insert into abwehr_bionica_models values
  ('abwehr-bionica-scandi', 'Abwehr Scandi', '498', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-scandi-komplektaciya-bionica-combo-1/p1708', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/lDRyCVifuM3nfRp5DZAMGIpGefDXJqE98kMDmS2H.jpg.webp?v=1783407179'),
  ('abwehr-bionica-queen', 'Abwehr Queen', 'LP5', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-queen-komplektaciya-bionica-combo/p1691', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/OHakuY8lESXnqGHdEx7VmxT9SnAs7lEbrj2QywF7.jpg.webp?v=1775199547'),
  ('abwehr-bionica-ufo-black', 'Abwehr Ufo Black', '496', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-ufo-black-komplektaciya-bionica-combo-1-1/p1705', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/AGc7OhB0aWVNRvEC1NVBlSczt1gmaZ6xcb1fs6CU.jpg.webp?v=1778827619'),
  ('abwehr-bionica-ufo-white', 'Abwehr Ufo White', '496', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-ufo-white-komplektaciya-bionica-combo/p1412', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/uefJHiPvBe2u8nny1eHPhtBxfrmqjMkvc4UEQPHG.jpg.webp?v=1771583818'),
  ('abwehr-bionica-country-neoglass', 'Abwehr Country NeoGlass', '552', 'https://abwehr.com.ua/catalog/vhidni-dveri-zi-sklom-model-country-neoglass-komplektaciya-bionica-combo/p1575', 'Вхідні двері зі склопакетом для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/AomLF2OrJnLi04ORO2b2RUYFQeKJywXCt9PmDwmT.jpg.webp?v=1771579116'),
  ('abwehr-bionica-paradise-glass', 'Abwehr Paradise Glass', 'LP1', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-paradise-glass-komplektaciya-bionica-combo/p1417', 'Вхідні двері зі склопакетом для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/YkwEYDj9RcQ5F3FnAjsbHjOYMHz223NuNpH27W7j.jpg.webp?v=1776951716');

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  model.slug,
  'entrance',
  'Abwehr',
  'Bionica Combo',
  model.name,
  'Сталь, МДФ-накладки та заводські атмосферостійкі покриття',
  'Сучасний',
  'Заводські декори',
  'Ціна за запитом',
  model.name || ' — ' || lower(model.door_type) || ' колекції Bionica Combo. Терморозрив і три контури ущільнення допомагають зберігати комфорт у будинку; доступні заводські декори та комплектації. Актуальну ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Колекція Bionica Combo', 'Терморозрив', '3 контури ущільнення'),
  model.main_image,
  99999,
  false
from abwehr_bionica_models model
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
from abwehr_bionica_models model
cross join lateral (
  values
    ('Тип виробу', model.door_type, 10),
    ('Колекція', 'Bionica Combo', 20),
    ('Призначення', 'Для приватного будинку', 30),
    ('Терморозрив', 'Так', 40),
    ('Контури ущільнення', '3 контури', 50)
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
  model.name || ' · Bionica Combo · код ' || model.product_code,
  'verified',
  now(),
  'Офіційна картка виробника: окрема модель Bionica Combo, базові технічні параметри та фотогалерея.'
from abwehr_bionica_models model
where not exists (
  select 1 from public.product_sources source
  where source.product_slug = model.slug and source.source_url = model.source_url
);

create temporary table abwehr_bionica_gallery (
  product_slug text not null,
  image_path text not null,
  sort_order integer not null
) on commit drop;

insert into abwehr_bionica_gallery values
  ('abwehr-bionica-scandi', 'https://abwehr.com.ua/storage/products/images/big/lDRyCVifuM3nfRp5DZAMGIpGefDXJqE98kMDmS2H.jpg.webp?v=1783407179', 1),
  ('abwehr-bionica-scandi', 'https://abwehr.com.ua/storage/products/images/big/GzIFyOB6soRMH4ko9MzLJ3GsuQMf2ayygahvA0JW.jpg.webp?v=1783407183', 2),
  ('abwehr-bionica-scandi', 'https://abwehr.com.ua/storage/products/images/big/PEUD5R4cvmUzutlHIzzunWUCxYtAD5BDWMtIbaZS.jpg.webp?v=1783407181', 3),
  ('abwehr-bionica-scandi', 'https://abwehr.com.ua/storage/products/images/big/XseOBJpurlNTAfz3HQe4uYhiXNpJl9yTEgEmXuU7.jpg.webp?v=1783407181', 4),
  ('abwehr-bionica-scandi', 'https://abwehr.com.ua/storage/products/images/big/BYUXR9cknvHJnh7ZOVrvRp5x9yiKtj4T80jtEo1a.jpg.webp?v=1783407179', 5),
  ('abwehr-bionica-queen', 'https://abwehr.com.ua/storage/products/images/big/OHakuY8lESXnqGHdEx7VmxT9SnAs7lEbrj2QywF7.jpg.webp?v=1775199547', 1),
  ('abwehr-bionica-queen', 'https://abwehr.com.ua/storage/products/images/big/B0BYlPPhu0y50rHDJdkkECJvp3gkugc6hYRoNYAK.jpg.webp?v=1775199550', 2),
  ('abwehr-bionica-queen', 'https://abwehr.com.ua/storage/products/images/big/LnCMlR91vlU0KmSZEacI1ymQUNc40i7TmV97Citi.jpg.webp?v=1775199547', 3),
  ('abwehr-bionica-queen', 'https://abwehr.com.ua/storage/products/images/big/OaRKa6dOfbaU6Van9yoemMIds5v96fT4egOkIrZn.jpg.webp?v=1775199549', 4),
  ('abwehr-bionica-queen', 'https://abwehr.com.ua/storage/products/images/big/nqaKXKBYmLvPZS3rbifxxoK8RYtsE6TKt76o8dwF.jpg.webp?v=1775199548', 5),
  ('abwehr-bionica-ufo-black', 'https://abwehr.com.ua/storage/products/images/big/AGc7OhB0aWVNRvEC1NVBlSczt1gmaZ6xcb1fs6CU.jpg.webp?v=1778827619', 1),
  ('abwehr-bionica-ufo-black', 'https://abwehr.com.ua/storage/products/images/big/1ozNRAu3rJq1O0g9apRigWPG9o3nBJ1oh7ZVmoeE.jpg.webp?v=1778827619', 2),
  ('abwehr-bionica-ufo-white', 'https://abwehr.com.ua/storage/products/images/big/uefJHiPvBe2u8nny1eHPhtBxfrmqjMkvc4UEQPHG.jpg.webp?v=1771583818', 1),
  ('abwehr-bionica-ufo-white', 'https://abwehr.com.ua/storage/products/images/big/2qJSFPKYZyf4r69nSnb6q2bumjNAjb73q1GtCBJw.jpg.webp?v=1771578272', 2),
  ('abwehr-bionica-ufo-white', 'https://abwehr.com.ua/storage/products/images/big/dWYd7FcuzkFBAnrbBd0wPHGQsRu8nxyfmFAtr4CT.jpg.webp?v=1771582010', 3),
  ('abwehr-bionica-ufo-white', 'https://abwehr.com.ua/storage/products/images/big/c0P2LO986X3na0pFMSKdjeLWERNHdUqlY6Agrv2D.jpg.webp?v=1771581844', 4),
  ('abwehr-bionica-country-neoglass', 'https://abwehr.com.ua/storage/products/images/big/AomLF2OrJnLi04ORO2b2RUYFQeKJywXCt9PmDwmT.jpg.webp?v=1771579116', 1),
  ('abwehr-bionica-country-neoglass', 'https://abwehr.com.ua/storage/products/images/big/HAcjFvvPgR1You9v81pKL729coRRmIjuOTLdvDQi.jpg.webp?v=1771579790', 2),
  ('abwehr-bionica-country-neoglass', 'https://abwehr.com.ua/storage/products/images/big/kGtHdddF13cZ7vpQX0Fw9TpLaCb7t8DJI9NtkWtQ.jpg.webp?v=1771582677', 3),
  ('abwehr-bionica-country-neoglass', 'https://abwehr.com.ua/storage/products/images/big/5MbM0gcixXKUOP0mcMJMxTCaDeEG4ulcQT9VwBns.jpg.webp?v=1771578527', 4),
  ('abwehr-bionica-country-neoglass', 'https://abwehr.com.ua/storage/products/images/big/2QKSGL41DaZ4dc3xhZzkKgvieqMEvfMHfVqk9uoz.jpg.webp?v=1771578228', 5),
  ('abwehr-bionica-paradise-glass', 'https://abwehr.com.ua/storage/products/images/big/YkwEYDj9RcQ5F3FnAjsbHjOYMHz223NuNpH27W7j.jpg.webp?v=1776951716', 1),
  ('abwehr-bionica-paradise-glass', 'https://abwehr.com.ua/storage/products/images/big/Saui7a2XCI4nod34OKGWW5uxAenBK9jQA7aFs7be.jpg.webp?v=1771580904', 2),
  ('abwehr-bionica-paradise-glass', 'https://abwehr.com.ua/storage/products/images/big/Ly3O4O5uivFawdb4i0FQGGK5mboX692ilnYAfZgR.jpg.webp?v=1771580237', 3),
  ('abwehr-bionica-paradise-glass', 'https://abwehr.com.ua/storage/products/images/big/LIp2WcxiC9CLsQUyVrUNKPgexzSiwM2qkG15htsv.jpg.webp?v=1771580181', 4),
  ('abwehr-bionica-paradise-glass', 'https://abwehr.com.ua/storage/products/images/big/TvzCrHoKJLgxUIqOZZDFy0qchVDa21DINg6XR21l.jpg.webp?v=1771581047', 5);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0
from abwehr_bionica_models model
where not exists (
  select 1 from public.product_media media
  where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image
);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select product_slug, 'gallery', 'Офіційне фото ' || sort_order, image_path, sort_order
from abwehr_bionica_gallery gallery
where not exists (
  select 1 from public.product_media media
  where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug in (
    'abwehr-bionica-scandi', 'abwehr-bionica-queen', 'abwehr-bionica-ufo-black',
    'abwehr-bionica-ufo-white', 'abwehr-bionica-country-neoglass', 'abwehr-bionica-paradise-glass'
  ) and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in (
  'abwehr-bionica-scandi', 'abwehr-bionica-queen', 'abwehr-bionica-ufo-black',
  'abwehr-bionica-ufo-white', 'abwehr-bionica-country-neoglass', 'abwehr-bionica-paradise-glass'
);
