-- ABWEHR TERMIX: first six official models as hidden drafts.
-- No existing product is changed or deleted. All new cards have is_available = false.

begin;

create temporary table abwehr_termix_models (
  slug text primary key,
  name text not null,
  product_code text not null,
  sizes text not null,
  source_url text not null,
  main_image text not null
) on commit drop;

insert into abwehr_termix_models values
  ('abwehr-termix-desire', 'Abwehr Desire', '0', '860 × 2050 мм, 960 × 2050 мм', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-desire-komplektaciya-termix-1201-1/p1709', 'https://abwehr.com.ua/storage/products/images/big/RnQR5fT7NvHluOFbSzQ36zQMRJjFIuAb8hq7Pzja.jpg.webp?v=1782208108'),
  ('abwehr-termix-paradise', 'Abwehr Paradise', 'LP1', '860 × 2050 мм, 960 × 2050 мм', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-paradise-komplektaciya-termix/p1646', 'https://abwehr.com.ua/storage/products/images/big/kwCZI19KqZzAephSvcDWz6cq1CUmVFRDUkRTlMHE.jpg.webp?v=1771582747'),
  ('abwehr-termix-polaris', 'Abwehr Polaris', 'LP14', '860 × 2050 мм, 960 × 2050 мм', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-polaris-komplektaciya-termix/p1728', 'https://abwehr.com.ua/storage/products/images/big/XbTNYSYJOWYwPeP1zZBg8daqu9hgY16Vhacnva0y.jpg.webp?v=1787906586'),
  ('abwehr-termix-queen', 'Abwehr Queen', 'LP5', '860 × 2050 мм, 960 × 2050 мм', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-queen-komplektaciya-termix-2/p1630', 'https://abwehr.com.ua/storage/products/images/big/iUiLiwNARethQBjrpSpyb8VOa6ylP1YivdGQFPnS.jpg.webp?v=1771582509'),
  ('abwehr-termix-supreme', 'Abwehr Supreme', 'LP12', '960 × 2050 мм', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-supreme-komplektaciya-termix-1-1/p1689', 'https://abwehr.com.ua/storage/products/images/big/jkPmIfZnqUd9VD8PIbWAAbs089wllwtH3C5oa6b9.jpg.webp?v=1775035159'),
  ('abwehr-termix-trinity', 'Abwehr Trinity', '541', '860 × 2050 мм, 960 × 2050 мм', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-trinity-komplektaciya-termix/p1436', 'https://abwehr.com.ua/storage/products/images/big/0oXjEnXSXxhP3Uvn0Bh3lixaWTrMz8jiLSNlNuxc.jpg.webp?v=1771578084');

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
  model.name || ' — вхідні двері серії Termix від Abwehr для приватного будинку. Терморозрив, багатошарове утеплення та стійке покриття Lampre допомагають захистити вхід від холоду, вологи й перепадів температур. Доступні заводські декори та напрямки відкривання; актуальну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Серія Termix', 'Для приватного будинку', 'Терморозрив'),
  model.main_image,
  99999,
  false
from abwehr_termix_models model
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
from abwehr_termix_models model
cross join (
  values
    ('Серія', 'Termix', 20),
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

-- The size value differs by model, so it is added separately.
insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select slug, 'Розміри дверного блоку', sizes, 10, true
from abwehr_termix_models
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
  model.name || ' · Termix · код ' || model.product_code,
  'verified',
  now(),
  'Офіційна картка виробника: модель, серія, базовий розмір і фотогалерея.'
from abwehr_termix_models model
where not exists (
  select 1 from public.product_sources source
  where source.product_slug = model.slug and source.source_url = model.source_url
);

create temporary table abwehr_termix_gallery (
  product_slug text not null,
  image_path text not null,
  sort_order integer not null
) on commit drop;

insert into abwehr_termix_gallery values
  ('abwehr-termix-desire', 'https://abwehr.com.ua/storage/products/images/big/RnQR5fT7NvHluOFbSzQ36zQMRJjFIuAb8hq7Pzja.jpg.webp?v=1782208108', 1),
  ('abwehr-termix-desire', 'https://abwehr.com.ua/storage/products/images/big/4bhjqruZ04SgPa4J7rXGComjkbEcn09QLmDjO3X7.jpg.webp?v=1782208112', 2),
  ('abwehr-termix-desire', 'https://abwehr.com.ua/storage/products/images/big/HkITKieK6VM7CGR5GUQDDhsSelxmeYOCZ2uiqz6s.jpg.webp?v=1782208109', 3),
  ('abwehr-termix-desire', 'https://abwehr.com.ua/storage/products/images/big/fn3tRyuZpwaegIO9RAzuQ9lGOpDJuyjGen9xiCXv.jpg.webp?v=1782208110', 4),
  ('abwehr-termix-paradise', 'https://abwehr.com.ua/storage/products/images/big/kwCZI19KqZzAephSvcDWz6cq1CUmVFRDUkRTlMHE.jpg.webp?v=1771582747', 1),
  ('abwehr-termix-paradise', 'https://abwehr.com.ua/storage/products/images/big/6ms49qCji16CwqlDYwWJuHh6JwmqtRk9Ad5Eftll.jpg.webp?v=1771578688', 2),
  ('abwehr-termix-paradise', 'https://abwehr.com.ua/storage/products/images/big/RudQcC0RwyWs7rOjaK9ZB8LTjdS4aVHbT9HkuExA.jpg.webp?v=1771580822', 3),
  ('abwehr-termix-paradise', 'https://abwehr.com.ua/storage/products/images/big/DPaoWoYlNBwgFp7wxBy8UiGeJTQyuVq312NBL4C5.jpg.webp?v=1771579395', 4),
  ('abwehr-termix-polaris', 'https://abwehr.com.ua/storage/products/images/big/XbTNYSYJOWYwPeP1zZBg8daqu9hgY16Vhacnva0y.jpg.webp?v=1787906586', 1),
  ('abwehr-termix-polaris', 'https://abwehr.com.ua/storage/products/images/big/ra6luFf43M2rws8D6yBE9il5uTnWpoI5i67D1cMn.jpg.webp?v=1787906590', 2),
  ('abwehr-termix-polaris', 'https://abwehr.com.ua/storage/products/images/big/ZAmpJu0Wa6jjFJAkioOdju500BeVq5zGFyMMZGZH.jpg.webp?v=1787906587', 3),
  ('abwehr-termix-polaris', 'https://abwehr.com.ua/storage/products/images/big/mNalNPcURR7gdzvHjgfAGR2j4YbAFoKKmALSGDFE.jpg.webp?v=1787906588', 4),
  ('abwehr-termix-queen', 'https://abwehr.com.ua/storage/products/images/big/iUiLiwNARethQBjrpSpyb8VOa6ylP1YivdGQFPnS.jpg.webp?v=1771582509', 1),
  ('abwehr-termix-queen', 'https://abwehr.com.ua/storage/products/images/big/ye8hQBQegrnO3yZCAtd1ODrZcMU6DMCltVX1yUYa.jpg.webp?v=1771584209', 2),
  ('abwehr-termix-queen', 'https://abwehr.com.ua/storage/products/images/big/gASi8bahYEKfIYtvvcOXPQDURVXMpaq1FJCGBQNg.jpg.webp?v=1771582278', 3),
  ('abwehr-termix-queen', 'https://abwehr.com.ua/storage/products/images/big/MvWgWTWtXZc64ajUsBMujcBokPWwjp4RTZVwBUns.jpg.webp?v=1771580318', 4),
  ('abwehr-termix-supreme', 'https://abwehr.com.ua/storage/products/images/big/jkPmIfZnqUd9VD8PIbWAAbs089wllwtH3C5oa6b9.jpg.webp?v=1775035159', 1),
  ('abwehr-termix-supreme', 'https://abwehr.com.ua/storage/products/images/big/tOtGimc20czm6smqxWDDDZLJSyc9usumgRFtQsbX.jpg.webp?v=1775035162', 2),
  ('abwehr-termix-supreme', 'https://abwehr.com.ua/storage/products/images/big/Gb45LHnHKcd3LHCFPr7becDBJ1MHj3J0G0oWTdj8.jpg.webp?v=1775035160', 3),
  ('abwehr-termix-supreme', 'https://abwehr.com.ua/storage/products/images/big/5ibjYiGf5kESecHdhBlnOBypvmp42GpdcUJPGLeS.jpg.webp?v=1775035159', 4),
  ('abwehr-termix-trinity', 'https://abwehr.com.ua/storage/products/images/big/0oXjEnXSXxhP3Uvn0Bh3lixaWTrMz8jiLSNlNuxc.jpg.webp?v=1771578084', 1),
  ('abwehr-termix-trinity', 'https://abwehr.com.ua/storage/products/images/big/aLsIcvcuAbz7J6VvyCuEGCqm8JHEq6xFtleq3WoU.jpg.webp?v=1771581676', 2),
  ('abwehr-termix-trinity', 'https://abwehr.com.ua/storage/products/images/big/JfofzqYj8m5Ljqi8OgzKPMwu2aXndNRBUzQJnlWj.jpg.webp?v=1771580027', 3),
  ('abwehr-termix-trinity', 'https://abwehr.com.ua/storage/products/images/big/VuNwnytsDSEOc4u0sgj2NoKe1JKXfqtcpUqUfIOT.jpg.webp?v=1771581231', 4);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0
from abwehr_termix_models model
where not exists (
  select 1 from public.product_media media
  where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image
);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select product_slug, 'gallery', 'Офіційне фото ' || sort_order, image_path, sort_order
from abwehr_termix_gallery gallery
where not exists (
  select 1 from public.product_media media
  where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug like 'abwehr-termix-%' and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in (
  'abwehr-termix-desire',
  'abwehr-termix-paradise',
  'abwehr-termix-polaris',
  'abwehr-termix-queen',
  'abwehr-termix-supreme',
  'abwehr-termix-trinity'
);
