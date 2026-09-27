-- Пакет із шести прихованих моделей Magda з 7-ї сторінки офіційного каталогу.

begin;

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values
('magda-515ph-official','entrance','Magda','Квартира','Magda Модель №515 ПХ','Сталь, МДФ-накладки та заводські покриття','Для квартири','Заводські декори','Ціна за запитом','Magda Модель №515 ПХ — вхідні двері для квартири з офіційного каталогу виробника. Допоможемо обрати тип комплектації, декор і розмір дверного блоку.',jsonb_build_array('Офіційна модель Magda','Для квартири','Заводські декори'),'https://magda.com.ua/storage/app/uploads/public/aad/427/978/thumb__0_0_0_0_auto.jpg',99018,false),
('magda-508-official','entrance','Magda','Квартира','Magda Модель №508','Сталь, МДФ-накладки та заводські покриття','Для квартири','Заводські декори','Ціна за запитом','Magda Модель №508 — вхідні двері для квартири з офіційного каталогу виробника. Актуальну комплектацію, декор і ціну уточнюйте у менеджера.',jsonb_build_array('Офіційна модель Magda','Для квартири','Заводські декори'),'https://magda.com.ua/storage/app/uploads/public/559/3d4/b11/thumb__0_0_0_0_auto.jpg',99019,false),
('magda-815-official','entrance','Magda','Вулиця','Magda Модель №815','Сталь, МДФ та порошкове фарбування','Для будинку або офісу','Порошкове фарбування','Ціна за запитом','Magda Модель №815 — металеві вхідні двері для будинку або офісу зі структурним склопакетом. Зовнішнє покриття — порошкове фарбування; доступні різні типи фурнітури.',jsonb_build_array('Офіційна модель Magda','Для будинку або офісу','Структурний склопакет','Порошкове фарбування'),'https://magda.com.ua/storage/app/uploads/public/626/f82/078/thumb__0_0_0_0_auto.jpg',99020,false),
('magda-146pch-official','entrance','Magda','Квартира','Magda Модель №146 ПЧ','Сталь, МДФ-накладки та заводські покриття','Для квартири','Заводські декори','Ціна за запитом','Magda Модель №146 ПЧ — вхідні двері для квартири. Комбінація кольорів плівки та фурнітури дозволяє підібрати виконання під інтер’єр.',jsonb_build_array('Офіційна модель Magda','Для квартири','Заводські декори'),'https://magda.com.ua/storage/app/uploads/public/90d/cf3/c93/thumb__0_0_0_0_auto.jpg',99021,false),
('magda-814-official','entrance','Magda','Вулиця','Magda Модель №814','Сталь, МДФ та заводські покриття','Для будинку або офісу','Заводські декори','Ціна за запитом','Magda Модель №814 — металеві вхідні двері для будинку або офісу зі склопакетом. Модель доступна з різними типами фурнітури.',jsonb_build_array('Офіційна модель Magda','Для будинку або офісу','Склопакет'),'https://magda.com.ua/storage/app/uploads/public/23e/30c/d27/thumb__0_0_0_0_auto.jpg',99022,false),
('magda-710-grid-027-official','entrance','Magda','Вулиця','Magda Модель №710 решітка 027','Сталь, МДФ та заводські покриття','Для будинку','Заводські декори','Ціна за запитом','Magda Модель №710 решітка 027 — металеві вхідні двері зі склопакетом і декоративною решіткою. Можлива комплектація чорною або хромованою фурнітурою.',jsonb_build_array('Офіційна модель Magda','Для будинку','Склопакет','Декоративна решітка'),'https://magda.com.ua/storage/app/uploads/public/20f/a2d/4f4/thumb__0_0_0_0_auto.jpg',99023,false)
on conflict (slug) do update set collection=excluded.collection,name=excluded.name,material=excluded.material,style=excluded.style,color=excluded.color,description=excluded.description,features=excluded.features,image_path=excluded.image_path,updated_at=now();

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
('magda-515ph-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/515ph','Модель №515ПХ','verified',now(),'Офіційна картка виробника'),
('magda-508-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/508','Модель №508','verified',now(),'Офіційна картка виробника'),
('magda-815-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/t-40-pch-sklopaket-strukturnij','Модель №815','verified',now(),'Офіційна картка виробника'),
('magda-146pch-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/146-pch','Модель №146 ПЧ','verified',now(),'Офіційна картка виробника'),
('magda-814-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/t-15-pch-ps-1','Модель №814','verified',now(),'Офіційна картка виробника'),
('magda-710-grid-027-official','Офіційний каталог Magda','https://magda.com.ua/uk/catalog/item/t-16-pch-kovka-027','Модель №710 решітка 027','verified',now(),'Офіційна картка виробника')
on conflict (product_slug,source_url) do update set source_product_name=excluded.source_product_name,verification_status=excluded.verification_status,verified_at=excluded.verified_at,notes=excluded.notes;

insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values
('magda-515ph-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/aad/427/978/thumb__0_0_0_0_auto.jpg',1,true),
('magda-508-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/559/3d4/b11/thumb__0_0_0_0_auto.jpg',1,true),
('magda-815-official','gallery','Фото 1','https://magda.com.ua/storage/app/uploads/public/626/f82/078/thumb__0_0_0_0_auto.jpg',1,true),
('magda-815-official','gallery','Фото 2','https://magda.com.ua/storage/app/uploads/public/f0d/ee0/14d/thumb__0_0_0_0_auto.jpg',2,true),
('magda-815-official','gallery','Фото 3','https://magda.com.ua/storage/app/uploads/public/b4c/950/082/thumb__0_0_0_0_auto.jpg',3,true),
('magda-146pch-official','gallery','Фото 1','https://magda.com.ua/storage/app/uploads/public/90d/cf3/c93/thumb__0_0_0_0_auto.jpg',1,true),
('magda-146pch-official','gallery','Фото 2','https://magda.com.ua/storage/app/uploads/public/491/cf2/732/thumb__0_0_0_0_auto.jpg',2,true),
('magda-814-official','gallery','Фото 1','https://magda.com.ua/storage/app/uploads/public/23e/30c/d27/thumb__0_0_0_0_auto.jpg',1,true),
('magda-814-official','gallery','Фото 2','https://magda.com.ua/storage/app/uploads/public/b3c/49d/e79/thumb__0_0_0_0_auto.jpg',2,true),
('magda-710-grid-027-official','gallery','Головне фото','https://magda.com.ua/storage/app/uploads/public/20f/a2d/4f4/thumb__0_0_0_0_auto.jpg',1,true)
on conflict (product_slug,kind,image_path) do update set label=excluded.label,sort_order=excluded.sort_order,is_active=excluded.is_active;

insert into public.product_specs (product_slug,label,value,sort_order,is_active)
select slug,label,value,sort_order,true from (values
('magda-515ph-official','Доступні типи комплектації','Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13',10),
('magda-508-official','Доступні типи комплектації','Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13',10),
('magda-815-official','Доступний тип комплектації','Тип 4 з терморозривом',10),
('magda-146pch-official','Доступні типи комплектації','Тип 2.24 (2.24 Kale), Тип 3.23, Тип 5, Тип 13, Тип 12.2',10),
('magda-814-official','Доступний тип комплектації','Тип 15',10),
('magda-710-grid-027-official','Доступний тип комплектації','Тип 16',10),
('magda-515ph-official','Товщина полотна','90 мм залежно від типу комплектації',20),
('magda-508-official','Товщина полотна','90 мм залежно від типу комплектації',20),
('magda-146pch-official','Товщина полотна','90 мм залежно від типу комплектації',20)
) as v(slug,label,value,sort_order)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=excluded.is_active;

commit;

select p.slug,p.name as "модель",p.collection as "колекція",p.is_available as "опубліковано",count(m.id) filter(where m.kind='gallery' and m.is_active) as "фото_в_галереї",count(s.id) filter(where s.verification_status='verified') as "офіційних_джерел"
from public.products p left join public.product_media m on m.product_slug=p.slug left join public.product_sources s on s.product_slug=p.slug
where p.slug in ('magda-515ph-official','magda-508-official','magda-815-official','magda-146pch-official','magda-814-official','magda-710-grid-027-official')
group by p.slug,p.name,p.collection,p.is_available order by p.name;
