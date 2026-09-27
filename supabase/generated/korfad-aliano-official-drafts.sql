-- KORFAD · ALIANO — перший офіційний пакет.
-- Додає 7 МІЖКІМНАТНИХ моделей як приховані чернетки та 33 точні фото-варіанти.
-- Не змінює старі KFD-моделі. Ціни й терміни виготовлення не імпортуються.
-- Джерело: https://korfad.com.ua/mizhkimnatni-dveri-korfad/filter/kolekcja=2/

begin;

create temporary table korfad_aliano_models (
  slug text, name text, sizes text, glass_position text, glass_amount text, source_url text, main_image text
) on commit drop;

insert into korfad_aliano_models values
    ('korfad-aliano-al-01', 'KORFAD AL-01', '400, 600, 700, 800 або 900 × 2000 мм', 'Вертикальне скло', 'Багато скла', 'https://korfad.com.ua/dverne-polotno-aliano-al-01-800-kh-2000-super-pet-aliaska-dvostoronnie-bronzove-dzerkalo/', 'https://korfad.com.ua/content/images/31/223x480l85nn0/43261496172109.webp'),
    ('korfad-aliano-al-02', 'KORFAD AL-02', '400, 600, 700, 800 або 900 × 2000 мм', 'Вертикальне скло', 'Багато скла', 'https://korfad.com.ua/dverne-polotno-aliano-al-02-800-kh-2000-super-pet-aliaska-dvostoronnie-bronzove-dzerkalo/', 'https://korfad.com.ua/content/images/50/223x480l85nn0/38372234720754.webp'),
    ('korfad-aliano-al-03', 'KORFAD AL-03', '600, 700, 800 або 900 × 2000 мм', 'Комбіноване горизонтальне і вертикальне скло', 'Мінімум скла', 'https://korfad.com.ua/dverne-polotno-aliano-al-03-800-kh-2000-super-pet-aliaska-lacobel-chornyi/', 'https://korfad.com.ua/content/images/12/223x480l85nn0/77370145757163.webp'),
    ('korfad-aliano-al-04', 'KORFAD AL-04', '700, 800 або 900 × 2000 мм', 'Комбіноване горизонтальне і вертикальне скло', 'Мінімум скла', 'https://korfad.com.ua/dverne-polotno-aliano-al-04-800-kh-2000-super-pet-aliaska-sklo-chorne/', 'https://korfad.com.ua/content/images/37/223x480l85nn0/96266317109247.webp'),
    ('korfad-aliano-al-05', 'KORFAD AL-05', '600, 700, 800 або 900 × 2000 мм', 'Комбіноване горизонтальне і вертикальне скло', 'Багато скла', 'https://korfad.com.ua/dverne-polotno-aliano-al-05-800-kh-2000-super-pet-aliaska/', 'https://korfad.com.ua/content/images/48/223x480l85nn0/41860923060053.webp'),
    ('korfad-aliano-al-06', 'KORFAD AL-06', '600, 700, 800 або 900 × 2000 мм', 'Вертикальне скло', 'Багато скла', 'https://korfad.com.ua/dverne-polotno-aliano-al-06-800-kh-2000-super-pet-aliaska-dvostoronnie-hrafit-dzerkalo/', 'https://korfad.com.ua/content/images/7/223x480l85nn0/60320133133485.webp'),
    ('korfad-aliano-al-07', 'KORFAD AL-07', '600, 700, 800 або 900 × 2000 мм', 'Горизонтальне скло', 'Багато скла', 'https://korfad.com.ua/dverne-polotno-aliano-al-07-800-kh-2000-super-pet-aliaska-dvostoronnie-hrafit-dzerkalo/', 'https://korfad.com.ua/content/images/35/223x480l85nn0/42870900372185.webp')
;

create temporary table korfad_aliano_variants (
  slug text, color text, glass text, image_path text, source_url text, sort_order integer
) on commit drop;

