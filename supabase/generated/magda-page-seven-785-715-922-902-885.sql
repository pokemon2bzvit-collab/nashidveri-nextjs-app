-- П'ять нових чернеток Magda та уточнення чинної моделі №902.1 без дублювання.

begin;

insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values
('magda-785-1-official','entrance','Magda','Вулиця','Magda Модель №785.1','Сталь, МДФ та порошкове фарбування','Для будинку або офісу','Заводські декори','Ціна за запитом','Magda Модель №785.1 — вхідні двері зі склопакетом для будинку або офісу. Конструкція з терморозривом типу 6.23; доступні різні види решіток і комплектації фурнітури.',jsonb_build_array('Офіційна модель Magda','Терморозрив','Склопакет','Для будинку або офісу'),'https://magda.com.ua/storage/app/uploads/public/873/06f/f8c/thumb__0_0_0_0_auto.jpg',99024,false),
('magda-715-structural-1-official','entrance','Magda','Вулиця','Magda Модель №715 склопакет структурний 1','Сталь, МДФ та заводські покриття','Для будинку','Заводські декори','Ціна за запитом','Magda Модель №715 зі структурним склопакетом — металеві вхідні двері. Можлива комплектація чорною або хромованою фурнітурою.',jsonb_build_array('Офіційна модель Magda','Склопакет','Чорна або хромована фурнітура'),'https://magda.com.ua/storage/app/uploads/public/c50/c95/ae4/thumb__0_0_0_0_auto.jpg',99025,false),
('magda-922-1-official','entrance','Magda','Вулиця','Magda Модель №922.1','Сталь, МДФ та заводські покриття','Для будинку, квартири або офісу','Заводські декори','Ціна за запитом','Magda Модель №922.1 — металеві вхідні двері для будинку, квартири або офісу в комплектації ПЧ. Доступні тип 16 і виконання з терморозривом.',jsonb_build_array('Офіційна модель Magda','Комплектація ПЧ','Терморозрив','Для будинку, квартири або офісу'),'https://magda.com.ua/storage/app/uploads/public/5d6/a42/48c/thumb__0_0_0_0_auto.jpg',99026,false),
('magda-902-official','entrance','Magda','Вулиця','Magda Модель №902','Сталь, МДФ та заводські покриття','Для будинку, квартири або офісу','Заводські декори','Ціна за запитом','Magda Модель №902 — вхідні двері для будинку, квартири або офісу в комплектації ПХ. Лаконічний дизайн поєднано з можливістю виконання з терморозривом.',jsonb_build_array('Офіційна модель Magda','Комплектація ПХ','Терморозрив','Для будинку, квартири або офісу'),'https://magda.com.ua/storage/app/uploads/public/39c/9b2/f14/thumb__0_0_0_0_auto.jpg',99027,false),
('magda-885-1-official','entrance','Magda','Вулиця','Magda Модель №885.1','Сталь, МДФ та заводські покриття','Для будинку','Заводські декори','Ціна за запитом','Magda Модель №885.1 — металеві вхідні двері зі склопакетом у комплектації ПС1. Доступні виконання з терморозривом.',jsonb_build_array('Офіційна модель Magda','Склопакет','Комплектація ПС1','Терморозрив'),'https://magda.com.ua/storage/app/uploads/public/212/0d2/f55/thumb__0_0_0_0_auto.jpg',99028,false)
on conflict (slug) do update set collection=excluded.collection,name=excluded.name,material=excluded.material,style=excluded.style,color=excluded.color,description=excluded.description,features=excluded.features,image_path=excluded.image_path,updated_at=now();

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
('magda-785-1-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/t623pch-785-reshitka-029','Модель №785.1','verified',now(),'Офіційна картка виробника'),
('magda-715-structural-1-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/t16pch-715-sklopaket-strukturnij-1','Модель №715 склопакет структурний 1','verified',now(),'Офіційна картка виробника'),
('magda-922-1-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/t16pch-9221','Модель №922.1','verified',now(),'Офіційна картка виробника'),
('magda-902-1-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/t16pch-9021','Модель №902.1','verified',now(),'Додаткове офіційне виконання ПЧ, тип 16.'),
('magda-902-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/t16pch-902','Модель №902','verified',now(),'Офіційна картка виробника'),
('magda-885-1-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/t40pch-8851-sklopaket-ps1','Модель №885.1','verified',now(),'Офіційна картка виробника')
on conflict (product_slug,source_url) do update set source_product_name=excluded.source_product_name,verification_status=excluded.verification_status,verified_at=excluded.verified_at,notes=excluded.notes;

insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values
('magda-785-1-official','gallery','Фото 1','https://magda.com.ua/storage/app/uploads/public/873/06f/f8c/thumb__0_0_0_0_auto.jpg',1,true),
('magda-785-1-official','gallery','Фото 2','https://magda.com.ua/storage/app/uploads/public/eaa/7a1/1d9/thumb__0_0_0_0_auto.jpg',2,true),
('magda-785-1-official','gallery','Фото 3','https://magda.com.ua/storage/app/uploads/public/a85/629/19e/thumb__0_0_0_0_auto.jpg',3,true),
('magda-785-1-official','gallery','Фото 4','https://magda.com.ua/storage/app/uploads/public/967/9b6/ec7/thumb__0_0_0_0_auto.jpg',4,true),
('magda-715-structural-1-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/c50/c95/ae4/thumb__0_0_0_0_auto.jpg',1,true),
('magda-922-1-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/5d6/a42/48c/thumb__0_0_0_0_auto.jpg',1,true),
('magda-902-1-official','gallery','Виконання ПЧ, тип 16','https://magda.com.ua/storage/app/uploads/public/2be/62e/7bf/thumb__0_0_0_0_auto.jpg',3,true),
('magda-902-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/39c/9b2/f14/thumb__0_0_0_0_auto.jpg',1,true),
('magda-885-1-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/212/0d2/f55/thumb__0_0_0_0_auto.jpg',1,true)
on conflict (product_slug,kind,image_path) do update set label=excluded.label,sort_order=excluded.sort_order,is_active=excluded.is_active;

insert into public.product_specs (product_slug,label,value,sort_order,is_active)
select slug,label,value,sort_order,true from (values
('magda-785-1-official','Тип комплектації','Тип 6.23 з терморозривом',10),
('magda-785-1-official','Товщина полотна','94 мм',20),
('magda-785-1-official','Товщина короба','112 мм з терморозривом',30),
('magda-715-structural-1-official','Тип комплектації','Тип 16',10),
('magda-922-1-official','Доступні типи комплектації','Тип 6.23 з терморозривом, Тип 16',10),
('magda-902-1-official','Додаткове виконання','Комплектація ПЧ, тип 16',20),
('magda-902-official','Доступні типи комплектації','Тип 6.23 з терморозривом, Тип 16',10),
('magda-885-1-official','Доступні типи комплектації','Тип 4 з терморозривом, Тип 6.23 з терморозривом',10)
) as v(slug,label,value,sort_order)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=excluded.is_active;

commit;

select p.slug,p.name as "модель",p.collection as "колекція",p.is_available as "опубліковано",count(m.id) filter(where m.kind='gallery' and m.is_active) as "фото_в_галереї",count(s.id) filter(where s.verification_status='verified') as "офіційних_джерел"
from public.products p left join public.product_media m on m.product_slug=p.slug left join public.product_sources s on s.product_slug=p.slug
where p.slug in ('magda-785-1-official','magda-715-structural-1-official','magda-922-1-official','magda-902-1-official','magda-902-official','magda-885-1-official')
group by p.slug,p.name,p.collection,p.is_available order by p.name;
