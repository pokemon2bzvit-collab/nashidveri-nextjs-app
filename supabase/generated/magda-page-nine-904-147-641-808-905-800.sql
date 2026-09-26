-- Чернетки Magda: сторінка 9, перші шість офіційних моделей.
-- Усі моделі залишаються прихованими до окремої перевірки та публікації.

begin;

insert into public.products
  (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
values
  ('magda-904-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №904.1', 'Сталь, вологостійкий МДФ та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №904.1 — вуличні вхідні двері з терморозривом. Комбіноване покриття з фарбуванням і оцинкованим металом допомагає підібрати практичне рішення для приватного будинку. Доступні заводські декори та комплектація; актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для приватного будинку', 'Терморозрив'), 'https://magda.com.ua/storage/app/uploads/public/6fb/2a9/b96/thumb__0_0_0_0_auto.jpg', 99001, false),
  ('magda-147-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №147', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №147 — вхідні двері для квартири з варіантами комплектації фурнітури та заводськими покриттями. Допоможемо підібрати декор і комплектацію під ваш інтер’єр; актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Кілька типів комплектації'), 'https://magda.com.ua/storage/app/uploads/public/c14/8ee/387/thumb__0_0_0_0_auto.jpg', 99002, false),
  ('magda-641-1-pch-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №641.1 ПЧ', 'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №641.1 ПЧ — вхідні двері для квартири з тепло- і шумоізоляцією. Поєднання двох кольорів МДФ-панелей створює виразний вигляд; доступні заводські декори та комплектації. Актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Комбіновані МДФ-панелі'), 'https://magda.com.ua/storage/app/uploads/public/1c4/292/bb4/thumb__0_0_0_0_auto.jpg', 99003, false),
  ('magda-808-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №808', 'Сталь, вологостійкий МДФ та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №808 — вуличні вхідні двері з терморозривом. Модель підходить для приватного будинку; доступні заводські покриття та точну комплектацію допоможе підібрати менеджер.', jsonb_build_array('Офіційна модель Magda', 'Для приватного будинку', 'Терморозрив'), 'https://magda.com.ua/storage/app/uploads/public/90e/005/794/thumb__0_0_0_0_auto.jpg', 99004, false),
  ('magda-905-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №905.1', 'Сталь, вологостійкий МДФ та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №905.1 — вуличні вхідні двері з конструкцією з терморозривом. Для моделі передбачені заводські варіанти фурнітури та декорів; актуальну комплектацію й ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для приватного будинку', 'Терморозрив'), 'https://magda.com.ua/storage/app/uploads/public/bb0/566/76a/thumb__0_0_0_0_auto.jpg', 99005, false),
  ('magda-800-1-official', 'entrance', 'Magda', 'Вулиця', 'Magda Модель №800.1', 'Сталь, вологостійкий МДФ та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом', 'Magda Модель №800.1 — вуличні вхідні двері зі склопакетом для приватного будинку або офісу. Модель поєднує захист, сучасний вигляд і заводські варіанти комплектації; актуальну ціну уточнюйте у менеджера.', jsonb_build_array('Офіційна модель Magda', 'Для приватного будинку або офісу', 'Склопакет', 'Терморозрив'), 'https://magda.com.ua/storage/app/uploads/public/aab/372/d1f/thumb__0_0_0_0_auto.jpg', 99006, false)
on conflict (slug) do update set
  name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color,
  description = excluded.description, features = excluded.features, image_path = excluded.image_path,
  collection = excluded.collection, updated_at = now();

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-904-1-official', 'Призначення', 'Для приватного будинку', 10, true), ('magda-904-1-official', 'Конструкція', 'З терморозривом', 20, true),
  ('magda-147-official', 'Призначення', 'Для квартири', 10, true), ('magda-147-official', 'Доступні комплектації', 'Тип 2.24 (Kale), тип 3.23, тип 5, тип 13, тип 12.2', 20, true),
  ('magda-641-1-pch-official', 'Призначення', 'Для квартири', 10, true), ('magda-641-1-pch-official', 'Доступні комплектації', 'Тип 3.23, тип 5, тип 13', 20, true),
  ('magda-808-official', 'Призначення', 'Для приватного будинку', 10, true), ('magda-808-official', 'Конструкція', 'З терморозривом', 20, true),
  ('magda-905-1-official', 'Призначення', 'Для приватного будинку', 10, true), ('magda-905-1-official', 'Конструкція', 'З терморозривом', 20, true),
  ('magda-800-1-official', 'Призначення', 'Для приватного будинку або офісу', 10, true), ('magda-800-1-official', 'Конструкція', 'Зі склопакетом і терморозривом', 20, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-904-1-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/904', 'Модель №904.1', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-147-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/147', 'Модель №147', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-641-1-pch-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/641', 'Модель №641.1 ПЧ', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-808-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/808', 'Модель №808', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-905-1-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/9051', 'Модель №905.1', 'verified', now(), 'Офіційна картка виробника'),
  ('magda-800-1-official', 'Magda', 'https://magda.com.ua/uk/catalog/item/8001', 'Модель №800.1', 'verified', now(), 'Офіційна картка виробника')
on conflict (product_slug, source_url) do update set verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-904-1-official', 'gallery', 'Magda Модель №904.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/6fb/2a9/b96/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-904-1-official', 'gallery', 'Magda Модель №904.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/a8b/853/1db/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-147-official', 'gallery', 'Magda Модель №147 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/c14/8ee/387/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-147-official', 'gallery', 'Magda Модель №147 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/ff9/6f4/2d5/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-641-1-pch-official', 'gallery', 'Magda Модель №641.1 ПЧ — фото 1', 'https://magda.com.ua/storage/app/uploads/public/1c4/292/bb4/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-641-1-pch-official', 'gallery', 'Magda Модель №641.1 ПЧ — фото 2', 'https://magda.com.ua/storage/app/uploads/public/b61/4ab/238/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-808-official', 'gallery', 'Magda Модель №808 — головне фото', 'https://magda.com.ua/storage/app/uploads/public/90e/005/794/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-905-1-official', 'gallery', 'Magda Модель №905.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/bb0/566/76a/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-905-1-official', 'gallery', 'Magda Модель №905.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/b9e/145/d67/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-800-1-official', 'gallery', 'Magda Модель №800.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/aab/372/d1f/thumb__0_0_0_0_auto.jpg', 10, true),
  ('magda-800-1-official', 'gallery', 'Magda Модель №800.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/ea3/7c8/047/thumb__0_0_0_0_auto.jpg', 20, true),
  ('magda-800-1-official', 'gallery', 'Magda Модель №800.1 — фото 3', 'https://magda.com.ua/storage/app/uploads/public/a33/380/297/thumb__0_0_0_0_auto.jpg', 30, true),
  ('magda-800-1-official', 'gallery', 'Magda Модель №800.1 — фото 4', 'https://magda.com.ua/storage/app/uploads/public/8cd/fc8/5f1/thumb__0_0_0_0_auto.png', 40, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
       count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
       count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-904-1-official','magda-147-official','magda-641-1-pch-official','magda-808-official','magda-905-1-official','magda-800-1-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