insert into korfad_aliano_variants values
    ('korfad-aliano-al-01','Super PET аляска','Двостороннє бронзове дзеркало','https://korfad.com.ua/content/images/31/223x480l85nn0/43261496172109.webp','https://korfad.com.ua/dverne-polotno-aliano-al-01-800-kh-2000-super-pet-aliaska-dvostoronnie-bronzove-dzerkalo/',1),
    ('korfad-aliano-al-01','Super PET антрацит','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/47/223x480l85nn0/20117649415009.webp','https://korfad.com.ua/dverne-polotno-aliano-al-01-800-kh-2000-super-pet-antratsyt-dvostoronnie-hrafit-dzerkalo/',2),
    ('korfad-aliano-al-01','Super PET магнолія','Двостороннє бронзове дзеркало','https://korfad.com.ua/content/images/13/223x480l85nn0/94660374798612.webp','https://korfad.com.ua/dverne-polotno-aliano-al-01-800-kh-2000-super-pet-mahnoliia-dvostoronnie-bronzove-dzerkalo/',3),
    ('korfad-aliano-al-01','Super PET сірий','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/29/223x480l85nn0/53632267565076.webp','https://korfad.com.ua/dverne-polotno-aliano-al-01-800-kh-2000-super-pet-siryi-dvostoronnie-hrafit-dzerkalo/',4),
    ('korfad-aliano-al-01','Super PET чорний','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/39/223x480l85nn0/45768325792131.webp','https://korfad.com.ua/dverne-polotno-aliano-al-01-800-kh-2000-super-pet-chornyi-dvostoronnie-hrafit-dzerkalo/',5),
    ('korfad-aliano-al-02','Super PET аляска','Двостороннє бронзове дзеркало','https://korfad.com.ua/content/images/50/223x480l85nn0/38372234720754.webp','https://korfad.com.ua/dverne-polotno-aliano-al-02-800-kh-2000-super-pet-aliaska-dvostoronnie-bronzove-dzerkalo/',1),
    ('korfad-aliano-al-02','Super PET антрацит','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/18/223x480l85nn0/49816624608440.webp','https://korfad.com.ua/dverne-polotno-aliano-al-02-800-kh-2000-super-pet-antratsyt-dvostoronnie-hrafit-dzerkalo/',2),
    ('korfad-aliano-al-02','Super PET магнолія','Двостороннє бронзове дзеркало','https://korfad.com.ua/content/images/32/223x480l85nn0/85400666637180.webp','https://korfad.com.ua/dverne-polotno-aliano-al-02-800-kh-2000-super-pet-mahnoliia-dvostoronnie-bronzove-dzerkalo/',3),
    ('korfad-aliano-al-02','Super PET сірий','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/47/223x480l85nn0/14615553007912.webp','https://korfad.com.ua/dverne-polotno-aliano-al-02-800-kh-2000-super-pet-siryi-dvostoronnie-hrafit-dzerkalo/',4),
    ('korfad-aliano-al-02','Super PET чорний','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/9/223x480l85nn0/76676165191039.webp','https://korfad.com.ua/dverne-polotno-aliano-al-02-800-kh-2000-super-pet-chornyi-dvostoronnie-hrafit-dzerkalo/',5),
    ('korfad-aliano-al-03','Super PET аляска','Чорне скло','https://korfad.com.ua/content/images/12/223x480l85nn0/77370145757163.webp','https://korfad.com.ua/dverne-polotno-aliano-al-03-800-kh-2000-super-pet-aliaska-lacobel-chornyi/',1),
    ('korfad-aliano-al-03','Super PET антрацит','Чорне скло','https://korfad.com.ua/content/images/20/223x480l85nn0/49245414078001.webp','https://korfad.com.ua/dverne-polotno-aliano-al-03-800-kh-2000-super-pet-antratsyt-lacobel-chornyi/',2),
    ('korfad-aliano-al-03','Super PET магнолія','Чорне скло','https://korfad.com.ua/content/images/25/223x480l85nn0/87362998147452.webp','https://korfad.com.ua/dverne-polotno-aliano-al-03-800-kh-2000-super-pet-mahnoliia-lacobel-chornyi/',3),
    ('korfad-aliano-al-03','Super PET сірий','Чорне скло','https://korfad.com.ua/content/images/29/223x480l85nn0/79037964838251.webp','https://korfad.com.ua/dverne-polotno-aliano-al-03-800-kh-2000-super-pet-siryi-lacobel-chornyi/',4),
    ('korfad-aliano-al-03','Super PET чорний','Чорне скло','https://korfad.com.ua/content/images/34/223x480l85nn0/51583686627356.webp','https://korfad.com.ua/dverne-polotno-aliano-al-03-800-kh-2000-super-pet-chornyi-lacobel-chornyi/',5),
    ('korfad-aliano-al-04','Super PET аляска','Чорне скло','https://korfad.com.ua/content/images/37/223x480l85nn0/96266317109247.webp','https://korfad.com.ua/dverne-polotno-aliano-al-04-800-kh-2000-super-pet-aliaska-sklo-chorne/',1),
    ('korfad-aliano-al-04','Super PET антрацит','Чорне скло','https://korfad.com.ua/content/images/41/223x480l85nn0/65969904490309.webp','https://korfad.com.ua/dverne-polotno-aliano-al-04-800-kh-2000-super-pet-antratsyt-lacobel-chornyi/',2),
    ('korfad-aliano-al-04','Super PET магнолія','Сатин білий','https://korfad.com.ua/content/images/42/223x480l85nn0/72973727537776.webp','https://korfad.com.ua/dverne-polotno-aliano-al-04-700-kh-2000-super-pet-mahnoliia-satyn-bilyi/',3),
    ('korfad-aliano-al-04','Super PET сірий','Чорне скло','https://korfad.com.ua/content/images/43/223x480l85nn0/89862925701939.webp','https://korfad.com.ua/dverne-polotno-aliano-al-04-800-kh-2000-super-pet-siryi-lacobel-chornyi/',4),
    ('korfad-aliano-al-04','Super PET чорний','Чорне скло','https://korfad.com.ua/content/images/44/223x480l85nn0/52588954363639.webp','https://korfad.com.ua/dverne-polotno-aliano-al-04-700-kh-2000-super-pet-chornyi-lacobel-chornyi/',5),
    ('korfad-aliano-al-05','Super PET аляска','Сатин білий','https://korfad.com.ua/content/images/48/223x480l85nn0/41860923060053.webp','https://korfad.com.ua/dverne-polotno-aliano-al-05-800-kh-2000-super-pet-aliaska/',1),
    ('korfad-aliano-al-05','Super PET антрацит','Сатин білий','https://korfad.com.ua/content/images/2/223x480l85nn0/41991327365177.webp','https://korfad.com.ua/dverne-polotno-aliano-al-05-800-kh-2000-super-pet-antratsyt/',2),
    ('korfad-aliano-al-05','Super PET сірий','Сатин білий','https://korfad.com.ua/content/images/4/223x480l85nn0/97275805138613.webp','https://korfad.com.ua/dverne-polotno-aliano-al-05-800-kh-2000-super-pet-siryi-satyn-bilyi/',3),
    ('korfad-aliano-al-05','Super PET чорний','Сатин білий','https://korfad.com.ua/content/images/6/223x480l85nn0/34116743430899.webp','https://korfad.com.ua/dverne-polotno-aliano-al-05-800-kh-2000-super-pet-chornyi-satyn-bilyi/',4),
    ('korfad-aliano-al-06','Super PET аляска','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/7/223x480l85nn0/60320133133485.webp','https://korfad.com.ua/dverne-polotno-aliano-al-06-800-kh-2000-super-pet-aliaska-dvostoronnie-hrafit-dzerkalo/',1),
    ('korfad-aliano-al-06','Super PET антрацит','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/23/223x480l85nn0/39229326382620.webp','https://korfad.com.ua/dverne-polotno-aliano-al-06-800-kh-2000-super-pet-antratsyt-dvostoronnie-hrafit-dzerkalo/',2),
    ('korfad-aliano-al-06','Super PET магнолія','Двостороннє бронзове дзеркало','https://korfad.com.ua/content/images/38/223x480l85nn0/75312673676576.webp','https://korfad.com.ua/dverne-polotno-aliano-al-06-800-kh-2000-super-pet-mahnoliia-dvostoronnie-bronzove-dzerkalo/',3),
    ('korfad-aliano-al-06','Super PET сірий','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/6/223x480l85nn0/94639311608010.webp','https://korfad.com.ua/dverne-polotno-aliano-al-06-800-kh-2000-super-pet-siryi-dvostoronnie-hrafit-dzerkalo/',4),
    ('korfad-aliano-al-06','Super PET чорний','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/23/223x480l85nn0/17134151769691.webp','https://korfad.com.ua/dverne-polotno-aliano-al-06-800-kh-2000-super-pet-chornyi-dvostoronnie-hrafit-dzerkalo/',5),
    ('korfad-aliano-al-07','Super PET аляска','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/35/223x480l85nn0/42870900372185.webp','https://korfad.com.ua/dverne-polotno-aliano-al-07-800-kh-2000-super-pet-aliaska-dvostoronnie-hrafit-dzerkalo/',1),
    ('korfad-aliano-al-07','Super PET антрацит','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/46/223x480l85nn0/86684563217664.webp','https://korfad.com.ua/dverne-polotno-aliano-al-07-800-kh-2000-super-pet-antratsyt-dvostoronnie-hrafit-dzerkalo/',2),
    ('korfad-aliano-al-07','Super PET сірий','Двостороннє графіт дзеркало','https://korfad.com.ua/content/images/3/223x480l85nn0/48324265237040.webp','https://korfad.com.ua/dverne-polotno-aliano-al-07-800-kh-2000-super-pet-siryi-dvostoronnie-hrafit-dzerkalo/',3),
  ('korfad-aliano-al-07','Super PET чорний','Двостороннє графіт триплекс дзеркало','https://korfad.com.ua/content/images/8/223x480l85nn0/62414841889451.webp','https://korfad.com.ua/dverne-polotno-aliano-al-07-800-kh-2000-super-pet-chornyi-dvostoronnie-hrafit-trypleks-dzerkalo/',4)
