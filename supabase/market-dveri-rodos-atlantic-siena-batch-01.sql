-- Market Dveri — Rodos Atlantic та Siena: точні картки моделей.
-- Перевірено 03.09.2026: модель, тип полотна та головне фото збігаються.
-- Ціни навмисно не імпортуються. Скрипт можна запускати повторно.

with source(slug, description, label, image_path, source_url, source_product_name, leaf_type, coating) as (
  values
    ('catalog-180','Rodos Atlantic A001 ПО — міжкімнатні двері з ПВХ-покриттям та заскленим полотном. Практичне рішення для житлових приміщень із телескопічним або компланарним погонажем.','Atlantic A001 ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27046/dveri-rodos-atlantic-a001-po-main.jpg','https://market-dveri.ua/uk/dveri-a001-po-rodos/','Rodos Atlantic A001 ПО','Зі склом','ПВХ плівка'),
    ('catalog-181','Rodos Atlantic A001 ПГ — глухі міжкімнатні двері з практичним ПВХ-покриттям. Полотно 44 мм, доступний телескопічний або компланарний погонаж.','Atlantic A001 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27045/dveri-rodos-atlantic-a001-pg-main.jpg','https://market-dveri.ua/uk/dveri-a001-pg-rodos/','Rodos Atlantic A001 ПГ','Глухе','ПВХ плівка'),
    ('catalog-182','Rodos Atlantic A002 ПГ — глухі міжкімнатні двері з ПВХ-покриттям. Модель у колекції Atlantic з полотном 44 мм та можливістю підрізки.','Atlantic A002 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27047/dveri-rodos-atlantic-a002-pg-main.jpg','https://market-dveri.ua/uk/dveri-a002-pg-rodos/','Rodos Atlantic A002 ПГ','Глухе','ПВХ плівка'),
    ('catalog-183','Rodos Atlantic A002 напівскло — міжкімнатні двері з ПВХ-покриттям і частковим заскленням. Полотно 44 мм для стандартних прорізів.','Atlantic A002 напівскло','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27048/dveri-rodos-atlantic-a002-napivsklo-main.jpg','https://market-dveri.ua/uk/dveri-a002-napivsklo-rodos/','Rodos Atlantic A002 напівскло','Напівскло','ПВХ плівка'),
    ('catalog-184','Rodos Atlantic A002 ПО — міжкімнатні двері з ПВХ-покриттям та заскленим полотном. Практичне рішення для інтер’єру в стилі прованс.','Atlantic A002 ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27049/dveri-rodos-atlantic-a002-po-main.jpg','https://market-dveri.ua/uk/dveri-a002-po-rodos/','Rodos Atlantic A002 ПО','Зі склом','ПВХ плівка'),
    ('catalog-185','Rodos Atlantic A003 ПГ — глухі міжкімнатні двері з ПВХ-покриттям. Полотно 44 мм, доступне в типових ширинах і з можливістю підрізки.','Atlantic A003 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27050/dveri-rodos-atlantic-a003-pg-main.jpg','https://market-dveri.ua/uk/dveri-a003-pg-rodos/','Rodos Atlantic A003 ПГ','Глухе','ПВХ плівка'),
    ('catalog-187','Rodos Atlantic A004 ПГ — глухі міжкімнатні двері з ПВХ-покриттям. Модель Atlantic із полотном 44 мм та телескопічним або компланарним погонажем.','Atlantic A004 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27052/dveri-rodos-atlantic-a004-pg-main.jpg','https://market-dveri.ua/uk/dveri-a004-pg-rodos/','Rodos Atlantic A004 ПГ','Глухе','ПВХ плівка'),
    ('catalog-188','Rodos Atlantic A004 напівскло — міжкімнатні двері з ПВХ-покриттям і частковим заскленням. Полотно 44 мм для стандартних прорізів.','Atlantic A004 напівскло','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27053/dveri-rodos-atlantic-a004-napivsklo-main.jpg','https://market-dveri.ua/uk/dveri-a004-napivsklo-rodos/','Rodos Atlantic A004 напівскло','Напівскло','ПВХ плівка'),
    ('catalog-189','Rodos Atlantic A004 ПО — міжкімнатні двері з ПВХ-покриттям та заскленим полотном. Практичне рішення для інтер’єру в стилі прованс.','Atlantic A004 ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27054/dveri-rodos-atlantic-a004-po-main.jpg','https://market-dveri.ua/uk/dveri-a004-po-rodos/','Rodos Atlantic A004 ПО','Зі склом','ПВХ плівка'),
    ('catalog-190','Rodos Atlantic A005 ПГ — глухі міжкімнатні двері з ПВХ-покриттям. Полотно 44 мм, можливі типові ширини та підрізка до 20 мм.','Atlantic A005 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27055/dveri-rodos-atlantic-a005-pg-main.jpg','https://market-dveri.ua/uk/dveri-a005-pg-rodos/','Rodos Atlantic A005 ПГ','Глухе','ПВХ плівка'),
    ('catalog-191','Rodos Atlantic A005 ПО — міжкімнатні двері з ПВХ-покриттям та заскленим полотном. Модель Atlantic з практичним полотном 44 мм.','Atlantic A005 ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27056/dveri-rodos-atlantic-a005-po-main.jpg','https://market-dveri.ua/uk/dveri-a005-po-rodos/','Rodos Atlantic A005 ПО','Зі склом','ПВХ плівка'),
    ('catalog-192','Rodos Atlantic A006 ПГ — глухі міжкімнатні двері з ПВХ-покриттям. Полотно 44 мм, телескопічний або компланарний погонаж.','Atlantic A006 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27057/dveri-rodos-atlantic-a006-pg-main.jpg','https://market-dveri.ua/uk/dveri-a006-pg-rodos/','Rodos Atlantic A006 ПГ','Глухе','ПВХ плівка'),
    ('catalog-193','Rodos Atlantic A006 ПО — міжкімнатні двері з ПВХ-покриттям та заскленим полотном. Практичне рішення для інтер’єру в стилі прованс.','Atlantic A006 ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27058/dveri-rodos-atlantic-a006-po-main.jpg','https://market-dveri.ua/uk/dveri-a006-po-rodos/','Rodos Atlantic A006 ПО','Зі склом','ПВХ плівка'),
    ('catalog-240','Rodos Siena Asti ПО — пофарбовані міжкімнатні двері з заскленим полотном. Класична колекція Siena з полотном 44 мм.','Siena Asti ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27060/dveri-rodos-siena-asti-po-main.jpg','https://market-dveri.ua/uk/dveri-siena-asti-po-rodos/','Rodos Siena Asti ПО','Зі склом','Фарба'),
    ('catalog-241','Rodos Siena Asti ПГ — глухі пофарбовані міжкімнатні двері класичної колекції Siena. Полотно 44 мм для стандартних прорізів.','Siena Asti ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27059/dveri-rodos-siena-asti-pg-main.jpg','https://market-dveri.ua/uk/dveri-siena-asti-pg-rodos/','Rodos Siena Asti ПГ','Глухе','Фарба'),
    ('catalog-242','Rodos Siena Laura ПО — пофарбовані міжкімнатні двері з заскленим полотном. Класична модель Siena з полотном 44 мм.','Siena Laura ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27063/dveri-rodos-siena-laura-po-main.jpg','https://market-dveri.ua/uk/dveri-siena-laura-po-rodos/','Rodos Siena Laura ПО','Зі склом','Фарба'),
    ('catalog-243','Rodos Siena Laura ПГ — глухі пофарбовані міжкімнатні двері класичної колекції Siena. Полотно 44 мм для стандартних прорізів.','Siena Laura ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27062/dveri-rodos-siena-laura-pg-main.jpg','https://market-dveri.ua/uk/dveri-siena-laura-pg-rodos/','Rodos Siena Laura ПГ','Глухе','Фарба'),
    ('catalog-245','Rodos Siena Rossi ПГ — глухі пофарбовані міжкімнатні двері класичної колекції Siena. Полотно 44 мм для стандартних прорізів.','Siena Rossi ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27065/dveri-rodos-siena-rossi-pg-main.jpg','https://market-dveri.ua/uk/dveri-siena-rossi-pg-rodos/','Rodos Siena Rossi ПГ','Глухе','Фарба')
)
update public.products as product
set description = source.description, image_path = source.image_path
from source
where product.slug = source.slug;

