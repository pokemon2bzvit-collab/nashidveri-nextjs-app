-- ABWEHR FRAME: six distinct structural models as hidden drafts.
-- No existing product is modified, deleted, or published.

begin;

create temporary table abwehr_frame_special_models (
  slug text primary key,
  name text not null,
  product_code text not null,
  source_url text not null,
  door_type text not null,
  block_size text not null,
  main_image text not null
) on commit drop;

insert into abwehr_frame_special_models values
  ('abwehr-frame-queen-glass', 'Abwehr Queen Frame зі склопакетом', 'LP5', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-ta-sklom-model-queen-komplektaciya-frame/p1733', 'Нестандартні двері зі склопакетом', 'До 1400 × 2050 мм; фрамуга до 600 мм', 'https://abwehr.com.ua/storage/products/images/big/K9io37AfuG9aBr3vO2NeDvMJ20MdhTTr9kr1nctr.jpg.webp?v=1790077629'),
  ('abwehr-frame-desire', 'Abwehr Desire Frame', 'LP0', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-ta-pokrittyam-lampre-model-desire-komplektaciya-frame-1/p1686', 'Нестандартні двері з покриттям Lampre', '1400–1600 × 2200 мм', 'https://abwehr.com.ua/storage/products/images/big/R4yB5fxNBJXHSD9JlWhPbYvYAxik38BnoRqkcQwM.jpg.webp?v=1774260249'),
  ('abwehr-frame-paradise-closer', 'Abwehr Paradise Frame з дотягувачем', 'LP1', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-ta-dotyaguvachem-model-paradise-komplektaciya-frame/p1655', 'Нестандартні двері з дотягувачем', 'До 1400 × 2050 мм', 'https://abwehr.com.ua/storage/products/images/big/903NbDkpLnZc9GGvFDz6U87BXEYhDJ4gTi73kcFK.jpg.webp?v=1771578926'),
  ('abwehr-frame-revolution-transom', 'Abwehr Revolution Frame з фрамугою', 'LP6', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-ta-framugoyu-model-revolution-komplektaciya-frame-2/p1475', 'Нестандартні двері з фрамугою', '1400–1600 × 2050 мм; фрамуга до 600 мм', 'https://abwehr.com.ua/storage/products/images/big/92PhuKHcSv25RQMg6UY4p9w0aCxE3ApTlWooXm4Q.jpg.webp?v=1771578931'),
  ('abwehr-frame-palermo', 'Abwehr Palermo Frame', '462', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-model-palermo-rozmir-komplektaciya-frame/p1327', 'Нестандартні двостулкові двері', '1600–1800 × 2050 мм', 'https://abwehr.com.ua/storage/products/images/big/wd0GejoKT4EXJolmpW3NwfpOtMI5jef9u9x6OZy0.jpg.webp?v=1771584006'),
  ('abwehr-frame-country-transom', 'Abwehr Country Frame з фрамугою', '501', 'https://abwehr.com.ua/catalog/vhidni-nestandartni-dveri-z-termorozrivom-ta-framugoyu-model-country-komplektaciya-frame/p1540', 'Нестандартні двостулкові двері з фрамугою', '1600–1800 × 2050 мм; фрамуга до 600 мм', 'https://abwehr.com.ua/storage/products/images/big/gdAU15mC4Qcw24ejTxOQ1KOM0B0AF14Yx4tNVHkV.jpg.webp?v=1771582321');

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
  model.name || ' — ' || lower(model.door_type) || ' Abwehr колекції Frame для приватного будинку. Терморозрив, посилена рамкова конструкція та індивідуальний розмір дають змогу адаптувати двері під конкретний проріз. Актуальну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Колекція Frame', 'Індивідуальний розмір', 'Терморозрив'),
  model.main_image,
  99999,
  false
from abwehr_frame_special_models model
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
from abwehr_frame_special_models model
cross join lateral (
  values
    ('Тип конструкції', model.door_type, 10),
    ('Розмір дверного блоку', model.block_size, 20),
    ('Колекція', 'Frame', 30),
    ('Призначення', 'Для приватного будинку', 40),
    ('Терморозрив', 'Так', 50),
    ('Товщина полотна', '100 мм', 60),
    ('Товщина короба', '133 мм', 70),
    ('МДФ-накладки', 'Вологостійкий МДФ 16 мм', 80)
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
  'Офіційна картка виробника: окрема конструкція Frame, технічні параметри та фотогалерея.'
from abwehr_frame_special_models model
where not exists (
  select 1 from public.product_sources source
  where source.product_slug = model.slug and source.source_url = model.source_url
);

create temporary table abwehr_frame_special_gallery (
  product_slug text not null,
  image_path text not null,
  sort_order integer not null
) on commit drop;

insert into abwehr_frame_special_gallery values
  ('abwehr-frame-queen-glass', 'https://abwehr.com.ua/storage/products/images/big/K9io37AfuG9aBr3vO2NeDvMJ20MdhTTr9kr1nctr.jpg.webp?v=1790077629', 1),
  ('abwehr-frame-desire', 'https://abwehr.com.ua/storage/products/images/big/R4yB5fxNBJXHSD9JlWhPbYvYAxik38BnoRqkcQwM.jpg.webp?v=1774260249', 1),
  ('abwehr-frame-desire', 'https://abwehr.com.ua/storage/products/images/big/vdzczllmma5Qg7IBprJcvrMp10gKEHtpLSjY36aQ.jpg.webp?v=1774260249', 2),
  ('abwehr-frame-desire', 'https://abwehr.com.ua/storage/products/images/big/2USgMJ8Xp80tScub661TRClzTY2n3huRdK7J0ETP.jpg.webp?v=1774260249', 3),
  ('abwehr-frame-desire', 'https://abwehr.com.ua/storage/products/images/big/VN6rEeBUNLV6GMingdWDb4SDLuMRNg7KMQgOLif2.jpg.webp?v=1774260249', 4),
  ('abwehr-frame-desire', 'https://abwehr.com.ua/storage/products/images/big/JCGMFfmgSfWIfUZtwHD7UQhjkm6A6gsv86WJwpFv.jpg.webp?v=1774260250', 5),
  ('abwehr-frame-paradise-closer', 'https://abwehr.com.ua/storage/products/images/big/903NbDkpLnZc9GGvFDz6U87BXEYhDJ4gTi73kcFK.jpg.webp?v=1771578926', 1),
  ('abwehr-frame-paradise-closer', 'https://abwehr.com.ua/storage/products/images/big/AFbdZpj2SVugJITadasVDtzzrzrVDezxXUJbpyaQ.jpg.webp?v=1771579058', 2),
  ('abwehr-frame-paradise-closer', 'https://abwehr.com.ua/storage/products/images/big/7i8SThUrzjC307X0JHxOSeJAnaIBLXiT0DocHNSc.jpg.webp?v=1771578793', 3),
  ('abwehr-frame-paradise-closer', 'https://abwehr.com.ua/storage/products/images/big/bUtcZ8xbx6Ox3Wv6yZYEMMwFq40EfRFVR0KpO91b.jpg.webp?v=1771581792', 4),
  ('abwehr-frame-paradise-closer', 'https://abwehr.com.ua/storage/products/images/big/76sWprx8ZdTeDZQsGAQOMJ7gJ8g94knFjFP52NB9.jpg.webp?v=1771578735', 5),
  ('abwehr-frame-revolution-transom', 'https://abwehr.com.ua/storage/products/images/big/92PhuKHcSv25RQMg6UY4p9w0aCxE3ApTlWooXm4Q.jpg.webp?v=1771578931', 1),
  ('abwehr-frame-palermo', 'https://abwehr.com.ua/storage/products/images/big/wd0GejoKT4EXJolmpW3NwfpOtMI5jef9u9x6OZy0.jpg.webp?v=1771584006', 1),
  ('abwehr-frame-palermo', 'https://abwehr.com.ua/storage/products/images/big/7tOda0WKkAiMf7nQ9LP3RQ4m6ZK989KjceUh2dVh.jpg.webp?v=1771578812', 2),
  ('abwehr-frame-palermo', 'https://abwehr.com.ua/storage/products/images/big/O0Rpfbdo7QlZcSAbecBmEsB3Qf2yI6Szi4vVtAtk.jpg.webp?v=1771580423', 3),
  ('abwehr-frame-palermo', 'https://abwehr.com.ua/storage/products/images/big/7SW2I9DI0xA115ZRKsPSaSo0wzogV2C1TVNvyhe7.jpg.webp?v=1771578763', 4),
  ('abwehr-frame-palermo', 'https://abwehr.com.ua/storage/products/images/big/iBO2HVD5mluXW0H2NacwgM1SQZJsJmE52sX5Upm6.jpg.webp?v=1771582470', 5),
  ('abwehr-frame-country-transom', 'https://abwehr.com.ua/storage/products/images/big/gdAU15mC4Qcw24ejTxOQ1KOM0B0AF14Yx4tNVHkV.jpg.webp?v=1771582321', 1),
  ('abwehr-frame-country-transom', 'https://abwehr.com.ua/storage/products/images/big/Nzs4M84DiKssqf5kIv0mQ2T1ucIyTxvYHutWJ3UH.jpg.webp?v=1771580423', 2);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0
from abwehr_frame_special_models model
where not exists (
  select 1 from public.product_media media
  where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image
);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select product_slug, 'gallery', 'Офіційне фото ' || sort_order, image_path, sort_order
from abwehr_frame_special_gallery gallery
where not exists (
  select 1 from public.product_media media
  where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug in (
    'abwehr-frame-queen-glass', 'abwehr-frame-desire', 'abwehr-frame-paradise-closer',
    'abwehr-frame-revolution-transom', 'abwehr-frame-palermo', 'abwehr-frame-country-transom'
  ) and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in (
  'abwehr-frame-queen-glass', 'abwehr-frame-desire', 'abwehr-frame-paradise-closer',
  'abwehr-frame-revolution-transom', 'abwehr-frame-palermo', 'abwehr-frame-country-transom'
);
