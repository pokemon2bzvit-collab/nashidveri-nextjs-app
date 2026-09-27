-- Q Doors: додає актуальну модель «Преміум Некст» як приховану чернетку.
-- Стара картка «Q Doors Стиль M» не змінюється: спершу звіряємо моделі поруч.

begin;

insert into public.products (
  slug,
  category,
  brand,
  collection,
  name,
  material,
  style,
  color,
  price,
  description,
  features,
  image_path,
  sort_order,
  is_available
)
values (
  'qdoors-premium-next-official',
  'entrance',
  'Q Doors',
  'Преміум',
  'Q Doors Преміум Некст',
  'Сталь, МДФ-накладки та заводські покриття',
  'Сучасний',
  'Заводські декори',
  'Ціна за запитом',
  'Q Doors Преміум Некст — вхідні двері серії Преміум для квартири. Полотно 85 мм, сталевий лист 1,5 мм, короб 115 мм та утеплення мінеральною ватою забезпечують практичну комплектацію для щоденного користування. Доступні заводські декори; актуальну ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Q Doors', 'Серія Преміум', 'Офіційна картка виробника'),
  'https://e-c.storage.googleapis.com/res/dca7fd1f-aeb7-4250-bead-97a11ef3a23d/original',
  99999,
  false
)
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

insert into public.product_sources (
  product_slug,
  source_name,
  source_url,
  source_product_name,
  verification_status,
  verified_at,
  notes
)
values (
  'qdoors-premium-next-official',
  'Q Doors — офіційний каталог',
  'https://qdoors.ua/shop/premium-stil-m',
  'Преміум Некст (008)',
  'verified',
  now(),
  'Картку перевірено в офіційному каталозі Q Doors 2026-09-24.'
)
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('qdoors-premium-next-official', 'gallery', 'Фото 1', 'https://e-c.storage.googleapis.com/res/dca7fd1f-aeb7-4250-bead-97a11ef3a23d/original', 10, true),
  ('qdoors-premium-next-official', 'gallery', 'Фото 2', 'https://e-c.storage.googleapis.com/res/2997c3cf-3f4a-4411-b99c-96ff28d2ebef/original', 20, true)
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = excluded.is_active;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('qdoors-premium-next-official', 'Призначення', 'Для квартири', 10, true),
  ('qdoors-premium-next-official', 'Товщина полотна', '85 мм', 20, true),
  ('qdoors-premium-next-official', 'Товщина металу', '1,5 мм', 30, true),
  ('qdoors-premium-next-official', 'Глибина короба', '115 мм', 40, true),
  ('qdoors-premium-next-official', 'Утеплення', 'Мінеральна вата', 50, true),
  ('qdoors-premium-next-official', 'Контури ущільнення', '2 контури на полотні', 60, true),
  ('qdoors-premium-next-official', 'МДФ-накладки', '16 + 16 мм', 70, true),
  ('qdoors-premium-next-official', 'Верхній замок', 'Kale 257', 80, true),
  ('qdoors-premium-next-official', 'Нижній замок', 'Kale 252', 90, true)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = excluded.is_active;

commit;

-- Перевірка після виконання: чернетка має бути прихованою.
select
  p.slug,
  p.name as модель,
  p.collection as серія,
  p.is_available as опубліковано,
  count(distinct s.id) as офіційних_джерел,
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as фото_в_галереї,
  count(distinct ps.id) filter (where ps.is_active) as характеристик
from public.products p
left join public.product_sources s on s.product_slug = p.slug
left join public.product_media m on m.product_slug = p.slug
left join public.product_specs ps on ps.product_slug = p.slug
where p.slug = 'qdoors-premium-next-official'
group by p.slug, p.name, p.collection, p.is_available;
