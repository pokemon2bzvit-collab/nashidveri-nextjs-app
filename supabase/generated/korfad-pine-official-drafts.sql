-- KORFAD · Сосна.
-- Додає 4 приховані чернетки з точними офіційними фото.
-- Джерело: https://korfad.com.ua/mizhkimnatni-dveri-korfad/filter/kolekcja=20;page=all/

begin;

create temporary table korfad_pine_models (slug text, name text, source_url text, image_path text) on commit drop;
insert into korfad_pine_models values
  ('korfad-cd-01','KORFAD CD-01','https://korfad.com.ua/dverne-polotno-sosna-cd-01-800-kh-2000/','https://korfad.com.ua/content/images/13/199x480l85nn0/dverne-polotno-sosna-cd-01-800-kh-2000-50661457491457.webp'),
  ('korfad-cd-02','KORFAD CD-02','https://korfad.com.ua/dverne-polotno-sosna-cd-02-800-kh-2000/','https://korfad.com.ua/content/images/17/199x480l85nn0/dverne-polotno-sosna-cd-02-800-kh-2000-30768687522564.webp'),
  ('korfad-cd-03','KORFAD CD-03','https://korfad.com.ua/dverne-polotno-sosna-cd-03-800-kh-2000/','https://korfad.com.ua/content/images/21/199x480l85nn0/dverne-polotno-sosna-cd-03-800-kh-2000-14897262362931.webp'),
  ('korfad-cd-04','KORFAD CD-04','https://korfad.com.ua/dverne-polotno-sosna-cd-04-800-kh-2000/','https://korfad.com.ua/content/images/25/199x480l85nn0/dverne-polotno-sosna-cd-04-800-kh-2000-16833102875235.webp');

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select slug, 'interior', 'KORFAD', 'Сосна', name, 'Натуральна сосна під фарбування', 'Класичний', 'Під фарбування', 'Ціна за запитом',
  name || ' — міжкімнатні двері KORFAD із натуральної сосни під фарбування. Модель можна підібрати під інтер’єр і потрібну комплектацію; деталі та ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика KORFAD', 'Колекція Сосна'), image_path, 99999, false
from korfad_pine_models
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select slug, label, value, sort_order, true
from korfad_pine_models
cross join lateral (values
  ('Розміри полотна', '600, 700, 800 або 900 × 2000 мм', 10),
  ('Конструкція полотна', 'Збірні дверні полотна', 20),
  ('Декор', 'Сосна натуральна під фарбування', 30),
  ('Торець полотна', 'Під фарбування', 40),
  ('Гарантія виробника', '60 місяців', 90)
) as specification(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select slug, 'KORFAD — офіційний каталог', source_url, name, 'verified', now(), 'Імпортовано з офіційної картки KORFAD: модель, характеристики та головне фото.'
from korfad_pine_models model
where not exists (select 1 from public.product_sources source where source.product_slug = model.slug and source.source_url = model.source_url);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'main', 'Головне фото', image_path, 0 from korfad_pine_models model
where not exists (select 1 from public.product_media media where media.product_slug = model.slug and media.kind = 'main');

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'gallery', 'Натуральна сосна під фарбування', image_path, 1 from korfad_pine_models variant
where not exists (select 1 from public.product_media media where media.product_slug = variant.slug and media.kind = 'gallery' and media.image_path = variant.image_path);

commit;

select count(*) as моделей, count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media where product_slug like 'korfad-cd-%' and kind = 'main') as моделей_з_фото
from public.products where brand = 'KORFAD' and collection = 'Сосна';
