-- KORFAD · CLASSICO.
-- Додає 5 прихованих чернеток і 42 точні фото декорів з офіційного каталогу.
-- Варіанти скла/малюнку залишені у підписах фото, без неіснуючих комбінацій у конфігураторі.
-- Джерело: https://korfad.com.ua/mizhkimnatni-dveri-korfad/filter/kolekcja=5;page=all/

begin;

create temporary table korfad_classico_models (slug text, name text, main_image text) on commit drop;
insert into korfad_classico_models values
  ('korfad-cl-02','KORFAD CL-02','https://korfad.com.ua/content/images/48/223x480l85nn0/60061678156857.webp'),
  ('korfad-cl-05','KORFAD CL-05','https://korfad.com.ua/content/images/32/223x480l85nn0/41275543924149.webp'),
  ('korfad-cl-07','KORFAD CL-07','https://korfad.com.ua/content/images/29/223x480l85nn0/78819016782518.webp'),
  ('korfad-cl-08','KORFAD CL-08','https://korfad.com.ua/content/images/13/223x480l85nn0/24030418659441.webp'),
  ('korfad-cl-09','KORFAD CL-09','https://korfad.com.ua/content/images/3/234x480l85nn0/82843076483591.webp');

create temporary table korfad_classico_variants (slug text, color text, detail text, image_path text, source_url text, sort_order integer) on commit drop;
insert into korfad_classico_variants values
  ('korfad-cl-02','Білений дуб','Сатин бронза · М 1','https://korfad.com.ua/content/images/48/223x480l85nn0/60061678156857.webp','https://korfad.com.ua/dverne-polotno-classico-cl-02-800-kh-2000-bilenyi-dubsklo-bronza-m-1/',1),
  ('korfad-cl-02','Білий перламутр','М 3','https://korfad.com.ua/content/images/27/223x480l85nn0/89063136383732.webp','https://korfad.com.ua/dverne-polotno-classico-cl-02-800-kh-2000-bilyi-perlamutr-m3/',2),
  ('korfad-cl-02','Горіх','Сатин бронза · М 2','https://korfad.com.ua/content/images/43/223x480l85nn0/53052349083181.webp','https://korfad.com.ua/dverne-polotno-classico-cl-02-800-kh-2000-horikh-sklo-bronza-m-2/',3),
  ('korfad-cl-02','Дуб браш','Сатин бронза · М 2','https://korfad.com.ua/content/images/22/223x480l85nn0/98609268021701.webp','https://korfad.com.ua/dverne-polotno-classico-cl-02-800-kh-2000-dub-brash-sklo-bronza-m-2/',4),
  ('korfad-cl-02','Дуб грей','Сатин бронза · М 1','https://korfad.com.ua/content/images/50/223x480l85nn0/47753229891020.webp','https://korfad.com.ua/dverne-polotno-classico-cl-02-800-kh-2000-dub-hrei-sklo-bronza-m-1/',5),
  ('korfad-cl-02','Дуб марсала','Сатин бронза · М 2','https://korfad.com.ua/content/images/25/223x480l85nn0/58709654632402.webp','https://korfad.com.ua/dverne-polotno-classico-cl-02-800-kh-2000-dub-marsala-sklo-bronza-m-2/',6),
  ('korfad-cl-02','Дуб нордик','М 2','https://korfad.com.ua/content/images/49/223x480l85nn0/81225111846848.webp','https://korfad.com.ua/dverne-polotno-classico-cl-02-800-kh-2000-dub-nordyk-m-2/',7),
  ('korfad-cl-02','Дуб тобакко','Сатин бронза · М 1','https://korfad.com.ua/content/images/2/223x480l85nn0/15426451610881.webp','https://korfad.com.ua/dverne-polotno-classico-cl-02-800-kh-2000-dub-tobakko-satyn-bronza-m-1/',8),
  ('korfad-cl-02','Еш-вайт','Глухе','https://korfad.com.ua/content/images/7/223x480l85nn0/38805798374037.webp','https://korfad.com.ua/dverne-polotno-classico-cl-02-800-kh-2000-esh-vait/',9),
  ('korfad-cl-05','Білений дуб','М 2','https://korfad.com.ua/content/images/32/223x480l85nn0/41275543924149.webp','https://korfad.com.ua/dverne-polotno-classico-cl-05-800-kh-2000-bilenyi-dub-m-2/',1),
  ('korfad-cl-05','Білий перламутр','М 2','https://korfad.com.ua/content/images/9/223x480l85nn0/34474850403375.webp','https://korfad.com.ua/dverne-polotno-classico-cl-05-800-kh-2000-bilyi-perlamutr-m-2/',2),
  ('korfad-cl-05','Горіх','Сатин бронза · М 1','https://korfad.com.ua/content/images/25/223x480l85nn0/75657015841895.webp','https://korfad.com.ua/dverne-polotno-classico-cl-05-800-kh-2000-horikh-sklo-bronza-m-1/',3),
  ('korfad-cl-05','Дуб браш','Сатин бронза · М 1','https://korfad.com.ua/content/images/4/223x480l85nn0/24827243315795.webp','https://korfad.com.ua/dverne-polotno-classico-cl-05-800-kh-2000-dub-brash-sklo-bronza-m-1/',4),
  ('korfad-cl-05','Дуб грей','Сатин бронза · М 2','https://korfad.com.ua/content/images/34/223x480l85nn0/34689181168328.webp','https://korfad.com.ua/dverne-polotno-classico-cl-05-800-kh-2000-dub-hrei-sklo-bronza-m-2/',5),
  ('korfad-cl-05','Дуб марсала','Сатин бронза · М 2','https://korfad.com.ua/content/images/7/223x480l85nn0/33883596882085.webp','https://korfad.com.ua/dverne-polotno-classico-cl-05-800-kh-2000-dub-marsala-sklo-bronza-m-2/',6),
  ('korfad-cl-05','Дуб нордик','М 1','https://korfad.com.ua/content/images/31/223x480l85nn0/99188122083411.webp','https://korfad.com.ua/dverne-polotno-classico-cl-05-800-kh-2000-dub-nordyk-m1/',7),
  ('korfad-cl-05','Дуб тобакко','Сатин бронза · М 2','https://korfad.com.ua/content/images/43/223x480l85nn0/47779904026036.webp','https://korfad.com.ua/dverne-polotno-classico-cl-05-800-kh-2000-dub-tobakkosklo-bronza-m-2/',8),
  ('korfad-cl-05','Еш-вайт','М 2','https://korfad.com.ua/content/images/4/223x480l85nn0/39894639383891.webp','https://korfad.com.ua/dverne-polotno-classico-cl-05-800-kh-2000-esh-vait-m-2/',9),
  ('korfad-cl-07','Білений дуб','М 1','https://korfad.com.ua/content/images/29/223x480l85nn0/78819016782518.webp','https://korfad.com.ua/dverne-polotno-classico-cl-07-800-kh-2000-bilenyi-dub-m-1/',1),
  ('korfad-cl-07','Білий перламутр','М 2','https://korfad.com.ua/content/images/4/223x480l85nn0/11461795239582.webp','https://korfad.com.ua/dverne-polotno-classico-cl-07-800-kh-2000-bilyi-perlamutr-m-2/',2),
  ('korfad-cl-07','Горіх','Сатин бронза · М 2','https://korfad.com.ua/content/images/20/223x480l85nn0/78403037469303.webp','https://korfad.com.ua/dverne-polotno-classico-cl-07-800-kh-2000-horikh-sklo-bronza-m-2/',3),
  ('korfad-cl-07','Дуб браш','Сатин бронза · М 2','https://korfad.com.ua/content/images/47/223x480l85nn0/54453207849359.webp','https://korfad.com.ua/dverne-polotno-classico-cl-07-800-kh-2000-dub-brash-sklo-bronza-m-2/',4),
  ('korfad-cl-07','Дуб грей','М 2','https://korfad.com.ua/content/images/23/223x480l85nn0/99359935658303.webp','https://korfad.com.ua/dverne-polotno-classico-cl-07-800-kh-2000-dub-hrei-m-2/',5),
  ('korfad-cl-07','Дуб марсала','Сатин бронза · М 1','https://korfad.com.ua/content/images/47/223x480l85nn0/72663415494913.webp','https://korfad.com.ua/dverne-polotno-classico-cl-07-800-kh-2000-dub-marsala-sklo-bronza-m-1/',6),
  ('korfad-cl-07','Дуб нордик','М 2','https://korfad.com.ua/content/images/21/223x480l85nn0/47369776683999.webp','https://korfad.com.ua/dverne-polotno-classico-cl-07-800-kh-2000-dub-nordyk-m-2/',7),
  ('korfad-cl-07','Дуб тобакко','Сатин бронза · М 2','https://korfad.com.ua/content/images/28/223x480l85nn0/95256112343314.webp','https://korfad.com.ua/dverne-polotno-classico-cl-07-800-kh-2000-dub-tobakkosklo-bronza-m-2/',8),
  ('korfad-cl-07','Еш-вайт','Сатин бронза','https://korfad.com.ua/content/images/39/223x480l85nn0/77097774093275.webp','https://korfad.com.ua/dverne-polotno-classico-cl-07-800-kh-2000-esh-vait-sklo-bronza/',9),
  ('korfad-cl-08','Білений дуб','Глухе','https://korfad.com.ua/content/images/13/223x480l85nn0/24030418659441.webp','https://korfad.com.ua/dverne-polotno-classico-sl-08-800-kh-2000-bilenyi-dub/',1),
  ('korfad-cl-08','Білий перламутр','Глухе','https://korfad.com.ua/content/images/17/223x480l85nn0/88717319240202.webp','https://korfad.com.ua/dverne-polotno-classico-sl-08-800-kh-2000-bilyi-perlamutr/',2),
  ('korfad-cl-08','Горіх','Глухе','https://korfad.com.ua/content/images/22/223x480l85nn0/74991054597179.webp','https://korfad.com.ua/dverne-polotno-classico-sl-08-800-kh-2000-horikh/',3),
  ('korfad-cl-08','Дуб браш','Глухе','https://korfad.com.ua/content/images/27/223x480l85nn0/38617768095050.webp','https://korfad.com.ua/dverne-polotno-classico-sl-08-800-kh-2000-dub-brash/',4),
  ('korfad-cl-08','Дуб грей','Глухе','https://korfad.com.ua/content/images/32/223x480l85nn0/68675144604331.webp','https://korfad.com.ua/dverne-polotno-classico-sl-08-800-kh-2000-dub-hrei/',5),
  ('korfad-cl-08','Дуб марсала','Глухе','https://korfad.com.ua/content/images/36/223x480l85nn0/66514447417162.webp','https://korfad.com.ua/dverne-polotno-classico-sl-08-800-kh-2000-dub-marsala/',6),
  ('korfad-cl-08','Дуб нордик','Глухе','https://korfad.com.ua/content/images/40/223x480l85nn0/71779640003474.webp','https://korfad.com.ua/dverne-polotno-classico-sl-08-800-kh-2000-dub-nordyk/',7),
  ('korfad-cl-08','Дуб тобакко','Глухе','https://korfad.com.ua/content/images/44/223x480l85nn0/71591504501952.webp','https://korfad.com.ua/dverne-polotno-classico-sl-08-800-kh-2000-dub-tobakko/',8),
  ('korfad-cl-08','Еш-вайт','Глухе','https://korfad.com.ua/content/images/48/223x480l85nn0/79488043397203.webp','https://korfad.com.ua/dverne-polotno-classico-sl-08-800-kh-2000-esh-vait/',9),
  ('korfad-cl-09','Білений дуб','М 4 · білий','https://korfad.com.ua/content/images/3/234x480l85nn0/82843076483591.webp','https://korfad.com.ua/dverne-polotno-classico-sl-09-700-kh-2000-bilenyi-dub-m-4-bilyi/',1),
  ('korfad-cl-09','Білий перламутр','М 4 · білий','https://korfad.com.ua/content/images/6/234x480l85nn0/70644642121481.webp','https://korfad.com.ua/dverne-polotno-classico-sl-09-800-kh-2000-bilyi-perlamutr-m-4-bilyi/',2),
  ('korfad-cl-09','Горіх','Сатин білий · М 1','https://korfad.com.ua/content/images/17/234x480l85nn0/51820326770914.webp','https://korfad.com.ua/dverne-polotno-classico-sl-09-800-kh-2000-horikh-satyn-bilyi-m-1/',3),
  ('korfad-cl-09','Дуб марсала','М 1 · білий','https://korfad.com.ua/content/images/20/234x480l85nn0/19477685926739.webp','https://korfad.com.ua/dverne-polotno-classico-sl-09-800-kh-2000-dub-marsala-m-1-bilyi/',4),
  ('korfad-cl-09','Дуб нордик','М 1 · білий','https://korfad.com.ua/content/images/21/234x480l85nn0/32461154813795.webp','https://korfad.com.ua/dverne-polotno-classico-sl-09-800-kh-2000-dub-nordyk-m-1-bilyi/',5),
  ('korfad-cl-09','Еш-вайт','М 1 · білий','https://korfad.com.ua/content/images/23/234x480l85nn0/52775545272960.webp','https://korfad.com.ua/dverne-polotno-classico-sl-09-800-kh-2000-esh-vait-m-1-bilyi/',6);

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select slug, 'interior', 'KORFAD', 'CLASSICO', name, 'Декоративне покриття', 'Класичний', 'Заводські декори', 'Ціна за запитом',
  name || ' — збірні міжкімнатні двері колекції CLASSICO. Доступні підтверджені заводські декори, скло та малюнки для окремих виконань; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика KORFAD', 'Колекція CLASSICO'), main_image, 99999, false
