-- П'ять нових моделей Magda та додаткове офіційне виконання існуючої №807.

begin;

insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values
('magda-518-1-pch-official','entrance','Magda','Квартира','Magda Модель №518.1 ПЧ','Сталь, МДФ-накладки та заводські покриття','Для квартири','Заводські декори','Ціна за запитом','Magda Модель №518.1 ПЧ — металеві вхідні двері для квартири. Якісна тепло- і шумоізоляція та надійна фурнітура створюють комфорт для щоденного користування.',jsonb_build_array('Офіційна модель Magda','Для квартири','Комплектація ПЧ'),'https://magda.com.ua/storage/app/uploads/public/6a1/63d/d81/thumb__0_0_0_0_auto.jpg',99029,false),
('magda-519-1-pch-official','entrance','Magda','Квартира','Magda Модель №519.1 ПЧ','Сталь, МДФ-накладки та заводські покриття','Для квартири','Заводські декори','Ціна за запитом','Magda Модель №519.1 ПЧ — вхідні двері для квартири з офіційного каталогу виробника. Допоможемо обрати тип комплектації, декор і розмір дверного блоку.',jsonb_build_array('Офіційна модель Magda','Для квартири','Комплектація ПЧ'),'https://magda.com.ua/storage/app/uploads/public/9fa/f4c/f34/thumb__0_0_0_0_auto.jpg',99030,false),
('magda-632-1-pch-official','entrance','Magda','Вулиця','Magda Модель №632.1 ПЧ','Сталь, МДФ-накладки та заводські покриття','Для будинку, квартири або офісу','Заводські декори','Ціна за запитом','Magda Модель №632.1 ПЧ — вхідні двері з великим вибором типів комплектації: від квартирних до виконань з терморозривом. Підкажемо оптимальний варіант під ваш об’єкт.',jsonb_build_array('Офіційна модель Magda','Комплектація ПЧ','Терморозрив','Для будинку, квартири або офісу'),'https://magda.com.ua/storage/app/uploads/public/71e/286/3dc/thumb__0_0_0_0_auto.jpg',99031,false),
('magda-635-official','entrance','Magda','Квартира','Magda Модель №635','Сталь, МДФ-накладки та заводські покриття','Для квартири','ПВХ-плівка','Ціна за запитом','Magda Модель №635 — двері для квартири з комплектацією прямокутною чорною фурнітурою. Виробник вказує 59 варіантів ПВХ-покриття та декілька типів фурнітури.',jsonb_build_array('Офіційна модель Magda','Для квартири','ПВХ-покриття','Вибір фурнітури'),'https://magda.com.ua/storage/app/uploads/public/1a9/952/80d/thumb__0_0_0_0_auto.jpg',99032,false),
('magda-642-1-ph-official','entrance','Magda','Вулиця','Magda Модель №642.1 ПХ','Сталь, МДФ-накладки та заводські покриття','Для будинку, квартири або офісу','Заводські декори','Ціна за запитом','Magda Модель №642.1 ПХ — вхідні двері з широким вибором комплектацій, у тому числі з терморозривом. Допоможемо підібрати рішення для квартири, будинку або офісу.',jsonb_build_array('Офіційна модель Magda','Комплектація ПХ','Терморозрив','Для будинку, квартири або офісу'),'https://magda.com.ua/storage/app/uploads/public/125/209/5ab/thumb__0_0_0_0_auto.jpg',99033,false)
on conflict (slug) do update set collection=excluded.collection,name=excluded.name,material=excluded.material,style=excluded.style,color=excluded.color,description=excluded.description,features=excluded.features,image_path=excluded.image_path,updated_at=now();

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
('magda-807-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/t401-reshitka-025','Модель №807 решітка 025','verified',now(),'Додаткове виконання: склопакет, решітка 025, терморозрив.'),
('magda-518-1-pch-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/518-pch','Модель №518.1 ПЧ','verified',now(),'Офіційна картка виробника'),
('magda-519-1-pch-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/519-pch','Модель №519.1 ПЧ','verified',now(),'Офіційна картка виробника'),
('magda-632-1-pch-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/6321-pch','Модель №632.1 ПЧ','verified',now(),'Офіційна картка виробника'),
('magda-635-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/635pch','Модель №635','verified',now(),'Офіційна картка виробника'),
('magda-642-1-ph-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/632-ph','Модель №642.1 ПХ','verified',now(),'Офіційна картка виробника')
on conflict (product_slug,source_url) do update set source_product_name=excluded.source_product_name,verification_status=excluded.verification_status,verified_at=excluded.verified_at,notes=excluded.notes;

insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values
('magda-807-official','gallery','Решітка 025, терморозрив','https://magda.com.ua/storage/app/uploads/public/ff8/526/8c5/thumb__0_0_0_0_auto.jpg',4,true),
('magda-518-1-pch-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/6a1/63d/d81/thumb__0_0_0_0_auto.jpg',1,true),
('magda-519-1-pch-official','gallery','Фото 1','https://magda.com.ua/storage/app/uploads/public/9fa/f4c/f34/thumb__0_0_0_0_auto.jpg',1,true),
('magda-519-1-pch-official','gallery','Фото 2','https://magda.com.ua/storage/app/uploads/public/3d1/4ee/5fb/thumb__0_0_0_0_auto.jpg',2,true),
('magda-632-1-pch-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/71e/286/3dc/thumb__0_0_0_0_auto.jpg',1,true),
('magda-635-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/1a9/952/80d/thumb__0_0_0_0_auto.jpg',1,true),
('magda-642-1-ph-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/125/209/5ab/thumb__0_0_0_0_auto.jpg',1,true)
on conflict (product_slug,kind,image_path) do update set label=excluded.label,sort_order=excluded.sort_order,is_active=excluded.is_active;

insert into public.product_specs (product_slug,label,value,sort_order,is_active)
select slug,label,value,sort_order,true from (values
('magda-807-official','Додаткове виконання','Решітка 025, склопакет, тип 4 з терморозривом',20),
('magda-518-1-pch-official','Доступні типи комплектації','Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13, Тип 12.2',10),
('magda-519-1-pch-official','Доступні типи комплектації','Тип 2.24 (2.24 Kale), Тип 3.23, Тип 13',10),
('magda-632-1-pch-official','Доступні типи комплектації','Тип 2.24, Тип 3.23, Тип 5, Тип 13, Тип 4 і 6.23 з терморозривом, Тип 15, Тип 16, Тип 12.2',10),
('magda-635-official','Доступні типи комплектації','Тип 2.24, Тип 3.23, Тип 5, Тип 13, Тип 15, Тип 12.2',10),
('magda-642-1-ph-official','Доступні типи комплектації','Тип 2.24, Тип 3.23, Тип 5, Тип 13, Тип 4 і 6.23 з терморозривом, Тип 15, Тип 16, Тип 12.2',10)
) as v(slug,label,value,sort_order)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=excluded.is_active;

commit;

select p.slug,p.name as "модель",p.collection as "колекція",p.is_available as "опубліковано",count(m.id) filter(where m.kind='gallery' and m.is_active) as "фото_в_галереї",count(s.id) filter(where s.verification_status='verified') as "офіційних_джерел"
from public.products p left join public.product_media m on m.product_slug=p.slug left join public.product_sources s on s.product_slug=p.slug
where p.slug in ('magda-807-official','magda-518-1-pch-official','magda-519-1-pch-official','magda-632-1-pch-official','magda-635-official','magda-642-1-ph-official')
group by p.slug,p.name,p.collection,p.is_available order by p.name;
