-- StilDoors Classic: офіційна модель як прихована чернетка.
begin;
insert into public.catalog_collections (brand_id,name,category,description,is_active,sort_order) select id,'Classic','interior','Міжкімнатні двері StilDoors колекції Classic.',true,76 from public.catalog_brands where name='StilDoors' on conflict (brand_id,name,category) do update set description=excluded.description,is_active=true,updated_at=now();
insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values
('stildoors-classic-carolina-official', 'interior', 'StilDoors', 'Classic', 'StilDoors Carolina', 'Міжкімнатні', 'Класичні двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Carolina — міжкімнатні двері колекції Classic. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція Classic","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/classic/carolina/biliy-mat/sklo-satin/dveri-classic-carolina-biliy-mat-sklo-satin.jpg', '10900', 'false') on conflict (slug) do update set name=excluded.name,description=excluded.description,image_path=excluded.image_path,is_available=false,updated_at=now();
insert into public.product_specs (product_slug,label,value,sort_order,is_active) values
('stildoors-classic-carolina-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-classic-carolina-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-classic-carolina-official', 'Декори', 'білий мат', '120', 'true')
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;
insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values
('stildoors-classic-carolina-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/classic/carolina/biliy-mat/sklo-satin/dveri-classic-carolina-biliy-mat-sklo-satin.jpg', '0', 'true') on conflict (product_slug,kind,image_path) do update set label=excluded.label,sort_order=excluded.sort_order,is_active=true;
insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
('stildoors-classic-carolina-official', 'StilDoors', 'https://stildoors.com.ua/dveri/classic/carolina/biliy-mat/sklo-satin/', 'StilDoors Carolina', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото та характеристики.') on conflict (product_slug,source_url) do update set verification_status='verified',verified_at=now(),notes=excluded.notes;
commit;
select count(*) as офіційних_чернеток from public.products where slug='stildoors-classic-carolina-official' and not is_available;
