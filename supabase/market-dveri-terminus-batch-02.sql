-- Market Dveri — пакет 02: Terminus Frezato.
-- 16 моделей з прямим збігом номера та колекції.
-- Скрипт можна безпечно запускати повторно.

update public.products as product
set description = format(
  'Термінус Frezato %s — фарбовані міжкімнатні двері в сучасному дизайні. МДФ-плити на каркасі, полотно 44 мм, приховані петлі та телескопічний або компланарний погонаж поєднують акуратний вигляд і практичність.',
  source.model
)
from (values
  ('catalog-303', '24.1'), ('catalog-304', '24.2'), ('catalog-305', '24.3'), ('catalog-306', '24.4'), ('catalog-307', '24.5'),
  ('catalog-310', '705.1'), ('catalog-311', '705.2'), ('catalog-312', '705.3'), ('catalog-313', '705.4'),
  ('catalog-314', '706.1'), ('catalog-315', '706.2'), ('catalog-316', '706.3'),
  ('catalog-317', '707.1'), ('catalog-318', '707.2'), ('catalog-319', '707.3'), ('catalog-320', '707.4')
) as source(slug, model)
where product.slug = source.slug;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-303', 'main', 'Термінус Frezato 24.1', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215325/dveri-terminus-frezato-24-1-main.jpg', 0),
  ('catalog-304', 'main', 'Термінус Frezato 24.2', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215326/dveri-terminus-frezato-24-2-main.jpg', 0),
  ('catalog-305', 'main', 'Термінус Frezato 24.3', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215327/dveri-terminus-frezato-24-3-main.jpg', 0),
  ('catalog-306', 'main', 'Термінус Frezato 24.4', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215328/dveri-terminus-frezato-24-4-main.jpg', 0),
  ('catalog-307', 'main', 'Термінус Frezato 24.5', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/215329/dveri-terminus-frezato-24-5-main.jpg', 0),
  ('catalog-310', 'main', 'Термінус Frezato 705.1', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27130/dveri-terminus-frezato-705-1-main.jpg', 0),
  ('catalog-311', 'main', 'Термінус Frezato 705.2', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27131/dveri-terminus-frezato-705-2-main.jpg', 0),
  ('catalog-312', 'main', 'Термінус Frezato 705.3', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27132/dveri-terminus-frezato-705-3-main.jpg', 0),
  ('catalog-313', 'main', 'Термінус Frezato 705.4', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27133/dveri-terminus-frezato-705-4-main.jpg', 0),
  ('catalog-314', 'main', 'Термінус Frezato 706.1', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27134/dveri-terminus-frezato-706-1-main.jpg', 0),
  ('catalog-315', 'main', 'Термінус Frezato 706.2', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27135/dveri-terminus-frezato-706-2-main.jpg', 0),
  ('catalog-316', 'main', 'Термінус Frezato 706.3', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27136/dveri-terminus-frezato-706-3-main.jpg', 0),
  ('catalog-317', 'main', 'Термінус Frezato 707.1', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27137/dveri-terminus-frezato-707-1-main.jpg', 0),
  ('catalog-318', 'main', 'Термінус Frezato 707.2', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27138/dveri-terminus-frezato-707-2-main.jpg', 0),
  ('catalog-319', 'main', 'Термінус Frezato 707.3', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27139/dveri-terminus-frezato-707-3-main.jpg', 0),
  ('catalog-320', 'main', 'Термінус Frezato 707.4', 'https://market-dveri.ua/image/catalog/product/mizhkimnatni-dveri/terminus/27140/dveri-terminus-frezato-707-4-main.jpg', 0)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (select 1 from public.product_media as existing where existing.product_slug = media.product_slug and existing.image_path = media.image_path);

insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from unnest(array[
  'catalog-303','catalog-304','catalog-305','catalog-306','catalog-307','catalog-310','catalog-311','catalog-312',
  'catalog-313','catalog-314','catalog-315','catalog-316','catalog-317','catalog-318','catalog-319','catalog-320'
]) as products(product_slug)
cross join (values
  ('Покриття', 'Фарба', 100), ('Наповнення', 'МДФ-плити на каркасі', 110), ('Скло', 'Глухі', 120), ('Стиль', 'Модерн, хай-тек', 130),
  ('Розміри полотна', '600 / 700 / 800 / 900 мм', 140), ('Висота полотна', '2000 мм', 150), ('Товщина полотна', '44 мм', 160),
  ('Відкривання', 'Розпашні, одностулкові', 170), ('Торець полотна', 'Окутаний без стиків', 180),
  ('Погонаж', 'Телескопічний, компланарний', 190), ('Можливість підрізки', 'Немає', 200), ('Додатково', 'Приховані петлі', 210),
  ('Шумоізоляція', 'Середня', 220), ('Країна виробник', 'Україна', 230), ('Місто виробник', 'Вінниця', 240)
) as shared(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('catalog-303', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-24-1-terminus/', 'Terminus Frezato 24-1', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-304', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-24-2-terminus/', 'Terminus Frezato 24-2', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-305', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-24-3-terminus/', 'Terminus Frezato 24-3', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-306', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-24-4-terminus/', 'Terminus Frezato 24-4', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-307', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-24-5-terminus/', 'Terminus Frezato 24-5', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-310', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-705-1-terminus/', 'Terminus Frezato 705-1', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-311', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-705-2-terminus/', 'Terminus Frezato 705-2', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-312', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-705-3-terminus/', 'Terminus Frezato 705-3', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-313', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-705-4-terminus/', 'Terminus Frezato 705-4', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-314', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-706-1-terminus/', 'Terminus Frezato 706-1', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-315', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-706-2-terminus/', 'Terminus Frezato 706-2', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-316', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-706-3-terminus/', 'Terminus Frezato 706-3', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-317', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-707-1-terminus/', 'Terminus Frezato 707-1', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-318', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-707-2-terminus/', 'Terminus Frezato 707-2', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-319', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-707-3-terminus/', 'Terminus Frezato 707-3', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.'),
  ('catalog-320', 'Market Dveri', 'https://market-dveri.ua/uk/dveri-707-4-terminus/', 'Terminus Frezato 707-4', 'verified', now(), 'Номер моделі, колекція, фото та характеристики збігаються.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;
