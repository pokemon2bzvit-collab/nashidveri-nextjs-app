-- Magda: друга перевірена трійка з офіційного каталогу.
-- Створює лише приховані чернетки: 528.1, 740.1, 925.1.

begin;

insert into public.products (
  slug, category, brand, collection, name, material, style, color,
  price, description, features, image_path, sort_order, is_available, updated_at
)
values
  ('magda-528-1-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №528.1',
   'Сталь, МДФ-панелі та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 528.1 — вхідні двері для квартири з чорними молдингами та надійною фурнітурою. Гнутий профіль, утеплене полотно й два контури ущільнення допомагають зберігати комфорт у помешканні; актуальну комплектацію й ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Чорні молдинги'),
   'https://magda.com.ua/storage/app/uploads/public/8fe/506/47c/thumb__0_0_0_0_auto.jpg', 99004, false, now()),
  ('magda-740-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №740.1',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку', 'Заводські декори', 'Ціна за запитом',
   'Magda 740.1 — вхідні двері для приватного будинку, що поєднують сучасний дизайн, довговічність і захист. Заводська комплектація типу 16 передбачає вологостійку МДФ-панель та два контури ущільнення; актуальну ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Тип 16'),
   'https://magda.com.ua/storage/app/uploads/public/915/cf1/ab2/thumb__0_0_0_0_auto.jpg', 99005, false, now()),
  ('magda-925-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №925.1',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку', 'Заводські декори', 'Ціна за запитом',
   'Magda 925.1 — вхідні двері для приватного будинку з терморозривом, вертикальною ручкою та енергоощадним склопакетом. Конструкція допомагає зменшити втрати тепла; актуальну комплектацію, декори й ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив', 'Енергоощадний склопакет'),
   'https://magda.com.ua/storage/app/uploads/public/f0a/89d/b1c/thumb__0_0_0_0_auto.jpg', 99006, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-528-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/5281', 'Модель №528.1', 'verified', now(), 'Для квартири; типи 2.24, 3.23, 5, 13, 12.2.'),
  ('magda-740-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/7401', 'Модель №740.1', 'verified', now(), 'Для будинку; тип 16.'),
  ('magda-925-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/9251', 'Модель №925.1', 'verified', now(), 'Для будинку; тип 4 з терморозривом.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-528-1-official', 'gallery', 'Модель 528.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/8fe/506/47c/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-528-1-official', 'gallery', 'Модель 528.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/05b/714/aeb/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-740-1-official', 'gallery', 'Модель 740.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/915/cf1/ab2/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-740-1-official', 'gallery', 'Модель 740.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/a3c/2e5/0e4/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-925-1-official', 'gallery', 'Модель 925.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/f0a/89d/b1c/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-925-1-official', 'gallery', 'Модель 925.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/4cf/153/2a2/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-925-1-official', 'gallery', 'Модель 925.1 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/aaf/754/586/thumb__0_0_0_0_auto.jpg', 3, true),
  ('magda-925-1-official', 'gallery', 'Модель 925.1 — фото 4', 'https://magda.com.ua/storage/app/uploads/public/9b0/e01/050/thumb__0_0_0_0_auto.jpg', 4, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-528-1-official', 'Типи комплектації', 'Тип 2.24, 3.23, 5, 13 або 12.2', 1, true),
  ('magda-528-1-official', 'Товщина полотна', '90 мм, гнутий профіль', 2, true),
  ('magda-528-1-official', 'Товщина короба', '100 мм, гнутий профіль', 3, true),
  ('magda-528-1-official', 'Товщина металу', '1,2 мм', 4, true),
  ('magda-528-1-official', 'Контури ущільнення', '2', 5, true),
  ('magda-528-1-official', 'Наповнення', 'Мінеральна та кам’яна вата', 6, true),
  ('magda-740-1-official', 'Тип комплектації', 'Тип 16', 1, true),
  ('magda-740-1-official', 'Товщина полотна', '75 мм', 2, true),
  ('magda-740-1-official', 'Товщина короба', '113 мм', 3, true),
  ('magda-740-1-official', 'Товщина металу', '1,2 мм', 4, true),
  ('magda-740-1-official', 'Контури ущільнення', '2', 5, true),
  ('magda-740-1-official', 'Наповнення', 'Мінеральна вата', 6, true),
  ('magda-925-1-official', 'Тип комплектації', 'Тип 4 з терморозривом', 1, true),
  ('magda-925-1-official', 'Товщина полотна', '90 мм', 2, true),
  ('magda-925-1-official', 'Товщина короба', '130 мм з терморозривом', 3, true),
  ('magda-925-1-official', 'Товщина металу короба', '1,2 мм', 4, true),
  ('magda-925-1-official', 'Контури ущільнення', '2', 5, true),
  ('magda-925-1-official', 'Наповнення', 'Мінеральна та кам’яна вата, екструдований пінополістирол', 6, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-528-1-official','magda-740-1-official','magda-925-1-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
