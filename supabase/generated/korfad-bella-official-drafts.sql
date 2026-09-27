-- KORFAD · BELLA.
-- Додає 2 приховані чернетки й 29 точних фото комбінацій декору та скла.
-- Старі KFD-моделі та попередні колекції KORFAD не змінюються.
-- Джерело: https://korfad.com.ua/mizhkimnatni-dveri-korfad/filter/kolekcja=4;page=all/

begin;

create temporary table korfad_bella_models (
  slug text, name text, source_url text, main_image text
) on commit drop;

insert into korfad_bella_models values
  ('korfad-bl-01', 'KORFAD BL-01', 'https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-art-beton-satyn-bronza/', 'https://korfad.com.ua/content/images/12/192x480l85nn0/90609861615495.webp'),
  ('korfad-bl-02', 'KORFAD BL-02', 'https://korfad.com.ua/dverne-polotno-bella-bl-02-800-kh-2000-art-beton-satyn/', 'https://korfad.com.ua/content/images/9/192x480l85nn0/95743794074822.webp');

create temporary table korfad_bella_variants (
  slug text, color text, glass text, image_path text, source_url text, sort_order integer
) on commit drop;

insert into korfad_bella_variants values
  ('korfad-bl-01','Арт бетон','Сатин бронза','https://korfad.com.ua/content/images/12/192x480l85nn0/90609861615495.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-art-beton-satyn-bronza/',1),
  ('korfad-bl-01','Білений дуб','Сатин білий','https://korfad.com.ua/content/images/15/192x480l85nn0/87517250402175.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-bilenyi-dub-satyn/',2),
  ('korfad-bl-01','Білий перламутр','Сатин білий','https://korfad.com.ua/content/images/18/192x480l85nn0/37722649299892.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-bilyi-perlamutr-satyn/',3),
  ('korfad-bl-01','Білий ясен','Сатин білий','https://korfad.com.ua/content/images/23/192x480l85nn0/55114099872004.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-bilyi-yasen-satyn/',4),
  ('korfad-bl-01','Венге','Сатин білий','https://korfad.com.ua/content/images/27/192x480l85nn0/85602780444514.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-venhe-satyn/',5),
  ('korfad-bl-01','Горіх','Сатин бронза','https://korfad.com.ua/content/images/30/192x480l85nn0/93012392235324.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-horikh-bronza/',6),
  ('korfad-bl-01','Дуб браш','Сатин білий','https://korfad.com.ua/content/images/35/192x480l85nn0/20787428265019.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-900-kh-2000-dub-brash-satyn/',7),
  ('korfad-bl-01','Дуб грей','Сатин білий','https://korfad.com.ua/content/images/36/192x480l85nn0/78436999080395.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-dub-hrei-satyn/',8),
  ('korfad-bl-01','Дуб марсала','Сатин бронза','https://korfad.com.ua/content/images/39/192x480l85nn0/96192155415731.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-dub-marsala-satyn-bronza/',9),
  ('korfad-bl-01','Дуб нордик','Сатин бронза','https://korfad.com.ua/content/images/44/192x480l85nn0/85458501507107.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-900-kh-2000-dub-nordyk-bronza/',10),
  ('korfad-bl-01','Дуб тобакко','Сатин білий','https://korfad.com.ua/content/images/49/192x480l85nn0/64725343721152.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-dub-tobakko-satyn/',11),
  ('korfad-bl-01','Еш-вайт','Сатин бронза','https://korfad.com.ua/content/images/2/192x480l85nn0/59904592750984.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-600-kh-2000-esh-vait-sklo-bronza/',12),
  ('korfad-bl-01','Лофт бетон','Сатин білий','https://korfad.com.ua/content/images/4/192x480l85nn0/93426545443354.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-loft-beton-satyn/',13),
  ('korfad-bl-01','Сталь кортен','Сатин білий','https://korfad.com.ua/content/images/8/192x480l85nn0/77132444412657.webp','https://korfad.com.ua/dverne-polotno-bella-bl-01-800-kh-2000-stal-korten-satyn/',14),
  ('korfad-bl-02','Арт бетон','Сатин білий','https://korfad.com.ua/content/images/9/192x480l85nn0/95743794074822.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-800-kh-2000-art-beton-satyn/',1),
  ('korfad-bl-02','Білений дуб','Сатин білий','https://korfad.com.ua/content/images/11/192x480l85nn0/64709128213870.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-800-kh-2000-bilenyi-dub-satyn/',2),
  ('korfad-bl-02','Білий перламутр','Сатин білий','https://korfad.com.ua/content/images/13/192x480l85nn0/25050383334381.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-800-kh-2000-bilyi-perlamutr-satyn/',3),
  ('korfad-bl-02','Білий ясен','Сатин білий','https://korfad.com.ua/content/images/18/192x480l85nn0/86336152914113.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-800-kh-2000-bilyi-yasen-satyn/',4),
  ('korfad-bl-02','Венге','Сатин білий','https://korfad.com.ua/content/images/21/192x480l85nn0/57945570349221.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-900-kh-2000-venhe-satyn/',5),
  ('korfad-bl-02','Горіх','Сатин бронза','https://korfad.com.ua/content/images/24/192x480l85nn0/66767086773064.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-900-kh-2000-horikh-sklo-bronza/',6),
  ('korfad-bl-02','Дуб браш','Сатин бронза','https://korfad.com.ua/content/images/29/192x480l85nn0/78267172191944.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-900-kh-2000-dub-brash-bronza/',7),
  ('korfad-bl-02','Дуб грей','Сатин бронза','https://korfad.com.ua/content/images/31/192x480l85nn0/26075022486168.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-900-kh-2000-dub-hrei-bronza/',8),
  ('korfad-bl-02','Дуб марсала','Сатин білий','https://korfad.com.ua/content/images/33/192x480l85nn0/36384197071299.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-900-kh-2000-dub-marsala-satyn/',9),
  ('korfad-bl-02','Дуб нордик','Сатин білий','https://korfad.com.ua/content/images/35/192x480l85nn0/78512042903763.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-800-kh-2000-dub-nordyk-satyn/',10),
  ('korfad-bl-02','Дуб тобакко','Сатин білий','https://korfad.com.ua/content/images/37/192x480l85nn0/83650134503200.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-800-kh-2000-dub-tobakko-satyn/',11),
  ('korfad-bl-02','Еш-вайт','Сатин білий','https://korfad.com.ua/content/images/39/192x480l85nn0/31523219632548.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-700-kh-2000-esh-vait/',12),
  ('korfad-bl-02','Лайт бетон','Сатин білий','https://korfad.com.ua/content/images/40/192x480l85nn0/69967957045104.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-800-kh-2000-lait-beton-satyn/',13),
  ('korfad-bl-02','Лофт бетон','Сатин білий','https://korfad.com.ua/content/images/42/192x480l85nn0/36695928565111.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-800-kh-2000-loft-beton-satyn/',14),
  ('korfad-bl-02','Сталь кортен','Сатин білий','https://korfad.com.ua/content/images/43/192x480l85nn0/50121858864595.webp','https://korfad.com.ua/dverne-polotno-bella-bl-02-800-kh-2000-stal-korten-satyn/',15);

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select slug, 'interior', 'KORFAD', 'BELLA', name, 'Декоративне покриття', 'Сучасна класика', 'Заводські декори', 'Ціна за запитом',
  name || ' — збірні міжкімнатні двері колекції BELLA з горизонтальним склінням. Для моделі доступні підтверджені заводські декори та варіанти скла; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика KORFAD', 'Колекція BELLA'), main_image, 99999, false
