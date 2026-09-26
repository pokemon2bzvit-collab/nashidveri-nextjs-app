-- Чернетки Magda №337, №338 і №509 з офіційного каталогу.

begin;

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price,
  description, features, image_path, sort_order, is_available
) values
(
  'magda-337-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №337',
  'Сталь, МДФ-накладки та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
  'Magda Модель №337 — вхідні двері для квартири з офіційного каталогу виробника. Модель має дизайн внутрішньої сторони полотна та доступна в кількох типах комплектації. Актуальну ціну й декор уточнюйте у менеджера.',
  jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Заводські декори'),
  'https://magda.com.ua/storage/app/uploads/public/a85/25a/8fb/thumb__0_0_0_0_auto.jpg', 99009, false
),
(
  'magda-338-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №338',
  'Сталь, МДФ-накладки та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
  'Magda Модель №338 — практичні вхідні двері для квартири з офіційного каталогу виробника. Допоможемо обрати тип комплектації та колір МДФ-панелей під ваш інтер’єр. Актуальну ціну уточнюйте у менеджера.',
  jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Заводські декори'),
  'https://magda.com.ua/storage/app/uploads/public/ec9/dca/d21/thumb__0_0_0_0_auto.jpg', 99010, false
),
(
  'magda-509-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №509',
  'Сталь, МДФ-накладки та заводські покриття', 'Для будинку', 'Заводські декори', 'Ціна за запитом',
  'Magda Модель №509 — вхідні двері з офіційного каталогу виробника. Доступне квартирне, вуличне та виконання з терморозривом — підкажемо оптимальну комплектацію для вашого об’єкта. Актуальну ціну уточнюйте у менеджера.',
  jsonb_build_array('Офіційна модель Magda', 'Вуличне виконання', 'Варіант з терморозривом', 'Заводські декори'),
  'https://magda.com.ua/storage/app/uploads/public/688/c27/c44/thumb__0_0_0_0_auto.jpg', 99011, false
)
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes
) values
  ('magda-337-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/337', 'Модель №337', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-338-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/338', 'Модель №338', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-509-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/509', 'Модель №509', 'verified', now(), 'Офіційна картка виробника')
on conflict (product_slug, source_url) do update set
  source_product_name = excluded.source_product_name, verification_status = excluded.verification_status,
  verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values
  ('magda-337-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/a85/25a/8fb/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-338-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/ec9/dca/d21/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-509-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/688/c27/c44/thumb__0_0_0_0_auto.jpg', 1, true)
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label, sort_order = excluded.sort_order, is_active = excluded.is_active;

insert into public.product_specs (product_slug, label, value, sort_order, is_active) values
  ('magda-337-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13', 10, true),
  ('magda-337-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20, true),
  ('magda-337-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30, true),
  ('magda-337-official', 'Товщина металу', '1,2 мм залежно від типу комплектації', 40, true),
  ('magda-338-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13', 10, true),
  ('magda-338-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20, true),
  ('magda-338-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30, true),
  ('magda-338-official', 'Товщина металу', '1,2 мм залежно від типу комплектації', 40, true),
  ('magda-509-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13, Тип 4 з терморозривом', 10, true),
  ('magda-509-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20, true),
  ('magda-509-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30, true),
  ('magda-509-official', 'Товщина металу', '1,2 мм залежно від типу комплектації', 40, true),
  ('magda-509-official', 'Наповнення', 'Мінеральна та кам’яна вата залежно від комплектації', 50, true)
on conflict (product_slug, label) do update set
  value = excluded.value, sort_order = excluded.sort_order, is_active = excluded.is_active;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-337-official', 'magda-338-official', 'magda-509-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
