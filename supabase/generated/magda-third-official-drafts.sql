-- Magda: наступні дві моделі з достатньою офіційною галереєю.
-- 543.1 має 3 фото, 501.1 — 2. Обидві створюються прихованими чернетками.
-- Модель 100 навмисно не додано: у виробника наразі лише одне фото.

begin;

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-543-1-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №543.1',
   'Сталь, МДФ-панелі та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом',
   'Magda 543.1 — практичні вхідні двері для квартири, що поєднують ефективний захист і оптимальну вартість. Утеплене полотно, гнутий профіль і два контури ущільнення допомагають створити комфортний вхід; актуальну комплектацію й ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Гнутий профіль'),
   'https://magda.com.ua/storage/app/uploads/public/96d/463/0bb/thumb__0_0_0_0_auto.jpg', 99007, false, now()),
  ('magda-501-1-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №501.1',
   'Сталь, МДФ-панелі та заводські покриття', 'Для квартири', 'Бетон антрацит · бетон світло-сірий', 'Ціна за запитом',
   'Magda 501.1 — вхідні двері для квартири з контрастним поєднанням бетону антрацит на зовнішній стороні та світло-сірого бетону в інтер’єрі. Доступні кілька типів комплектації; актуальну ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Гнутий профіль'),
   'https://magda.com.ua/storage/app/uploads/public/e1f/907/1d7/thumb__0_0_0_0_auto.jpg', 99008, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-543-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/5431', 'Модель №543.1', 'verified', now(), 'Для квартири; тип 2.24 / 2.24 Kale.'),
  ('magda-501-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/5011', 'Модель №501.1', 'verified', now(), 'Для квартири; типи 2.24, 3.23, 5, 13.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-543-1-official', 'gallery', 'Модель 543.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/96d/463/0bb/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-543-1-official', 'gallery', 'Модель 543.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/1b5/8d8/b91/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-543-1-official', 'gallery', 'Модель 543.1 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/932/722/a30/thumb__0_0_0_0_auto.jpg', 3, true),
  ('magda-501-1-official', 'gallery', 'Модель 501.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/e1f/907/1d7/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-501-1-official', 'gallery', 'Модель 501.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/e25/f31/512/thumb__0_0_0_0_auto.jpg', 2, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-543-1-official', 'Тип комплектації', 'Тип 2.24 або 2.24 Kale', 1, true),
  ('magda-543-1-official', 'Товщина полотна', '90 мм, гнутий профіль', 2, true),
  ('magda-543-1-official', 'Товщина короба', '100 мм, гнутий профіль', 3, true),
  ('magda-543-1-official', 'Товщина металу', '1,2 мм', 4, true),
  ('magda-543-1-official', 'Контури ущільнення', '2', 5, true),
  ('magda-543-1-official', 'Наповнення', 'Мінеральна та кам’яна вата', 6, true),
  ('magda-501-1-official', 'Типи комплектації', 'Тип 2.24, 3.23, 5 або 13', 1, true),
  ('magda-501-1-official', 'Товщина полотна', '90 мм, гнутий профіль', 2, true),
  ('magda-501-1-official', 'Товщина короба', '100 мм, гнутий профіль', 3, true),
  ('magda-501-1-official', 'Товщина металу', '1,2 мм', 4, true),
  ('magda-501-1-official', 'Контури ущільнення', '2', 5, true),
  ('magda-501-1-official', 'Наповнення', 'Мінеральна та кам’яна вата', 6, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-543-1-official','magda-501-1-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
