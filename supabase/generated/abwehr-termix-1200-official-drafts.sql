-- ABWEHR TERMIX 1200: official half-and-half entrance doors as hidden drafts.
-- The existing Abwehr Tower 1200 card is deliberately not changed here.
-- This script does not publish, remove, or alter any current catalog card.

begin;

create temporary table abwehr_termix_1200_models (
  slug text primary key,
  name text not null,
  product_code text not null,
  source_url text not null,
  main_image text not null
) on commit drop;

insert into abwehr_termix_1200_models values
  ('abwehr-termix-avenue-1200', 'Abwehr Avenue 1200', '537', 'https://abwehr.com.ua/catalog/polutorni-dveri-z-termorozrivom-model-avenue-komplektaciya-termix-1200-2/p1599', 'https://abwehr.com.ua/storage/products/images/big/wTsnCXuksMpQVPZsaAwWZp8oVzJ4TZUAIwinAU3j.jpg.webp?v=1771583989'),
  ('abwehr-termix-carat-1200', 'Abwehr Carat 1200', '536', 'https://abwehr.com.ua/catalog/polutorni-dveri-z-termorozrivom-model-carat-komplektaciya-termix-1200-1/p1642', 'https://abwehr.com.ua/storage/products/images/big/5c4jQUumbUeDwXQK36UOZGAeoTSqcZpsCPUWAiAE.jpg.webp?v=1771578561'),
  ('abwehr-termix-desire-1200', 'Abwehr Desire 1200', '0', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-desire-komplektaciya-termix-1200-2/p1662', 'https://abwehr.com.ua/storage/products/images/big/n0h77MQLPa6CtrM8DSCU8mZghtdNDXe6EnM9iHQT.jpg.webp?v=1771582969'),
  ('abwehr-termix-queen-1200', 'Abwehr Queen 1200', 'LP5', 'https://abwehr.com.ua/catalog/polutorni-dveri-z-termorozrivom-model-queen-komplektaciya-termix-1200-1/p1726', 'https://abwehr.com.ua/storage/products/images/big/Z5Qn9nZB5QOYYKf7E4HoPPnUuzt6cec3qL2rNcSh.jpg.webp?v=1787834175'),
  ('abwehr-termix-revolution-1200', 'Abwehr Revolution 1200', 'LP6', 'https://abwehr.com.ua/catalog/polutorni-dveri-z-termorozrivom-model-revolution-komplektaciya-termix-1200-1/p1718', 'https://abwehr.com.ua/storage/products/images/big/lNFRem6sNGKajMVtKUqYjrZmrVxKugpoDn2dEKUp.jpg.webp?v=1785307798');

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  model.slug,
  'entrance',
  'Abwehr',
  'Termix',
  model.name,
  'Сталь, МДФ та покриття Lampre',
  'Сучасний',
  'Заводські декори',
  'Ціна за запитом',
  model.name || ' — полуторні вхідні двері Abwehr серії Termix 1200 для приватного будинку. Терморозрив, багатошарове утеплення та стійке покриття Lampre допомагають захистити вхід від холоду, вологи й перепадів температур. Доступні заводські декори та напрямки відкривання; актуальну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Серія Termix 1200', 'Полуторне виконання', 'Терморозрив'),
  model.main_image,
  99999,
  false
