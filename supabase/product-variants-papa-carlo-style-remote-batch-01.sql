-- Papa Carlo Style: офіційні URL фото замість ручного завантаження у Storage.
-- Для кожної моделі додано першу точно підтверджену комбінацію «колір + кромка».
-- Джерело: прямий конфігуратор Papa Carlo, перевірено 01.09.2026.
-- Скрипт можна виконувати повторно.

update public.product_variants as variant
set image_path = source.image_path,
    is_active = true
from (values
  ('catalog-113', 1227, 'https://papa-carlo.com.ua/assets/cache/images/c/c2609c69b498047c4f1aae41d2ce36df.jpg'),
  ('catalog-114', 2054, 'https://papa-carlo.com.ua/assets/cache/images/f/f84f9625c73abac4633b99c3f656e70b.jpg'),
  ('catalog-115', 2073, 'https://papa-carlo.com.ua/assets/cache/images/1/1b60484818f4204f082960e9c9a219fe.jpg'),
  ('catalog-116', 2398, 'https://papa-carlo.com.ua/assets/cache/images/0/05610ddf03cd58fd42fac232b8cb0e42.jpg'),
  ('catalog-117', 2414, 'https://papa-carlo.com.ua/assets/cache/images/f/fc58453c5b5afa906e3f2a8c0cdf9aa4.jpg'),
  ('catalog-118', 2430, 'https://papa-carlo.com.ua/assets/cache/images/7/77f57c8cecbdd39bdd55b0c067a7f47b.jpg')
) as source(product_slug, sort_order, image_path)
where variant.product_slug = source.product_slug
  and variant.sort_order = source.sort_order;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  ('catalog-113', 'Papa Carlo', 'https://papa-carlo.com.ua/ua/dverne-polotno-st-04/', 'Дверне полотно ST-04', 'verified', now(), 'Офіційний конфігуратор; підтверджено фото варіанта 1227.'),
  ('catalog-114', 'Papa Carlo', 'https://papa-carlo.com.ua/ua/dverne-polotno-st-25/', 'Дверне полотно ST-25', 'verified', now(), 'Офіційний конфігуратор; підтверджено фото варіанта 2054.'),
  ('catalog-115', 'Papa Carlo', 'https://papa-carlo.com.ua/ua/dverne-polotno-st-26/', 'Дверне полотно ST-26', 'verified', now(), 'Офіційний конфігуратор; підтверджено фото варіанта 2073.'),
  ('catalog-116', 'Papa Carlo', 'https://papa-carlo.com.ua/ua/dverne-polotno-st-33/', 'Дверне полотно ST-33', 'verified', now(), 'Офіційний конфігуратор; підтверджено фото варіанта 2398.'),
  ('catalog-117', 'Papa Carlo', 'https://papa-carlo.com.ua/ua/dverne-polotno-st-34/', 'Дверне полотно ST-34', 'verified', now(), 'Офіційний конфігуратор; підтверджено фото варіанта 2414.'),
  ('catalog-118', 'Papa Carlo', 'https://papa-carlo.com.ua/ua/dverne-polotno-st-35/', 'Дверне полотно ST-35', 'verified', now(), 'Офіційний конфігуратор; підтверджено фото варіанта 2430.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
