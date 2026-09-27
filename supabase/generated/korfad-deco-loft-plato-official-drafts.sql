-- KORFAD · DECO LOFT PLATO.
-- Додає DLP-01 як приховану чернетку з 10 точними фото заводських декорів.
-- Джерело: https://korfad.com.ua/mizhkimnatni-dveri-korfad/filter/kolekcja=21;page=all/

begin;

create temporary table korfad_deco_models (slug text, name text, main_image text) on commit drop;
insert into korfad_deco_models values
  ('korfad-dlp-01','KORFAD DLP-01','https://korfad.com.ua/content/images/29/223x480l85nn0/34954451133430.webp');

create temporary table korfad_deco_variants (slug text, color text, detail text, image_path text, source_url text, sort_order integer) on commit drop;
insert into korfad_deco_variants values
  ('korfad-dlp-01','Super PET аляска','Чорна декоративна вставка · S/P','https://korfad.com.ua/content/images/29/223x480l85nn0/34954451133430.webp','https://korfad.com.ua/karkasno-shchytovi-dveri-deco-loft-plato-dlp-01-800-kh-2000-super-pet-aliaska-chorna-s-p/',1),
  ('korfad-dlp-01','Super PET антрацит','Чорна декоративна вставка · S/P','https://korfad.com.ua/content/images/37/223x480l85nn0/56744644775124.webp','https://korfad.com.ua/karkasno-shchytovi-dveri-deco-loft-plato-dlp-01-800-kh-2000-super-pet-antratsyt-chorna-s-p/',2),
  ('korfad-dlp-01','Super PET магнолія','Чорна декоративна вставка · S/P','https://korfad.com.ua/content/images/43/223x480l85nn0/96801494633333.webp','https://korfad.com.ua/karkasno-shchytovi-dveri-deco-loft-plato-dlp-01-800-kh-2000-super-pet-mahnoliia-chorna-s-p/',3),
  ('korfad-dlp-01','Super PET сірий','Чорна декоративна вставка · S/P','https://korfad.com.ua/content/images/49/223x480l85nn0/36687924952412.webp','https://korfad.com.ua/karkasno-shchytovi-dveri-deco-loft-plato-dlp-01-800-kh-2000-super-pet-siryi-chorna-s-p/',4),
  ('korfad-dlp-01','Super PET чорний','Чорна декоративна вставка · чорна матова кромка · S/P','https://korfad.com.ua/content/images/5/223x480l85nn0/70491540346151.webp','https://korfad.com.ua/karkasno-shchytovi-dveri-deco-loft-plato-dlp-01-800-kh-2000-super-pet-chornyi-chorna-chorna-matova-kromka-s-p/',5),
  ('korfad-dlp-01','Арт бетон','Чорна декоративна вставка · чорна матова кромка · S/P','https://korfad.com.ua/content/images/13/223x480l85nn0/93982029544592.webp','https://korfad.com.ua/karkasno-shchytovi-dveri-deco-loft-plato-dlp-01-800-kh-2000-art-beton-chorna-chorna-matova-kromka-s-p/',6),
  ('korfad-dlp-01','Білий перламутр','Чорна декоративна вставка · S/P','https://korfad.com.ua/content/images/15/223x480l85nn0/99040911484176.webp','https://korfad.com.ua/karkasno-shchytovi-dveri-deco-loft-plato-dlp-01-800-kh-2000-bilyi-perlamutr-chorna-s-p/',7),
  ('korfad-dlp-01','Лайт бетон','Чорна декоративна вставка · чорна матова кромка · S/P','https://korfad.com.ua/content/images/21/223x480l85nn0/50215847450688.webp','https://korfad.com.ua/karkasno-shchytovi-dveri-deco-loft-plato-dlp-01-800-kh-2000-lait-beton-chorna-chorna-matova-kromka-s-p/',8),
  ('korfad-dlp-01','Лофт бетон','Чорна декоративна вставка · чорна матова кромка · S/P','https://korfad.com.ua/content/images/23/223x480l85nn0/69732969160422.webp','https://korfad.com.ua/karkasno-shchytovi-dveri-deco-loft-plato-dlp-01-800-kh-2000-loft-beton-chorna-chorna-matova-kromka-s-p/',9),
  ('korfad-dlp-01','Сталь кортен','Чорна декоративна вставка · чорна матова кромка · S/P','https://korfad.com.ua/content/images/26/223x480l85nn0/75043926956570.webp','https://korfad.com.ua/karkasno-shchytovi-dveri-deco-loft-plato-dlp-01-800-kh-2000-stal-korten-chorna-chorna-matova-kromka-s-p/',10);

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select slug, 'interior', 'KORFAD', 'DECO LOFT PLATO', name, 'Super PET та декоративні покриття', 'Лофт', 'Заводські декори', 'Ціна за запитом',
  name || ' — каркасно-щитові міжкімнатні двері колекції DECO LOFT PLATO. Для моделі підтверджені заводські декори з чорною декоративною вставкою; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика KORFAD', 'Колекція DECO LOFT PLATO'), main_image, 99999, false
from korfad_deco_models
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select slug, label, value, sort_order, true
from korfad_deco_models
cross join lateral (values
  ('Конструкція полотна', 'Каркасно-щитові дверні полотна', 20),
  ('Розміри полотна', '600 × 2000, 700 × 2000 або 800 × 2000 мм', 30),
  ('Вид полотна', 'Глухе', 40),
  ('Декоративна вставка', 'Чорна або золота — залежно від виконання', 50),
  ('Кромка полотна', 'Звичайна, алюмінієва або чорна матова — залежно від виконання', 60),
  ('Гарантія виробника', '60 місяців', 90)
) as specification(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
select slug, 'color', 'Декор', color, null, null, sort_order
from korfad_deco_variants
on conflict (product_slug, option_group, label) do update set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select slug, jsonb_build_object('color', color), image_path, sort_order, true
from korfad_deco_variants
on conflict (product_slug, selections) do update set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select slug, 'KORFAD — офіційний каталог', 'https://korfad.com.ua/mizhkimnatni-dveri-korfad/filter/kolekcja=21;page=all/', name, 'verified', now(), 'Імпортовано з офіційних карток KORFAD: модель і точні фото заводських декорів.'
from korfad_deco_models model
where not exists (select 1 from public.product_sources source where source.product_slug = model.slug and source.source_url = 'https://korfad.com.ua/mizhkimnatni-dveri-korfad/filter/kolekcja=21;page=all/');

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'main', 'Головне фото', main_image, 0 from korfad_deco_models model
where not exists (select 1 from public.product_media media where media.product_slug = model.slug and media.kind = 'main');

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'gallery', 'Декор: ' || color || ' · ' || detail, image_path, sort_order from korfad_deco_variants variant
where not exists (select 1 from public.product_media media where media.product_slug = variant.slug and media.kind = 'gallery' and media.image_path = variant.image_path);

commit;

select count(*) as моделей, count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_variants where product_slug = 'korfad-dlp-01' and is_active) as фото_варіантів
from public.products where brand = 'KORFAD' and collection = 'DECO LOFT PLATO';
