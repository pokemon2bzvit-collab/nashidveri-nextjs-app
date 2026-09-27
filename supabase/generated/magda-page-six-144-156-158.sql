-- Чернетки Magda з 6-ї сторінки офіційного каталогу.
-- Моделі не відображатимуться на сайті до окремої перевірки й публікації.

begin;

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
) values
(
  'magda-144-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №144',
  'Сталь, МДФ-накладки та заводські покриття', 'Для квартири або будинку',
  'Заводські декори', 'Ціна за запитом',
  'Magda Модель №144 — вхідні двері з офіційного каталогу виробника. Для моделі доступні квартирне та вуличне виконання, тому допоможемо підібрати тип комплектації, декор і розмір під ваш об’єкт. Актуальну ціну уточнюйте у менеджера.',
  jsonb_build_array('Офіційна модель Magda', 'Квартирне та вуличне виконання', 'Заводські декори'),
  'https://magda.com.ua/storage/app/uploads/public/d95/2bd/f3d/thumb__0_0_0_0_auto.jpg', 99006, false
),
(
  'magda-156-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №156',
  'Сталь, МДФ-накладки та заводські покриття', 'Для квартири або будинку',
  'Заводські декори', 'Ціна за запитом',
  'Magda Модель №156 — вхідні двері з офіційного каталогу виробника. Для моделі доступні квартирне та вуличне виконання, тому допоможемо підібрати тип комплектації, декор і розмір під ваш об’єкт. Актуальну ціну уточнюйте у менеджера.',
  jsonb_build_array('Офіційна модель Magda', 'Квартирне та вуличне виконання', 'Заводські декори'),
  'https://magda.com.ua/storage/app/uploads/public/222/e84/ae5/thumb__0_0_0_0_auto.jpg', 99007, false
),
(
  'magda-158-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №158',
  'Сталь, МДФ-накладки та заводські покриття', 'Для квартири',
  'Заводські декори', 'Ціна за запитом',
  'Magda Модель №158 — вхідні двері з офіційного каталогу виробника для квартири. Допоможемо підібрати тип комплектації, декор і розмір дверного блоку. Актуальну ціну уточнюйте у менеджера.',
  jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Заводські декори'),
  'https://magda.com.ua/storage/app/uploads/public/3ab/9f7/22d/thumb__0_0_0_0_auto.jpg', 99008, false
)
on conflict (slug) do update set
  collection = excluded.collection,
  name = excluded.name,
  material = excluded.material,
  style = excluded.style,
  color = excluded.color,
  description = excluded.description,
  features = excluded.features,
  image_path = excluded.image_path,
  updated_at = now();

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes
) values
  ('magda-144-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/144', 'Модель №144', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-156-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/156', 'Модель №156', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-158-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/158', 'Модель №158', 'verified', now(), 'Офіційна картка виробника')
on conflict (product_slug, source_url) do update set
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values
  ('magda-144-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/d95/2bd/f3d/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-156-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/222/e84/ae5/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-158-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/3ab/9f7/22d/thumb__0_0_0_0_auto.jpg', 1, true)
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = excluded.is_active;

insert into public.product_specs (product_slug, label, value, sort_order, is_active) values
  ('magda-144-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13, Тип 12.2', 10, true),
  ('magda-144-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20, true),
  ('magda-144-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30, true),
  ('magda-144-official', 'Товщина металу', '1,2 мм залежно від типу комплектації', 40, true),
  ('magda-144-official', 'Наповнення', 'Мінеральна та кам’яна вата залежно від комплектації', 50, true),
  ('magda-156-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13, Тип 12.2', 10, true),
  ('magda-156-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20, true),
  ('magda-156-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30, true),
  ('magda-156-official', 'Товщина металу', '1,2 мм залежно від типу комплектації', 40, true),
  ('magda-156-official', 'Наповнення', 'Мінеральна та кам’яна вата залежно від комплектації', 50, true),
  ('magda-158-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13, Тип 12.2', 10, true),
  ('magda-158-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20, true),
  ('magda-158-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30, true),
  ('magda-158-official', 'Товщина металу', '1,2 мм залежно від типу комплектації', 40, true),
  ('magda-158-official', 'Наповнення', 'Мінеральна та кам’яна вата залежно від комплектації', 50, true)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = excluded.is_active;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-144-official', 'magda-156-official', 'magda-158-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
