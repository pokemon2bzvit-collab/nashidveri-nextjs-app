-- StilDoors Riko: 2 офіційні моделі як приховані чернетки.
begin;
insert into public.catalog_collections (brand_id,name,category,description,is_active,sort_order) select id,'Riko','interior','Міжкімнатні двері StilDoors колекції Riko.',true,78 from public.catalog_brands where name='StilDoors' on conflict (brand_id,name,category) do update set description=excluded.description,is_active=true,updated_at=now();
insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values
('stildoors-riko-dela-official', 'interior', 'StilDoors', 'Riko', 'StilDoors Dela', 'Міжкімнатні', 'Сучасні двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Dela — міжкімнатні двері колекції Riko. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 38 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція Riko","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/riko/dela/klen-molochniy/sklo-satin/dveri-riko-dela-klen-molochniy-sklo-satin.jpg', '11100', 'false'),
('stildoors-riko-vena-official', 'interior', 'StilDoors', 'Riko', 'StilDoors Vena', 'Міжкімнатні', 'Сучасні двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Vena — міжкімнатні двері колекції Riko. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 38 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція Riko","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/riko/vena/klen-molochniy/sklo-satin/dveri-riko-vena-klen-molochniy-sklo-satin.jpg', '11101', 'false')
on conflict (slug) do update set name=excluded.name,description=excluded.description,image_path=excluded.image_path,is_available=false,updated_at=now();
insert into public.product_specs (product_slug,label,value,sort_order,is_active) values
('stildoors-riko-dela-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-riko-dela-official', 'Товщина полотна', '38 мм', '110', 'true'),
('stildoors-riko-dela-official', 'Декори', 'клен молочний, клен французький', '120', 'true'),
('stildoors-riko-vena-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-riko-vena-official', 'Товщина полотна', '38 мм', '110', 'true'),
('stildoors-riko-vena-official', 'Декори', 'клен молочний, клен французький', '120', 'true')
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;
insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values
('stildoors-riko-dela-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/riko/dela/klen-molochniy/sklo-satin/dveri-riko-dela-klen-molochniy-sklo-satin.jpg', '0', 'true'),
('stildoors-riko-vena-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/riko/vena/klen-molochniy/sklo-satin/dveri-riko-vena-klen-molochniy-sklo-satin.jpg', '0', 'true')
on conflict (product_slug,kind,image_path) do update set label=excluded.label,sort_order=excluded.sort_order,is_active=true;
insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
('stildoors-riko-dela-official', 'StilDoors', 'https://stildoors.com.ua/dveri/riko/dela/klen-molochniy/sklo-satin/', 'StilDoors Dela', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото та характеристики.'),
('stildoors-riko-vena-official', 'StilDoors', 'https://stildoors.com.ua/dveri/riko/vena/klen-molochniy/sklo-satin/', 'StilDoors Vena', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото та характеристики.')
on conflict (product_slug,source_url) do update set verification_status='verified',verified_at=now(),notes=excluded.notes;
commit;
select count(*) as офіційних_чернеток from public.products where brand='StilDoors' and collection='Riko' and slug like 'stildoors-riko-%-official' and not is_available;
