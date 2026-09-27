-- Magda, сторінка 4: офіційні моделі 140, 141 та 143.
-- Кожна картка має одне підтверджене офіційне фото й додається прихованою.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-140-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №140',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 140 — вхідні металеві двері для квартири з кількома доступними типами комплектації. Допоможемо підібрати декор, замки, розмір і точну вартість для вашого прорізу.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/311/777/894/thumb__0_0_0_0_auto.jpg', 99032, false, now()),
  ('magda-141-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №141',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 141 — вхідні металеві двері для квартири з вибором базових, посилених та термовиконань. Точний декор, комплектацію й ціну узгодимо перед замовленням.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації', 'Можливе термовиконання'),
   'https://magda.com.ua/storage/app/uploads/public/a77/89c/f08/thumb__0_0_0_0_auto.jpg', 99033, false, now()),
  ('magda-143-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №143',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 143 — вхідні металеві двері для квартири з різними заводськими типами комплектації. Підкажемо доступні декори, замки та параметри під ваш проріз.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації', 'Можливе термовиконання'),
   'https://magda.com.ua/storage/app/uploads/public/711/f6b/b3b/thumb__0_0_0_0_auto.jpg', 99034, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources
  (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-140-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/140', 'Модель №140', 'verified', now(), 'Типи 2.24, 3.23, 5, 13, 12.2; одне офіційне фото.'),
  ('magda-141-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/141', 'Модель №141', 'verified', now(), 'Типи 2.24, 3.23, 5, 13, 4 з терморозривом, 15, 16, 12.2; одне офіційне фото.'),
  ('magda-143-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/143', 'Модель №143', 'verified', now(), 'Типи 2.24, 3.23, 5, 13, 4 з терморозривом, 15, 16, 12.2; одне офіційне фото.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-140-official', 'gallery', 'Модель 140 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/311/777/894/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-141-official', 'gallery', 'Модель 141 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/a77/89c/f08/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-143-official', 'gallery', 'Модель 143 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/711/f6b/b3b/thumb__0_0_0_0_auto.jpg', 1, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-140-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 12.2', 1, true),
  ('magda-140-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-140-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-140-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true),
  ('magda-141-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13, 4 з терморозривом, 15, 16 або 12.2', 1, true),
  ('magda-141-official', 'Товщина полотна', 'Від 75 мм залежно від типу', 2, true),
  ('magda-141-official', 'Товщина короба', 'Від 75 мм залежно від типу', 3, true),
  ('magda-141-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true),
  ('magda-143-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13, 4 з терморозривом, 15, 16 або 12.2', 1, true),
  ('magda-143-official', 'Товщина полотна', 'Від 75 мм залежно від типу', 2, true),
  ('magda-143-official', 'Товщина короба', 'Від 75 мм залежно від типу', 3, true),
  ('magda-143-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-140-official', 'magda-141-official', 'magda-143-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
