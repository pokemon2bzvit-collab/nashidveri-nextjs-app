-- Papa Carlo T-18: окрема офіційна чернетка.
-- Дані взято з картки виробника 14.09.2026.
-- Скрипт НЕ змінює наявний T-00F і НЕ публікує нову модель у каталозі.

begin;

insert into public.products (
  slug, category, brand, collection, name, material, style, color,
  price, description, features, image_path, sort_order, is_available
) values (
  'papa-carlo-t-18-official',
  'interior',
  'Papa Carlo',
  'Tetra',
  'Papa Carlo T-18',
  'Міжкімнатні двері',
  'Колекція Tetra',
  'Варіанти декорів',
  'Ціна за запитом',
  'Papa Carlo T-18 — міжкімнатні двері колекції Tetra з поліпропіленовою плівкою Renolit (Німеччина). Полотно товщиною 40 мм доступне у стандартних ширинах 610, 710, 810 та 910 мм; можливе виготовлення нестандартного розміру під замовлення. Двері мають стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні. Актуальну комплектацію й ціну уточнюйте у менеджера.',
  '["Фабрика Papa Carlo", "Колекція Tetra", "Офіційна картка виробника"]'::jsonb,
  'https://papa-karlo.com.ua/content/images/26/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-t-18-91405346675505.jpg',
  118,
  false
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
  is_available = false,
  updated_at = now();

insert into public.product_specs (product_slug, label, value, sort_order, is_active) values
  ('papa-carlo-t-18-official', 'Розміри полотна', 'ширина: 610, 710, 810 або 910 мм; висота: 2002 мм, можливий нестандартний розмір під замовлення', 100, true),
  ('papa-carlo-t-18-official', 'Товщина полотна', '40 мм', 110, true),
  ('papa-carlo-t-18-official', 'Матеріал покриття', 'Поліпропіленова плівка Renolit (Німеччина)', 120, true)
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values
  ('papa-carlo-t-18-official', 'main', 'Papa Carlo T-18 — головне фото', 'https://papa-karlo.com.ua/content/images/26/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-t-18-91405346675505.jpg', 0, true)
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = true;

delete from public.product_sources
where product_slug = 'papa-carlo-t-18-official'
  and source_url = 'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-t-18/';

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
) values (
  'papa-carlo-t-18-official',
  'Papa Carlo',
  'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-t-18/',
  'Міжкімнатні двері Папа Карло T-18 — Ламіновані, артикул 02201',
  'verified',
  now(),
  'Офіційна картка Papa Carlo: фото та базові технічні параметри.'
);

commit;

-- Перевірка після виконання:
select p.slug, p.name, p.collection, p.is_available, p.image_path,
       count(distinct s.label) as specs,
       count(distinct src.source_url) as sources
from public.products p
left join public.product_specs s on s.product_slug = p.slug and s.is_active = true
left join public.product_sources src on src.product_slug = p.slug
where p.slug = 'papa-carlo-t-18-official'
group by p.slug, p.name, p.collection, p.is_available, p.image_path;
