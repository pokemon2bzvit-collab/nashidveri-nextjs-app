-- Magda, сторінка 4: офіційні моделі 150, 153 та 157.
-- По одному підтвердженому офіційному фото на модель; картки створюються прихованими.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-150-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №150',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 150 — вхідні металеві двері для квартири з кількома доступними типами комплектації. Допоможемо підібрати декор, замки, розмір і точну вартість для вашого прорізу.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/5c0/032/94c/thumb__0_0_0_0_auto.jpg', 99035, false, now()),
  ('magda-153-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №153',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 153 — вхідні металеві двері для квартири з вибором заводських типів комплектації. Уточнимо декор, замки, параметри дверного блоку й актуальну ціну.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/775/934/e59/thumb__0_0_0_0_auto.jpg', 99036, false, now()),
  ('magda-157-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №157',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 157 — вхідні металеві двері для квартири, доступні в декількох заводських типах комплектації. Підкажемо доступні декори, фурнітуру й вартість під ваш проріз.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/e6e/055/24f/thumb__0_0_0_0_auto.jpg', 99037, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources
  (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-150-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/150', 'Модель №150', 'verified', now(), 'Типи 2.24, 3.23, 5, 13, 12.2; одне офіційне фото.'),
  ('magda-153-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/153', 'Модель №153', 'verified', now(), 'Типи 2.24, 3.23, 5, 13, 12.2; одне офіційне фото.'),
  ('magda-157-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/157', 'Модель №157', 'verified', now(), 'Типи 2.24, 3.23, 5, 13, 12.2; одне офіційне фото.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-150-official', 'gallery', 'Модель 150 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/5c0/032/94c/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-153-official', 'gallery', 'Модель 153 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/775/934/e59/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-157-official', 'gallery', 'Модель 157 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/e6e/055/24f/thumb__0_0_0_0_auto.jpg', 1, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-150-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 12.2', 1, true),
  ('magda-150-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-150-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-150-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true),
  ('magda-153-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 12.2', 1, true),
  ('magda-153-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-153-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-153-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true),
  ('magda-157-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 12.2', 1, true),
  ('magda-157-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-157-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-157-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-150-official', 'magda-153-official', 'magda-157-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
