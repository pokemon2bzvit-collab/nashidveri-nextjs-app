-- Magda, завершення сторінки 5: офіційні моделі 166, 167 і 169.
-- У 166 три офіційні фото, у 167 та 169 — по одному.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-166-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №166',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 166 — сучасні вхідні двері для квартири з надійним захистом. Доступні кілька типів комплектації; декор, замки та точну ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Сучасний дизайн', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/462/b26/be8/thumb__0_0_0_0_auto.jpg', 99049, false, now()),
  ('magda-167-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №167',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 167 — вхідні металеві двері для квартири з вибором заводських типів комплектації. Допоможемо підібрати декор, фурнітуру та розмір для вашого прорізу.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/b98/5c4/ee9/thumb__0_0_0_0_auto.jpg', 99050, false, now()),
  ('magda-169-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №169',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 169 — вхідні металеві двері для квартири з кількома доступними заводськими типами комплектації. Актуальні декори, замки та ціну підкаже менеджер.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/af8/a1a/265/thumb__0_0_0_0_auto.jpg', 99051, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources
  (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-166-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/166', 'Модель №166', 'verified', now(), 'Типи 2.24, 3.23, 13, 12.2; три офіційні фото.'),
  ('magda-167-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/167', 'Модель №167', 'verified', now(), 'Типи 2.24, 3.23, 5, 13, 12.2; одне офіційне фото.'),
  ('magda-169-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/169', 'Модель №169', 'verified', now(), 'Типи 2.24, 3.23, 5, 13, 12.2; одне офіційне фото.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-166-official', 'gallery', 'Модель 166 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/462/b26/be8/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-166-official', 'gallery', 'Модель 166 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/562/e6a/b32/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-166-official', 'gallery', 'Модель 166 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/785/662/7e8/thumb__0_0_0_0_auto.jpg', 3, true),
  ('magda-167-official', 'gallery', 'Модель 167 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/b98/5c4/ee9/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-169-official', 'gallery', 'Модель 169 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/af8/a1a/265/thumb__0_0_0_0_auto.jpg', 1, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-166-official', 'Доступні типи комплектації', '2.24, 3.23, 13 або 12.2', 1, true),
  ('magda-166-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-166-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-167-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 12.2', 1, true),
  ('magda-167-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-167-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-169-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 12.2', 1, true),
  ('magda-169-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-169-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-166-official', 'magda-167-official', 'magda-169-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
