-- KORFAD · EXELLENCE · WESTON. П'ять підтверджених декорів OUTSIDE.
-- Джерело: https://korfad.com.ua/dverni-polotna-farbovani/filter/kolekcja=24;model=71/
begin;
create temporary table korfad_ex_weston (color text, image_path text, source_url text, sort_order integer) on commit drop;
insert into korfad_ex_weston values
('Біла емаль','https://korfad.com.ua/content/images/6/278x600l80mc0/dverne-polotno-weston-800-kh-2000-bila-emal-19206320335494.webp','https://korfad.com.ua/dverne-polotno-weston-800-kh-2000-bila-emal/',1),
('RAL 1013 Шампань','https://korfad.com.ua/content/images/37/278x600l80mc0/37457242582682.webp','https://korfad.com.ua/dverne-polotno-weston-800-kh-2000-ral-1013-shampan/',2),
('RAL 7036 Сірий','https://korfad.com.ua/content/images/18/278x600l80mc0/44657384729365.webp','https://korfad.com.ua/dverne-polotno-weston-800-kh-2000-ral-7036-siryi/',3),
('RAL 7047 Світло Сірий','https://korfad.com.ua/content/images/26/278x600l80mc0/80880137011389.webp','https://korfad.com.ua/dverne-polotno-weston-800-kh-2000-ral-7047-svitlo-siryi/',4),
('Тауп','https://korfad.com.ua/content/images/28/278x600l80mc0/49309865920006.webp','https://korfad.com.ua/dverne-polotno-weston-800-kh-2000-taup/',5);
insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available)
select 'korfad-ex-weston','interior','KORFAD','EXELLENCE','KORFAD WESTON','Фарбоване покриття','Сучасний','Заводські кольори RAL','Ціна за запитом','KORFAD WESTON — фарбовані міжкімнатні двері колекції EXELLENCE. Доступні підтверджені заводські кольори; точну комплектацію й ціну уточнюйте у менеджера.',jsonb_build_array('Фабрика KORFAD','Колекція EXELLENCE'),min(image_path),99999,false from korfad_ex_weston
on conflict (slug) do update set name=excluded.name,material=excluded.material,style=excluded.style,color=excluded.color,description=excluded.description,image_path=excluded.image_path;
insert into public.product_specs (product_slug,label,value,sort_order,is_active) values
('korfad-ex-weston','Конструкція полотна','Каркасно-щитові двері фарбовані',20,true),('korfad-ex-weston','Розміри полотна','800 × 2000 мм',30,true),('korfad-ex-weston','Доступні декори','Біла емаль, RAL 1013 Шампань, RAL 7036 Сірий, RAL 7047 Світло Сірий, Тауп',40,true),('korfad-ex-weston','Гарантія виробника','60 місяців',90,true)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;
insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order)
select 'korfad-ex-weston','color','Колір',color,null,image_path,sort_order from korfad_ex_weston
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;
insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active)
select 'korfad-ex-weston',jsonb_build_object('color',color),image_path,sort_order,true from korfad_ex_weston
on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;
insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes)
select 'korfad-ex-weston','KORFAD — офіційний каталог',source_url,'WESTON','verified',now(),'Імпортовано з офіційних карток KORFAD: п''ять точних фото заводських декорів.' from korfad_ex_weston
where not exists (select 1 from public.product_sources where product_slug='korfad-ex-weston' and source_url=korfad_ex_weston.source_url);
insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select 'korfad-ex-weston','main','Головне фото',min(image_path),0 from korfad_ex_weston where not exists (select 1 from public.product_media where product_slug='korfad-ex-weston' and kind='main');
insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select 'korfad-ex-weston','gallery','Колір: '||color,image_path,sort_order from korfad_ex_weston source where not exists (select 1 from public.product_media media where media.product_slug='korfad-ex-weston' and media.kind='gallery' and media.image_path=source.image_path);
commit;
select count(*) as моделей,count(*) filter (where is_available) as опубліковано,(select count(*) from public.product_variants where product_slug='korfad-ex-weston' and is_active) as фото_варіантів from public.products where slug='korfad-ex-weston';
