-- Чернетки Magda: сторінка 10, друга частина.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
values
  ('magda-809-1-ornament-2-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №809.1 орнамент №2', 'Сталь, вологостійкий МДФ та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №809.1 орнамент №2 — вхідні металеві двері для приватного будинку з терморозривом. Лаконічний дизайн та надійна конструкція доповнюються заводськими варіантами декорів; актуальну комплектацію й ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для приватного будинку', 'Терморозрив', 'Орнамент №2'), 'https://magda.com.ua/storage/app/uploads/public/890/37f/060/thumb__0_0_0_0_auto.jpg', 99019, false),
  ('magda-151-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №151.1', 'Сталь, вологостійкий МДФ та заводські покриття', 'Класичний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №151.1 — вхідні двері для приватного будинку з полімерною накладкою та патинуванням зовні. Допоможемо підібрати заводський декор і комплектацію; актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для приватного будинку', 'Полімерна накладка', 'Патинування'), 'https://magda.com.ua/storage/app/uploads/public/f6b/18a/1e7/thumb__0_0_0_0_auto.jpg', 99020, false),
  ('magda-346-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №346', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №346 — вхідні двері для квартири з лаконічним дизайном і надійною конструкцією. Доступні заводські декори та комплектація типу 2.24 Kale; точну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Тип 2.24 Kale'), 'https://magda.com.ua/storage/app/uploads/public/a8c/5cd/7a9/thumb__0_0_0_0_auto.jpg', 99021, false),
  ('magda-112-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №112', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №112 — вхідні металеві двері для квартири з дзеркалом на внутрішній стороні. Модель допоможе візуально доповнити інтер’єр; доступні заводські декори та комплектація типу 2.24 Kale.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Дзеркало з внутрішнього боку', 'Тип 2.24 Kale'), 'https://magda.com.ua/storage/app/uploads/public/21f/d1a/7df/thumb__0_0_0_0_auto.jpg', 99022, false),
  ('magda-114-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №114', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №114 — вхідні двері для квартири з практичним дизайном і надійним захистом. Доступні заводські декори та варіанти комплектації фурнітури типу 2.24 Kale; актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Тип 2.24 Kale'), 'https://magda.com.ua/storage/app/uploads/public/7a1/28a/94f/thumb__0_0_0_0_auto.jpg', 99023, false),
  ('magda-653-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №653', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №653 — вхідні металеві двері для квартири з тепло- і шумоізоляцією. Дизайн МДФ-панелей поєднує два кольори, створюючи виразний вигляд; актуальну комплектацію й ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Тепло- і шумоізоляція', 'Комбіновані МДФ-панелі'), 'https://magda.com.ua/storage/app/uploads/public/2e8/e76/619/thumb__0_0_0_0_auto.jpg', 99024, false)
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path, collection = excluded.collection, updated_at = now();

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-809-1-ornament-2-official', 'Призначення', 'Для приватного будинку', 10, true), ('magda-809-1-ornament-2-official', 'Конструкція', 'З терморозривом', 20, true),
  ('magda-151-1-official', 'Призначення', 'Для приватного будинку', 10, true), ('magda-151-1-official', 'Зовнішнє оздоблення', 'Полімерна накладка з патинуванням', 20, true),
  ('magda-346-official', 'Призначення', 'Для квартири', 10, true), ('magda-346-official', 'Доступна комплектація', 'Тип 2.24 (Kale)', 20, true),
  ('magda-112-official', 'Призначення', 'Для квартири', 10, true), ('magda-112-official', 'Особливість', 'Дзеркало з внутрішнього боку', 20, true),
  ('magda-114-official', 'Призначення', 'Для квартири', 10, true), ('magda-114-official', 'Доступна комплектація', 'Тип 2.24 (Kale)', 20, true),
  ('magda-653-official', 'Призначення', 'Для квартири', 10, true), ('magda-653-official', 'Особливість дизайну', 'Комбіновані кольори МДФ-панелей', 20, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-809-1-ornament-2-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/8091-ornament-2', 'Модель №809.1 орнамент №2', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-151-1-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/1511', 'Модель №151.1', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-346-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/346', 'Модель №346', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-112-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/112', 'Модель №112', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-114-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/114', 'Модель №114', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-653-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/653', 'Модель №653', 'verified', now(), 'Офіційна картка виробника')
on conflict (product_slug, source_url) do update set verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-809-1-ornament-2-official', 'gallery', 'Magda Модель №809.1 орнамент №2 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/890/37f/060/thumb__0_0_0_0_auto.jpg', 10, true), ('magda-809-1-ornament-2-official', 'gallery', 'Magda Модель №809.1 орнамент №2 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/9ee/c8f/a5f/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-151-1-official', 'gallery', 'Magda Модель №151.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/f6b/18a/1e7/thumb__0_0_0_0_auto.jpg', 10, true), ('magda-151-1-official', 'gallery', 'Magda Модель №151.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/ff7/79f/53b/thumb__0_0_0_0_auto.jpg', 20, true), ('magda-151-1-official', 'gallery', 'Magda Модель №151.1 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/94a/d78/dd4/thumb__0_0_0_0_auto.jpg', 30, true),
  ('magda-346-official', 'gallery', 'Magda Модель №346 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/a8c/5cd/7a9/thumb__0_0_0_0_auto.jpg', 10, true), ('magda-346-official', 'gallery', 'Magda Модель №346 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/67c/c45/b4b/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-112-official', 'gallery', 'Magda Модель №112 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/21f/d1a/7df/thumb__0_0_0_0_auto.jpg', 10, true), ('magda-112-official', 'gallery', 'Magda Модель №112 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/396/0ff/d94/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-114-official', 'gallery', 'Magda Модель №114 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/7a1/28a/94f/thumb__0_0_0_0_auto.jpg', 10, true), ('magda-114-official', 'gallery', 'Magda Модель №114 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/e33/149/1ac/thumb__0_0_0_0_auto.jpg', 20, true), ('magda-114-official', 'gallery', 'Magda Модель №114 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/990/813/b58/thumb__0_0_0_0_auto.jpg', 30, true),
  ('magda-653-official', 'gallery', 'Magda Модель №653 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/2e8/e76/619/thumb__0_0_0_0_auto.jpg', 10, true), ('magda-653-official', 'gallery', 'Magda Модель №653 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/cc9/8d0/565/thumb__0_0_0_0_auto.jpg', 20, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано", count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї", count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p left join public.product_media m on m.product_slug = p.slug left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-809-1-ornament-2-official','magda-151-1-official','magda-346-official','magda-112-official','magda-114-official','magda-653-official')
group by p.slug, p.name, p.collection, p.is_available order by p.name;
