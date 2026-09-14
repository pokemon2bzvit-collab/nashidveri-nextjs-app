-- Офіційна Papa Carlo T-11: звичайне виконання окремо від T-11 (BLK).
-- Одразу показується у каталозі.

begin;

insert into public.products (
  slug, category, brand, collection, name, material, style, color,
  price, description, features, image_path, sort_order, is_available
) values (
  'papa-carlo-t-11-official',
  'interior',
  'Papa Carlo',
  'Tetra',
  'Papa Carlo T-11',
  'Міжкімнатні',
  'Колекція Tetra',
  'Варіанти декорів і скла',
  'Ціна за запитом',
  'Papa Carlo T-11 — міжкімнатні двері колекції Tetra з вертикальним склом і поліпропіленовою плівкою Renolit (Німеччина). Полотно товщиною 38 мм доступне у стандартних ширинах 610, 710, 810 та 910 мм; можливе виготовлення нестандартного розміру під замовлення. Двері мають стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні. Актуальну комплектацію й ціну уточнюйте у менеджера.',
  '["Фабрика Papa Carlo", "Колекція Tetra", "Вертикальне скло", "Офіційна картка виробника"]'::jsonb,
  'https://papa-karlo.com.ua/content/images/8/420x940l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.jpg',
  111,
  true
)
on conflict (slug) do update set
  category = excluded.category,
  brand = excluded.brand,
  collection = excluded.collection,
  name = excluded.name,
  material = excluded.material,
  style = excluded.style,
  color = excluded.color,
  price = excluded.price,
  description = excluded.description,
  features = excluded.features,
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_available = true,
  updated_at = now();

insert into public.product_specs (product_slug, label, value, sort_order, is_active) values
  ('papa-carlo-t-11-official', 'Розміри полотна', 'ширина: 610, 710, 810 або 910 мм; висота: 2000 мм, можливий нестандартний розмір під замовлення', 100, true),
  ('papa-carlo-t-11-official', 'Товщина полотна', '38 мм', 110, true),
  ('papa-carlo-t-11-official', 'Матеріал покриття', 'Поліпропіленова плівка Renolit (Німеччина)', 120, true),
  ('papa-carlo-t-11-official', 'Варіант скла', 'Вертикальне скло', 130, true)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_options (
  product_slug, option_group, group_label, label, image_path, sort_order, is_active
) values (
  'papa-carlo-t-11-official',
  'glass',
  'Скло',
  'Вертикальне скло',
  'https://papa-karlo.com.ua/content/images/8/420x940l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.jpg',
  20,
  true
)
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label,
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_variants (
  product_slug, selections, image_path, sort_order, is_active
) values (
  'papa-carlo-t-11-official',
  '{"glass":"Вертикальне скло"}'::jsonb,
  'https://papa-karlo.com.ua/content/images/8/420x940l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.jpg',
  20,
  true
)
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_media (
  product_slug, kind, label, image_path, sort_order, is_active
) values (
  'papa-carlo-t-11-official',
  'main',
  'Papa Carlo T-11 — головне фото',
  'https://papa-karlo.com.ua/content/images/8/420x940l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.jpg',
  0,
  true
)
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = true;

delete from public.product_sources
where product_slug = 'papa-carlo-t-11-official'
  and source_url = 'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-t-11/';

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
) values (
  'papa-carlo-t-11-official',
  'Papa Carlo',
  'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-t-11/',
  'Міжкімнатні двері Папа Карло T-11 — Ламіновані, артикул 01623',
  'verified',
  now(),
  'Офіційна картка Papa Carlo: фото, вертикальне скло та базові технічні параметри.'
);

commit;

select p.slug, p.name, p.collection, p.is_available,
       count(distinct s.label) as характеристик,
       count(distinct v.selections) as фото_варіантів
from public.products p
left join public.product_specs s on s.product_slug = p.slug and s.is_active = true
left join public.product_variants v on v.product_slug = p.slug and v.is_active = true
where p.slug = 'papa-carlo-t-11-official'
group by p.slug, p.name, p.collection, p.is_available;