with source(slug, label, image_path) as (
  values
    ('catalog-180','Atlantic A001 ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27046/dveri-rodos-atlantic-a001-po-main.jpg'),('catalog-181','Atlantic A001 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27045/dveri-rodos-atlantic-a001-pg-main.jpg'),('catalog-182','Atlantic A002 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27047/dveri-rodos-atlantic-a002-pg-main.jpg'),('catalog-183','Atlantic A002 напівскло','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27048/dveri-rodos-atlantic-a002-napivsklo-main.jpg'),('catalog-184','Atlantic A002 ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27049/dveri-rodos-atlantic-a002-po-main.jpg'),('catalog-185','Atlantic A003 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27050/dveri-rodos-atlantic-a003-pg-main.jpg'),('catalog-187','Atlantic A004 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27052/dveri-rodos-atlantic-a004-pg-main.jpg'),('catalog-188','Atlantic A004 напівскло','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27053/dveri-rodos-atlantic-a004-napivsklo-main.jpg'),('catalog-189','Atlantic A004 ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27054/dveri-rodos-atlantic-a004-po-main.jpg'),('catalog-190','Atlantic A005 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27055/dveri-rodos-atlantic-a005-pg-main.jpg'),('catalog-191','Atlantic A005 ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27056/dveri-rodos-atlantic-a005-po-main.jpg'),('catalog-192','Atlantic A006 ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27057/dveri-rodos-atlantic-a006-pg-main.jpg'),('catalog-193','Atlantic A006 ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27058/dveri-rodos-atlantic-a006-po-main.jpg'),('catalog-240','Siena Asti ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27060/dveri-rodos-siena-asti-po-main.jpg'),('catalog-241','Siena Asti ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27059/dveri-rodos-siena-asti-pg-main.jpg'),('catalog-242','Siena Laura ПО','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27063/dveri-rodos-siena-laura-po-main.jpg'),('catalog-243','Siena Laura ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27062/dveri-rodos-siena-laura-pg-main.jpg'),('catalog-245','Siena Rossi ПГ','https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/rodos/27065/dveri-rodos-siena-rossi-pg-main.jpg')
)
update public.product_media as media
set image_path = source.image_path, label = source.label, sort_order = 0, is_active = true
from source
where media.product_slug = source.slug and media.kind = 'main';

