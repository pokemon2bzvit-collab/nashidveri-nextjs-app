-- KORFAD · ALUMINIUM LOFT PLATO.
-- Додає 4 приховані чернетки та 19 точних фото декорів.
-- Старі KFD-моделі не змінюються.
-- Джерело: https://korfad.com.ua/mizhkimnatni-dveri-korfad/filter/kolekcja=3/

begin;

create temporary table korfad_alp_models (
  slug text, name text, sizes text, source_url text, main_image text
) on commit drop;

insert into korfad_alp_models values
  ('korfad-alp-01', 'KORFAD ALP-01', '600, 700 або 800 × 2000 мм', 'https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-01-800-kh-2000-art-beton-aliuminii/', 'https://korfad.com.ua/content/images/17/223x480l85nn0/96154446925927.webp'),
  ('korfad-alp-02', 'KORFAD ALP-02', '600, 700 або 800 × 2000 мм', 'https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-02-800-kh-2000-art-beton-aliuminii/', 'https://korfad.com.ua/content/images/40/223x480l85nn0/76099040790726.webp'),
  ('korfad-alp-03', 'KORFAD ALP-03', '600, 700, 800 або 900 × 2000 мм', 'https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-03-800-kh-2000-art-beton-aliuminii/', 'https://korfad.com.ua/content/images/9/223x480l85nn0/69950185102194.webp'),
  ('korfad-alp-07', 'KORFAD ALP-07', '600, 700 або 800 × 2000 мм', 'https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-07-800-kh-2000-art-beton-aliuminii/', 'https://korfad.com.ua/content/images/39/223x480l85nn0/19598031369366.webp');

create temporary table korfad_alp_variants (
  slug text, color text, image_path text, source_url text, sort_order integer
) on commit drop;

