-- Magda: нові моделі 715 і 701, плюс варіант решітки 018 для наявної 807.
-- 715 і 701 створюються прихованими чернетками.
-- Модель 807 не дублюється: до неї додається ще одне офіційне фото та джерело.

begin;

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-715-thermal-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №715 з терморозривом',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку', 'Заводські декори', 'Ціна за запитом',
   'Magda 715 — вхідні металеві двері для приватного будинку зі склопакетом і терморозривом. Доступні комплектації з чорною або хромованою фурнітурою; актуальну ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив', 'Склопакет'),
   'https://magda.com.ua/storage/app/uploads/public/ae6/349/fc0/thumb__0_0_0_0_auto.jpg', 99024, false, now()),
  ('magda-701-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №701',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для приватного будинку', 'Заводські декори', 'Ціна за запитом',
   'Magda 701 — вхідні металеві двері для приватного будинку з терморозривом. Допоможемо підібрати декор, комплектацію та розмір дверного блоку; актуальну ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив'),
   'https://magda.com.ua/storage/app/uploads/public/098/c8a/019/thumb__0_0_0_0_auto.png', 99025, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-715-thermal-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/t623pch-715-sklopaket-strukturnij-1', 'Модель №715 з терморозривом', 'verified', now(), 'Для будинку; склопакет, тип 6.23 з терморозривом.'),
  ('magda-701-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/701-bronze-oak', 'Модель №701', 'verified', now(), 'Для будинку; тип 6.23 з терморозривом.'),
  ('magda-807-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/143-r021', 'Модель №807 (018)', 'verified', now(), 'Офіційний варіант тієї самої моделі з дизайном решітки 018.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-715-thermal-official', 'gallery', 'Модель 715 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/ae6/349/fc0/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-715-thermal-official', 'gallery', 'Модель 715 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/728/479/c53/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-715-thermal-official', 'gallery', 'Модель 715 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/9bf/42f/22e/thumb__0_0_0_0_auto.jpg', 3, true),
  ('magda-715-thermal-official', 'gallery', 'Модель 715 — фото 4', 'https://magda.com.ua/storage/app/uploads/public/f63/40a/abc/thumb__0_0_0_0_auto.jpg', 4, true),
  ('magda-701-official', 'gallery', 'Модель 701 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/098/c8a/019/thumb__0_0_0_0_auto.png', 1, true),
  ('magda-701-official', 'gallery', 'Модель 701 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/85d/96e/8d1/thumb__0_0_0_0_auto.png', 2, true),
  ('magda-701-official', 'gallery', 'Модель 701 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/e9e/5cf/b73/thumb__0_0_0_0_auto.png', 3, true),
  ('magda-807-official', 'gallery', 'Варіант решітки 018', 'https://magda.com.ua/storage/app/uploads/public/ba9/826/0b5/thumb__0_0_0_0_auto.jpg', 2, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

update public.products
set
  description = 'Magda 807 — вхідні металеві двері для приватного будинку зі склопакетом і терморозривом. Доступні декоративні решітки у виконаннях 018 або 019; актуальну комплектацію й ціну уточнюйте у менеджера.',
  updated_at = now()
where slug = 'magda-807-official';

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-715-thermal-official', 'Тип комплектації', 'Тип 6.23 з терморозривом', 1, true),
  ('magda-715-thermal-official', 'Товщина полотна', '94 мм', 2, true),
  ('magda-715-thermal-official', 'Товщина короба', '112 мм з терморозривом', 3, true),
  ('magda-715-thermal-official', 'Товщина металу короба', '1,2 мм', 4, true),
  ('magda-715-thermal-official', 'Контури ущільнення', '3', 5, true),
  ('magda-715-thermal-official', 'Фурнітура', 'Чорна або хромована', 6, true),
  ('magda-701-official', 'Тип комплектації', 'Тип 6.23 з терморозривом', 1, true),
  ('magda-701-official', 'Товщина полотна', '94 мм', 2, true),
  ('magda-701-official', 'Товщина короба', '112 мм з терморозривом', 3, true),
  ('magda-701-official', 'Товщина металу короба', '1,2 мм', 4, true),
  ('magda-701-official', 'Контури ущільнення', '3', 5, true),
  ('magda-701-official', 'Наповнення', 'Кам’яна вата, екструдований пінополістирол та НПЕ-полотно', 6, true),
  ('magda-807-official', 'Дизайн решітки', '018 або 019', 1, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select
  p.slug,
  p.name as "модель",
  p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-715-thermal-official', 'magda-701-official', 'magda-807-official')
group by p.slug, p.name, p.is_available
order by p.name;
