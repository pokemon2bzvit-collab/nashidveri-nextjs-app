-- Magda, сторінка 5: офіційні моделі 319 патина, 204 патина та 300.
-- У 319 і 204 по одному фото, у 300 — три підтверджені офіційні фото.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-319-patina-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №319 патина',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Патина', 'Ціна за запитом',
   'Magda 319 патина — вхідні металеві двері для квартири з декоративним оздобленням патиною. Доступні заводські типи комплектації; декор, розмір і ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Оздоблення патиною'),
   'https://magda.com.ua/storage/app/uploads/public/c49/362/4d2/thumb__0_0_0_0_auto.png', 99043, false, now()),
  ('magda-204-patina-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №204 патина',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Патина', 'Ціна за запитом',
   'Magda 204 патина — вхідні металеві двері для квартири з декоративним оздобленням патиною. Підкажемо доступну комплектацію, декор та ціну під ваш проріз.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Оздоблення патиною'),
   'https://magda.com.ua/storage/app/uploads/public/593/3f9/ac6/thumb__0_0_0_0_auto.png', 99044, false, now()),
  ('magda-300-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №300',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 300 — сучасні вхідні двері для квартири. Дизайн моделі поєднується з лиштвою, створюючи завершений вигляд вхідної групи; доступні варіанти зі дзеркалом.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Сучасний дизайн', 'Варіанти зі дзеркалом'),
   'https://magda.com.ua/storage/app/uploads/public/521/28a/156/thumb__0_0_0_0_auto.jpg', 99045, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources
  (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-319-patina-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/319-patina', 'Модель №319 патина', 'verified', now(), 'Типи 2.24, 3.23, 5, 13; одне офіційне фото.'),
  ('magda-204-patina-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/204-patina', 'Модель №204 патина', 'verified', now(), 'Тип 2.24; одне офіційне фото.'),
  ('magda-300-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/300', 'Модель №300', 'verified', now(), 'Типи 2.24, 3.23, 5, 13; три офіційні фото.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-319-patina-official', 'gallery', 'Модель 319 патина — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/c49/362/4d2/thumb__0_0_0_0_auto.png', 1, true),
  ('magda-204-patina-official', 'gallery', 'Модель 204 патина — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/593/3f9/ac6/thumb__0_0_0_0_auto.png', 1, true),
  ('magda-300-official', 'gallery', 'Модель 300 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/521/28a/156/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-300-official', 'gallery', 'Модель 300 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/a4f/216/7db/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-300-official', 'gallery', 'Модель 300 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/2c6/9b4/2fc/thumb__0_0_0_0_auto.jpg', 3, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-319-patina-official', 'Доступні типи комплектації', '2.24, 3.23, 5 або 13', 1, true),
  ('magda-319-patina-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-319-patina-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-204-patina-official', 'Тип комплектації', '2.24', 1, true),
  ('magda-204-patina-official', 'Товщина полотна', '90 мм', 2, true),
  ('magda-204-patina-official', 'Товщина короба', '100 мм', 3, true),
  ('magda-300-official', 'Доступні типи комплектації', '2.24, 3.23, 5 або 13', 1, true),
  ('magda-300-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-300-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-300-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-319-patina-official', 'magda-204-patina-official', 'magda-300-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
