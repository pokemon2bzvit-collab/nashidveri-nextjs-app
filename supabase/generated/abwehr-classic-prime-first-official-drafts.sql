-- ABWEHR CLASSIC PRIME: first six distinct current models as hidden drafts.
-- Product cards are sourced from the official manufacturer pages.

begin;

create temporary table abwehr_classic_models (
  slug text primary key, name text not null, product_code text not null,
  source_url text not null, main_image text not null
) on commit drop;

insert into abwehr_classic_models values
 ('abwehr-classic-briona-official','Abwehr Briona','593','https://abwehr.com.ua/catalog/vhidni-dveri-model-briona-komplektaciya-classic-prime/p1682','https://abwehr.com.ua/storage/products/images/big/BhCqdnEYueyaysMKOuXeq3NNW0pfI0h6TSOyADIb.jpg.webp?v=1773306364'),
 ('abwehr-classic-monica-official','Abwehr Monica','571','https://abwehr.com.ua/catalog/vhidni-dveri-model-monica-komplektaciya-classic-prime/p1621','https://abwehr.com.ua/storage/products/images/big/yeCz9nqCrg2G5yoxSsoKswVX64IQW2ZwrmgpCG9f.jpg.webp?v=1771584209'),
 ('abwehr-classic-geneva-official','Abwehr Geneva','585','https://abwehr.com.ua/catalog/vhidni-dveri-model-geneva-komplektaciya-classic-prime/p1620','https://abwehr.com.ua/storage/products/images/big/hafUcgiv9B4FoP0zVlbIOmAVNgwyJxgihz1eWst6.jpg.webp?v=1771582411'),
 ('abwehr-classic-novella-official','Abwehr Novella','581','https://abwehr.com.ua/catalog/vhidni-dveri-model-novella-komplektaciya-classic-prime/p1572','https://abwehr.com.ua/storage/products/images/big/aHkpUyHZWz06Wo5zBMEosqbP9G9NGFYLwRbYoHWI.jpg.webp?v=1771581669'),
 ('abwehr-classic-sabrina-official','Abwehr Sabrina','578','https://abwehr.com.ua/catalog/vhidni-dveri-model-sabrina-komplektaciya-classic-prime/p1563','https://abwehr.com.ua/storage/products/images/big/Vl8GJcJt8H2zOWGWecmhdDUm79rEi11o3UIoB7mX.jpg.webp?v=1771581216'),
 ('abwehr-classic-simfonia-official','Abwehr Simfonia','576','https://abwehr.com.ua/catalog/vhidni-dveri-model-simfonia-komplektaciya-classic-prime/p1558','https://abwehr.com.ua/storage/products/images/big/pKVoE9MRDvS78QCDSX90Hxx3rkKVYTG16HTRsP4Z.jpg.webp?v=1771583236');

insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available)
select slug,'entrance','Abwehr','Classic Prime',name,'Сталь, МДФ-накладки та заводські покриття','Сучасний','Заводські декори','Ціна за запитом',
 name || ' — вхідні двері для квартири серії Classic Prime. Три контури ущільнення та утеплена конструкція допомагають зберігати комфорт у приміщенні; точну комплектацію, декори й ціну уточнюйте у менеджера.',
 jsonb_build_array('Фабрика Abwehr','Колекція Classic Prime','3 контури ущільнення'),main_image,99999,false
from abwehr_classic_models
on conflict (slug) do update set name=excluded.name,material=excluded.material,style=excluded.style,color=excluded.color,description=excluded.description,features=excluded.features,image_path=excluded.image_path;

insert into public.product_specs (product_slug,label,value,sort_order,is_active)
select slug,label,value,sort_order,true from abwehr_classic_models
cross join lateral (values
 ('Тип конструкції','Вхідні двері для квартири',10),('Колекція','Classic Prime',20),('Призначення','Для квартири',30),('Контури ущільнення','3 контури',40)
) as spec(label,value,sort_order)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes)
select slug,'ABWEHR',source_url,name || ' · Classic Prime · код ' || product_code,'verified',now(),'Офіційна картка виробника: окрема актуальна модель Classic Prime та фотогалерея.'
from abwehr_classic_models
where not exists (select 1 from public.product_sources source where source.product_slug=abwehr_classic_models.slug and source.source_url=abwehr_classic_models.source_url);

