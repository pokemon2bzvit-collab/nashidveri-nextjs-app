-- Magda 530.1: перевірена офіційна чернетка з двома фото.

begin;

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values (
  'magda-530-1-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №530.1',
  'Сталь, МДФ-панелі та заводські покриття', 'Для квартири', 'Спил дерева коньячний та інші заводські декори', 'Ціна за запитом',
  'Magda 530.1 — вхідні двері для квартири у декорі «спил дерева коньячний». Для моделі доступні понад 40 варіантів кольорів і кілька комплектацій фурнітури; утеплене полотно та два контури ущільнення допомагають зберігати комфорт у помешканні.',
  jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Понад 40 заводських декорів'),
  'https://magda.com.ua/storage/app/uploads/public/f59/483/ee2/thumb__0_0_0_0_auto.jpg', 99009, false, now()
)
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values ('magda-530-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/5301', 'Модель №530.1', 'verified', now(), 'Типи 2.24, 3.23, 5, 13, 12.2; понад 40 кольорів і три комплектації фурнітури.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-530-1-official', 'gallery', 'Модель 530.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/f59/483/ee2/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-530-1-official', 'gallery', 'Модель 530.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/cae/8d3/a5f/thumb__0_0_0_0_auto.jpg', 2, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-530-1-official', 'Типи комплектації', 'Тип 2.24, 3.23, 5, 13 або 12.2', 1, true),
  ('magda-530-1-official', 'Товщина полотна', '90 мм, гнутий профіль', 2, true),
  ('magda-530-1-official', 'Товщина короба', '100 мм, гнутий профіль', 3, true),
  ('magda-530-1-official', 'Товщина металу', '1,2 мм', 4, true),
  ('magda-530-1-official', 'Контури ущільнення', '2', 5, true),
  ('magda-530-1-official', 'Наповнення', 'Мінеральна та кам’яна вата', 6, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug = 'magda-530-1-official'
group by p.slug, p.name, p.is_available;
