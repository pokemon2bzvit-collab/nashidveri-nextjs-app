-- KORFAD · EXELLENCE · PAULINA.
-- Одна прихована модель з 10 точними фото: 5 декорів × OUTSIDE / INSIDE.
-- Джерело: https://korfad.com.ua/dverni-polotna-farbovani/filter/kolekcja=24;model=67/

begin;

create temporary table korfad_ex_paulina (color text, configuration text, image_path text, source_url text, sort_order integer) on commit drop;
insert into korfad_ex_paulina values
  ('Біла емаль','OUTSIDE','https://korfad.com.ua/content/images/40/278x600l80mc0/dverne-polotno-paulina-800-kh-2000-bila-emal-54991032011593.webp','https://korfad.com.ua/dverne-polotno-paulina-800-kh-2000-bila-emal/',1),
  ('Біла емаль','INSIDE','https://korfad.com.ua/content/images/12/278x600l80mc0/dverne-polotno-paulina-800-kh-2010-bila-emal-inside-27319079989651.webp','https://korfad.com.ua/dverne-polotno-paulina-800-kh-2010-bila-emal-inside/',2),
  ('RAL 1013 Шампань','OUTSIDE','https://korfad.com.ua/content/images/7/278x600l80mc0/88589428697406.webp','https://korfad.com.ua/dverne-polotno-paulina-800-kh-2000-ral-1013-shampan/',3),
  ('RAL 1013 Шампань','INSIDE','https://korfad.com.ua/content/images/12/278x600l80mc0/78015181341877.webp','https://korfad.com.ua/dverne-polotno-paulina-800-kh-2012-ral-1013-shampan-inside/',4),
  ('RAL 7036 Сірий','OUTSIDE','https://korfad.com.ua/content/images/38/278x600l80mc0/64287724928065.webp','https://korfad.com.ua/dverne-polotno-paulina-800-kh-2000-ral-7036-siryi/',5),
  ('RAL 7036 Сірий','INSIDE','https://korfad.com.ua/content/images/43/278x600l80mc0/85571065616024.webp','https://korfad.com.ua/dverne-polotno-paulina-800-kh-2012-ral-7036-siryi-inside/',6),
  ('RAL 7047 Світло Сірий','OUTSIDE','https://korfad.com.ua/content/images/46/278x600l80mc0/26300122168078.webp','https://korfad.com.ua/dverne-polotno-paulina-800-kh-2000-ral-7047-svitlo-siryi/',7),
  ('RAL 7047 Світло Сірий','INSIDE','https://korfad.com.ua/content/images/1/278x600l80mc0/54428051108974.webp','https://korfad.com.ua/dverne-polotno-paulina-800-kh-2012-ral-7047-svitlo-siryi-inside/',8),
  ('Тауп','OUTSIDE','https://korfad.com.ua/content/images/48/278x600l80mc0/25584896514616.webp','https://korfad.com.ua/dverne-polotno-paulina-800-kh-2000-taup/',9),
  ('Тауп','INSIDE','https://korfad.com.ua/content/images/3/278x600l80mc0/16841640325348.webp','https://korfad.com.ua/dverne-polotno-paulina-800-kh-2012-taup-inside/',10);

insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available)
select 'korfad-ex-paulina','interior','KORFAD','EXELLENCE','KORFAD PAULINA','Фарбоване покриття','Сучасний','Заводські кольори RAL','Ціна за запитом',
  'KORFAD PAULINA — фарбовані міжкімнатні двері колекції EXELLENCE. Доступні підтверджені кольори RAL і виконання OUTSIDE або INSIDE; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика KORFAD','Колекція EXELLENCE'),min(image_path),99999,false from korfad_ex_paulina
on conflict (slug) do update set name=excluded.name,material=excluded.material,style=excluded.style,color=excluded.color,description=excluded.description,image_path=excluded.image_path;

insert into public.product_specs (product_slug,label,value,sort_order,is_active) values
  ('korfad-ex-paulina','Конструкція полотна','Каркасно-щитові двері фарбовані',20,true),
  ('korfad-ex-paulina','Розміри полотна','800 × 2000 мм (OUTSIDE) або 800 × 2012 мм (INSIDE)',30,true),
  ('korfad-ex-paulina','Доступні декори','Біла емаль, RAL 1013 Шампань, RAL 7036 Сірий, RAL 7047 Світло Сірий, Тауп',40,true),
  ('korfad-ex-paulina','Гарантія виробника','60 місяців',90,true)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;

insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order)
select 'korfad-ex-paulina','color','Колір',color,null,null,min(sort_order) from korfad_ex_paulina group by color
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;

insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order) values
  ('korfad-ex-paulina','configuration','Відкривання','OUTSIDE',null,null,10),('korfad-ex-paulina','configuration','Відкривання','INSIDE',null,null,20)
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;

insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active)
select 'korfad-ex-paulina',jsonb_build_object('color',color,'configuration',configuration),image_path,sort_order,true from korfad_ex_paulina
on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes)
select 'korfad-ex-paulina','KORFAD — офіційний каталог',source_url,'PAULINA','verified',now(),'Імпортовано з офіційних карток KORFAD: точні фото кольорів і виконань OUTSIDE / INSIDE.' from korfad_ex_paulina
where not exists (select 1 from public.product_sources where product_slug='korfad-ex-paulina' and source_url=korfad_ex_paulina.source_url);

insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select 'korfad-ex-paulina','main','Головне фото',min(image_path),0 from korfad_ex_paulina
where not exists (select 1 from public.product_media where product_slug='korfad-ex-paulina' and kind='main');
insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select 'korfad-ex-paulina','gallery','Колір: '||color||' · '||configuration,image_path,sort_order from korfad_ex_paulina source
where not exists (select 1 from public.product_media media where media.product_slug='korfad-ex-paulina' and media.kind='gallery' and media.image_path=source.image_path);

commit;
select count(*) as моделей,count(*) filter (where is_available) as опубліковано,(select count(*) from public.product_variants where product_slug='korfad-ex-paulina' and is_active) as фото_варіантів from public.products where slug='korfad-ex-paulina';