from korfad_classico_models
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select slug, label, value, sort_order, true
from korfad_classico_models
cross join lateral (values
  ('Конструкція полотна', 'Збірні дверні полотна', 20),
  ('Доступні виконання', 'Заводські декори, скло та малюнки відповідно до моделі', 40),
  ('Гарантія виробника', '60 місяців', 90)
) as specification(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
select slug, 'color', 'Декор', color, null, null, min(sort_order)
from korfad_classico_variants group by slug, color
on conflict (product_slug, option_group, label) do update set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select slug, jsonb_build_object('color', color), image_path, sort_order, true
from korfad_classico_variants
on conflict (product_slug, selections) do update set image_path = excluded.image_path, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select slug, 'KORFAD — офіційний каталог', 'https://korfad.com.ua/mizhkimnatni-dveri-korfad/filter/kolekcja=5;page=all/', name, 'verified', now(), 'Імпортовано з офіційних карток KORFAD: модель і точні фото заводських виконань.'
from korfad_classico_models model
where not exists (select 1 from public.product_sources source where source.product_slug = model.slug and source.source_url = 'https://korfad.com.ua/mizhkimnatni-dveri-korfad/filter/kolekcja=5;page=all/');

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'main', 'Головне фото', main_image, 0 from korfad_classico_models model
where not exists (select 1 from public.product_media media where media.product_slug = model.slug and media.kind = 'main');

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select slug, 'gallery', 'Декор: ' || color || ' · ' || detail, image_path, sort_order from korfad_classico_variants variant
where not exists (select 1 from public.product_media media where media.product_slug = variant.slug and media.kind = 'gallery' and media.image_path = variant.image_path);

commit;

select count(*) as моделей, count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_variants where product_slug like 'korfad-cl-%' and is_active) as фото_варіантів
from public.products where brand = 'KORFAD' and collection = 'CLASSICO';
