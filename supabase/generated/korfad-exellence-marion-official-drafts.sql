-- KORFAD · EXELLENCE · MARION.
-- Одна прихована модель з 12 точними фото: 6 декорів × OUTSIDE / INSIDE.
-- Джерело: https://korfad.com.ua/dverni-polotna-farbovani/filter/kolekcja=24;model=66/

begin;

create temporary table korfad_ex_marion (color text, configuration text, image_path text, source_url text, sort_order integer) on commit drop;
insert into korfad_ex_marion values
  ('Біла емаль','OUTSIDE','https://korfad.com.ua/content/images/35/278x600l80mc0/dverne-polotno-marion-800-kh-2000-bila-emal-62989715133976.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2000-bila-emal/',1),
  ('Біла емаль','INSIDE','https://korfad.com.ua/content/images/37/278x600l80mc0/dverne-polotno-marion-800-kh-2010-bila-emal-inside-43684088565992.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2010-bila-emal-inside/',2),
  ('RAL 1013 Шампань','OUTSIDE','https://korfad.com.ua/content/images/47/278x600l80mc0/19800368636287.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2000-ral-1013-shampan/',3),
  ('RAL 1013 Шампань','INSIDE','https://korfad.com.ua/content/images/2/278x600l80mc0/73159111471377.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2012-ral-1013-shampan-inside/',4),
  ('RAL 7036 Сірий','OUTSIDE','https://korfad.com.ua/content/images/28/278x600l80mc0/16823818627237.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2000-ral-7036-siryi/',5),
  ('RAL 7036 Сірий','INSIDE','https://korfad.com.ua/content/images/33/278x600l80mc0/36821996045949.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2012-ral-7036-siryi-inside/',6),
  ('RAL 7047 Світло Сірий','OUTSIDE','https://korfad.com.ua/content/images/36/278x600l80mc0/76083351084121.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2000-ral-7047-svitlo-siryi/',7),
  ('RAL 7047 Світло Сірий','INSIDE','https://korfad.com.ua/content/images/41/278x600l80mc0/77267667542649.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2012-ral-7047-svitlo-siryi-inside/',8),
  ('Тауп','OUTSIDE','https://korfad.com.ua/content/images/38/278x600l80mc0/83854425530806.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2000-taup/',9),
  ('Тауп','INSIDE','https://korfad.com.ua/content/images/43/278x600l80mc0/37650541303522.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2012-taup-inside/',10),
  ('RAL 7016 Антрацит','OUTSIDE','https://korfad.com.ua/content/images/20/278x600l80mc0/90391001096984.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2000-ral-7016-antratsyt/',11),
  ('RAL 7016 Антрацит','INSIDE','https://korfad.com.ua/content/images/25/278x600l80mc0/45239316663866.webp','https://korfad.com.ua/dverne-polotno-marion-800-kh-2012-ral-7016-antratsyt-inside/',12);

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select 'korfad-ex-marion','interior','KORFAD','EXELLENCE','KORFAD MARION','Фарбоване покриття','Сучасний','Заводські кольори RAL','Ціна за запитом',
  'KORFAD MARION — фарбовані міжкімнатні двері колекції EXELLENCE. Доступні підтверджені кольори RAL і виконання OUTSIDE або INSIDE; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика KORFAD','Колекція EXELLENCE'), min(image_path), 99999, false
from korfad_ex_marion
on conflict (slug) do update set name=excluded.name, material=excluded.material, style=excluded.style, color=excluded.color, description=excluded.description, image_path=excluded.image_path;

insert into public.product_specs (product_slug,label,value,sort_order,is_active) values
  ('korfad-ex-marion','Конструкція полотна','Каркасно-щитові двері фарбовані',20,true),
  ('korfad-ex-marion','Розміри полотна','800 × 2000 мм (OUTSIDE) або 800 × 2012 мм (INSIDE)',30,true),
  ('korfad-ex-marion','Доступні декори','Біла емаль, RAL 1013 Шампань, RAL 7036 Сірий, RAL 7047 Світло Сірий, Тауп, RAL 7016 Антрацит',40,true),
  ('korfad-ex-marion','Гарантія виробника','60 місяців',90,true)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;

insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order)
select 'korfad-ex-marion','color','Колір',color,null,null,min(sort_order) from korfad_ex_marion group by color
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;

insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order) values
  ('korfad-ex-marion','configuration','Відкривання','OUTSIDE',null,null,10),
  ('korfad-ex-marion','configuration','Відкривання','INSIDE',null,null,20)
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;

insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active)
select 'korfad-ex-marion',jsonb_build_object('color',color,'configuration',configuration),image_path,sort_order,true from korfad_ex_marion
on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes)
select 'korfad-ex-marion','KORFAD — офіційний каталог',source_url,'MARION','verified',now(),'Імпортовано з офіційних карток KORFAD: точні фото кольорів і виконань OUTSIDE / INSIDE.' from korfad_ex_marion
where not exists (select 1 from public.product_sources where product_slug='korfad-ex-marion' and source_url=korfad_ex_marion.source_url);

insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select 'korfad-ex-marion','main','Головне фото',min(image_path),0 from korfad_ex_marion
where not exists (select 1 from public.product_media where product_slug='korfad-ex-marion' and kind='main');

insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select 'korfad-ex-marion','gallery','Колір: '||color||' · '||configuration,image_path,sort_order from korfad_ex_marion source
where not exists (select 1 from public.product_media media where media.product_slug='korfad-ex-marion' and media.kind='gallery' and media.image_path=source.image_path);

commit;

select count(*) as моделей,count(*) filter (where is_available) as опубліковано,(select count(*) from public.product_variants where product_slug='korfad-ex-marion' and is_active) as фото_варіантів from public.products where slug='korfad-ex-marion';
