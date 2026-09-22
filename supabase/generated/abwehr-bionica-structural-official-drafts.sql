-- ABWEHR BIONICA COMBO: distinct structural executions as hidden drafts.
-- They differ by transom, non-standard block, width 1200 or electronic lock.
-- No existing product is modified, deleted, or published.

begin;

create temporary table abwehr_bionica_structural_models (
  slug text primary key,
  name text not null,
  product_code text not null,
  source_url text not null,
  construction_type text not null,
  main_image text not null
) on commit drop;

insert into abwehr_bionica_structural_models values
  ('abwehr-bionica-ufo-white-false-transom', 'Abwehr Ufo White з фальшфрамугою', '496', 'https://abwehr.com.ua/catalog/vhidni-nestandartny-dveri-z-falsh-framugoyu-model-ufo-white-komplektaciya-bionica-combo/p1695', 'Нестандартні двері з фальшфрамугою', 'https://abwehr.com.ua/storage/products/images/big/4oPEn28nUbkZA7ya8pdIfdvGoxMHoqpOVAA4yFJV.jpg.webp?v=1776255986'),
  ('abwehr-bionica-ufo-black-electronic', 'Abwehr Ufo Black з електронним замком', '496', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-ta-elektronnim-zamkom-model-ufo-black-komplektaciya-bionica-combo/p1551', 'Двері з електронним замком', 'https://abwehr.com.ua/storage/products/images/big/X0EpbPaziF81BZzpVjEHKcaMzGUnDAIDh7taP2Ka.jpg.webp?v=1771581345'),
  ('abwehr-bionica-revolution-1200-glass', 'Abwehr Revolution 1200 зі склопакетом', 'LP6', 'https://abwehr.com.ua/catalog/vhidni-dveri-zi-sklom-ta-pokrittyam-lampre-model-revolution-komplektaciya-bionica-combo-1200/p1696', 'Напівторастулкові двері 1200 мм зі склопакетом', 'https://abwehr.com.ua/storage/products/images/big/b8lTof8fiP8MeoyF8pPhjEX2Jfw5NhIj0KlDb9Fe.jpg.webp?v=1776328101'),
  ('abwehr-bionica-queen-1200-transom', 'Abwehr Queen 1200 з фрамугою', 'LP5', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-framugoyu-ta-pokrittyam-lampre-model-queen-komplektaciya-bionica-combo-1200/p1644', 'Напівторастулкові двері 1200 мм з фрамугою', 'https://abwehr.com.ua/storage/products/images/big/96QYaQx5XS31UFzerf7RyD9hQbelEXl6gIzYNumu.jpg.webp?v=1771578941'),
  ('abwehr-bionica-queen-inside-transom', 'Abwehr Queen з внутрішнім відкриванням і фрамугою', 'LP5', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-vnutrishnim-vidkrivannyam-ta-framugoyu-model-queen-komplektaciya-bionica-combo/p1667', 'Двері з внутрішнім відкриванням і фрамугою', 'https://abwehr.com.ua/storage/products/images/big/1YNPgPRWx7nlP5H3jrDKOZOj3ohcSZQKTv5pl1jl.jpg.webp?v=1771578144'),
  ('abwehr-bionica-revolution-transom', 'Abwehr Revolution з фрамугою', 'LP6', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-framugoyu-ta-pokrittyam-lampre-model-revolution-komplektaciya-bionica-combo/p1648', 'Двері з фрамугою', 'https://abwehr.com.ua/storage/products/images/big/rmy2xHIQczSKovtIHVXUkEGFeuln50HZwpXrHZc5.jpg.webp?v=1771583492');

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  model.slug, 'entrance', 'Abwehr', 'Bionica Combo', model.name,
  'Сталь, МДФ-накладки та заводські атмосферостійкі покриття',
  'Сучасний', 'Заводські декори', 'Ціна за запитом',
  model.name || ' — ' || lower(model.construction_type) || ' Abwehr колекції Bionica Combo для приватного будинку. Терморозрив і три контури ущільнення допомагають підтримувати комфорт у приміщенні; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Колекція Bionica Combo', 'Терморозрив', '3 контури ущільнення'),
  model.main_image, 99999, false
from abwehr_bionica_structural_models model
on conflict (slug) do update set
  name = excluded.name, material = excluded.material, style = excluded.style,
  color = excluded.color, description = excluded.description, features = excluded.features,
  image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select model.slug, spec.label, spec.value, spec.sort_order, true
from abwehr_bionica_structural_models model
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
  'Офіційна картка виробника: окрема конструкція Bionica Combo та фотогалерея.'
from abwehr_bionica_structural_models model
where not exists (
  select 1 from public.product_sources source
  where source.product_slug = model.slug and source.source_url = model.source_url
);

create temporary table abwehr_bionica_structural_gallery (
  product_slug text not null,
  image_path text not null,
  sort_order integer not null
) on commit drop;

insert into abwehr_bionica_structural_gallery values
  ('abwehr-bionica-ufo-white-false-transom', 'https://abwehr.com.ua/storage/products/images/big/4oPEn28nUbkZA7ya8pdIfdvGoxMHoqpOVAA4yFJV.jpg.webp?v=1776255986', 1),
  ('abwehr-bionica-ufo-white-false-transom', 'https://abwehr.com.ua/storage/products/images/big/3d8odG1ieyOaiZBYUxDLsfbIauH5U2Mn35uSmdhi.jpg.webp?v=1776254951', 2),
  ('abwehr-bionica-ufo-white-false-transom', 'https://abwehr.com.ua/storage/products/images/big/Wnv7vi0rHXn2177uH5lNPH8562No9uaitezNnBHL.jpg.webp?v=1776254951', 3),
  ('abwehr-bionica-ufo-white-false-transom', 'https://abwehr.com.ua/storage/products/images/big/iwrjaqJI8xCFOohzWop5Q0ZkMbHluQyKxDz3k3Pn.jpg.webp?v=1776254949', 4),
  ('abwehr-bionica-ufo-white-false-transom', 'https://abwehr.com.ua/storage/products/images/big/jslldZWA4Z9QwzgYmp74PU87OUBBaXJzpTTD1cvu.jpg.webp?v=1776254949', 5),
  ('abwehr-bionica-ufo-black-electronic', 'https://abwehr.com.ua/storage/products/images/big/X0EpbPaziF81BZzpVjEHKcaMzGUnDAIDh7taP2Ka.jpg.webp?v=1771581345', 1),
  ('abwehr-bionica-ufo-black-electronic', 'https://abwehr.com.ua/storage/products/images/big/YTz8dfqwRqjUr7QoXRhK9lDMQV6jm6xgV2gQMNmw.jpg.webp?v=1771581499', 2),
  ('abwehr-bionica-ufo-black-electronic', 'https://abwehr.com.ua/storage/products/images/big/dBc2ufhEbXt7YeHDbgKCwb6Ws0x7VSOKkheH5SMR.jpg.webp?v=1771581971', 3),
  ('abwehr-bionica-ufo-black-electronic', 'https://abwehr.com.ua/storage/products/images/big/L8PHQu9EfrlTjfqvKisOpafrWebyufRciqLbqjMK.jpg.webp?v=1771580159', 4),
  ('abwehr-bionica-ufo-black-electronic', 'https://abwehr.com.ua/storage/products/images/big/G5uVbtMXHbgkbzwjOZj1sRmWSlWK6yb7Q0z8b6iZ.jpg.webp?v=1771579671', 5),
  ('abwehr-bionica-revolution-1200-glass', 'https://abwehr.com.ua/storage/products/images/big/b8lTof8fiP8MeoyF8pPhjEX2Jfw5NhIj0KlDb9Fe.jpg.webp?v=1776328101', 1),
  ('abwehr-bionica-revolution-1200-glass', 'https://abwehr.com.ua/storage/products/images/big/8lS6eG3rfm8yZ51wRt7JJ22VfAHfHz1msUFpi9q9.jpg.webp?v=1776328099', 2),
  ('abwehr-bionica-revolution-1200-glass', 'https://abwehr.com.ua/storage/products/images/big/NQndmGCHRaAhLtMzPJiCRI1jcrKJXjYEvCWTDQ8z.jpg.webp?v=1776328102', 3),
  ('abwehr-bionica-revolution-1200-glass', 'https://abwehr.com.ua/storage/products/images/big/f35JCllDaIK2K6HGRwKEqP8Lfftl7pLbbcyT905i.jpg.webp?v=1776328100', 4),
  ('abwehr-bionica-revolution-1200-glass', 'https://abwehr.com.ua/storage/products/images/big/8ZAXvV4LJE07kmDf1P6Mq41e6x2076aZDBBnFPcn.jpg.webp?v=1776328101', 5),
  ('abwehr-bionica-queen-1200-transom', 'https://abwehr.com.ua/storage/products/images/big/96QYaQx5XS31UFzerf7RyD9hQbelEXl6gIzYNumu.jpg.webp?v=1771578941', 1),
  ('abwehr-bionica-queen-1200-transom', 'https://abwehr.com.ua/storage/products/images/big/k54n3K1Y4f6gVhPHMHTl5G3PiTnIP9OqIvAftv8n.jpg.webp?v=1771582654', 2),
  ('abwehr-bionica-queen-1200-transom', 'https://abwehr.com.ua/storage/products/images/big/W8yBhJKx1ZiUMgPKZFY48f39ggRycdS6UiLzDISG.jpg.webp?v=1771581254', 3),
  ('abwehr-bionica-queen-1200-transom', 'https://abwehr.com.ua/storage/products/images/big/w1TRL2P5wQmDn8X9RW8A9Kv1KpMN1MetjfxWOA0o.jpg.webp?v=1771583944', 4),
  ('abwehr-bionica-queen-1200-transom', 'https://abwehr.com.ua/storage/products/images/big/uORo5Ejv5EKNTcYEP2xYrB3exytAwCGWcOVZH15Q.jpg.webp?v=1771583794', 5),
  ('abwehr-bionica-queen-inside-transom', 'https://abwehr.com.ua/storage/products/images/big/1YNPgPRWx7nlP5H3jrDKOZOj3ohcSZQKTv5pl1jl.jpg.webp?v=1771578144', 1),
  ('abwehr-bionica-queen-inside-transom', 'https://abwehr.com.ua/storage/products/images/big/nohakRXwKuSMYSg6xDmltpAeBbyhijyD00tqm1XO.jpg.webp?v=1771583058', 2),
  ('abwehr-bionica-queen-inside-transom', 'https://abwehr.com.ua/storage/products/images/big/LgMaYZHjr0KUlgk6FZjW3wgEOD2ZUlUmenuaI569.jpg.webp?v=1771580211', 3),
  ('abwehr-bionica-queen-inside-transom', 'https://abwehr.com.ua/storage/products/images/big/BE2mfmo74WpCAes4NNz2v8dtAUuznWzTOS983hFN.jpg.webp?v=1771579163', 4),
  ('abwehr-bionica-queen-inside-transom', 'https://abwehr.com.ua/storage/products/images/big/GniWi9FXcfOEknJCmsgtsvn0z1ncZTxnouWtdeHt.jpg.webp?v=1771579747', 5),
  ('abwehr-bionica-revolution-transom', 'https://abwehr.com.ua/storage/products/images/big/rmy2xHIQczSKovtIHVXUkEGFeuln50HZwpXrHZc5.jpg.webp?v=1771583492', 1);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0
from abwehr_bionica_structural_models model
where not exists (
  select 1 from public.product_media media
  where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image
);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select product_slug, 'gallery', 'Офіційне фото ' || sort_order, image_path, sort_order
from abwehr_bionica_structural_gallery gallery
where not exists (
  select 1 from public.product_media media
  where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug in (
    'abwehr-bionica-ufo-white-false-transom', 'abwehr-bionica-ufo-black-electronic',
    'abwehr-bionica-revolution-1200-glass', 'abwehr-bionica-queen-1200-transom',
    'abwehr-bionica-queen-inside-transom', 'abwehr-bionica-revolution-transom'
  ) and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in (
  'abwehr-bionica-ufo-white-false-transom', 'abwehr-bionica-ufo-black-electronic',
  'abwehr-bionica-revolution-1200-glass', 'abwehr-bionica-queen-1200-transom',
  'abwehr-bionica-queen-inside-transom', 'abwehr-bionica-revolution-transom'
);