from abwehr_termix_1200_models model
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
from abwehr_termix_1200_models model
cross join (
  values
    ('Розмір дверного блоку', '1200 × 2050 мм', 10),
    ('Серія', 'Termix 1200', 20),
    ('Призначення', 'Для приватного будинку', 30),
    ('Терморозрив', 'Так', 40),
    ('Товщина полотна', '100 мм', 50),
    ('Товщина короба', '115 мм', 60),
    ('Гарантія виробника', '2 роки', 70)
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
  model.name || ' · Termix 1200 · код ' || model.product_code,
  'verified',
  now(),
  'Офіційна картка виробника: модель, серія Termix 1200, базовий розмір і фотогалерея.'
from abwehr_termix_1200_models model
where not exists (
  select 1 from public.product_sources source
  where source.product_slug = model.slug and source.source_url = model.source_url
);

create temporary table abwehr_termix_1200_gallery (
  product_slug text not null,
  image_path text not null,
  sort_order integer not null
) on commit drop;

insert into abwehr_termix_1200_gallery values
  ('abwehr-termix-avenue-1200', 'https://abwehr.com.ua/storage/products/images/big/wTsnCXuksMpQVPZsaAwWZp8oVzJ4TZUAIwinAU3j.jpg.webp?v=1771583989', 1),
  ('abwehr-termix-avenue-1200', 'https://abwehr.com.ua/storage/products/images/big/ZI0unRFaVRTNrZTR2P5W5UgM6kO5m3OvAqVcQn3M.jpg.webp?v=1771581575', 2),
  ('abwehr-termix-carat-1200', 'https://abwehr.com.ua/storage/products/images/big/5c4jQUumbUeDwXQK36UOZGAeoTSqcZpsCPUWAiAE.jpg.webp?v=1771578561', 1),
  ('abwehr-termix-carat-1200', 'https://abwehr.com.ua/storage/products/images/big/Rne6Q9QwSc2zJxckjFIkK4pfiGUDgsMJPDC1NlPZ.jpg.webp?v=1771580810', 2),
  ('abwehr-termix-desire-1200', 'https://abwehr.com.ua/storage/products/images/big/n0h77MQLPa6CtrM8DSCU8mZghtdNDXe6EnM9iHQT.jpg.webp?v=1771582969', 1),
  ('abwehr-termix-desire-1200', 'https://abwehr.com.ua/storage/products/images/big/ZxVbsp2apPxJEIHDw6c9j3jkKTnsPltW4qKxXDUF.jpg.webp?v=1771581635', 2),
  ('abwehr-termix-queen-1200', 'https://abwehr.com.ua/storage/products/images/big/Z5Qn9nZB5QOYYKf7E4HoPPnUuzt6cec3qL2rNcSh.jpg.webp?v=1787834175', 1),
  ('abwehr-termix-queen-1200', 'https://abwehr.com.ua/storage/products/images/big/dBI4Up88e1ZSpgzQgh47q7459SVsFFA4H8IZuGBj.jpg.webp?v=1787834175', 2),
  ('abwehr-termix-queen-1200', 'https://abwehr.com.ua/storage/products/images/big/90ulSnqRGFJP0utbLoEJXSHwAuhY4q4j1cSEyxhD.jpg.webp?v=1787834175', 3),
  ('abwehr-termix-queen-1200', 'https://abwehr.com.ua/storage/products/images/big/PsYjJjjdrouRESJFdnCHnhVsaP35xy13e7o3fAOW.jpg.webp?v=1787834175', 4),
  ('abwehr-termix-revolution-1200', 'https://abwehr.com.ua/storage/products/images/big/lNFRem6sNGKajMVtKUqYjrZmrVxKugpoDn2dEKUp.jpg.webp?v=1785307798', 1),
  ('abwehr-termix-revolution-1200', 'https://abwehr.com.ua/storage/products/images/big/uQ6g8a61JjysRjz8VeWv5TJslSVroWZXdupxzmcG.jpg.webp?v=1785307801', 2),
  ('abwehr-termix-revolution-1200', 'https://abwehr.com.ua/storage/products/images/big/vCiS6NWw5qUoKUJnaes1beMItunW5CnLcJH0DMF4.jpg.webp?v=1785307798', 3),
  ('abwehr-termix-revolution-1200', 'https://abwehr.com.ua/storage/products/images/big/OrTJzKLncBU7RFR37pE5jfughhezGWTf6bB8gkxp.jpg.webp?v=1785307799', 4);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0
from abwehr_termix_1200_models model
where not exists (
  select 1 from public.product_media media
  where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image
);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select product_slug, 'gallery', 'Офіційне фото ' || sort_order, image_path, sort_order
from abwehr_termix_1200_gallery gallery
where not exists (
  select 1 from public.product_media media
  where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug in (
    'abwehr-termix-avenue-1200',
    'abwehr-termix-carat-1200',
    'abwehr-termix-desire-1200',
    'abwehr-termix-queen-1200',
    'abwehr-termix-revolution-1200'
  ) and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in (
  'abwehr-termix-avenue-1200',
  'abwehr-termix-carat-1200',
  'abwehr-termix-desire-1200',
  'abwehr-termix-queen-1200',
  'abwehr-termix-revolution-1200'
);
