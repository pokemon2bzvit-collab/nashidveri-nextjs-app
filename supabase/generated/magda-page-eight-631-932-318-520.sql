-- П'ять прихованих моделей Magda. Картку «Тип 16 ПЧ темний горіх» пропущено:
-- це назва комплектації, а не окрема модель.

begin;

insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values
('magda-631-ph-official','entrance','Magda','Вулиця','Magda Модель №631 ПХ','Сталь, МДФ-накладки та заводські покриття','Для будинку, квартири або офісу','Заводські декори','Ціна за запитом','Magda Модель №631 ПХ — вхідні двері з дизайном внутрішньої сторони полотна. Доступні різні типи комплектації, зокрема виконання з терморозривом.',jsonb_build_array('Офіційна модель Magda','Комплектація ПХ','Терморозрив','Для будинку, квартири або офісу'),'https://magda.com.ua/storage/app/uploads/public/058/017/8f8/thumb__0_0_0_0_auto.jpg',99034,false),
('magda-932-1-official','entrance','Magda','Вулиця','Magda Модель №932.1','Сталь, МДФ та заводські покриття','Для будинку','Заводські декори','Ціна за запитом','Magda Модель №932.1 — вуличні вхідні двері з конструкцією з терморозривом. Для моделі доступні різні варіанти фурнітури: прямокутна чорна, прямокутна хромована або звичайна хромована.',jsonb_build_array('Офіційна модель Magda','Терморозрив','Вуличні двері','Вибір фурнітури'),'https://magda.com.ua/storage/app/uploads/public/214/1d6/617/thumb__0_0_0_0_auto.jpg',99035,false),
('magda-318-official','entrance','Magda','Квартира','Magda Модель №318','Сталь, МДФ-накладки та заводські покриття','Для квартири','Патина','Ціна за запитом','Magda Модель №318 — вхідні двері з патиною, що створює ефект старовини, рельєфності та контрастності. Актуальну комплектацію й ціну уточнюйте у менеджера.',jsonb_build_array('Офіційна модель Magda','Покриття патина','Для квартири'),'https://magda.com.ua/storage/app/uploads/public/1b4/69b/272/thumb__0_0_0_0_auto.png',99036,false),
('magda-318-1-official','entrance','Magda','Квартира','Magda Модель №318 №1','Сталь, МДФ-накладки та заводські покриття','Для квартири','Патина','Ціна за запитом','Magda Модель №318 №1 — вхідні двері з покриттям патина та кованим елементом №1. Допоможемо підібрати декор, комплектацію й розмір.',jsonb_build_array('Офіційна модель Magda','Покриття патина','Кований елемент','Для квартири'),'https://magda.com.ua/storage/app/uploads/public/2f6/473/c65/thumb__0_0_0_0_auto.png',99037,false),
('magda-520-1-official','entrance','Magda','Квартира','Magda Модель №520.1','Сталь, МДФ-накладки та заводські покриття','Для квартири','Заводські декори','Ціна за запитом','Magda Модель №520.1 — металеві вхідні двері для квартири з лаконічним геометричним дизайном. Тепло- і шумоізоляція та надійна фурнітура забезпечують комфортне користування.',jsonb_build_array('Офіційна модель Magda','Для квартири','Тепло- і шумоізоляція'),'https://magda.com.ua/storage/app/uploads/public/f4f/a8a/f2d/thumb__0_0_0_0_auto.jpg',99038,false)
on conflict (slug) do update set collection=excluded.collection,name=excluded.name,material=excluded.material,style=excluded.style,color=excluded.color,description=excluded.description,features=excluded.features,image_path=excluded.image_path,updated_at=now();

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
('magda-631-ph-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/631-ph','Модель №631 ПХ','verified',now(),'Офіційна картка виробника'),
('magda-932-1-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/9321','Модель №932.1','verified',now(),'Офіційна картка виробника'),
('magda-318-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/318','Модель №318','verified',now(),'Офіційна картка виробника'),
('magda-318-1-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/318-1','Модель №318 №1','verified',now(),'Офіційна картка виробника'),
('magda-520-1-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/5201','Модель №520.1','verified',now(),'Офіційна картка виробника')
on conflict (product_slug,source_url) do update set source_product_name=excluded.source_product_name,verification_status=excluded.verification_status,verified_at=excluded.verified_at,notes=excluded.notes;

insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values
('magda-631-ph-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/058/017/8f8/thumb__0_0_0_0_auto.jpg',1,true),
('magda-932-1-official','gallery','Фото 1','https://magda.com.ua/storage/app/uploads/public/214/1d6/617/thumb__0_0_0_0_auto.jpg',1,true),
('magda-932-1-official','gallery','Фото 2','https://magda.com.ua/storage/app/uploads/public/8c3/a21/cc8/thumb__0_0_0_0_auto.jpg',2,true),
('magda-318-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/1b4/69b/272/thumb__0_0_0_0_auto.png',1,true),
('magda-318-1-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/2f6/473/c65/thumb__0_0_0_0_auto.png',1,true),
('magda-520-1-official','gallery','Фото 1','https://magda.com.ua/storage/app/uploads/public/f4f/a8a/f2d/thumb__0_0_0_0_auto.jpg',1,true),
('magda-520-1-official','gallery','Фото 2','https://magda.com.ua/storage/app/uploads/public/758/0aa/3fe/thumb__0_0_0_0_auto.jpg',2,true)
on conflict (product_slug,kind,image_path) do update set label=excluded.label,sort_order=excluded.sort_order,is_active=excluded.is_active;

insert into public.product_specs (product_slug,label,value,sort_order,is_active)
select slug,label,value,sort_order,true from (values
('magda-631-ph-official','Доступні типи комплектації','Тип 2.24, Тип 3.23, Тип 5, Тип 13, Тип 4 і 6.23 з терморозривом, Тип 15, Тип 16, Тип 12.2',10),
('magda-932-1-official','Тип комплектації','Тип 6.23 з терморозривом',10),
('magda-318-official','Доступні типи комплектації','Тип 2.24, Тип 3.23, Тип 5, Тип 13, Тип 12.2',10),
('magda-318-1-official','Доступні типи комплектації','Тип 2.24, Тип 3.23, Тип 5, Тип 13, Тип 12.2',10),
('magda-520-1-official','Доступні типи комплектації','Тип 2.24, Тип 3.23, Тип 5, Тип 13',10)
) as v(slug,label,value,sort_order)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=excluded.is_active;

commit;

select p.slug,p.name as "модель",p.collection as "колекція",p.is_available as "опубліковано",count(m.id) filter(where m.kind='gallery' and m.is_active) as "фото_в_галереї",count(s.id) filter(where s.verification_status='verified') as "офіційних_джерел"
from public.products p left join public.product_media m on m.product_slug=p.slug left join public.product_sources s on s.product_slug=p.slug
where p.slug in ('magda-631-ph-official','magda-932-1-official','magda-318-official','magda-318-1-official','magda-520-1-official')
group by p.slug,p.name,p.collection,p.is_available order by p.name;
