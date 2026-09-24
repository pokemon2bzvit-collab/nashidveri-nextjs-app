-- Magda: офіційне уточнення двох наявних моделей.
-- Змінює ЛИШЕ catalog-52 (711.1) та catalog-53 (945):
-- додає підтверджені Magda-джерела, галереї та перевірені характеристики.
-- Моделі залишаються опублікованими, нових карток не створюється.

begin;

-- 1. Офіційні джерела.
insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  (
    'catalog-52',
    'Офіційний каталог Magda',
    'https://magda.com.ua/uk/catalog/item/7111',
    'Magda Модель №711.1',
    'verified', now(),
    'Офіційна картка: двері для будинку, типи 6.23 з терморозривом та 16.'
  ),
  (
    'catalog-53',
    'Офіційний каталог Magda',
    'https://magda.com.ua/uk/catalog/item/9451',
    'Magda Модель №945',
    'verified', now(),
    'Офіційна картка: двері для будинку, тип 6.23 з терморозривом.'
  )
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;

-- 2. Головні фото і короткі, перевірені описи.
update public.products
set
  image_path = case slug
    when 'catalog-52' then 'https://magda.com.ua/storage/app/uploads/public/0d7/fc6/d09/thumb__0_0_0_0_auto.jpg'
    when 'catalog-53' then 'https://magda.com.ua/storage/app/uploads/public/f7a/981/a50/thumb__0_0_0_0_auto.jpg'
  end,
  description = case slug
    when 'catalog-52' then 'Magda 711.1 — вхідні двері для приватного будинку зі склопакетом і декоративною накладкою. Доступні типи 6.23 з терморозривом та 16; точна комплектація залежить від обраного виконання. Актуальну ціну й покриття уточнюйте у менеджера.'
    when 'catalog-53' then 'Magda 945 — вхідні двері для приватного будинку з поєднанням ламінації та фарбованого металу. Конструкція з терморозривом допомагає зменшити втрати тепла; актуальну комплектацію, покриття й ціну уточнюйте у менеджера.'
  end,
  updated_at = now()
where slug in ('catalog-52', 'catalog-53');

-- 3. Офіційні фотографії. Перший кадр дублює головне фото,
-- решта показуються у мініатюрах під ним.
insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('catalog-52', 'gallery', 'Модель 711.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/0d7/fc6/d09/thumb__0_0_0_0_auto.jpg', 1, true),
  ('catalog-52', 'gallery', 'Модель 711.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/0fd/1b2/e9b/thumb__0_0_0_0_auto.jpg', 2, true),
  ('catalog-52', 'gallery', 'Модель 711.1 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/36f/c4f/18c/thumb__0_0_0_0_auto.jpg', 3, true),
  ('catalog-52', 'gallery', 'Модель 711.1 — фото 4', 'https://magda.com.ua/storage/app/uploads/public/f23/fcc/c02/thumb__0_0_0_0_auto.jpg', 4, true),
  ('catalog-52', 'gallery', 'Модель 711.1 — фото 5', 'https://magda.com.ua/storage/app/uploads/public/8cb/abb/cd4/thumb__0_0_0_0_auto.jpg', 5, true),
  ('catalog-52', 'gallery', 'Модель 711.1 — фото 6', 'https://magda.com.ua/storage/app/uploads/public/3f4/519/745/thumb__0_0_0_0_auto.jpg', 6, true),
  ('catalog-52', 'gallery', 'Модель 711.1 — фото 7', 'https://magda.com.ua/storage/app/uploads/public/73e/240/ba7/thumb__0_0_0_0_auto.jpg', 7, true),
  ('catalog-53', 'gallery', 'Модель 945 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/f7a/981/a50/thumb__0_0_0_0_auto.jpg', 1, true),
  ('catalog-53', 'gallery', 'Модель 945 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/772/b96/ce7/thumb__0_0_0_0_auto.jpg', 2, true)
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = true;

-- 4. Спільні офіційні параметри для типу 6.23 з терморозривом.
insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('catalog-52', 'Типи комплектації', 'Тип 6.23 з терморозривом або Тип 16', 1, true),
  ('catalog-52', 'Товщина полотна', '94 мм', 2, true),
  ('catalog-52', 'Товщина короба', '112 мм з терморозривом', 3, true),
  ('catalog-52', 'Товщина металу короба', '1,2 мм', 4, true),
  ('catalog-52', 'Покриття металоконструкції', 'Ґрунт-фарба та порошкове фарбування', 5, true),
  ('catalog-52', 'Наповнення', 'Кам’яна вата, екструдований пінополістирол та НПЕ-полотно', 6, true),
  ('catalog-52', 'Контури ущільнення', '3', 7, true),
  ('catalog-52', 'Верхній замок', 'Сувальдний Securemme 2019', 8, true),
  ('catalog-52', 'Нижній замок', 'Циліндровий Securemme 2061', 9, true),
  ('catalog-53', 'Тип комплектації', 'Тип 6.23 з терморозривом', 1, true),
  ('catalog-53', 'Товщина полотна', '94 мм', 2, true),
  ('catalog-53', 'Товщина короба', '112 мм з терморозривом', 3, true),
  ('catalog-53', 'Товщина металу короба', '1,2 мм', 4, true),
  ('catalog-53', 'Покриття металоконструкції', 'Ґрунт-фарба та порошкове фарбування', 5, true),
  ('catalog-53', 'Наповнення', 'Кам’яна вата, екструдований пінополістирол та НПЕ-полотно', 6, true),
  ('catalog-53', 'Контури ущільнення', '3', 7, true),
  ('catalog-53', 'Верхній замок', 'Сувальдний Securemme 2019', 8, true),
  ('catalog-53', 'Нижній замок', 'Циліндровий Securemme 2061', 9, true)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;

commit;

-- Перевірка результату.
select
  p.slug,
  p.name as "модель",
  p.is_available as "опубліковано",
  count(distinct s.id) filter (where s.source_url ilike '%magda.com.ua%') as "офіційних_джерел",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї"
from public.products p
left join public.product_sources s on s.product_slug = p.slug
left join public.product_media m on m.product_slug = p.slug
where p.slug in ('catalog-52', 'catalog-53')
group by p.slug, p.name, p.is_available
order by p.slug;
