-- Magda, сторінка 5: нові моделі 613 і 614.
-- 807 ПC №1 — офіційний варіант уже наявної моделі 807, тож додаємо його до тієї ж картки.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-613-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №613',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 613 — вхідні металеві двері з дизайном для внутрішньої сторони полотна. Доступні різні типи комплектації; декор, замки та точну ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Дизайн внутрішньої сторони', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/447/d45/354/thumb__0_0_0_0_auto.jpg', 99041, false, now()),
  ('magda-614-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №614',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 614 — вхідні металеві двері з дизайном для внутрішньої сторони полотна. Допоможемо підібрати декор, тип комплектації й параметри під ваш проріз.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Дизайн внутрішньої сторони', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/9cf/36e/a01/thumb__0_0_0_0_auto.jpg', 99042, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources
  (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-613-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/613', 'Модель №613', 'verified', now(), 'Для квартири; типи 2.24, 3.23, 5, 13, 4 з терморозривом; одне офіційне фото.'),
  ('magda-614-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/614', 'Модель №614', 'verified', now(), 'Для квартири; типи 2.24, 3.23, 5, 13, 4 з терморозривом; одне офіційне фото.'),
  ('magda-807-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/T4-p-1', 'Модель №807 ПC №1', 'verified', now(), 'Варіант моделі 807: склопакет з піскоструминним дизайном, тип 4 з терморозривом.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-613-official', 'gallery', 'Модель 613 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/447/d45/354/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-614-official', 'gallery', 'Модель 614 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/9cf/36e/a01/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-807-official', 'gallery', 'Модель 807 — ПC №1, піскоструминний склопакет', 'https://magda.com.ua/storage/app/uploads/public/bba/f38/26d/thumb__0_0_0_0_auto.jpg', 3, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-613-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 4 з терморозривом', 1, true),
  ('magda-613-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-613-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-613-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true),
  ('magda-614-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 4 з терморозривом', 1, true),
  ('magda-614-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-614-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-614-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true),
  ('magda-807-official', 'Варіант дизайну', 'ПC №1 — склопакет із піскоструминним дизайном', 6, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-613-official', 'magda-614-official', 'magda-807-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
