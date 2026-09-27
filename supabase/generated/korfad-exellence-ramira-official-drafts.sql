-- KORFAD · EXELLENCE · RAMIRA.
-- Одна прихована модель з 5 точними офіційними фото; виробник вказує лише OUTSIDE.
-- Джерело: https://korfad.com.ua/dverni-polotna-farbovani/filter/kolekcja=24;model=68/

begin;

create temporary table korfad_ex_ramira (color text, image_path text, source_url text, sort_order integer) on commit drop;
insert into korfad_ex_ramira values
  ('Біла емаль','https://korfad.com.ua/content/images/44/278x600l80mc0/dverne-polotno-ramira-800-kh-2000-bila-emal-58991105726735.webp','https://korfad.com.ua/dverne-polotno-ramira-800-kh-2000-bila-emal/',1),
  ('RAL 1013 Шампань','https://korfad.com.ua/content/images/37/278x600l80mc0/29007344840329.webp','https://korfad.com.ua/dverne-polotno-ramira-800-kh-2000-ral-1013-shampan/',2),
  ('RAL 7036 Сірий','https://korfad.com.ua/content/images/18/278x600l80mc0/75006965542944.webp','https://korfad.com.ua/dverne-polotno-ramira-800-kh-2000-ral-7036-siryi/',3),
  ('RAL 7047 Світло Сірий','https://korfad.com.ua/content/images/26/278x600l80mc0/80007587459446.webp','https://korfad.com.ua/dverne-polotno-ramira-800-kh-2000-ral-7047-svitlo-siryi/',4),
  ('Тауп','https://korfad.com.ua/content/images/28/278x600l80mc0/56995881238416.webp','https://korfad.com.ua/dverne-polotno-ramira-800-kh-2000-taup/',5);

insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available)
select 'korfad-ex-ramira','interior','KORFAD','EXELLENCE','KORFAD RAMIRA','Фарбоване покриття','Сучасний','Заводські кольори RAL','Ціна за запитом',
  'KORFAD RAMIRA — фарбовані міжкімнатні двері колекції EXELLENCE. Доступні підтверджені заводські кольори; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика KORFAD','Колекція EXELLENCE'),min(image_path),99999,false from korfad_ex_ramira
on conflict (slug) do update set name=excluded.name,material=excluded.material,style=excluded.style,color=excluded.color,description=excluded.description,image_path=excluded.image_path;

insert into public.product_specs (product_slug,label,value,sort_order,is_active) values
  ('korfad-ex-ramira','Конструкція полотна','Каркасно-щитові двері фарбовані',20,true),
  ('korfad-ex-ramira','Розміри полотна','800 × 2000 мм',30,true),
  ('korfad-ex-ramira','Доступні декори','Біла емаль, RAL 1013 Шампань, RAL 7036 Сірий, RAL 7047 Світло Сірий, Тауп',40,true),
  ('korfad-ex-ramira','Гарантія виробника','60 місяців',90,true)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;

insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order)
select 'korfad-ex-ramira','color','Колір',color,null,image_path,sort_order from korfad_ex_ramira
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;

insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active)
select 'korfad-ex-ramira',jsonb_build_object('color',color),image_path,sort_order,true from korfad_ex_ramira
on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes)
select 'korfad-ex-ramira','KORFAD — офіційний каталог',source_url,'RAMIRA','verified',now(),'Імпортовано з офіційних карток KORFAD: п''ять точних фото заводських декорів.' from korfad_ex_ramira
where not exists (select 1 from public.product_sources where product_slug='korfad-ex-ramira' and source_url=korfad_ex_ramira.source_url);

insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select 'korfad-ex-ramira','main','Головне фото',min(image_path),0 from korfad_ex_ramira
where not exists (select 1 from public.product_media where product_slug='korfad-ex-ramira' and kind='main');
insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select 'korfad-ex-ramira','gallery','Колір: '||color,image_path,sort_order from korfad_ex_ramira source
where not exists (select 1 from public.product_media media where media.product_slug='korfad-ex-ramira' and media.kind='gallery' and media.image_path=source.image_path);

commit;
select count(*) as моделей,count(*) filter (where is_available) as опубліковано,(select count(*) from public.product_variants where product_slug='korfad-ex-ramira' and is_active) as фото_варіантів from public.products where slug='korfad-ex-ramira';
