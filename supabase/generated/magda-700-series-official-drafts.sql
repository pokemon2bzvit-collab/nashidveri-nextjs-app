-- Magda: моделі 700, 700.1 та 720.1 з офіційного каталогу.
-- Чернетки: 700 має 1 фото, 700.1 — 2, 720.1 — 5.

begin;

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-700-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №700',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку', 'Дуб бронзовий', 'Ціна за запитом',
   'Magda 700 — вхідні металеві двері для приватного будинку в декорі «дуб бронзовий» зі склопакетом і терморозривом. Актуальну комплектацію, розмір та ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив', 'Склопакет'),
   'https://magda.com.ua/storage/app/uploads/public/624/387/c47/thumb__0_0_0_0_auto.jpg', 99018, false, now()),
  ('magda-700-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №700.1',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку', 'Темний горіх', 'Ціна за запитом',
   'Magda 700.1 — металеві вхідні двері для приватного будинку в кольорі «темний горіх». Конструкція з терморозривом допомагає підтримувати комфорт у приміщенні; актуальну комплектацію й ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив'),
   'https://magda.com.ua/storage/app/uploads/public/a8a/66e/5ca/thumb__0_0_0_0_auto.jpg', 99019, false, now()),
  ('magda-720-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №720.1',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку', 'Заводські декори', 'Ціна за запитом',
   'Magda 720.1 — вхідні металеві двері для будинку, доступні в конструктивних типах 16 та 6.23. Заводська конструкція допомагає захищати оселю від холоду та шуму; точну комплектацію й ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив', 'Тип 16 або 6.23'),
   'https://magda.com.ua/storage/app/uploads/public/274/276/e0d/thumb__0_0_0_0_auto.jpg', 99020, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-700-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/700-bronze-oak', 'Модель №700', 'verified', now(), 'Для будинку; тип 6.23 з терморозривом; одне офіційне фото.'),
  ('magda-700-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/7001', 'Модель №700.1', 'verified', now(), 'Для будинку; тип 6.23 з терморозривом.'),
  ('magda-720-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/7201', 'Модель №720.1', 'verified', now(), 'Для будинку; типи 16 та 6.23.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-700-official', 'gallery', 'Модель 700 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/624/387/c47/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-700-1-official', 'gallery', 'Модель 700.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/a8a/66e/5ca/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-700-1-official', 'gallery', 'Модель 700.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/12c/9cb/1f1/thumb__0_0_0_0_auto.png', 2, true),
  ('magda-720-1-official', 'gallery', 'Модель 720.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/274/276/e0d/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-720-1-official', 'gallery', 'Модель 720.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/c71/e8e/849/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-720-1-official', 'gallery', 'Модель 720.1 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/204/6cc/702/thumb__0_0_0_0_auto.jpg', 3, true),
  ('magda-720-1-official', 'gallery', 'Модель 720.1 — фото 4', 'https://magda.com.ua/storage/app/uploads/public/84d/66f/db6/thumb__0_0_0_0_auto.jpg', 4, true),
  ('magda-720-1-official', 'gallery', 'Модель 720.1 — фото 5', 'https://magda.com.ua/storage/app/uploads/public/711/4ec/586/thumb__0_0_0_0_auto.jpg', 5, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-700-official', 'Тип комплектації', 'Тип 6.23 з терморозривом', 1, true),
  ('magda-700-official', 'Товщина полотна', '94 мм', 2, true),
  ('magda-700-official', 'Товщина короба', '112 мм з терморозривом', 3, true),
  ('magda-700-official', 'Товщина металу короба', '1,2 мм', 4, true),
  ('magda-700-official', 'Контури ущільнення', '3', 5, true),
  ('magda-700-official', 'Наповнення', 'Кам’яна вата, екструдований пінополістирол та НПЕ-полотно', 6, true),
  ('magda-700-1-official', 'Тип комплектації', 'Тип 6.23 з терморозривом', 1, true),
  ('magda-700-1-official', 'Товщина полотна', '94 мм', 2, true),
  ('magda-700-1-official', 'Товщина короба', '112 мм з терморозривом', 3, true),
  ('magda-700-1-official', 'Товщина металу короба', '1,2 мм', 4, true),
  ('magda-700-1-official', 'Контури ущільнення', '3', 5, true),
  ('magda-700-1-official', 'Наповнення', 'Кам’яна вата, екструдований пінополістирол та НПЕ-полотно', 6, true),
  ('magda-720-1-official', 'Типи комплектації', 'Тип 16 або 6.23 з терморозривом', 1, true),
  ('magda-720-1-official', 'Товщина полотна', '94 мм', 2, true),
  ('magda-720-1-official', 'Товщина короба', '112 мм з терморозривом', 3, true),
  ('magda-720-1-official', 'Товщина металу короба', '1,2 мм', 4, true),
  ('magda-720-1-official', 'Контури ущільнення', '3', 5, true),
  ('magda-720-1-official', 'Наповнення', 'Кам’яна вата, екструдований пінополістирол та НПЕ-полотно', 6, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-700-official','magda-700-1-official','magda-720-1-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
