-- ABWEHR TERMIX: structurally distinct models as hidden drafts.
-- Tower with a transom and Revolution 1200 with a glass unit are separate cards,
-- not colour/decor variants of the already imported models.

begin;

create temporary table abwehr_termix_special_models (
  slug text primary key,
  name text not null,
  product_code text not null,
  source_url text not null,
  main_image text not null,
  size_value text not null,
  door_type text not null
) on commit drop;

insert into abwehr_termix_special_models values
  ('abwehr-termix-tower-transom', 'Abwehr Tower з фрамугою', '527', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-framugoyu-ta-termorozrivom-model-tower-komplektaciya-termix/p1675', 'https://abwehr.com.ua/storage/products/images/big/q2c7GBvWJ4YlB7pJWeYLFATG5hB1dfEMcLAsgLAk.jpg.webp?v=1771583317', 'Розмір уточнюється під час комплектації', 'Вхідні двері з фрамугою'),
  ('abwehr-termix-revolution-1200-glass', 'Abwehr Revolution 1200 зі склопакетом', 'LP6', 'https://abwehr.com.ua/catalog/polutorni-dveri-zi-sklom-ta-termorozrivom-model-revolution-komplektaciya-termix-1200/p1610', 'https://abwehr.com.ua/storage/products/images/big/TMcZ4ivsROr0F718xJrFUnHInPoYMa3m6zB8zToF.jpg.webp?v=1771580980', '1200 × 2050 мм', 'Полуторні вхідні двері зі склопакетом');

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
  model.name || ' — ' || lower(model.door_type) || ' Abwehr серії Termix для приватного будинку. Терморозрив, багатошарове утеплення та стійке покриття Lampre допомагають захистити вхід від холоду, вологи й перепадів температур. Актуальну комплектацію, декори та ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Серія Termix', model.door_type, 'Терморозрив'),
  model.main_image,
  99999,
  false
from abwehr_termix_special_models model
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
from abwehr_termix_special_models model
cross join lateral (
  values
    ('Розмір дверного блоку', model.size_value, 10),
    ('Серія', 'Termix', 20),
    ('Тип виробу', model.door_type, 30),
    ('Призначення', 'Для приватного будинку', 40),
    ('Терморозрив', 'Так', 50),
    ('Товщина полотна', '100 мм', 60),
    ('Товщина короба', '115 мм', 70),
    ('Гарантія виробника', '2 роки', 80)
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
  model.name || ' · Termix · код ' || model.product_code,
  'verified',
  now(),
  'Офіційна картка виробника: окреме конструктивне виконання та фотогалерея.'
from abwehr_termix_special_models model
where not exists (
  select 1 from public.product_sources source
  where source.product_slug = model.slug and source.source_url = model.source_url
);

create temporary table abwehr_termix_special_gallery (
  product_slug text not null,
  image_path text not null,
  sort_order integer not null
) on commit drop;

insert into abwehr_termix_special_gallery values
  ('abwehr-termix-tower-transom', 'https://abwehr.com.ua/storage/products/images/big/q2c7GBvWJ4YlB7pJWeYLFATG5hB1dfEMcLAsgLAk.jpg.webp?v=1771583317', 1),
  ('abwehr-termix-tower-transom', 'https://abwehr.com.ua/storage/products/images/big/NABUwi5PD4MlZK1ISIPNrtZ68KNdO2M0UbbHuRbB.jpg.webp?v=1771580345', 2),
  ('abwehr-termix-tower-transom', 'https://abwehr.com.ua/storage/products/images/big/AKD747JcebOdBVzDxjD2zQpYFlhOF2idlijzKnTd.jpg.webp?v=1771579066', 3),
  ('abwehr-termix-revolution-1200-glass', 'https://abwehr.com.ua/storage/products/images/big/TMcZ4ivsROr0F718xJrFUnHInPoYMa3m6zB8zToF.jpg.webp?v=1771580980', 1),
  ('abwehr-termix-revolution-1200-glass', 'https://abwehr.com.ua/storage/products/images/big/xzBXRLcX5aH5Bk3McmiyhUdBIM4iWojkhGfAv9Ad.jpg.webp?v=1771584150', 2);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0
from abwehr_termix_special_models model
where not exists (
  select 1 from public.product_media media
  where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image
);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select product_slug, 'gallery', 'Офіційне фото ' || sort_order, image_path, sort_order
from abwehr_termix_special_gallery gallery
where not exists (
  select 1 from public.product_media media
  where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path
);

commit;

select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug in (
    'abwehr-termix-tower-transom',
    'abwehr-termix-revolution-1200-glass'
  ) and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in ('abwehr-termix-tower-transom', 'abwehr-termix-revolution-1200-glass');
