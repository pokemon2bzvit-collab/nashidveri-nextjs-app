-- Magda, завершення сторінки 4: офіційні моделі 160, 607 та 609.
-- По одному підтвердженому фото; усі картки створюються прихованими.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-160-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №160',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 160 — вхідні металеві двері для квартири з кількома заводськими типами комплектації. Допоможемо підібрати декор, замки, розмір і точну вартість.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/178/633/4d2/thumb__0_0_0_0_auto.jpg', 99038, false, now()),
  ('magda-607-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №607',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 607 — вхідні двері для квартири з акцентом на дизайн внутрішньої сторони полотна. Доступні різні типи комплектації; декор, замки та ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Дизайн внутрішньої сторони', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/e2c/9b8/725/thumb__0_0_0_0_auto.jpg', 99039, false, now()),
  ('magda-609-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №609',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 609 — вхідні двері для квартири з акцентом на дизайн внутрішньої сторони полотна. Допоможемо підібрати доступний декор, комплектацію та розмір для вашого прорізу.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Дизайн внутрішньої сторони', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/7af/be1/a3b/thumb__0_0_0_0_auto.jpg', 99040, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources
  (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-160-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/160', 'Модель №160', 'verified', now(), 'Типи 2.24, 3.23, 5, 13, 12.2; одне офіційне фото.'),
  ('magda-607-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/607', 'Модель №607', 'verified', now(), 'Для квартири; типи 2.24, 3.23, 5, 13, 4 з терморозривом; одне офіційне фото.'),
  ('magda-609-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/609', 'Модель №609', 'verified', now(), 'Для квартири; типи 2.24, 3.23, 5, 13, 4 з терморозривом; одне офіційне фото.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-160-official', 'gallery', 'Модель 160 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/178/633/4d2/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-607-official', 'gallery', 'Модель 607 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/e2c/9b8/725/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-609-official', 'gallery', 'Модель 609 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/7af/be1/a3b/thumb__0_0_0_0_auto.jpg', 1, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-160-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 12.2', 1, true),
  ('magda-160-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-160-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-160-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true),
  ('magda-607-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 4 з терморозривом', 1, true),
  ('magda-607-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-607-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-607-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true),
  ('magda-609-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 4 з терморозривом', 1, true),
  ('magda-609-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-609-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-609-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-160-official', 'magda-607-official', 'magda-609-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