with models(product_slug, leaf_type, coating, sort_base) as (
  values
    ('catalog-180','Зі склом','ПВХ плівка',100),('catalog-181','Глухе','ПВХ плівка',100),('catalog-182','Глухе','ПВХ плівка',100),('catalog-183','Напівскло','ПВХ плівка',100),('catalog-184','Зі склом','ПВХ плівка',100),('catalog-185','Глухе','ПВХ плівка',100),('catalog-187','Глухе','ПВХ плівка',100),('catalog-188','Напівскло','ПВХ плівка',100),('catalog-189','Зі склом','ПВХ плівка',100),('catalog-190','Глухе','ПВХ плівка',100),('catalog-191','Зі склом','ПВХ плівка',100),('catalog-192','Глухе','ПВХ плівка',100),('catalog-193','Зі склом','ПВХ плівка',100),('catalog-240','Зі склом','Фарба',100),('catalog-241','Глухе','Фарба',100),('catalog-242','Зі склом','Фарба',100),('catalog-243','Глухе','Фарба',100),('catalog-245','Глухе','Фарба',100)
), specs(product_slug,label,value,sort_order) as (
  select product_slug,'Тип виробу','Міжкімнатні двері',sort_base from models
  union all select product_slug,'Тип полотна',leaf_type,sort_base+10 from models
  union all select product_slug,'Покриття',coating,sort_base+20 from models
  union all select product_slug,'Товщина полотна','44 мм',sort_base+30 from models
  union all select product_slug,'Доступні ширини','600 / 700 / 800 / 900 мм',sort_base+40 from models
  union all select product_slug,'Висота полотна','2000 мм',sort_base+50 from models
  union all select product_slug,'Відкривання','Розпашні, одностулкові',sort_base+60 from models
  union all select product_slug,'Погонаж','Телескопічний або компланарний',sort_base+70 from models
  union all select product_slug,'Підрізка полотна','До 20 мм',sort_base+80 from models
  union all select product_slug,'Країна виробництва','Україна',sort_base+90 from models
)
insert into public.product_specs (product_slug,label,value,sort_order)
select product_slug,label,value,sort_order from specs
on conflict (product_slug,label) do update
set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
  ('catalog-180','Market Dveri','https://market-dveri.ua/uk/dveri-a001-po-rodos/','Rodos Atlantic A001 ПО','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-181','Market Dveri','https://market-dveri.ua/uk/dveri-a001-pg-rodos/','Rodos Atlantic A001 ПГ','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-182','Market Dveri','https://market-dveri.ua/uk/dveri-a002-pg-rodos/','Rodos Atlantic A002 ПГ','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-183','Market Dveri','https://market-dveri.ua/uk/dveri-a002-napivsklo-rodos/','Rodos Atlantic A002 напівскло','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-184','Market Dveri','https://market-dveri.ua/uk/dveri-a002-po-rodos/','Rodos Atlantic A002 ПО','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-185','Market Dveri','https://market-dveri.ua/uk/dveri-a003-pg-rodos/','Rodos Atlantic A003 ПГ','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-187','Market Dveri','https://market-dveri.ua/uk/dveri-a004-pg-rodos/','Rodos Atlantic A004 ПГ','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-188','Market Dveri','https://market-dveri.ua/uk/dveri-a004-napivsklo-rodos/','Rodos Atlantic A004 напівскло','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-189','Market Dveri','https://market-dveri.ua/uk/dveri-a004-po-rodos/','Rodos Atlantic A004 ПО','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-190','Market Dveri','https://market-dveri.ua/uk/dveri-a005-pg-rodos/','Rodos Atlantic A005 ПГ','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-191','Market Dveri','https://market-dveri.ua/uk/dveri-a005-po-rodos/','Rodos Atlantic A005 ПО','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-192','Market Dveri','https://market-dveri.ua/uk/dveri-a006-pg-rodos/','Rodos Atlantic A006 ПГ','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-193','Market Dveri','https://market-dveri.ua/uk/dveri-a006-po-rodos/','Rodos Atlantic A006 ПО','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-240','Market Dveri','https://market-dveri.ua/uk/dveri-siena-asti-po-rodos/','Rodos Siena Asti ПО','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-241','Market Dveri','https://market-dveri.ua/uk/dveri-siena-asti-pg-rodos/','Rodos Siena Asti ПГ','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-242','Market Dveri','https://market-dveri.ua/uk/dveri-siena-laura-po-rodos/','Rodos Siena Laura ПО','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-243','Market Dveri','https://market-dveri.ua/uk/dveri-siena-laura-pg-rodos/','Rodos Siena Laura ПГ','verified',now(),'Модель, тип полотна та головне фото збігаються.'),
  ('catalog-245','Market Dveri','https://market-dveri.ua/uk/dveri-siena-rossi-pg-rodos/','Rodos Siena Rossi ПГ','verified',now(),'Модель, тип полотна та головне фото збігаються.')
on conflict (product_slug,source_url) do update
set source_name=excluded.source_name, source_product_name=excluded.source_product_name,
    verification_status=excluded.verification_status, verified_at=excluded.verified_at, notes=excluded.notes;
