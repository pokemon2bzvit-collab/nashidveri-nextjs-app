-- Q Doors: шість відсутніх моделей серії «Авангард».
-- Моделі додаються прихованими до перевірки, без дублів за кольором.

begin;

with models as (
  select * from (values
    ('qdoors-avangard-converse-ak-official', 'Q Doors Авангард Конверс-AK', 'https://qdoors.ua/shop/avangard-gorizont-al', 'Авангард Конверс-АК (008)', 'https://e-c.storage.googleapis.com/res/87bc2d51-3b64-4879-9097-6c88d4c2f0dc/original'),
    ('qdoors-avangard-horizontal-al-official', 'Q Doors Авангард Горизонт AL', 'https://qdoors.ua/shop/avangard-trino', 'Авангард Горизонт AL (008)', 'https://e-c.storage.googleapis.com/res/49ce452d-97f7-4d99-bae9-5946be46a472/original'),
    ('qdoors-avangard-bacardi-official', 'Q Doors Авангард Бакарді', 'https://qdoors.ua/shop/avangard-tiffani', 'Авангард Бакарди (008)', 'https://e-c.storage.googleapis.com/res/f90df137-7278-4796-b783-5cfbf59e57c8/original'),
    ('qdoors-avangard-tiffani-official', 'Q Doors Авангард Тіффані', 'https://qdoors.ua/shop/avangard-konvers-ak', 'Авангард Тіффані (008)', 'https://e-c.storage.googleapis.com/res/de103094-5de2-4b6b-9119-7b8ff4d5dae5/original'),
    ('qdoors-avangard-trino-official', 'Q Doors Авангард Тріно', 'https://qdoors.ua/shop/avangard-trino-1', 'Авангард Тріно (008)', 'https://e-c.storage.googleapis.com/res/8afa9765-cc3d-4dfd-b48a-9e33d14fc79f/original'),
    ('qdoors-avangard-galant-ak-official', 'Q Doors Авангард Галант-AK', 'https://qdoors.ua/shop/avangard-bakardi-1', 'Авангард Галант-АК (008)', 'https://e-c.storage.googleapis.com/res/27fbf466-b536-4cb0-a49c-3683b38cb702/original')
  ) as v(slug, name, source_url, source_product_name, image_path)
)
insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
)
select
  slug,
  'entrance',
  'Q Doors',
  'Авангард',
  name,
  'Сталь, МДФ-накладки та заводські покриття',
  'Сучасний',
  'Заводські декори',
  'Ціна за запитом',
  replace(name, 'Q Doors ', '') || ' — вхідні двері серії Авангард для квартири. Полотно 95 мм, сталевий лист 1,8 мм, короб 130 мм та утеплення мінеральною ватою забезпечують надійну базову комплектацію. Доступні заводські декори; актуальну ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Q Doors', 'Серія Авангард', 'Офіційна картка виробника'),
  image_path,
  99999,
  false
from models
on conflict (slug) do update set
  category = excluded.category,
  brand = excluded.brand,
  collection = excluded.collection,
  name = excluded.name,
  material = excluded.material,
  style = excluded.style,
  color = excluded.color,
  price = excluded.price,
  description = excluded.description,
  features = excluded.features,
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_available = false,
  updated_at = now();

with models as (
  select * from (values
    ('qdoors-avangard-converse-ak-official', 'https://qdoors.ua/shop/avangard-gorizont-al', 'Авангард Конверс-АК (008)'),
    ('qdoors-avangard-horizontal-al-official', 'https://qdoors.ua/shop/avangard-trino', 'Авангард Горизонт AL (008)'),
    ('qdoors-avangard-bacardi-official', 'https://qdoors.ua/shop/avangard-tiffani', 'Авангард Бакарди (008)'),
    ('qdoors-avangard-tiffani-official', 'https://qdoors.ua/shop/avangard-konvers-ak', 'Авангард Тіффані (008)'),
    ('qdoors-avangard-trino-official', 'https://qdoors.ua/shop/avangard-trino-1', 'Авангард Тріно (008)'),
    ('qdoors-avangard-galant-ak-official', 'https://qdoors.ua/shop/avangard-bakardi-1', 'Авангард Галант-АК (008)')
  ) as v(slug, source_url, source_product_name)
)
insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
select slug, 'Q Doors — офіційний каталог', source_url, source_product_name,
  'verified', now(), 'Модель, серію, базові параметри й головне фото перевірено в офіційному каталозі Q Doors 2026-09-24.'
from models
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;

with models as (
  select * from (values
    ('qdoors-avangard-converse-ak-official', 'https://e-c.storage.googleapis.com/res/87bc2d51-3b64-4879-9097-6c88d4c2f0dc/original'),
    ('qdoors-avangard-horizontal-al-official', 'https://e-c.storage.googleapis.com/res/49ce452d-97f7-4d99-bae9-5946be46a472/original'),
    ('qdoors-avangard-bacardi-official', 'https://e-c.storage.googleapis.com/res/f90df137-7278-4796-b783-5cfbf59e57c8/original'),
    ('qdoors-avangard-tiffani-official', 'https://e-c.storage.googleapis.com/res/de103094-5de2-4b6b-9119-7b8ff4d5dae5/original'),
    ('qdoors-avangard-trino-official', 'https://e-c.storage.googleapis.com/res/8afa9765-cc3d-4dfd-b48a-9e33d14fc79f/original'),
    ('qdoors-avangard-galant-ak-official', 'https://e-c.storage.googleapis.com/res/27fbf466-b536-4cb0-a49c-3683b38cb702/original')
  ) as v(slug, image_path)
)
insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
select slug, 'gallery', 'Головне фото', image_path, 10, true
from models
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = excluded.is_active;

with models as (
  select * from (values
    ('qdoors-avangard-converse-ak-official'),
    ('qdoors-avangard-horizontal-al-official'),
    ('qdoors-avangard-bacardi-official'),
    ('qdoors-avangard-tiffani-official'),
    ('qdoors-avangard-trino-official'),
    ('qdoors-avangard-galant-ak-official')
  ) as v(slug)
), specs as (
  select * from (values
    ('Призначення', 'Для квартири', 10),
    ('Товщина полотна', '95 мм', 20),
    ('Товщина металу', '1,8 мм', 30),
    ('Глибина короба', '130 мм', 40),
    ('Утеплення', 'Мінеральна вата', 50),
    ('Контури ущільнення', '2 контури на полотні', 60),
    ('МДФ-накладки', '16 + 16 мм', 70)
  ) as v(label, value, sort_order)
)
insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select models.slug, specs.label, specs.value, specs.sort_order, true
from models cross join specs
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = excluded.is_active;

commit;

select
  p.collection as серія,
  count(*) as моделей,
  count(*) filter (where p.is_available) as опубліковано,
  count(*) filter (where not p.is_available) as чернеток,
  count(distinct s.id) as офіційних_джерел,
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as фото_в_галереях
from public.products p
left join public.product_sources s on s.product_slug = p.slug
left join public.product_media m on m.product_slug = p.slug
where p.slug in (
  'qdoors-avangard-converse-ak-official',
  'qdoors-avangard-horizontal-al-official',
  'qdoors-avangard-bacardi-official',
  'qdoors-avangard-tiffani-official',
  'qdoors-avangard-trino-official',
  'qdoors-avangard-galant-ak-official'
)
group by p.collection;