insert into korfad_alp_variants values
  ('korfad-alp-01','Арт бетон','https://korfad.com.ua/content/images/17/223x480l85nn0/96154446925927.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-01-800-kh-2000-art-beton-aliuminii/',1),
  ('korfad-alp-01','Білий перламутр','https://korfad.com.ua/content/images/20/223x480l85nn0/23390924677456.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-01-800-kh-2000-bilyi-perlamutr-aliuminii/',2),
  ('korfad-alp-01','Лайт бетон','https://korfad.com.ua/content/images/25/223x480l85nn0/54697243933153.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-01-800-kh-2000-lait-beton-aliuminii/',3),
  ('korfad-alp-01','Лофт бетон','https://korfad.com.ua/content/images/31/223x480l85nn0/72782310024434.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-01-800-kh-2000-loft-beton-aliuminii/',4),
  ('korfad-alp-01','Сталь кортен','https://korfad.com.ua/content/images/37/223x480l85nn0/87620108953823.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-01-800-kh-2000-stal-korten-aliuminii/',5),
  ('korfad-alp-02','Арт бетон','https://korfad.com.ua/content/images/40/223x480l85nn0/76099040790726.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-02-800-kh-2000-art-beton-aliuminii/',1),
  ('korfad-alp-02','Лайт бетон','https://korfad.com.ua/content/images/43/223x480l85nn0/24195574063341.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-02-800-kh-2000-lait-beton-aliuminii/',2),
  ('korfad-alp-02','Лофт бетон','https://korfad.com.ua/content/images/48/223x480l85nn0/78889566594126.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-02-800-kh-2000-loft-beton-aliuminii/',3),
  ('korfad-alp-02','Сталь кортен','https://korfad.com.ua/content/images/6/223x480l85nn0/42433211028701.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-02-800-kh-2000-stal-korten-aliuminii/',4),
  ('korfad-alp-03','Арт бетон','https://korfad.com.ua/content/images/9/223x480l85nn0/69950185102194.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-03-800-kh-2000-art-beton-aliuminii/',1),
  ('korfad-alp-03','Білий перламутр','https://korfad.com.ua/content/images/16/223x480l85nn0/18108558922376.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-03-800-kh-2000-bilyi-perlamutr-aliuminii/',2),
  ('korfad-alp-03','Лайт бетон','https://korfad.com.ua/content/images/23/223x480l85nn0/44019880789897.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-03-800-kh-2000-lait-beton-aliuminii/',3),
  ('korfad-alp-03','Лофт бетон','https://korfad.com.ua/content/images/29/223x480l85nn0/17255347041116.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-03-800-kh-2000-loft-beton-aliuminii/',4),
  ('korfad-alp-03','Сталь кортен','https://korfad.com.ua/content/images/36/223x480l85nn0/57654311482520.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-03-800-kh-2000-stal-korten-aliuminii/',5),
  ('korfad-alp-07','Арт бетон','https://korfad.com.ua/content/images/39/223x480l85nn0/19598031369366.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-07-800-kh-2000-art-beton-aliuminii/',1),
  ('korfad-alp-07','Білий перламутр','https://korfad.com.ua/content/images/42/223x480l85nn0/50818645143341.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-07-800-kh-2000-bilyi-perlamutr-aliuminii/',2),
  ('korfad-alp-07','Лайт бетон','https://korfad.com.ua/content/images/44/223x480l85nn0/61510247645599.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-07-800-kh-2000-lait-beton-aliuminii/',3),
  ('korfad-alp-07','Лофт бетон','https://korfad.com.ua/content/images/49/223x480l85nn0/43889022172779.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-07-800-kh-2000-loft-beton-aliuminii/',4),
  ('korfad-alp-07','Сталь кортен','https://korfad.com.ua/content/images/8/223x480l85nn0/40102017321372.webp','https://korfad.com.ua/dverne-polotno-aluminium-loft-plato-alp-07-800-kh-2000-stal-korten-aliuminii/',5);

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select slug, 'interior', 'KORFAD', 'ALUMINIUM LOFT PLATO', name, 'Декоративне покриття', 'Лофт', 'Заводські декори', 'Ціна за запитом',
  name || ' — міжкімнатні двері колекції ALUMINIUM LOFT PLATO. Каркасно-щитовий формат із алюмінієвою декоративною вставкою та заводськими декорами. Точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика KORFAD', 'Колекція ALUMINIUM LOFT PLATO'), main_image, 99999, false
from korfad_alp_models
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select slug, label, value, sort_order, true
from korfad_alp_models
cross join lateral (values
  ('Розміри полотна', sizes, 10),
  ('Конструкція полотна', 'Каркасно-щитові дверні полотна', 20),
  ('Декоративна вставка', 'Алюмінієва', 30),
  ('Торець полотна', 'Звичайна кромка', 40),
  ('Гарантія виробника', '60 місяців', 90)
) as specification(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
select slug, 'color', 'Декор', color, null, null, min(sort_order)
from korfad_alp_variants group by slug, color
on conflict (product_slug, option_group, label) do update set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select slug, jsonb_build_object('color', color), image_path, sort_order, true
from korfad_alp_variants
on conflict (product_slug, selections) do update set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select slug, 'KORFAD — офіційний каталог', source_url, name, 'verified', now(), 'Імпортовано з офіційної картки KORFAD: модель, характеристики та точне фото декору.'
from korfad_alp_models model
where not exists (select 1 from public.product_sources source where source.product_slug = model.slug and source.source_url = model.source_url);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'main', 'Головне фото', main_image, 0
from korfad_alp_models model
where not exists (select 1 from public.product_media media where media.product_slug = model.slug and media.kind = 'main');

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'gallery', 'Декор: ' || color, image_path, sort_order
from korfad_alp_variants variant
where not exists (select 1 from public.product_media media where media.product_slug = variant.slug and media.kind = 'gallery' and media.image_path = variant.image_path);

commit;

select count(*) as моделей, count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_variants where product_slug like 'korfad-alp-%' and is_active) as фото_варіантів
from public.products where brand = 'KORFAD' and collection = 'ALUMINIUM LOFT PLATO';