;
insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select slug, 'interior', 'KORFAD', 'ALIANO', name, 'Super PET', 'Сучасний', 'Заводські декори', 'Ціна за запитом',
  name || ' — міжкімнатні двері колекції ALIANO. Збірне полотно з покриттям Super PET; доступні заводські декори, скло та розміри. Точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика KORFAD', 'Колекція ALIANO'), main_image, 99999, false
from korfad_aliano_models
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select slug, label, value, sort_order, true
from korfad_aliano_models
cross join lateral (values
  ('Розміри полотна', sizes, 10),
  ('Покриття', 'Super PET', 20),
  ('Конструкція полотна', 'Збірні дверні полотна', 30),
  ('Торець полотна', 'Огорнутий без стиків', 40),
  ('Розташування скла', glass_position, 50),
  ('Властивості скла', glass_amount, 60),
  ('Гарантія виробника', '60 місяців', 90)
) as specification(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
select slug, 'color', 'Декор', color, null, null, min(sort_order)
from korfad_aliano_variants group by slug, color
on conflict (product_slug, option_group, label) do update set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
select slug, 'glass', 'Скло', glass, null, null, min(sort_order)
from korfad_aliano_variants group by slug, glass
on conflict (product_slug, option_group, label) do update set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select slug, jsonb_build_object('color', color, 'glass', glass), image_path, sort_order, true
from korfad_aliano_variants
on conflict (product_slug, selections) do update set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select slug, 'KORFAD — офіційний каталог', source_url, name, 'verified', now(), 'Імпортовано з офіційної картки KORFAD: модель, характеристики, декори, скло та точне фото варіанту.'
from korfad_aliano_models model
where not exists (select 1 from public.product_sources source where source.product_slug = model.slug and source.source_url = model.source_url);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'main', 'Головне фото', main_image, 0
from korfad_aliano_models model
where not exists (select 1 from public.product_media media where media.product_slug = model.slug and media.kind = 'main');

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'gallery', 'Декор: ' || color || ' · ' || glass, image_path, sort_order
from korfad_aliano_variants variant
where not exists (select 1 from public.product_media media where media.product_slug = variant.slug and media.kind = 'gallery' and media.image_path = variant.image_path);

commit;

-- Перевірка після запуску: має повернути 7 моделей, 0 опублікованих і 33 фото-варіанти.
select
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_variants where product_slug like 'korfad-aliano-%' and is_active) as фото_варіантів
from public.products
where brand = 'KORFAD' and collection = 'ALIANO';
