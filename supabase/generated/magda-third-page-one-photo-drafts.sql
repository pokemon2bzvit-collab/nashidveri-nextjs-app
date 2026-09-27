-- Magda: офіційні моделі з одним фото.
-- У виробника для кожної картки є лише один підтверджений кадр.
-- Моделі створюються прихованими чернетками, без штучної галереї.

begin;

insert into public.products (
  slug, category, brand, collection, name, material, style, color,
  price, description, features, image_path, sort_order, is_available, updated_at
)
values
  (
    'magda-605-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №605',
    'Сталь, МДФ-панелі та заводські покриття', 'Для квартири', 'Заводські декори',
    'Ціна за запитом',
    'Magda 605 — вхідні металеві двері з дизайном для внутрішньої сторони полотна. Допоможемо підібрати доступну комплектацію, декор і розмір дверного блоку; актуальну ціну уточнюйте у менеджера.',
    jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Заводські декори'),
    'https://magda.com.ua/storage/app/uploads/public/08e/0ce/0e0/thumb__0_0_0_0_auto.png',
    99015, false, now()
  ),
  (
    'magda-608-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №608',
    'Сталь, МДФ-панелі та заводські покриття', 'Для квартири', 'Заводські декори',
    'Ціна за запитом',
    'Magda 608 — вхідні металеві двері для квартири з дизайном внутрішньої сторони полотна. Гнутий профіль та заводська комплектація допомагають поєднати практичність і охайний вигляд; актуальну ціну уточнюйте у менеджера.',
    jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Гнутий профіль'),
    'https://magda.com.ua/storage/app/uploads/public/9ae/9de/6e9/thumb__0_0_0_0_auto.png',
    99016, false, now()
  ),
  (
    'magda-612-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №612',
    'Сталь, МДФ-панелі та заводські покриття', 'Для квартири', 'Заводські декори',
    'Ціна за запитом',
    'Magda 612 — вхідні металеві двері для квартири. Доступні заводські декори та комплектації; менеджер допоможе підібрати оптимальне рішення для вашого помешкання.',
    jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Гнутий профіль'),
    'https://magda.com.ua/storage/app/uploads/public/ef5/7dc/6bb/thumb__0_0_0_0_auto.jpg',
    99017, false, now()
  )
on conflict (slug) do update set
  collection = excluded.collection,
  name = excluded.name,
  material = excluded.material,
  style = excluded.style,
  color = excluded.color,
  description = excluded.description,
  features = excluded.features,
  image_path = excluded.image_path,
  updated_at = now();

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  ('magda-605-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/605', 'Модель №605', 'verified', now(), 'Офіційна картка має одне фото; параметри залежать від обраної комплектації.'),
  ('magda-608-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/608', 'Модель №608', 'verified', now(), 'Офіційна картка має одне фото; для квартири.'),
  ('magda-612-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/612', 'Модель №612', 'verified', now(), 'Офіційна картка має одне фото; для квартири.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-605-official', 'gallery', 'Модель 605 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/08e/0ce/0e0/thumb__0_0_0_0_auto.png', 1, true),
  ('magda-608-official', 'gallery', 'Модель 608 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/9ae/9de/6e9/thumb__0_0_0_0_auto.png', 1, true),
  ('magda-612-official', 'gallery', 'Модель 612 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/ef5/7dc/6bb/thumb__0_0_0_0_auto.jpg', 1, true)
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-605-official', 'Товщина полотна', '96 мм', 1, true),
  ('magda-605-official', 'Товщина короба', '130 мм', 2, true),
  ('magda-605-official', 'Товщина металу короба', '1,5 мм', 3, true),
  ('magda-605-official', 'МДФ-панелі', '16/10 мм', 4, true),
  ('magda-605-official', 'Верхній замок', 'Сувальдний Securemme 2019', 5, true),
  ('magda-605-official', 'Нижній замок', 'Циліндровий Securemme 2061', 6, true),
  ('magda-608-official', 'Товщина полотна', '90 мм, гнутий профіль', 1, true),
  ('magda-608-official', 'Товщина короба', '100 мм, гнутий профіль', 2, true),
  ('magda-608-official', 'Товщина металу', '1,2 мм', 3, true),
  ('magda-608-official', 'МДФ-панелі', '16/10 мм', 4, true),
  ('magda-608-official', 'Верхній замок', 'Базова комплектація або Kale 447L', 5, true),
  ('magda-608-official', 'Нижній замок', 'Базова комплектація або Kale 252R', 6, true),
  ('magda-612-official', 'Товщина полотна', '90 мм, гнутий профіль', 1, true),
  ('magda-612-official', 'Товщина короба', '100 мм, гнутий профіль', 2, true),
  ('magda-612-official', 'Товщина металу', '1,2 мм', 3, true),
  ('magda-612-official', 'МДФ-панелі', '16/10 мм', 4, true),
  ('magda-612-official', 'Верхній замок', 'Базова комплектація або Kale 447L', 5, true),
  ('magda-612-official', 'Нижній замок', 'Базова комплектація або Kale 252R', 6, true)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;

commit;

select
  p.slug,
  p.name as "модель",
  p.collection as "колекція",
  p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-605-official', 'magda-608-official', 'magda-612-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
