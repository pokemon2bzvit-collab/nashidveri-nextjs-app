-- Q Doors: три відсутні моделі серії «Ультра».
-- Кожна додається як прихована чернетка з перевіреним джерелом і фото.

begin;

with models as (
  select * from (values
    ('qdoors-ultra-flash-official', 'Q Doors Ультра Флеш', 'https://qdoors.ua/shop/ultra-soprano-m', 'Ультра Флеш (008)', 'https://e-c.storage.googleapis.com/res/245ca3fd-8150-4500-be5b-83be01055cc1/original'),
    ('qdoors-ultra-cross-ak-official', 'Q Doors Ультра Крос-AK', 'https://qdoors.ua/shop/ultra-frost-1', 'Крос-Ak (008)', 'https://e-c.storage.googleapis.com/res/715f0470-96dd-4a7d-a869-e298f91e3211/original'),
    ('qdoors-ultra-frost-official', 'Q Doors Ультра Фрост', 'https://qdoors.ua/shop/avangard-porto', 'Ультра Фрост (008)', 'https://e-c.storage.googleapis.com/res/ca5f4c2e-d4dc-4133-b79e-cfc033d6941e/original')
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
  'Ультра',
  name,
  'Сталь, МДФ-накладки та заводські покриття',
  'Сучасний',
  'Заводські декори',
  'Ціна за запитом',
  replace(name, 'Q Doors ', '') || ' — вхідні двері серії Ультра для квартири. Полотно 95 мм, сталевий лист 1,8 мм, короб 130 мм та утеплення мінеральною ватою допомагають забезпечити комфорт у приміщенні. Доступні заводські декори; актуальну ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Q Doors', 'Серія Ультра', 'Офіційна картка виробника'),
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
    ('qdoors-ultra-flash-official', 'https://qdoors.ua/shop/ultra-soprano-m', 'Ультра Флеш (008)'),
    ('qdoors-ultra-cross-ak-official', 'https://qdoors.ua/shop/ultra-frost-1', 'Крос-Ak (008)'),
    ('qdoors-ultra-frost-official', 'https://qdoors.ua/shop/avangard-porto', 'Ультра Фрост (008)')
  ) as v(slug, source_url, source_product_name)
)
insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
select slug, 'Q Doors — офіційний каталог', source_url, source_product_name,
  'verified', now(), 'Модель, серію, параметри й головне фото перевірено в офіційному каталозі Q Doors 2026-09-24.'
from models
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;

with models as (
  select * from (values
    ('qdoors-ultra-flash-official', 'https://e-c.storage.googleapis.com/res/245ca3fd-8150-4500-be5b-83be01055cc1/original'),
    ('qdoors-ultra-cross-ak-official', 'https://e-c.storage.googleapis.com/res/715f0470-96dd-4a7d-a869-e298f91e3211/original'),
    ('qdoors-ultra-frost-official', 'https://e-c.storage.googleapis.com/res/ca5f4c2e-d4dc-4133-b79e-cfc033d6941e/original')
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
    ('qdoors-ultra-flash-official'),
    ('qdoors-ultra-cross-ak-official'),
    ('qdoors-ultra-frost-official')
  ) as v(slug)
), specs as (
  select * from (values
    ('Призначення', 'Для квартири', 10),
    ('Товщина полотна', '95 мм', 20),
    ('Товщина металу', '1,8 мм', 30),
    ('Глибина короба', '130 мм', 40),
    ('Утеплення', 'Мінеральна вата', 50),
    ('Контури ущільнення', '2 контури на полотні', 60),
    ('МДФ-накладки', '16 + 16 мм', 70),
    ('Верхній замок', 'Securemme (Італія)', 80),
    ('Нижній замок', 'Securemme (Італія)', 90),
    ('Циліндр', 'Hardlock 50 × 50 або аналог', 100),
    ('Засувка', 'Apecs', 110)
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
  'qdoors-ultra-flash-official',
  'qdoors-ultra-cross-ak-official',
  'qdoors-ultra-frost-official'
)
group by p.collection;
