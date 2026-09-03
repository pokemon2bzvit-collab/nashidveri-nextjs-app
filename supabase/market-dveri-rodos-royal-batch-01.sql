-- Market Dveri — Rodos Royal Avalon: точні фото двох моделей зі шпоном.
-- Перевірено 03.09.2026. Скрипт можна запускати повторно; ціни не імпортуються.

with source(slug,label,image_path,description) as (
 values
 ('catalog-238','Royal Avalon · напівскло · шпон','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/21613/dveri-rodos-royal-avalon-napivsklo-shpon-main.jpg','Rodos Royal Avalon напівскло — міжкімнатні двері з натуральним шпоном та частковим заскленням.'),
 ('catalog-239','Royal Avalon · глухе · шпон','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/21612/dveri-rodos-royal-avalon-pg-shpon-main.jpg','Rodos Royal Avalon ПГ — глухі міжкімнатні двері з натуральним шпоном.')
)
update public.products as product set description=source.description,image_path=source.image_path from source where product.slug=source.slug;

with source(slug,label,image_path) as (values
 ('catalog-238','Royal Avalon · напівскло · шпон','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/21613/dveri-rodos-royal-avalon-napivsklo-shpon-main.jpg'),
 ('catalog-239','Royal Avalon · глухе · шпон','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/21612/dveri-rodos-royal-avalon-pg-shpon-main.jpg')
)
update public.product_media as media set image_path=source.image_path,label=source.label,sort_order=0,is_active=true from source where media.product_slug=source.slug and media.kind='main';

insert into public.product_specs(product_slug,label,value,sort_order) values
 ('catalog-238','Тип виробу','Міжкімнатні двері',100),('catalog-238','Тип полотна','Напівскло',110),('catalog-238','Покриття','Натуральний шпон',120),('catalog-238','Товщина полотна','44 мм',130),('catalog-238','Доступні ширини','600 / 700 / 800 / 900 мм',140),('catalog-238','Висота полотна','2000 мм',150),('catalog-238','Відкривання','Розпашні, одностулкові',160),('catalog-238','Країна виробництва','Україна',170),
 ('catalog-239','Тип виробу','Міжкімнатні двері',100),('catalog-239','Тип полотна','Глухе',110),('catalog-239','Покриття','Натуральний шпон',120),('catalog-239','Товщина полотна','44 мм',130),('catalog-239','Доступні ширини','600 / 700 / 800 / 900 мм',140),('catalog-239','Висота полотна','2000 мм',150),('catalog-239','Відкривання','Розпашні, одностулкові',160),('catalog-239','Країна виробництва','Україна',170)
on conflict(product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;

insert into public.product_sources(product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
 ('catalog-238','Market Dveri','https://market-dveri.ua/uk/avalon-polusteklo-shpon-21613/','Rodos Royal Avalon Напівскло Шпон','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
 ('catalog-239','Market Dveri','https://market-dveri.ua/uk/avalon-pg-shpon-21612/','Rodos Royal Avalon ПГ шпон','verified',now(),'Модель, тип полотна та головне фото збігаються.')
on conflict(product_slug,source_url) do update set source_name=excluded.source_name,source_product_name=excluded.source_product_name,verification_status=excluded.verification_status,verified_at=excluded.verified_at,notes=excluded.notes;
