-- Чернетки Magda: сторінка 9, друга частина.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
values
  ('magda-806-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №806.1', 'Сталь, вологостійкий МДФ та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №806.1 — вхідні металеві двері для приватного будинку або офісу. Заводська комплектація типу 15, практичні покриття та кілька фото допоможуть узгодити потрібне виконання в салоні. Актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для будинку або офісу', 'Тип 15'), 'https://magda.com.ua/storage/app/uploads/public/047/1b4/58a/thumb__0_0_0_0_auto.jpg', 99007, false),
  ('magda-645-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №645', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №645 — вхідні двері з тепло- і шумоізоляцією та надійною фурнітурою. Горизонтальна вставка дає змогу комбінувати заводські кольори покриття під інтер’єр; актуальну комплектацію й ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Комбіновані декори', 'Тип 2.24 Kale'), 'https://magda.com.ua/storage/app/uploads/public/3bf/f22/fb2/thumb__0_0_0_0_auto.jpg', 99008, false),
  ('magda-535-1-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №535.1', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №535.1 — вхідні металеві двері для квартири з оригінальним дизайном. Внутрішня сторона моделі декорована дзеркалом; доступні заводські виконання та комплектація типу 3.23. Актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Дзеркало з внутрішнього боку', 'Тип 3.23'), 'https://magda.com.ua/storage/app/uploads/public/93d/1e3/de1/thumb__0_0_0_0_auto.jpg', 99009, false),
  ('magda-110-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №110', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №110 — вхідні двері для квартири з лаконічним дизайном і надійною конструкцією. Допоможемо підібрати заводський декор та комплектацію типу 2.24 Kale; актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Тип 2.24 Kale'), 'https://magda.com.ua/storage/app/uploads/public/c6a/57d/0c1/thumb__0_0_0_0_auto.jpg', 99010, false),
  ('magda-542-1-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №542.1', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №542.1 — вхідні двері для квартири в сучасному стриманому дизайні. Заводська комплектація типу 13 передбачає замки Mottura або Securemme; доступні декори та актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Тип 13', 'Замки Mottura або Securemme'), 'https://magda.com.ua/storage/app/uploads/public/50f/caf/a75/thumb__0_0_0_0_auto.jpg', 99011, false),
  ('magda-539-1-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №539.1', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №539.1 — вхідні двері з елегантним дизайном і надійною конструкцією. Для моделі доступні заводські декори та комплектація типу 2.24 Kale; точне виконання й ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Тип 2.24 Kale'), 'https://magda.com.ua/storage/app/uploads/public/9f2/711/1c0/thumb__0_0_0_0_auto.jpg', 99012, false)
on conflict (slug) do update set
  name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color,
  description = excluded.description, features = excluded.features, image_path = excluded.image_path,
  collection = excluded.collection, updated_at = now();

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-806-1-official', 'Призначення', 'Для приватного будинку або офісу', 10, true), ('magda-806-1-official', 'Доступна комплектація', 'Тип 15', 20, true),
  ('magda-645-official', 'Призначення', 'Для квартири', 10, true), ('magda-645-official', 'Доступна комплектація', 'Тип 2.24 (Kale)', 20, true),
  ('magda-535-1-official', 'Призначення', 'Для квартири', 10, true), ('magda-535-1-official', 'Доступна комплектація', 'Тип 3.23', 20, true),
  ('magda-110-official', 'Призначення', 'Для квартири', 10, true), ('magda-110-official', 'Доступна комплектація', 'Тип 2.24 (Kale)', 20, true),
  ('magda-542-1-official', 'Призначення', 'Для квартири', 10, true), ('magda-542-1-official', 'Доступна комплектація', 'Тип 13', 20, true),
  ('magda-539-1-official', 'Призначення', 'Для квартири', 10, true), ('magda-539-1-official', 'Доступна комплектація', 'Тип 2.24 (Kale)', 20, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-806-1-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/8061', 'Модель №806.1', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-645-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/645', 'Модель №645', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-535-1-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/5351', 'Модель №535.1', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-110-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/110', 'Модель №110', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-542-1-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/5421', 'Модель №542.1', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-539-1-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/5391', 'Модель №539.1', 'verified', now(), 'Офіційна картка виробника')
on conflict (product_slug, source_url) do update set verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-806-1-official', 'gallery', 'Magda Модель №806.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/047/1b4/58a/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-806-1-official', 'gallery', 'Magda Модель №806.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/c8f/3ba/415/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-806-1-official', 'gallery', 'Magda Модель №806.1 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/715/c53/d40/thumb__0_0_0_0_auto.jpg', 30, true),
  ('magda-806-1-official', 'gallery', 'Magda Модель №806.1 — фото 4', 'https://magda.com.ua/storage/app/uploads/public/fd6/6ff/a1b/thumb__0_0_0_0_auto.jpg', 40, true),
  ('magda-806-1-official', 'gallery', 'Magda Модель №806.1 — фото 5', 'https://magda.com.ua/storage/app/uploads/public/b3b/cab/892/thumb__0_0_0_0_auto.jpg', 50, true),
  ('magda-645-official', 'gallery', 'Magda Модель №645 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/3bf/f22/fb2/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-645-official', 'gallery', 'Magda Модель №645 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/3dd/aaa/400/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-535-1-official', 'gallery', 'Magda Модель №535.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/93d/1e3/de1/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-535-1-official', 'gallery', 'Magda Модель №535.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/69d/426/874/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-535-1-official', 'gallery', 'Magda Модель №535.1 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/b9a/d6f/9ff/thumb__0_0_0_0_auto.jpg', 30, true),
  ('magda-535-1-official', 'gallery', 'Magda Модель №535.1 — фото 4', 'https://magda.com.ua/storage/app/uploads/public/e6f/ee4/7a9/thumb__0_0_0_0_auto.jpg', 40, true),
  ('magda-110-official', 'gallery', 'Magda Модель №110 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/c6a/57d/0c1/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-110-official', 'gallery', 'Magda Модель №110 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/167/739/e7b/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-110-official', 'gallery', 'Magda Модель №110 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/3a6/3c6/82d/thumb__0_0_0_0_auto.jpg', 30, true),
  ('magda-110-official', 'gallery', 'Magda Модель №110 — фото 4', 'https://magda.com.ua/storage/app/uploads/public/653/a6e/41f/thumb__0_0_0_0_auto.jpg', 40, true),
  ('magda-542-1-official', 'gallery', 'Magda Модель №542.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/50f/caf/a75/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-542-1-official', 'gallery', 'Magda Модель №542.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/e37/b88/5e4/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-539-1-official', 'gallery', 'Magda Модель №539.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/9f2/711/1c0/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-539-1-official', 'gallery', 'Magda Модель №539.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/f5b/9ef/021/thumb__0_0_0_0_auto.jpg', 20, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
       count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
       count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-806-1-official','magda-645-official','magda-535-1-official','magda-110-official','magda-542-1-official','magda-539-1-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
