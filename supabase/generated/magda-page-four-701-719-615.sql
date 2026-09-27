-- Magda, сторінка 4: нові моделі 719.1 і 615.
-- Сторінка «701-country-oak» є іншим офіційним виконанням уже доданої моделі 701,
-- тому її фото та джерело об'єднуємо з магда-701-official, без створення дубля.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-719-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №719.1',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для будинку або офісу', 'Заводські декори', 'Ціна за запитом',
   'Magda 719.1 — металеві вхідні двері для будинку або офісу з ламінованим металом зовні та вологостійкою МДФ-панеллю зсередини. Актуальну комплектацію, декор і ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для будинку або офісу', 'Ламінований метал зовні', 'Вологостійкий МДФ усередині'),
   'https://magda.com.ua/storage/app/uploads/public/29f/242/742/thumb__0_0_0_0_auto.jpg', 99030, false, now()),
  ('magda-615-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №615',
   'Сталь, вологостійкий МДФ та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 615 — вхідні металеві двері для квартири з кількома доступними типами комплектації. Допоможемо підібрати декор, замки, розмір і точну вартість для вашого прорізу.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'),
   'https://magda.com.ua/storage/app/uploads/public/c81/1f9/f4d/thumb__0_0_0_0_auto.jpg', 99031, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

-- Доповнюємо наявну 701 термовиконанням, а не створюємо другу картку тієї ж моделі.
update public.products
set collection = 'Вулиця', style = 'Для приватного будинку',
    description = 'Magda 701 — вхідні металеві двері для приватного будинку. Для моделі доступне офіційне виконання типу 6.23 з терморозривом; декор, розмір і комплектацію узгодимо перед замовленням.',
    features = jsonb_build_array('Офіційна модель Magda', 'Для будинку', 'Терморозрив'),
    updated_at = now()
where slug = 'magda-701-official';

insert into public.product_sources
  (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-719-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/714', 'Модель №719.1', 'verified', now(), 'Для будинку або офісу; п''ять офіційних фото.'),
  ('magda-615-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/615', 'Модель №615', 'verified', now(), 'Для квартири; одне офіційне фото.'),
  ('magda-701-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/701-country-oak', 'Модель №Т6.23 701', 'verified', now(), 'Виконання 6.23 з терморозривом; додаткові офіційні фото.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-719-1-official', 'gallery', 'Модель 719.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/29f/242/742/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-719-1-official', 'gallery', 'Модель 719.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/171/e3d/b5a/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-719-1-official', 'gallery', 'Модель 719.1 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/319/b47/01a/thumb__0_0_0_0_auto.jpg', 3, true),
  ('magda-719-1-official', 'gallery', 'Модель 719.1 — фото 4', 'https://magda.com.ua/storage/app/uploads/public/13d/718/fae/thumb__0_0_0_0_auto.jpg', 4, true),
  ('magda-719-1-official', 'gallery', 'Модель 719.1 — фото 5', 'https://magda.com.ua/storage/app/uploads/public/d49/0e6/14d/thumb__0_0_0_0_auto.jpg', 5, true),
  ('magda-615-official', 'gallery', 'Модель 615 — офіційне фото', 'https://magda.com.ua/storage/app/uploads/public/c81/1f9/f4d/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-701-official', 'gallery', 'Модель 701 — термовиконання, фото 1', 'https://magda.com.ua/storage/app/uploads/public/de5/641/3ab/thumb__0_0_0_0_auto.png', 10, true),
  ('magda-701-official', 'gallery', 'Модель 701 — термовиконання, фото 2', 'https://magda.com.ua/storage/app/uploads/public/9f5/aae/76e/thumb__0_0_0_0_auto.png', 11, true)
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-719-1-official', 'Тип комплектації', 'Тип 16', 1, true),
  ('magda-719-1-official', 'Товщина полотна', '75 мм', 2, true),
  ('magda-719-1-official', 'Товщина короба', '113 мм', 3, true),
  ('magda-719-1-official', 'Товщина металу', '1,2 мм', 4, true),
  ('magda-719-1-official', 'Наповнення', 'Мінеральна вата', 5, true),
  ('magda-719-1-official', 'Контури ущільнення', '2', 6, true),
  ('magda-615-official', 'Доступні типи комплектації', '2.24, 3.23, 5, 13 або 4 з терморозривом', 1, true),
  ('magda-615-official', 'Товщина полотна', 'Від 90 мм залежно від типу', 2, true),
  ('magda-615-official', 'Товщина короба', 'Від 100 мм залежно від типу', 3, true),
  ('magda-615-official', 'Наповнення', 'Мінеральна або кам''яна вата залежно від типу', 4, true),
  ('magda-701-official', 'Тип комплектації', 'Тип 6.23 з терморозривом', 1, true),
  ('magda-701-official', 'Товщина полотна', '94 мм', 2, true),
  ('magda-701-official', 'Товщина короба', '112 мм з терморозривом', 3, true),
  ('magda-701-official', 'Товщина металу короба', '1,2 мм', 4, true),
  ('magda-701-official', 'Контури ущільнення', '3', 5, true)
on conflict (product_slug, label) do update set
  value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-701-official', 'magda-719-1-official', 'magda-615-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
