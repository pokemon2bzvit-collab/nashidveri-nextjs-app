-- Magda, сторінка 5: офіційні моделі 611ПЧ, 623ПЧ та 625.
-- У кожної моделі по одному підтвердженому фото; картки створюються прихованими.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-611pch-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №611ПЧ',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 611ПЧ — вхідні металеві двері для квартири з кількома доступними типами комплектації. Підкажемо декор, замки, розмір і вартість для вашого прорізу.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/55d/3bb/80e/thumb__0_0_0_0_auto.jpg', 99046, false, now()),
  ('magda-623pch-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №623ПЧ',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 623ПЧ — вхідні двері для квартири з тепло- і шумоізоляцією та вертикальними вставками на зовнішній панелі. Комплектацію, декор і ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Вертикальні вставки', 'Тепло- і шумоізоляція'),
   'https://magda.com.ua/storage/app/uploads/public/1ac/26b/c95/thumb__0_0_0_0_auto.jpg', 99047, false, now()),
  ('magda-625-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №625',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 625 — вхідні металеві двері для квартири з вибором заводських типів комплектації. Допоможемо підібрати декор, замки та точний розмір під ваш проріз.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/bde/019/ec9/thumb__0_0_0_0_auto.jpg', 99048, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources
  (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-611pch-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/611', 'Модель №611ПЧ', 'verified', now(), 'Типи 2.24, 3.23, 5, 13; одне офіційне фото.'),
  ('magda-623pch-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/623', 'Модель №623ПЧ', 'verified', now(), 'Типи 2.24, 3.23, 5, 13; одне офіційне фото.'),
  ('magda-625-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/625', 'Модель №625', 'verified', now(), 'Типи 2.24, 3.23, 5, 13; одне офіційне фото.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-611pch-official', 'gallery', 'Модель 611ПЧ — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/55d/3bb/80e/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-623pch-official', 'gallery', 'Модель 623ПЧ — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/1ac/26b/c95/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-625-official', 'gallery', 'Модель 625 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/bde/019/ec9/thumb__0_0_0_0_auto.jpg', 1, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-611pch-official', 'Доступні типи комплектації', '2.24, 3.23, 5 або 13', 1, true),
  ('magda-611pch-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-611pch-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-623pch-official', 'Доступні типи комплектації', '2.24, 3.23, 5 або 13', 1, true),
  ('magda-623pch-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-623pch-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-623pch-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true),
  ('magda-625-official', 'Доступні типи комплектації', '2.24, 3.23, 5 або 13', 1, true),
  ('magda-625-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-625-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-611pch-official', 'magda-623pch-official', 'magda-625-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
