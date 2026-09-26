-- Чернетки Magda: остання, одинадцята сторінка офіційного каталогу.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
values
  ('magda-107-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №107', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №107 — функціональні вхідні металеві двері для квартири. Практична конструкція, заводські покриття та комплектація типу 2.24 Kale допоможуть підібрати потрібне виконання; актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Тип 2.24 Kale'), 'https://magda.com.ua/storage/app/uploads/public/4fb/e2c/e4c/thumb__0_0_0_0_auto.jpg', 99025, false),
  ('magda-521-1-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №521.1', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №521.1 — вхідні двері для квартири. Доступна заводська комплектація типу 1 і варіанти декорів; актуальну ціну та точне виконання уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Тип 1'), 'https://magda.com.ua/storage/app/uploads/public/8c9/76b/9df/thumb__0_0_0_0_auto.jpg', 99026, false)
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path, collection = excluded.collection, updated_at = now();

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-107-official', 'Призначення', 'Для квартири', 10, true), ('magda-107-official', 'Доступна комплектація', 'Тип 2.24 (Kale)', 20, true),
  ('magda-521-1-official', 'Призначення', 'Для квартири', 10, true), ('magda-521-1-official', 'Доступна комплектація', 'Тип 1', 20, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-107-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/107', 'Модель №107', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-521-1-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/5211', 'Модель №521.1', 'verified', now(), 'Офіційна картка виробника')
on conflict (product_slug, source_url) do update set verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-107-official', 'gallery', 'Magda Модель №107 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/4fb/e2c/e4c/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-107-official', 'gallery', 'Magda Модель №107 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/782/c4d/54c/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-521-1-official', 'gallery', 'Magda Модель №521.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/8c9/76b/9df/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-521-1-official', 'gallery', 'Magda Модель №521.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/283/bfc/ea7/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-521-1-official', 'gallery', 'Magda Модель №521.1 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/9ac/cda/3be/thumb__0_0_0_0_auto.jpg', 30, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано", count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї", count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p left join public.product_media m on m.product_slug = p.slug left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-107-official','magda-521-1-official')
group by p.slug, p.name, p.collection, p.is_available order by p.name;
