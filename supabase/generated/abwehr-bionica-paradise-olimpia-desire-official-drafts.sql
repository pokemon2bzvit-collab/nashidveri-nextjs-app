-- ABWEHR BIONICA COMBO: Paradise, Olimpia and Desire constructions as hidden drafts.
-- These are distinct models or structural versions from the official catalogue.
-- No existing product is deleted, changed, or published.

begin;

create temporary table abwehr_bionica_paradise_olimpia_desire (
  slug text primary key,
  name text not null,
  product_code text not null,
  source_url text not null,
  construction_type text not null,
  main_image text not null
) on commit drop;

insert into abwehr_bionica_paradise_olimpia_desire values
  ('abwehr-bionica-paradise', 'Abwehr Paradise', 'LP1', 'https://abwehr.com.ua/catalog/dveri-z-termorozrivom-model-paradise-komplektaciya-bionica-combo/p1382', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/99C8qrWwJCwgEfgbUUMEzo9pUzrvIiZCR8XUhxCq.jpg.webp?v=1777376263'),
  ('abwehr-bionica-paradise-king-size-1200', 'Abwehr Paradise King Size 1200', 'LP1', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-paradise-king-size-komplektaciya-bionica-combo-1200/p1339', 'Нестандартні двері King Size', 'https://abwehr.com.ua/storage/products/images/big/dLRbo9OCCfqaiN4aShCea8fYpGeJklGX9ZpFvs4S.jpg.webp?v=1771581995'),
  ('abwehr-bionica-paradise-glass-1200', 'Abwehr Paradise Glass 1200', 'LP1', 'https://abwehr.com.ua/catalog/polutorni-dveri-z-termorozrivom-model-paradise-glass-komplektaciya-bionica-combo-1200/p1157', 'Напівторастулкові двері 1200 мм зі склопакетом', 'https://abwehr.com.ua/storage/products/images/big/P9sQhhhkwM5tVOt62Jc0uCVPHcWd4WdYKtagcXg1.jpg.webp?v=1781517517'),
  ('abwehr-bionica-olimpia-glass', 'Abwehr Olimpia Glass', 'LP3', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-olimpia-glass-komplektaciya-bionica-combo/p1386', 'Вхідні двері зі склопакетом для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/wzcxrHKyVSn05d7iJjle24cm2ZzzpNMOaQBGghjw.jpg.webp?v=1777281081'),
  ('abwehr-bionica-olimpia-1200', 'Abwehr Olimpia 1200', 'LP3', 'https://abwehr.com.ua/catalog/polutorni-dveri-z-termorozrivom-model-olimpia-komplektaciya-bionica-combo-1200/p1251', 'Напівторастулкові двері 1200 мм', 'https://abwehr.com.ua/storage/products/images/big/STYz39EJbUlnThcGksmQtSvwoWAwAilxjh7unywu.jpg.webp?v=1781516678'),
  ('abwehr-bionica-desire-1200', 'Abwehr Desire 1200', '0', 'https://abwehr.com.ua/catalog/vhidni-polutorni-dveri-model-desire-komplektaciya-bionica-combo-1200/p1607', 'Напівторастулкові двері 1200 мм', 'https://abwehr.com.ua/storage/products/images/big/voIh7hL0phnDRKHsPbfDDi5buhE97snGFrhaDGCF.jpg.webp?v=1771583923');

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select model.slug, 'entrance', 'Abwehr', 'Bionica Combo', model.name,
  'Сталь, МДФ-накладки та заводські атмосферостійкі покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом',
  model.name || ' — ' || lower(model.construction_type) || ' колекції Bionica Combo. Терморозрив і три контури ущільнення допомагають підтримувати комфорт у приміщенні; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Колекція Bionica Combo', 'Терморозрив', '3 контури ущільнення'),
  model.main_image, 99999, false
from abwehr_bionica_paradise_olimpia_desire model
on conflict (slug) do update set
  name = excluded.name, material = excluded.material, style = excluded.style,
  color = excluded.color, description = excluded.description, features = excluded.features,
  image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select model.slug, spec.label, spec.value, spec.sort_order, true
from abwehr_bionica_paradise_olimpia_desire model
cross join lateral (values
  ('Тип конструкції', model.construction_type, 10),
  ('Колекція', 'Bionica Combo', 20),
  ('Призначення', 'Для приватного будинку', 30),
  ('Терморозрив', 'Так', 40),
  ('Контури ущільнення', '3 контури', 50)
) as spec(label, value, sort_order)
on conflict (product_slug, label) do update set
  value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select model.slug, 'ABWEHR', model.source_url,
  model.name || ' · Bionica Combo · код ' || model.product_code,
  'verified', now(), 'Офіційна картка виробника: окрема модель Bionica Combo та фотогалерея.'
from abwehr_bionica_paradise_olimpia_desire model
where not exists (
  select 1 from public.product_sources source
  where source.product_slug = model.slug and source.source_url = model.source_url
);

create temporary table abwehr_bionica_paradise_olimpia_desire_gallery (
  product_slug text not null, image_path text not null, sort_order integer not null
) on commit drop;

insert into abwehr_bionica_paradise_olimpia_desire_gallery values
  ('abwehr-bionica-paradise', 'https://abwehr.com.ua/storage/products/images/big/99C8qrWwJCwgEfgbUUMEzo9pUzrvIiZCR8XUhxCq.jpg.webp?v=1777376263', 1),
  ('abwehr-bionica-paradise-king-size-1200', 'https://abwehr.com.ua/storage/products/images/big/dLRbo9OCCfqaiN4aShCea8fYpGeJklGX9ZpFvs4S.jpg.webp?v=1771581995', 1),
  ('abwehr-bionica-paradise-king-size-1200', 'https://abwehr.com.ua/storage/products/images/big/z4wwxYU7ANXcU2GNNzHOFXNamG9d2Zu3dxD2fqVc.jpg.webp?v=1771584243', 2),
  ('abwehr-bionica-paradise-king-size-1200', 'https://abwehr.com.ua/storage/products/images/big/thJPyEIFzgQAFlL8iZo2TJWnT5pJW8EFoxUTkInT.jpg.webp?v=1771583724', 3),
  ('abwehr-bionica-paradise-king-size-1200', 'https://abwehr.com.ua/storage/products/images/big/b8ekJgvTJwlgELqd9Fg5jkRAWScxkE3twiBKSaMP.jpg.webp?v=1771581752', 4),
  ('abwehr-bionica-paradise-king-size-1200', 'https://abwehr.com.ua/storage/products/images/big/9iUmjeJL83ZaDDW4FZcp3Eyh6nYiCy1QAX8ySFZ3.jpg.webp?v=1771578999', 5),
  ('abwehr-bionica-paradise-glass-1200', 'https://abwehr.com.ua/storage/products/images/big/P9sQhhhkwM5tVOt62Jc0uCVPHcWd4WdYKtagcXg1.jpg.webp?v=1781517517', 1),
  ('abwehr-bionica-paradise-glass-1200', 'https://abwehr.com.ua/storage/products/images/big/UXmGHMHDOIfzEGw5ITp9f2lXH4F0EJSRBBZYEcRV.jpg.webp?v=1771581105', 2),
  ('abwehr-bionica-paradise-glass-1200', 'https://abwehr.com.ua/storage/products/images/big/8eF70GrnmxF8JccRqF0iCW3HvX2Z3hDjP36Pj7d9.jpg.webp?v=1771578883', 3),
  ('abwehr-bionica-paradise-glass-1200', 'https://abwehr.com.ua/storage/products/images/big/sZcMRUvuKJSWAAFHZhsvE1RTiYFuvVLqMrrYpsbo.jpg.webp?v=1771583587', 4),
  ('abwehr-bionica-paradise-glass-1200', 'https://abwehr.com.ua/storage/products/images/big/kjEakSGDn8H0epMy5EsiaUmEruwDM2yz1C7B7V0y.jpg.webp?v=1771582723', 5),
  ('abwehr-bionica-olimpia-glass', 'https://abwehr.com.ua/storage/products/images/big/wzcxrHKyVSn05d7iJjle24cm2ZzzpNMOaQBGghjw.jpg.webp?v=1777281081', 1),
  ('abwehr-bionica-olimpia-1200', 'https://abwehr.com.ua/storage/products/images/big/STYz39EJbUlnThcGksmQtSvwoWAwAilxjh7unywu.jpg.webp?v=1781516678', 1),
  ('abwehr-bionica-desire-1200', 'https://abwehr.com.ua/storage/products/images/big/voIh7hL0phnDRKHsPbfDDi5buhE97snGFrhaDGCF.jpg.webp?v=1771583923', 1),
  ('abwehr-bionica-desire-1200', 'https://abwehr.com.ua/storage/products/images/big/ID28oqSWBKG5uz5dqcclO7uJ7XEO8OclQ7ZLPZp7.jpg.webp?v=1771579894', 2);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0
from abwehr_bionica_paradise_olimpia_desire model
where not exists (
  select 1 from public.product_media media
  where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image
);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select gallery.product_slug, 'gallery', 'Офіційне фото ' || gallery.sort_order, gallery.image_path, gallery.sort_order
from abwehr_bionica_paradise_olimpia_desire_gallery gallery
where not exists (
  select 1 from public.product_media media
  where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path
);

commit;

select count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug in (
    'abwehr-bionica-paradise', 'abwehr-bionica-paradise-king-size-1200',
    'abwehr-bionica-paradise-glass-1200', 'abwehr-bionica-olimpia-glass',
    'abwehr-bionica-olimpia-1200', 'abwehr-bionica-desire-1200'
  ) and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in (
  'abwehr-bionica-paradise', 'abwehr-bionica-paradise-king-size-1200',
  'abwehr-bionica-paradise-glass-1200', 'abwehr-bionica-olimpia-glass',
  'abwehr-bionica-olimpia-1200', 'abwehr-bionica-desire-1200'
);