create temporary table abwehr_classic_gallery (product_slug text,image_path text,sort_order integer) on commit drop;
insert into abwehr_classic_gallery values
 ('abwehr-classic-briona-official','https://abwehr.com.ua/storage/products/images/big/BhCqdnEYueyaysMKOuXeq3NNW0pfI0h6TSOyADIb.jpg.webp?v=1773306364',1),('abwehr-classic-briona-official','https://abwehr.com.ua/storage/products/images/big/JNhfsRcngX58AIn3Oid46JXicLxyNgzCOb5oWSUP.jpg.webp?v=1773306366',2),('abwehr-classic-briona-official','https://abwehr.com.ua/storage/products/images/big/OQmqFgaFHqnJnuq1y0ni9CCcFVpyuqsLV1G5MqI8.jpg.webp?v=1773306365',3),('abwehr-classic-briona-official','https://abwehr.com.ua/storage/products/images/big/aq5wEt5cBePFT6wiRC9NfOTI0UOokT4mFp102QKN.jpg.webp?v=1773306365',4),('abwehr-classic-briona-official','https://abwehr.com.ua/storage/products/images/big/rFIWoMJIv0KadjvQvVeHOvAvHFqGzGmXrtMZ6pWJ.jpg.webp?v=1773306364',5),
 ('abwehr-classic-monica-official','https://abwehr.com.ua/storage/products/images/big/yeCz9nqCrg2G5yoxSsoKswVX64IQW2ZwrmgpCG9f.jpg.webp?v=1771584209',1),('abwehr-classic-monica-official','https://abwehr.com.ua/storage/products/images/big/DajrKrckDrponSaZwXzKJaz6EOvJIl137zczcG6H.jpg.webp?v=1771579416',2),('abwehr-classic-monica-official','https://abwehr.com.ua/storage/products/images/big/NVKny6e1hf8ShDScPVLkoXnibqmzWb5vo4V2HIT6.jpg.webp?v=1771580384',3),('abwehr-classic-monica-official','https://abwehr.com.ua/storage/products/images/big/TQkCQxWmejCDQfsPMHvIVMwRuRrGsOwI0Qv7d9zW.jpg.webp?v=1771580986',4),('abwehr-classic-monica-official','https://abwehr.com.ua/storage/products/images/big/EYNGX4tRQ2LbUrxd582UjcqH927d6a5SdajfTnLK.jpg.webp?v=1771579518',5),
 ('abwehr-classic-geneva-official','https://abwehr.com.ua/storage/products/images/big/hafUcgiv9B4FoP0zVlbIOmAVNgwyJxgihz1eWst6.jpg.webp?v=1771582411',1),('abwehr-classic-geneva-official','https://abwehr.com.ua/storage/products/images/big/9CYgDj3hb5BVvy1L1SvL2OjDretvnULhsE5DwozG.jpg.webp?v=1771578950',2),('abwehr-classic-geneva-official','https://abwehr.com.ua/storage/products/images/big/FVftMyO2kVEG4NYvBYD61ttM3vYShY1X7KNVS2Th.jpg.webp?v=1771579619',3),('abwehr-classic-geneva-official','https://abwehr.com.ua/storage/products/images/big/CcJWIdVrjRLx4Ov8gR0gGITNVmcQA1fwSJsHfikP.jpg.webp?v=1771579318',4),('abwehr-classic-geneva-official','https://abwehr.com.ua/storage/products/images/big/a9OYkkplJFEd9lsd8fhZp1JopgYWSbgjFtL7xaIS.jpg.webp?v=1771581654',5),
 ('abwehr-classic-novella-official','https://abwehr.com.ua/storage/products/images/big/aHkpUyHZWz06Wo5zBMEosqbP9G9NGFYLwRbYoHWI.jpg.webp?v=1771581669',1),('abwehr-classic-novella-official','https://abwehr.com.ua/storage/products/images/big/DiL5a5Txxd0qLSjIARPlzuUhyPUigtshmr8RGayG.jpg.webp?v=1771579428',2),('abwehr-classic-novella-official','https://abwehr.com.ua/storage/products/images/big/5k7PHvGl2PEhwskiVSxMFUHSkVR37QTlCQCo3xOk.jpg.webp?v=1771578574',3),('abwehr-classic-novella-official','https://abwehr.com.ua/storage/products/images/big/OVpfk9llmThfiUbZYrFjaMNyVvajJlpewYo3sRER.jpg.webp?v=1771580481',4),('abwehr-classic-novella-official','https://abwehr.com.ua/storage/products/images/big/WZaIbHfv7c0fPdEhdROoOjfFRuz8XBxo6zna5EWw.jpg.webp?v=1771581300',5),
 ('abwehr-classic-sabrina-official','https://abwehr.com.ua/storage/products/images/big/Vl8GJcJt8H2zOWGWecmhdDUm79rEi11o3UIoB7mX.jpg.webp?v=1771581216',1),('abwehr-classic-sabrina-official','https://abwehr.com.ua/storage/products/images/big/031NJ58bCvFWKhI25db9XhUDqv5lqXkjsyo9AF52.jpg.webp?v=1771578013',2),('abwehr-classic-sabrina-official','https://abwehr.com.ua/storage/products/images/big/ovE7Heby99gAPxxQnMa3msyPMwjLo3EDXMDoh2rw.jpg.webp?v=1771583188',3),('abwehr-classic-sabrina-official','https://abwehr.com.ua/storage/products/images/big/ykxjTLh3cIQ3JpIt5R5fH97Xd5cwA02guKSTfIBH.jpg.webp?v=1771584216',4),('abwehr-classic-sabrina-official','https://abwehr.com.ua/storage/products/images/big/Ljtzt5I2HXcE5L6jvGz1HBrzisrYL71kowNRrkU5.jpg.webp?v=1771580217',5),
 ('abwehr-classic-simfonia-official','https://abwehr.com.ua/storage/products/images/big/pKVoE9MRDvS78QCDSX90Hxx3rkKVYTG16HTRsP4Z.jpg.webp?v=1771583236',1),('abwehr-classic-simfonia-official','https://abwehr.com.ua/storage/products/images/big/WstbSDs4aknTUuSb0hqgHrloqVp7nlXiiTXABPdp.jpg.webp?v=1771581333',2),('abwehr-classic-simfonia-official','https://abwehr.com.ua/storage/products/images/big/PnDegQgnhppydpkMoDIGTdrqug19y2g3ow6upJ2l.jpg.webp?v=1771580601',3),('abwehr-classic-simfonia-official','https://abwehr.com.ua/storage/products/images/big/jec30nuciip3rpfTVW3qo2K6RomZi4PqWKTXdY1j.jpg.webp?v=1771582623',4),('abwehr-classic-simfonia-official','https://abwehr.com.ua/storage/products/images/big/Y5L78p7UJ12f0w9eh3PuTj58sUnTtLSrIYaJFISB.jpg.webp?v=1771581460',5);

insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select slug,'main','Головне фото',main_image,0 from abwehr_classic_models
where not exists (select 1 from public.product_media media where media.product_slug=abwehr_classic_models.slug and media.kind='main' and media.image_path=abwehr_classic_models.main_image);
insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select product_slug,'gallery','Офіційне фото ' || sort_order,image_path,sort_order from abwehr_classic_gallery
where not exists (select 1 from public.product_media media where media.product_slug=abwehr_classic_gallery.product_slug and media.kind='gallery' and media.image_path=abwehr_classic_gallery.image_path);

commit;

select count(*) as моделей,count(*) filter(where is_available) as опубліковано,
 (select count(*) from public.product_media media where media.product_slug in ('abwehr-classic-briona-official','abwehr-classic-monica-official','abwehr-classic-geneva-official','abwehr-classic-novella-official','abwehr-classic-sabrina-official','abwehr-classic-simfonia-official') and media.kind='gallery') as фото_в_галереях,
 count(*) filter(where image_path is not null) as моделей_з_фото
from public.products where slug in ('abwehr-classic-briona-official','abwehr-classic-monica-official','abwehr-classic-geneva-official','abwehr-classic-novella-official','abwehr-classic-sabrina-official','abwehr-classic-simfonia-official');
