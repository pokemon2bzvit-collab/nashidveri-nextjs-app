-- ABWEHR DEFENDER: first distinct models and 1200-mm constructions as hidden drafts.
-- No existing product is deleted, changed, or published.

begin;

create temporary table abwehr_defender_first (
  slug text primary key, name text not null, product_code text not null, source_url text not null,
  construction_type text not null, main_image text not null
) on commit drop;

insert into abwehr_defender_first values
  ('abwehr-defender-nordi-glass', 'Abwehr Nordi Glass', '506', 'https://abwehr.com.ua/catalog/vhidni-metalevi-dveri-zi-sklom-ta-termorozrivom-model-nordi-glass-komplektaciya-defender-1/p1720', 'Вхідні двері зі склопакетом для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/X6t6hd8OL6RXX5Yvz0QcJe1207mXFfPJkpcI1KXf.jpg.webp?v=1786440110'),
  ('abwehr-defender-pulse', 'Abwehr Pulse', '591', 'https://abwehr.com.ua/catalog/vhidni-metalevi-dveri-z-termorozrivom-model-pulse-komplektaciya-defender/p1707', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/UvYKmrSN9SlKYpKq7XGOOZDxmK5BQHXOUyv2NG3H.jpg.webp?v=1779446823'),
  ('abwehr-defender-vector', 'Abwehr Vector', '590', 'https://abwehr.com.ua/catalog/vhidni-metalevi-dveri-z-termorozrivom-model-vector-komplektaciya-defender/p1706', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/YMVzbU2rNJlo3cBuiLy3hiTtQbOgHO9BFWlmwZuP.jpg.webp?v=1779346418'),
  ('abwehr-defender-nordi-glass-1200', 'Abwehr Nordi Glass 1200', '506', 'https://abwehr.com.ua/catalog/vhidni-metalevi-dveri-z-termorozrivom-model-nordi-glass-komplektaciya-defender-1200/p1656', 'Напівторастулкові двері 1200 мм зі склопакетом', 'https://abwehr.com.ua/storage/products/images/big/JsG1rx3xnudTSbLg05clgbFFGDjw1hxoYfAbVKST.jpg.webp?v=1771580043'),
  ('abwehr-defender-solid-1200', 'Abwehr Solid 1200', 'KTM-76', 'https://abwehr.com.ua/catalog/vhidni-metalevi-dveri-z-termorozrivom-model-solid-komplektaciya-defender-1200/p1643', 'Напівторастулкові двері 1200 мм', 'https://abwehr.com.ua/storage/products/images/big/WDfLpeEmLfwMtuUawmcnrOjjweZDt91mN05SWQDO.jpg.webp?v=1771581267'),
  ('abwehr-defender-solid', 'Abwehr Solid', 'KTM-76', 'https://abwehr.com.ua/catalog/vhidni-metalevi-dveri-z-termorozrivom-model-solid-komplektaciya-defender-1-1/p1634', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/4yfg1evkJhoAniMWMkLR9ZIBiPFUbqPkV7si05j6.jpg.webp?v=1771578484');

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select model.slug, 'entrance', 'Abwehr', 'Defender', model.name,
  'Сталь, МДФ-накладки та заводські атмосферостійкі покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом',
  model.name || ' — ' || lower(model.construction_type) || ' серії Defender. Терморозрив допомагає підтримувати комфорт у приміщенні; точну комплектацію, декори й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Колекція Defender', 'Терморозрив'), model.main_image, 99999, false
from abwehr_defender_first model
on conflict (slug) do update set name=excluded.name, material=excluded.material, style=excluded.style, color=excluded.color, description=excluded.description, features=excluded.features, image_path=excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select model.slug, spec.label, spec.value, spec.sort_order, true
from abwehr_defender_first model
cross join lateral (values
  ('Тип конструкції', model.construction_type, 10), ('Колекція', 'Defender', 20),
  ('Призначення', 'Для приватного будинку', 30), ('Терморозрив', 'Так', 40)
) as spec(label,value,sort_order)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes)
select model.slug,'ABWEHR',model.source_url,model.name || ' · Defender · код ' || model.product_code,'verified',now(),'Офіційна картка виробника: окрема модель Defender та фотогалерея.'
from abwehr_defender_first model
where not exists (select 1 from public.product_sources source where source.product_slug=model.slug and source.source_url=model.source_url);

create temporary table abwehr_defender_first_gallery (product_slug text not null,image_path text not null,sort_order integer not null) on commit drop;
insert into abwehr_defender_first_gallery values
 ('abwehr-defender-nordi-glass','https://abwehr.com.ua/storage/products/images/big/X6t6hd8OL6RXX5Yvz0QcJe1207mXFfPJkpcI1KXf.jpg.webp?v=1786440110',1),('abwehr-defender-nordi-glass','https://abwehr.com.ua/storage/products/images/big/fKk8cyv6n42X9RZ9xuHJdZeZF6TMToFwXhDcAyLi.jpg.webp?v=1786440120',2),('abwehr-defender-nordi-glass','https://abwehr.com.ua/storage/products/images/big/bQihYPG4hIDLHaGr3YsVav6RQR7oztvALzAmWCwP.jpg.webp?v=1786440112',3),('abwehr-defender-nordi-glass','https://abwehr.com.ua/storage/products/images/big/y8TFWJ8ynNEeabjixqhEABIdP7WHnOyOgXlrWiwn.jpg.webp?v=1786440110',4),('abwehr-defender-nordi-glass','https://abwehr.com.ua/storage/products/images/big/dcWO6AV9cewgaaplLUNzaWbQ4JUL2egI4xQ6gZ4N.jpg.webp?v=1786440110',5),
 ('abwehr-defender-pulse','https://abwehr.com.ua/storage/products/images/big/UvYKmrSN9SlKYpKq7XGOOZDxmK5BQHXOUyv2NG3H.jpg.webp?v=1779446823',1),('abwehr-defender-pulse','https://abwehr.com.ua/storage/products/images/big/rcf3jRKbIgG7OS7CKlzOdNOSSKu0LAsAdXC7ech5.jpg.webp?v=1779446823',2),('abwehr-defender-pulse','https://abwehr.com.ua/storage/products/images/big/T6o0oyFyv4THKlYiRKoTid2eRLvbmSkinpWC7xGQ.jpg.webp?v=1779446826',3),('abwehr-defender-pulse','https://abwehr.com.ua/storage/products/images/big/e9x40AyDVBYy3k4Neyf5LiJOonAFkSK7OAqpiYXm.jpg.webp?v=1779446824',4),('abwehr-defender-pulse','https://abwehr.com.ua/storage/products/images/big/Td7SJK1xJhBBkkGXwynApjVLD8X0IevQzbyIs0Ib.jpg.webp?v=1779446823',5),
 ('abwehr-defender-vector','https://abwehr.com.ua/storage/products/images/big/YMVzbU2rNJlo3cBuiLy3hiTtQbOgHO9BFWlmwZuP.jpg.webp?v=1779346418',1),('abwehr-defender-vector','https://abwehr.com.ua/storage/products/images/big/tGgawnvzkaua4pYZQOZu9qf3imQ1TGNnH7D6qUcJ.jpg.webp?v=1779346423',2),('abwehr-defender-vector','https://abwehr.com.ua/storage/products/images/big/Q30Hi5m266B4dOmaZOnRdNnLluZcwyIzNoJpICOy.jpg.webp?v=1779346420',3),('abwehr-defender-vector','https://abwehr.com.ua/storage/products/images/big/zFJIVUpOUI7M50dtNWJikTfU33wFBd801Wbn7awG.jpg.webp?v=1779346419',4),('abwehr-defender-vector','https://abwehr.com.ua/storage/products/images/big/N5HSV3vIH8oc3Vt9ASBiL6hQF49xQA6ET7K8y0cA.jpg.webp?v=1779346418',5),
 ('abwehr-defender-nordi-glass-1200','https://abwehr.com.ua/storage/products/images/big/JsG1rx3xnudTSbLg05clgbFFGDjw1hxoYfAbVKST.jpg.webp?v=1771580043',1),('abwehr-defender-nordi-glass-1200','https://abwehr.com.ua/storage/products/images/big/ht42LKUF6dwjAyaC8nZpKN1CaU3CNJsJJyD6ZiSN.jpg.webp?v=1771582437',2),
 ('abwehr-defender-solid-1200','https://abwehr.com.ua/storage/products/images/big/WDfLpeEmLfwMtuUawmcnrOjjweZDt91mN05SWQDO.jpg.webp?v=1771581267',1),('abwehr-defender-solid-1200','https://abwehr.com.ua/storage/products/images/big/M7023gXjFmksoBWWmOONOPIPDUE8lUjiU7tPOTM6.jpg.webp?v=1771580251',2),('abwehr-defender-solid-1200','https://abwehr.com.ua/storage/products/images/big/5HIfxyvlw44eVGNJh5owhIIwylAxAfqwK5b2Khcl.jpg.webp?v=1771578515',3),('abwehr-defender-solid-1200','https://abwehr.com.ua/storage/products/images/big/dFeOIeXnN44bCXwjrdvfmBzWMxvNTVyaIWqTikCx.jpg.webp?v=1771581984',4),('abwehr-defender-solid-1200','https://abwehr.com.ua/storage/products/images/big/F5KfahCTDD26NAH0r3hx9JCHuWLGGRtdohWvGaDY.jpg.webp?v=1771579575',5),
 ('abwehr-defender-solid','https://abwehr.com.ua/storage/products/images/big/4yfg1evkJhoAniMWMkLR9ZIBiPFUbqPkV7si05j6.jpg.webp?v=1771578484',1),('abwehr-defender-solid','https://abwehr.com.ua/storage/products/images/big/9bmE71vnX7mB2wnVsSZfPXmIh4hcGg89CwdaDssJ.jpg.webp?v=1771578985',2),('abwehr-defender-solid','https://abwehr.com.ua/storage/products/images/big/8JHJiGuXGRmE4MbT3d5QOtZ1Qc3YdWGxVUSRfHcE.jpg.webp?v=1771578849',3),('abwehr-defender-solid','https://abwehr.com.ua/storage/products/images/big/hX0fHqj07Dv8wL1sZSD09Jl9pTGeVoaJ31BSoDBR.jpg.webp?v=1771582406',4),('abwehr-defender-solid','https://abwehr.com.ua/storage/products/images/big/YfEG6WTYf32NRPFemovn3rIPgNHvn9dDLPq8WPUx.jpg.webp?v=1771581516',5);

insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select model.slug,'main','Головне фото',model.main_image,0 from abwehr_defender_first model
where not exists(select 1 from public.product_media media where media.product_slug=model.slug and media.kind='main' and media.image_path=model.main_image);
insert into public.product_media (product_slug,kind,label,image_path,sort_order)
select gallery.product_slug,'gallery','Офіційне фото ' || gallery.sort_order,gallery.image_path,gallery.sort_order from abwehr_defender_first_gallery gallery
where not exists(select 1 from public.product_media media where media.product_slug=gallery.product_slug and media.kind='gallery' and media.image_path=gallery.image_path);

commit;

select count(*) as моделей,count(*) filter(where is_available) as опубліковано,
 (select count(*) from public.product_media media where media.product_slug in ('abwehr-defender-nordi-glass','abwehr-defender-pulse','abwehr-defender-vector','abwehr-defender-nordi-glass-1200','abwehr-defender-solid-1200','abwehr-defender-solid') and media.kind='gallery') as фото_в_галереях,
 count(*) filter(where image_path is not null) as моделей_з_фото
from public.products where slug in ('abwehr-defender-nordi-glass','abwehr-defender-pulse','abwehr-defender-vector','abwehr-defender-nordi-glass-1200','abwehr-defender-solid-1200','abwehr-defender-solid');
