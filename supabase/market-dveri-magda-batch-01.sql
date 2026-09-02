-- Market Dveri — Magda: точні моделі 711.1 і 945.
-- Скрипт можна безпечно запускати повторно.

update public.products as product
set description=source.description
from (values
 ('catalog-52','Magda 711.1 — вхідні двері для будинку зі склом і терморозривом 15 мм. Полотно 100 мм, три контури примикання, гнутий профіль коробу та замки Securemme забезпечують високий рівень тепла, тиші й захисту.'),
 ('catalog-53','Magda 945 — вхідні двері для будинку зі склом і терморозривом 15 мм. МДФ-накладки з обох боків, полотно 100 мм, три контури примикання та замки Securemme поєднують сучасний дизайн і надійну конструкцію.')
) as source(slug,description) where product.slug=source.slug;

insert into public.product_media (product_slug,kind,label,image_path,sort_order) values
 ('catalog-52','main','Magda 711.1 ТЧ','https://market-dveri.ua/image/catalog/product/vhidni-dveri/magda/225037/dveri-711-1-tch-magda-main.jpg',0),
 ('catalog-53','main','Magda 945/655 ТЧ','https://market-dveri.ua/image/catalog/product/vhidni-dveri/magda/225036/dveri-945-655-tch-magda-main.jpg',0)
on conflict (product_slug,kind,image_path) do update set label=excluded.label,sort_order=excluded.sort_order;

insert into public.product_options (product_slug,option_group,group_label,label,image_path,sort_order) values
 ('catalog-52','color','Декор полотна','ТЧ','https://market-dveri.ua/image/catalog/product/vhidni-dveri/magda/225037/dveri-711-1-tch-magda-main.jpg',1),
 ('catalog-52','color','Декор полотна','Дуб бронзовий','https://market-dveri.ua/image/catalog/product/vhidni-dveri/magda/225038/dveri-711-1-tch-dub-bronzovij-magda-main.jpg',2)
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;

insert into public.product_variants (product_slug,selections,image_path,sort_order) values
 ('catalog-52','{"color":"ТЧ"}'::jsonb,'https://market-dveri.ua/image/catalog/product/vhidni-dveri/magda/225037/dveri-711-1-tch-magda-main.jpg',1),
 ('catalog-52','{"color":"Дуб бронзовий"}'::jsonb,'https://market-dveri.ua/image/catalog/product/vhidni-dveri/magda/225038/dveri-711-1-tch-dub-bronzovij-magda-main.jpg',2)
on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;

insert into public.product_specs (product_slug,label,value,sort_order)
select product_slug,label,value,sort_order from unnest(array['catalog-52','catalog-53']) as products(product_slug)
cross join (values
 ('Призначення','Для будинку',100),('Розмір блоку','960 × 2050 мм',110),('Оздоблення','МДФ-накладки з обох боків',120),('Стиль','Модерн',130),('Глибина коробу','115 мм',140),('Товщина полотна','100 мм',150),('Товщина металу','1,2 мм',160),('Верхній замок','Securemme',170),('Нижній замок','Securemme',180),('Додатково','3 петлі, скло',190),('Конструкція коробу','Терморозрив 15 мм',200),('Контури примикання','3 контури',210),('Шумоізоляція','Високий рівень',220),('Теплоізоляція','Висока',230)) as shared(label,value,sort_order)
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
 ('catalog-52','Market Dveri','https://market-dveri.ua/uk/dveri-711-1-tch-magda/','Magda 711.1 ТЧ','verified',now(),'Номер моделі, призначення, фото та характеристики збігаються.'),
 ('catalog-53','Market Dveri','https://market-dveri.ua/uk/dveri-945-655-tch-magda/','Magda 945/655 ТЧ','verified',now(),'Номер моделі, призначення, фото та характеристики збігаються.')
on conflict (product_slug,source_url) do update set source_name=excluded.source_name,source_product_name=excluded.source_product_name,verification_status=excluded.verification_status,verified_at=excluded.verified_at,notes=excluded.notes;
