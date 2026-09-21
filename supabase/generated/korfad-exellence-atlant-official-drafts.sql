-- KORFAD · EXELLENCE · ATLANT.
-- Одна прихована модель з 10 точними фото: 5 декорів × OUTSIDE / INSIDE.
-- Джерело: https://korfad.com.ua/dverni-polotna-farbovani/filter/kolekcja=24/

begin;

create temporary table korfad_ex_atlant (color text, configuration text, image_path text, source_url text, sort_order integer) on commit drop;
insert into korfad_ex_atlant values
  ('Біла емаль','OUTSIDE','https://korfad.com.ua/content/images/19/223x480l85nn0/dverne-polotno-atlant-800-kh-2000-bila-emal-98181862230257.webp','https://korfad.com.ua/dverne-polotno-atlant-800-kh-2000-bila-emal/',1),
  ('Біла емаль','INSIDE','https://korfad.com.ua/content/images/37/223x480l85nn0/dverne-polotno-atlant-800-kh-2010-bila-emal-inside-21449239583305.webp','https://korfad.com.ua/dverne-polotno-atlant-800-kh-2010-bila-emal-inside/',2),
  ('RAL 1013 Шампань','OUTSIDE','https://korfad.com.ua/content/images/42/223x480l85nn0/24805429518528.webp','https://korfad.com.ua/dverne-polotno-atlant-800-kh-2000-ral-1013-shampan/',3),
  ('RAL 1013 Шампань','INSIDE','https://korfad.com.ua/content/images/47/223x480l85nn0/98525689976064.webp','https://korfad.com.ua/dverne-polotno-atlant-800-kh-2012-ral-1013-shampan-inside/',4),
  ('RAL 7036 Сірий','OUTSIDE','https://korfad.com.ua/content/images/23/223x480l85nn0/13239827329138.webp','https://korfad.com.ua/dverne-polotno-atlant-800-kh-2000-ral-7036-siryi/',5),
  ('RAL 7036 Сірий','INSIDE','https://korfad.com.ua/content/images/28/223x480l85nn0/34078905757789.webp','https://korfad.com.ua/dverne-polotno-atlant-800-kh-2012-ral-7036-siryi-inside/',6),
  ('RAL 7047 Світло Сірий','OUTSIDE','https://korfad.com.ua/content/images/31/223x480l85nn0/68110618132823.webp','https://korfad.com.ua/dverne-polotno-atlant-800-kh-2000-ral-7047-svitlo-siryi/',7),
  ('RAL 7047 Світло Сірий','INSIDE','https://korfad.com.ua/content/images/36/223x480l85nn0/24774928626046.webp','https://korfad.com.ua/dverne-polotno-atlant-800-kh-2012-ral-7047-svitlo-siryi-inside/',8),
  ('Тауп','OUTSIDE','https://korfad.com.ua/content/images/33/223x480l85nn0/46855012517880.webp','https://korfad.com.ua/dverne-polotno-atlant-800-kh-2000-taup/',9),
  ('Тауп','INSIDE','https://korfad.com.ua/content/images/38/223x480l85nn0/75705621147365.webp','https://korfad.com.ua/dverne-polotno-atlant-800-kh-2012-taup-inside/',10);

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select 'korfad-ex-atlant','interior','KORFAD','EXELLENCE','KORFAD ATLANT','Фарбоване покриття','Сучасний','Заводські кольори RAL','Ціна за запитом',
  'KORFAD ATLANT — фарбовані міжкімнатні двері колекції EXELLENCE. Доступні підтверджені кольори RAL і виконання OUTSIDE або INSIDE; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика KORFAD','Колекція EXELLENCE'), min(image_path), 99999, false
from korfad_ex_atlant
on conflict (slug) do update set name=excluded.name, material=excluded.material, style=excluded.style, color=excluded.color, description=excluded.description, image_path=excluded.image_path;

insert into public.product_specs (product_slug,label,value,sort_order,is_active) values
  ('korfad-ex-atlant','Конструкція полотна','Каркасно-щитові двері фарбовані',20,true),
  ('korfad-ex-atlant','Розміри полотна','800 × 2000 мм (OUTSIDE) або 800 × 2012 мм (INSIDE)',30,true),
  ('korfad-ex-atlant','Доступні декори','Біла емаль, RAL 1013 Шампань, RAL 7036 Сірий, RAL 7047 Світло Сірий, Тауп',40,true),
  ('korfad-ex-atlant','Гарантія виробника','60 місяців',90,true)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;

insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order)
select 'korfad-ex-atlant','color','Колір',color,null,null,min(sort_order) from korfad_ex_atlant group by color
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;

insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order) values
  ('korfad-ex-atlant','configuration','Відкривання','OUTSIDE',null,null,10),
  ('korfad-ex-atlant','configuration','Відкривання','INSIDE',null,null,20)
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;

insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active)
select 'korfad-ex-atlant',jsonb_build_object('color',color,'configuration',configuration),image_path,sort_order,true from korfad_ex_atlant
on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes)
select 'korfad-ex-atlant','KORFAD — офіційний каталог',source_url,'ATLANT','verified',now(),'Імпортовано з офіційних карток KORFAD: точні фото кольорів і виконань OUTSIDE / INSIDE.' from korfad_ex_atlant
where not exists (select 1 from public.product_sources where product_slug='korfad-ex-atlant' and source_url=korfad_ex_atlant.source_url);

insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select 'korfad-ex-atlant','main','Головне фото',min(image_path),0 from korfad_ex_atlant
where not exists (select 1 from public.product_media where product_slug='korfad-ex-atlant' and kind='main');

insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select 'korfad-ex-atlant','gallery','Колір: '||color||' · '||configuration,image_path,sort_order from korfad_ex_atlant source
where not exists (select 1 from public.product_media media where media.product_slug='korfad-ex-atlant' and media.kind='gallery' and media.image_path=source.image_path);

commit;

select count(*) as моделей,count(*) filter (where is_available) as опубліковано,(select count(*) from public.product_variants where product_slug='korfad-ex-atlant' and is_active) as фото_варіантів from public.products where slug='korfad-ex-atlant';
