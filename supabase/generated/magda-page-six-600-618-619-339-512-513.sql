-- Пакет із шести прихованих чернеток Magda з офіційного каталогу.

begin;

insert into public.products (
  slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available
) values
('magda-600-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №600', 'Сталь, МДФ-накладки та заводські покриття', 'Для будинку', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №600 — вхідні двері з офіційного каталогу виробника. Доступне виконання з терморозривом; підкажемо тип комплектації, декор і розмір для вашого об’єкта.', jsonb_build_array('Офіційна модель Magda', 'Варіант з терморозривом', 'Заводські декори'), 'https://magda.com.ua/storage/app/uploads/public/f92/7d4/088/thumb__0_0_0_0_auto.png', 99012, false),
('magda-618-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №618', 'Сталь, МДФ-накладки та заводські покриття', 'Для будинку', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №618 — вхідні двері з офіційного каталогу виробника. Доступне виконання з терморозривом; допоможемо обрати комплектацію, декор і розмір.', jsonb_build_array('Офіційна модель Magda', 'Варіант з терморозривом', 'Заводські декори'), 'https://magda.com.ua/storage/app/uploads/public/20d/a2e/f12/thumb__0_0_0_0_auto.jpg', 99013, false),
('magda-619-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №619', 'Сталь, МДФ-накладки та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №619 — сучасні вхідні двері для квартири з геометричним дизайном і вибором заводських кольорів плівки. Актуальну комплектацію й ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Заводські декори'), 'https://magda.com.ua/storage/app/uploads/public/afc/bb9/321/thumb__0_0_0_0_auto.jpg', 99014, false),
('magda-339-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №339', 'Сталь, МДФ-накладки та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №339 — вхідні двері для квартири з дизайном внутрішньої сторони полотна. Допоможемо підібрати тип комплектації, декор і розмір.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Заводські декори'), 'https://magda.com.ua/storage/app/uploads/public/e4f/c3e/17c/thumb__0_0_0_0_auto.jpg', 99015, false),
('magda-512ph-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №512 ПХ', 'Сталь, МДФ-накладки та заводські покриття', 'Для квартири', 'Покриття «Юпітер»', 'Ціна за запитом', 'Magda Модель №512 ПХ — вхідні двері для квартири з покриттям «Юпітер» з офіційного каталогу виробника. Для моделі доступні різні типи комплектації, зокрема варіант з терморозривом.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Покриття «Юпітер»', 'Варіант з терморозривом'), 'https://magda.com.ua/storage/app/uploads/public/c67/618/7ee/thumb__0_0_0_0_auto.jpg', 99016, false),
('magda-513ph-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №513.1 ПХ', 'Сталь, МДФ-накладки та заводські покриття', 'Для квартири', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №513.1 ПХ — вхідні двері для квартири з виразними вертикальними лініями дизайну. Допоможемо обрати комплектацію, декор і розмір дверного блоку.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Заводські декори'), 'https://magda.com.ua/storage/app/uploads/public/f2b/35f/f56/thumb__0_0_0_0_auto.jpg', 99017, false)
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material, style = excluded.style,
  color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values
('magda-600-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/600', 'Модель №600', 'verified', now(), 'Офіційна картка виробника'),
('magda-618-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/618', 'Модель №618', 'verified', now(), 'Офіційна картка виробника'),
('magda-619-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/619', 'Модель №619', 'verified', now(), 'Офіційна картка виробника'),
('magda-339-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/339', 'Модель №339', 'verified', now(), 'Офіційна картка виробника'),
('magda-512ph-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/512ph', 'Модель №512', 'verified', now(), 'Офіційна картка виробника'),
('magda-513ph-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/513ph', 'Модель №513.1ПХ', 'verified', now(), 'Офіційна картка виробника')
on conflict (product_slug, source_url) do update set source_product_name = excluded.source_product_name, verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values
('magda-600-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/f92/7d4/088/thumb__0_0_0_0_auto.png', 1, true),
('magda-618-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/20d/a2e/f12/thumb__0_0_0_0_auto.jpg', 1, true),
('magda-619-official', 'gallery', 'Фото 1', 'https://magda.com.ua/storage/app/uploads/public/afc/bb9/321/thumb__0_0_0_0_auto.jpg', 1, true),
('magda-619-official', 'gallery', 'Фото 2', 'https://magda.com.ua/storage/app/uploads/public/24e/7c0/db6/thumb__0_0_0_0_auto.jpg', 2, true),
('magda-619-official', 'gallery', 'Фото 3', 'https://magda.com.ua/storage/app/uploads/public/c27/a7c/40c/thumb__0_0_0_0_auto.jpg', 3, true),
('magda-339-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/e4f/c3e/17c/thumb__0_0_0_0_auto.jpg', 1, true),
('magda-512ph-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/c67/618/7ee/thumb__0_0_0_0_auto.jpg', 1, true),
('magda-513ph-official', 'gallery', 'Головне фото', 'https://magda.com.ua/storage/app/uploads/public/f2b/35f/f56/thumb__0_0_0_0_auto.jpg', 1, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = excluded.is_active;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select slug, label, value, sort_order, true
from (values
('magda-600-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13, Тип 4 з терморозривом', 10),
('magda-618-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13, Тип 4 з терморозривом', 10),
('magda-619-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13', 10),
('magda-339-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13', 10),
('magda-512ph-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13, Тип 4 з терморозривом, Тип 16', 10),
('magda-513ph-official', 'Доступні типи комплектації', 'Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13', 10),
('magda-600-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20),
('magda-618-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20),
('magda-619-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20),
('magda-339-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20),
('magda-512ph-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20),
('magda-513ph-official', 'Товщина полотна', '90 мм залежно від типу комплектації', 20),
('magda-600-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30),
('magda-618-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30),
('magda-619-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30),
('magda-339-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30),
('magda-512ph-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30),
('magda-513ph-official', 'Товщина короба', '100 мм залежно від типу комплектації', 30)
) as v(slug, label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = excluded.is_active;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-600-official','magda-618-official','magda-619-official','magda-339-official','magda-512ph-official','magda-513ph-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
