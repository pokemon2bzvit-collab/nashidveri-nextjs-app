-- Magda: моделі 717 і 702.1 з другої сторінки офіційного каталогу.
-- Обидві створюються прихованими чернетками, по 2 заводські фото.

begin;

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-717-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №717',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку', 'Дуб білий 1223-FGP та заводські декори', 'Ціна за запитом',
   'Magda 717 — вуличні вхідні двері зі структурним склопакетом і терморозривом. Доступні різні комплектації фурнітури: прямокутна чорна, прямокутна хромована або класична хромована; актуальну ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив', 'Структурний склопакет'),
   'https://magda.com.ua/storage/app/uploads/public/8d8/0f2/f6e/thumb__0_0_0_0_auto.jpg', 99010, false, now()),
  ('magda-702-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №702.1',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку', 'Заводські декори', 'Ціна за запитом',
   'Magda 702.1 — вхідні двері для приватного будинку з елегантним дизайном, надійним захистом і терморозривом. Допоможемо підібрати декор, комплектацію та розмір дверного блоку; актуальну ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив'),
   'https://magda.com.ua/storage/app/uploads/public/944/8ae/4af/thumb__0_0_0_0_auto.jpg', 99011, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-717-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/717', 'Модель №717', 'verified', now(), 'Для вулиці; тип 6.23 з терморозривом.'),
  ('magda-702-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/7021', 'Модель №702.1', 'verified', now(), 'Для будинку; тип 6.23 з терморозривом.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-717-official', 'gallery', 'Модель 717 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/8d8/0f2/f6e/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-717-official', 'gallery', 'Модель 717 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/4ea/e38/2e1/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-702-1-official', 'gallery', 'Модель 702.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/944/8ae/4af/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-702-1-official', 'gallery', 'Модель 702.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/5a3/060/a8a/thumb__0_0_0_0_auto.jpg', 2, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-717-official', 'Тип комплектації', 'Тип 6.23 з терморозривом', 1, true),
  ('magda-717-official', 'Товщина полотна', '94 мм', 2, true),
  ('magda-717-official', 'Товщина короба', '112 мм з терморозривом', 3, true),
  ('magda-717-official', 'Товщина металу короба', '1,2 мм', 4, true),
  ('magda-717-official', 'Контури ущільнення', '3', 5, true),
  ('magda-717-official', 'Наповнення', 'Кам’яна вата, екструдований пінополістирол та НПЕ-полотно', 6, true),
  ('magda-702-1-official', 'Тип комплектації', 'Тип 6.23 з терморозривом', 1, true),
  ('magda-702-1-official', 'Товщина полотна', '94 мм', 2, true),
  ('magda-702-1-official', 'Товщина короба', '112 мм з терморозривом', 3, true),
  ('magda-702-1-official', 'Товщина металу короба', '1,2 мм', 4, true),
  ('magda-702-1-official', 'Контури ущільнення', '3', 5, true),
  ('magda-702-1-official', 'Наповнення', 'Кам’яна вата, екструдований пінополістирол та НПЕ-полотно', 6, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-717-official','magda-702-1-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
