-- Q Doors: актуальні відсутні моделі серії «Преміум».
-- Усі додаються як приховані чернетки, без кольорових дублів.

begin;

with models as (
  select * from (values
    ('qdoors-premium-tracey-m-official', 'Q Doors Преміум Трейсі-М', 'https://qdoors.ua/shop/premium-lyuksor-1', 'Qdoors Преміум Kale Трейсі-М/Гладь оксид темний/бетон сніжний чорн кв фурн (008)', 'https://e-c.storage.googleapis.com/res/c40c8d6f-cfb4-47aa-859a-2bc2c46ae10c/original'),
    ('qdoors-premium-horizontal-official', 'Q Doors Преміум Горизонталь', 'https://qdoors.ua/shop/premium-gorizontal', 'Преміум Горизонталь (008)', 'https://e-c.storage.googleapis.com/res/0112102d-f6d6-4b2e-997a-0e11fb652e7f/original'),
    ('qdoors-premium-accent-official', 'Q Doors Преміум Акцент', 'https://qdoors.ua/shop/premium-vertikal-ak', 'Преміум Акцент (008)', 'https://e-c.storage.googleapis.com/res/3a13d45b-f7ec-425c-821a-01dc68a8cb14/original'),
    ('qdoors-premium-combi-ak-official', 'Q Doors Преміум Комбі-AK', 'https://qdoors.ua/shop/premium-lyuksor', 'Преміум Комбі-Ak (008)', 'https://e-c.storage.googleapis.com/res/4f7dabd7-7a3d-4176-8047-77b0efad1ae8/original'),
    ('qdoors-premium-vertical-ak-official', 'Q Doors Преміум Вертикаль-AK', 'https://qdoors.ua/shop/ultra-flesh', 'Преміум Вертикаль-АК (008)', 'https://e-c.storage.googleapis.com/res/4d702edd-1377-4547-96b1-f4fff5acb38e/original'),
    ('qdoors-premium-provans-official', 'Q Doors Преміум Прованс', 'https://qdoors.ua/shop/premium-gorizontal-2', 'Преміум Прованс (008)', 'https://e-c.storage.googleapis.com/res/8598f151-9173-45f0-a36d-f41754786a4e/original')
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
  'Преміум',
  name,
  'Сталь, МДФ-накладки та заводські покриття',
  'Сучасний',
  'Заводські декори',
  'Ціна за запитом',
  replace(name, 'Q Doors ', '') || ' — вхідні двері серії Преміум для квартири. Полотно 85 мм, сталевий лист 1,5 мм, короб 115 мм та утеплення мінеральною ватою забезпечують практичну комплектацію для щоденного користування. Доступні заводські декори; актуальну ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Q Doors', 'Серія Преміум', 'Офіційна картка виробника'),
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
    ('qdoors-premium-tracey-m-official', 'https://qdoors.ua/shop/premium-lyuksor-1', 'Qdoors Преміум Kale Трейсі-М/Гладь оксид темний/бетон сніжний чорн кв фурн (008)'),
    ('qdoors-premium-horizontal-official', 'https://qdoors.ua/shop/premium-gorizontal', 'Преміум Горизонталь (008)'),
    ('qdoors-premium-accent-official', 'https://qdoors.ua/shop/premium-vertikal-ak', 'Преміум Акцент (008)'),
    ('qdoors-premium-combi-ak-official', 'https://qdoors.ua/shop/premium-lyuksor', 'Преміум Комбі-Ak (008)'),
    ('qdoors-premium-vertical-ak-official', 'https://qdoors.ua/shop/ultra-flesh', 'Преміум Вертикаль-АК (008)'),
    ('qdoors-premium-provans-official', 'https://qdoors.ua/shop/premium-gorizontal-2', 'Преміум Прованс (008)')
  ) as v(slug, source_url, source_product_name)
)
insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
select
  slug,
  'Q Doors — офіційний каталог',
  source_url,
  source_product_name,
  'verified',
  now(),
  'Модель і головне фото перевірено в офіційному каталозі Q Doors 2026-09-24.'
from models
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;

with models as (
  select * from (values
    ('qdoors-premium-tracey-m-official', 'https://e-c.storage.googleapis.com/res/c40c8d6f-cfb4-47aa-859a-2bc2c46ae10c/original'),
    ('qdoors-premium-horizontal-official', 'https://e-c.storage.googleapis.com/res/0112102d-f6d6-4b2e-997a-0e11fb652e7f/original'),
    ('qdoors-premium-accent-official', 'https://e-c.storage.googleapis.com/res/3a13d45b-f7ec-425c-821a-01dc68a8cb14/original'),
    ('qdoors-premium-combi-ak-official', 'https://e-c.storage.googleapis.com/res/4f7dabd7-7a3d-4176-8047-77b0efad1ae8/original'),
    ('qdoors-premium-vertical-ak-official', 'https://e-c.storage.googleapis.com/res/4d702edd-1377-4547-96b1-f4fff5acb38e/original'),
    ('qdoors-premium-provans-official', 'https://e-c.storage.googleapis.com/res/8598f151-9173-45f0-a36d-f41754786a4e/original')
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
    ('qdoors-premium-tracey-m-official'),
    ('qdoors-premium-horizontal-official'),
    ('qdoors-premium-accent-official'),
    ('qdoors-premium-combi-ak-official'),
    ('qdoors-premium-vertical-ak-official'),
    ('qdoors-premium-provans-official')
  ) as v(slug)
), specs as (
  select * from (values
    ('Призначення', 'Для квартири', 10),
    ('Товщина полотна', '85 мм', 20),
    ('Товщина металу', '1,5 мм', 30),
    ('Глибина короба', '115 мм', 40),
    ('Утеплення', 'Мінеральна вата', 50),
    ('Контури ущільнення', '2 контури на полотні', 60),
    ('МДФ-накладки', '16 + 16 мм', 70),
    ('Верхній замок', 'Kale 257', 80),
    ('Нижній замок', 'Kale 252', 90)
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
  'qdoors-premium-tracey-m-official',
  'qdoors-premium-horizontal-official',
  'qdoors-premium-accent-official',
  'qdoors-premium-combi-ak-official',
  'qdoors-premium-vertical-ak-official',
  'qdoors-premium-provans-official'
)
group by p.collection;