from korfad_bella_models
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select slug, label, value, sort_order, true
from korfad_bella_models
cross join lateral (values
  ('Розміри полотна', '600, 700, 800 або 900 × 2000 мм', 10),
  ('Конструкція полотна', 'Збірні дверні полотна', 20),
  ('Розташування скла', 'Горизонтальне скло', 30),
  ('Властивості скла', 'Максимум скла', 40),
  ('Торець полотна', 'Огорнутий без стиків', 50),
  ('Гарантія виробника', '60 місяців', 90)
) as specification(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
select slug, 'color', 'Декор', color, null, null, min(sort_order)
from korfad_bella_variants group by slug, color
on conflict (product_slug, option_group, label) do update set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
select slug, 'glass', 'Скло', glass, null, null, min(sort_order)
from korfad_bella_variants group by slug, glass
on conflict (product_slug, option_group, label) do update set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select slug, jsonb_build_object('color', color, 'glass', glass), image_path, sort_order, true
from korfad_bella_variants
on conflict (product_slug, selections) do update set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select slug, 'KORFAD — офіційний каталог', source_url, name, 'verified', now(), 'Імпортовано з офіційної картки KORFAD: модель, характеристики та точні фото поєднань декору й скла.'
from korfad_bella_models model
where not exists (select 1 from public.product_sources source where source.product_slug = model.slug and source.source_url = model.source_url);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'main', 'Головне фото', main_image, 0
from korfad_bella_models model
where not exists (select 1 from public.product_media media where media.product_slug = model.slug and media.kind = 'main');

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'gallery', 'Декор: ' || color || ' · Скло: ' || glass, image_path, sort_order
from korfad_bella_variants variant
where not exists (select 1 from public.product_media media where media.product_slug = variant.slug and media.kind = 'gallery' and media.image_path = variant.image_path);

commit;

select count(*) as моделей, count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_variants where product_slug like 'korfad-bl-%' and is_active) as фото_варіантів
from public.products where brand = 'KORFAD' and collection = 'BELLA';
