-- StilDoors LOFT: 6 офіційних моделей як приховані чернетки.
begin;
insert into public.catalog_collections (brand_id,name,category,description,is_active,sort_order) select id,'LOFT','interior','Міжкімнатні двері StilDoors колекції LOFT.',true,74 from public.catalog_brands where name='StilDoors' on conflict (brand_id,name,category) do update set description=excluded.description,is_active=true,updated_at=now();
insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values
('stildoors-loft-loft-official', 'interior', 'StilDoors', 'LOFT', 'StilDoors Loft', 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Loft — міжкімнатні двері колекції LOFT. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти оформлення; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція LOFT","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/loft/loft/biliy-mat/gluhe/dveri-loft-loft-biliy-mat-gluhe.jpg', '10000', 'false'),
('stildoors-loft-loft-aluminium-official', 'interior', 'StilDoors', 'LOFT', 'StilDoors Loft Aluminium', 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Loft Aluminium — міжкімнатні двері колекції LOFT. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти оформлення; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція LOFT","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/loft/loft-aluminium/biliy-mat/molding-chorniy-kromka-chorna/dveri-loft-loft-aluminium-biliy-mat-molding-chorniy-kromka-chorna.jpg', '10001', 'false'),
('stildoors-loft-loft-glass-official', 'interior', 'StilDoors', 'LOFT', 'StilDoors Loft Glass', 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Loft Glass — міжкімнатні двері колекції LOFT. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти оформлення; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція LOFT","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/loft/loft-glass/biliy-mat/sklo-chorne/dveri-loft-loft-glass-biliy-mat-sklo-chorne.jpg', '10002', 'false'),
('stildoors-loft-loft-intro-official', 'interior', 'StilDoors', 'LOFT', 'StilDoors Loft Intro', 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Loft Intro — міжкімнатні двері колекції LOFT. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти оформлення; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція LOFT","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/loft/loft-intro/biliy-mat/molding-chorniy/dveri-loft-loft-intro-biliy-mat-molding-chorniy.jpg', '10003', 'false'),
('stildoors-loft-loft-line-official', 'interior', 'StilDoors', 'LOFT', 'StilDoors Loft Line', 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Loft Line — міжкімнатні двері колекції LOFT. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти оформлення; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція LOFT","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/loft/loft-line/biliy-mat/kromka-chorniy-mat/dveri-loft-loft-line-biliy-mat-kromka-chorniy-mat.jpg', '10004', 'false'),
('stildoors-loft-loft-rain-official', 'interior', 'StilDoors', 'LOFT', 'StilDoors Loft Rain', 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Loft Rain — міжкімнатні двері колекції LOFT. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти оформлення; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція LOFT","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/loft/loft-rain/biliy-mat/molding-chorniy/dveri-loft-loft-rain-biliy-mat-molding-chorniy.jpg', '10005', 'false')
on conflict (slug) do update set name=excluded.name,material=excluded.material,style=excluded.style,color=excluded.color,description=excluded.description,features=excluded.features,image_path=excluded.image_path,sort_order=excluded.sort_order,is_available=false,updated_at=now();
insert into public.product_specs (product_slug,label,value,sort_order,is_active) values
('stildoors-loft-loft-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-loft-loft-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-loft-loft-official', 'Декори', 'білий мат, світлий бетон, дуб альпійський, дуб крафт, дуб платіна, дуб смокі', '120', 'true'),
('stildoors-loft-loft-aluminium-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-loft-loft-aluminium-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-loft-loft-aluminium-official', 'Декори', 'білий мат, світлий бетон', '120', 'true'),
('stildoors-loft-loft-glass-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-loft-loft-glass-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-loft-loft-glass-official', 'Декори', 'білий мат, дуб альпійський, дуб крафт, дуб платіна, дуб смокі, світлий бетон', '120', 'true'),
('stildoors-loft-loft-intro-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-loft-loft-intro-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-loft-loft-intro-official', 'Декори', 'білий мат', '120', 'true'),
('stildoors-loft-loft-line-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-loft-loft-line-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-loft-loft-line-official', 'Декори', 'білий мат, дуб альпійський, дуб крафт, дуб платіна, дуб смокі, світлий бетон', '120', 'true'),
('stildoors-loft-loft-rain-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-loft-loft-rain-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-loft-loft-rain-official', 'Декори', 'білий мат', '120', 'true')
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;
insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values
('stildoors-loft-loft-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/loft/loft/biliy-mat/gluhe/dveri-loft-loft-biliy-mat-gluhe.jpg', '0', 'true'),
('stildoors-loft-loft-aluminium-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/loft/loft-aluminium/biliy-mat/molding-chorniy-kromka-chorna/dveri-loft-loft-aluminium-biliy-mat-molding-chorniy-kromka-chorna.jpg', '0', 'true'),
('stildoors-loft-loft-glass-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/loft/loft-glass/biliy-mat/sklo-chorne/dveri-loft-loft-glass-biliy-mat-sklo-chorne.jpg', '0', 'true'),
('stildoors-loft-loft-intro-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/loft/loft-intro/biliy-mat/molding-chorniy/dveri-loft-loft-intro-biliy-mat-molding-chorniy.jpg', '0', 'true'),
('stildoors-loft-loft-line-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/loft/loft-line/biliy-mat/kromka-chorniy-mat/dveri-loft-loft-line-biliy-mat-kromka-chorniy-mat.jpg', '0', 'true'),
('stildoors-loft-loft-rain-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/loft/loft-rain/biliy-mat/molding-chorniy/dveri-loft-loft-rain-biliy-mat-molding-chorniy.jpg', '0', 'true')
on conflict (product_slug,kind,image_path) do update set label=excluded.label,sort_order=excluded.sort_order,is_active=true;
insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order,is_active) values
('stildoors-loft-loft-official', 'color', 'Колір полотна', 'білий мат', null, null, '1', 'true'),
('stildoors-loft-loft-official', 'color', 'Колір полотна', 'світлий бетон', null, null, '2', 'true'),
('stildoors-loft-loft-official', 'color', 'Колір полотна', 'дуб альпійський', null, null, '3', 'true'),
('stildoors-loft-loft-official', 'color', 'Колір полотна', 'дуб крафт', null, null, '4', 'true'),
('stildoors-loft-loft-official', 'color', 'Колір полотна', 'дуб платіна', null, null, '5', 'true'),
('stildoors-loft-loft-official', 'color', 'Колір полотна', 'дуб смокі', null, null, '6', 'true'),
('stildoors-loft-loft-aluminium-official', 'color', 'Колір полотна', 'білий мат', null, null, '1', 'true'),
('stildoors-loft-loft-aluminium-official', 'color', 'Колір полотна', 'світлий бетон', null, null, '2', 'true'),
('stildoors-loft-loft-glass-official', 'color', 'Колір полотна', 'білий мат', null, null, '1', 'true'),
('stildoors-loft-loft-glass-official', 'color', 'Колір полотна', 'дуб альпійський', null, null, '2', 'true'),
('stildoors-loft-loft-glass-official', 'color', 'Колір полотна', 'дуб крафт', null, null, '3', 'true'),
('stildoors-loft-loft-glass-official', 'color', 'Колір полотна', 'дуб платіна', null, null, '4', 'true'),
('stildoors-loft-loft-glass-official', 'color', 'Колір полотна', 'дуб смокі', null, null, '5', 'true'),
('stildoors-loft-loft-glass-official', 'color', 'Колір полотна', 'світлий бетон', null, null, '6', 'true'),
('stildoors-loft-loft-intro-official', 'color', 'Колір полотна', 'білий мат', null, null, '1', 'true'),
('stildoors-loft-loft-line-official', 'color', 'Колір полотна', 'білий мат', null, null, '1', 'true'),
('stildoors-loft-loft-line-official', 'color', 'Колір полотна', 'дуб альпійський', null, null, '2', 'true'),
('stildoors-loft-loft-line-official', 'color', 'Колір полотна', 'дуб крафт', null, null, '3', 'true'),
('stildoors-loft-loft-line-official', 'color', 'Колір полотна', 'дуб платіна', null, null, '4', 'true'),
('stildoors-loft-loft-line-official', 'color', 'Колір полотна', 'дуб смокі', null, null, '5', 'true'),
('stildoors-loft-loft-line-official', 'color', 'Колір полотна', 'світлий бетон', null, null, '6', 'true'),
('stildoors-loft-loft-rain-official', 'color', 'Колір полотна', 'білий мат', null, null, '1', 'true')
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;
insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
('stildoors-loft-loft-official', 'StilDoors', 'https://stildoors.com.ua/dveri/loft/loft/biliy-mat/gluhe/', 'StilDoors Loft', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.'),
('stildoors-loft-loft-aluminium-official', 'StilDoors', 'https://stildoors.com.ua/dveri/loft/loft-aluminium/biliy-mat/molding-chorniy-kromka-chorna/', 'StilDoors Loft Aluminium', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.'),
('stildoors-loft-loft-glass-official', 'StilDoors', 'https://stildoors.com.ua/dveri/loft/loft-glass/biliy-mat/sklo-chorne/', 'StilDoors Loft Glass', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.'),
('stildoors-loft-loft-intro-official', 'StilDoors', 'https://stildoors.com.ua/dveri/loft/loft-intro/biliy-mat/molding-chorniy/', 'StilDoors Loft Intro', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.'),
('stildoors-loft-loft-line-official', 'StilDoors', 'https://stildoors.com.ua/dveri/loft/loft-line/biliy-mat/kromka-chorniy-mat/', 'StilDoors Loft Line', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.'),
('stildoors-loft-loft-rain-official', 'StilDoors', 'https://stildoors.com.ua/dveri/loft/loft-rain/biliy-mat/molding-chorniy/', 'StilDoors Loft Rain', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.')
on conflict (product_slug,source_url) do update set source_product_name=excluded.source_product_name,verification_status='verified',verified_at=now(),notes=excluded.notes;
commit;
select count(*) as офіційних_чернеток from public.products where brand='StilDoors' and collection='LOFT' and slug like 'stildoors-loft-%-official' and not is_available;
