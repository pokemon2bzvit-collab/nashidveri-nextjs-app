-- Magda: моделі 902.1, 809 і 807 з офіційного каталогу.
-- Усі створюються прихованими чернетками.

begin;

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-902-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №902.1',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для будинку, квартири або офісу', 'Заводські декори', 'Ціна за запитом',
   'Magda 902.1 — вхідні двері для будинку, квартири або офісу з лаконічним дизайном та надійною конструкцією. Актуальну комплектацію, декори й ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Тип 16', 'Для будинку, квартири або офісу'),
   'https://magda.com.ua/storage/app/uploads/public/339/997/233/thumb__0_0_0_0_auto.jpg', 99021, false, now()),
  ('magda-809-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №809',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку або офісу', 'MDS1065 · софттач мусонне дерево', 'Ціна за запитом',
   'Magda 809 — вхідні двері для будинку або офісу з терморозривом. Зовнішнє покриття MDS1065 поєднується з внутрішнім декором «софттач мусонне дерево»; актуальну комплектацію й ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив'),
   'https://magda.com.ua/storage/app/uploads/public/dc7/1e0/2b5/thumb__0_0_0_0_auto.jpg', 99022, false, now()),
  ('magda-807-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №807',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку', 'Заводські декори', 'Ціна за запитом',
   'Magda 807 — вхідні металеві двері для приватного будинку зі склопакетом та декоративною решіткою. Конструкція з терморозривом допомагає зберігати комфорт у приміщенні; актуальну ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив', 'Склопакет'),
   'https://magda.com.ua/storage/app/uploads/public/c7d/af1/631/thumb__0_0_0_0_auto.jpg', 99023, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-902-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/9021', 'Модель №902.1', 'verified', now(), 'Тип 16; для будинку, квартири або офісу.'),
  ('magda-809-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/tip-40-ornament-2', 'Модель №809', 'verified', now(), 'Для будинку або офісу; терморозрив.'),
  ('magda-807-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/142-n291', 'Модель №807', 'verified', now(), 'Для будинку; склопакет і терморозрив.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-902-1-official', 'gallery', 'Модель 902.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/339/997/233/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-902-1-official', 'gallery', 'Модель 902.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/409/bf1/d0e/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-809-official', 'gallery', 'Модель 809 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/dc7/1e0/2b5/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-809-official', 'gallery', 'Модель 809 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/06b/cb2/179/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-807-official', 'gallery', 'Модель 807 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/c7d/af1/631/thumb__0_0_0_0_auto.jpg', 1, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-902-1-official', 'Тип комплектації', 'Тип 16', 1, true),
  ('magda-902-1-official', 'Товщина полотна', '75 мм', 2, true),
  ('magda-902-1-official', 'Товщина короба', '113 мм', 3, true),
  ('magda-902-1-official', 'Товщина металу', '1,2 мм', 4, true),
  ('magda-902-1-official', 'Контури ущільнення', '2', 5, true),
  ('magda-902-1-official', 'Замки', 'Buonelle', 6, true),
  ('magda-809-official', 'Товщина полотна', '90 мм', 1, true),
  ('magda-809-official', 'Товщина короба', '130 мм з терморозривом', 2, true),
  ('magda-809-official', 'Товщина металу', '1,2 мм', 3, true),
  ('magda-809-official', 'Покриття металу', 'Ґрунт-фарба та порошкове фарбування', 4, true),
  ('magda-809-official', 'МДФ-панелі', '-/10 мм вологостійкий', 5, true),
  ('magda-809-official', 'Верхній замок', 'Сувальдний Securemme 2019', 6, true),
  ('magda-807-official', 'Товщина полотна', '90 мм', 1, true),
  ('magda-807-official', 'Товщина короба', '130 мм з терморозривом', 2, true),
  ('magda-807-official', 'Товщина металу', '1,2 мм', 3, true),
  ('magda-807-official', 'Покриття металу', 'Ґрунт-фарба та порошкове фарбування', 4, true),
  ('magda-807-official', 'МДФ-панелі', '-/10 мм вологостійкий', 5, true),
  ('magda-807-official', 'Верхній замок', 'Сувальдний Securemme 2019', 6, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-902-1-official','magda-809-official','magda-807-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
