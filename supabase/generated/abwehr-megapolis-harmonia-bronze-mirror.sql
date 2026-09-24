-- ABWEHR MEGAPOLIS: Harmonia with bronze mirror is a separate construction.
begin;
with model as (
  select 'abwehr-megapolis-harmonia-bronze-mirror'::text slug, 'Abwehr Harmonia з бронзовим дзеркалом'::text name,
  'https://abwehr.com.ua/catalog/vhidni-dveri-z-bronzovim-dzerkalom-model-harmonia-komplektaciya-megapolis-mg3/p1548'::text url,
  array['https://abwehr.com.ua/storage/products/images/big/pb8zmHOxzg6iZ6skzOLomS7njgCXw375owhwa6i1.jpg.webp?v=1771583271','https://abwehr.com.ua/storage/products/images/big/FRlKs9iHWGS4ORP7DuM2MSYWsBX4okUCJgln7Cnb.jpg.webp?v=1771579612','https://abwehr.com.ua/storage/products/images/big/dCi5GySmZM4cgTSE5hh6BQaUudfjfEExJdlVco0n.jpg.webp?v=1771581975','https://abwehr.com.ua/storage/products/images/big/PA8rXaIrQTN2iraEHxDk9tKy8qkjdpgD81RAmyCM.jpg.webp?v=1771580531','https://abwehr.com.ua/storage/products/images/big/sBPuNvrVBTtyGiuWH7j3W2bbMIDj70RI9nwkGGVv.jpg.webp?v=1771583543']::text[] photos
)
insert into public.products(slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available)
select slug,'entrance','Abwehr','Megapolis',name,'Сталь, МДФ-накладки та заводські покриття','Сучасний','Заводські декори','Ціна за запитом',name || ' — вхідні двері для квартири серії Megapolis з бронзовим дзеркалом. Три контури ущільнення та посилена конструкція допомагають забезпечити комфорт і захист; точну комплектацію, декори й ціну уточнюйте у менеджера.',jsonb_build_array('Фабрика Abwehr','Колекція Megapolis','Бронзове дзеркало','3 контури ущільнення'),photos[1],99999,false from model
on conflict(slug) do update set name=excluded.name,description=excluded.description,features=excluded.features,image_path=excluded.image_path;
insert into public.product_specs(product_slug,label,value,sort_order,is_active) values
 ('abwehr-megapolis-harmonia-bronze-mirror','Тип конструкції','Вхідні двері з бронзовим дзеркалом для квартири',10,true),('abwehr-megapolis-harmonia-bronze-mirror','Колекція','Megapolis',20,true),('abwehr-megapolis-harmonia-bronze-mirror','Дзеркало','Бронзове',30,true),('abwehr-megapolis-harmonia-bronze-mirror','Контури ущільнення','3 контури',40,true)
on conflict(product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;
insert into public.product_sources(product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
 ('abwehr-megapolis-harmonia-bronze-mirror','ABWEHR','https://abwehr.com.ua/catalog/vhidni-dveri-z-bronzovim-dzerkalom-model-harmonia-komplektaciya-megapolis-mg3/p1548','Abwehr Harmonia · Megapolis MG3 · бронзове дзеркало','verified',now(),'Офіційна картка виробника: окрема модель з бронзовим дзеркалом.')
on conflict do nothing;
insert into public.product_media(product_slug,kind,label,image_path,sort_order) values
 ('abwehr-megapolis-harmonia-bronze-mirror','main','Головне фото','https://abwehr.com.ua/storage/products/images/big/pb8zmHOxzg6iZ6skzOLomS7njgCXw375owhwa6i1.jpg.webp?v=1771583271',0),
 ('abwehr-megapolis-harmonia-bronze-mirror','gallery','Офіційне фото 1','https://abwehr.com.ua/storage/products/images/big/pb8zmHOxzg6iZ6skzOLomS7njgCXw375owhwa6i1.jpg.webp?v=1771583271',1),('abwehr-megapolis-harmonia-bronze-mirror','gallery','Офіційне фото 2','https://abwehr.com.ua/storage/products/images/big/FRlKs9iHWGS4ORP7DuM2MSYWsBX4okUCJgln7Cnb.jpg.webp?v=1771579612',2),('abwehr-megapolis-harmonia-bronze-mirror','gallery','Офіційне фото 3','https://abwehr.com.ua/storage/products/images/big/dCi5GySmZM4cgTSE5hh6BQaUudfjfEExJdlVco0n.jpg.webp?v=1771581975',3),('abwehr-megapolis-harmonia-bronze-mirror','gallery','Офіційне фото 4','https://abwehr.com.ua/storage/products/images/big/PA8rXaIrQTN2iraEHxDk9tKy8qkjdpgD81RAmyCM.jpg.webp?v=1771580531',4),('abwehr-megapolis-harmonia-bronze-mirror','gallery','Офіційне фото 5','https://abwehr.com.ua/storage/products/images/big/sBPuNvrVBTtyGiuWH7j3W2bbMIDj70RI9nwkGGVv.jpg.webp?v=1771583543',5)
on conflict do nothing;
commit;
select count(*) as моделей,count(*) filter(where is_available) as опубліковано,(select count(*) from public.product_media where product_slug='abwehr-megapolis-harmonia-bronze-mirror' and kind='gallery') as фото_в_галереях from public.products where slug='abwehr-megapolis-harmonia-bronze-mirror';
