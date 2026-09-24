-- ABWEHR GRAND: missing current models as hidden drafts from official cards.
-- Stella already exists in the catalogue and is deliberately not duplicated.

begin;

create temporary table abwehr_grand_models (
  slug text primary key,
  name text not null,
  product_code text not null,
  source_url text not null,
  construction_type text not null,
  main_image text not null
) on commit drop;

insert into abwehr_grand_models values
  ('abwehr-grand-ramina-official', 'Abwehr Ramina', '509', 'https://abwehr.com.ua/catalog/trohkonturni-vhidni-dveri-model-ramina-komplektaciya-grand/p1374', 'Вхідні двері для квартири', 'https://abwehr.com.ua/storage/products/images/big/qOc8UHNOGvAFjKktiKI3fCjMCKWIYHmhzHdjbqLx.jpg.webp?v=1771583359'),
  ('abwehr-grand-moderna-official', 'Abwehr Moderna', '493', 'https://abwehr.com.ua/catalog/trohkonturni-vhidni-dveri-model-moderna-komplektaciya-grand-2/p1609', 'Вхідні двері для квартири', 'https://abwehr.com.ua/storage/products/images/big/9SsA6noXAf9nGj82sxwkRG8QHrcvUPcUGWr3Opi6.jpg.webp?v=1771578975'),
  ('abwehr-grand-lorena-official', 'Abwehr Lorena', '550', 'https://abwehr.com.ua/catalog/trohkonturni-vhidni-dveri-z-vnutrishnim-vidkrivannyam-model-lorena-komplektaciya-grand/p1724', 'Вхідні двері з внутрішнім відкриванням', 'https://abwehr.com.ua/storage/products/images/big/PhHt3Nss9kpk2Sk4nAGExnoJA1pYtTmAVLGKtr8p.jpg.webp?v=1787212591'),
  ('abwehr-grand-enigma-official', 'Abwehr Enigma', '569', 'https://abwehr.com.ua/catalog/trohkonturni-vhidni-dveri-model-enigma-komplektaciya-grand/p1702', 'Вхідні двері для квартири', 'https://abwehr.com.ua/storage/products/images/big/zPGRSnBxwInZ9E0xAwJDYPK3pMwqOCGqRXp8suAs.jpg.webp?v=1777899661');

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select model.slug, 'entrance', 'Abwehr', 'Grand', model.name,
  'Сталь, МДФ-накладки та заводські покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом',
  model.name || ' — ' || lower(model.construction_type) || ' серії Grand. Три контури ущільнення, утеплене полотно та замки Securemme допомагають забезпечити комфорт і захист; точну комплектацію, декори й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Колекція Grand', '3 контури ущільнення', 'Замки Securemme'), model.main_image, 99999, false
from abwehr_grand_models model
on conflict (slug) do update set
  name = excluded.name, material = excluded.material, style = excluded.style,
  color = excluded.color, description = excluded.description, features = excluded.features,
  image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select model.slug, spec.label, spec.value, spec.sort_order, true
from abwehr_grand_models model
cross join lateral (values
  ('Тип конструкції', model.construction_type, 10),
  ('Колекція', 'Grand', 20),
  ('Призначення', 'Для квартири', 30),
  ('Контури ущільнення', '3 контури', 40),
  ('Замки', 'Securemme', 50)
) as spec(label, value, sort_order)
on conflict (product_slug, label) do update set
  value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select model.slug, 'ABWEHR', model.source_url, model.name || ' · Grand · код ' || model.product_code,
  'verified', now(), 'Офіційна картка виробника: окрема актуальна модель Grand та фотогалерея.'
from abwehr_grand_models model
where not exists (
  select 1 from public.product_sources source
  where source.product_slug = model.slug and source.source_url = model.source_url
);

create temporary table abwehr_grand_gallery (
  product_slug text not null, image_path text not null, sort_order integer not null
) on commit drop;

insert into abwehr_grand_gallery values
  ('abwehr-grand-ramina-official', 'https://abwehr.com.ua/storage/products/images/big/qOc8UHNOGvAFjKktiKI3fCjMCKWIYHmhzHdjbqLx.jpg.webp?v=1771583359', 1),
  ('abwehr-grand-ramina-official', 'https://abwehr.com.ua/storage/products/images/big/zCEbLXdX461D0pWcVuuBC3PlHRxL8dnzMfhX1mz5.jpg.webp?v=1771584255', 2),
  ('abwehr-grand-ramina-official', 'https://abwehr.com.ua/storage/products/images/big/iC3lcCTuLVrTNrSDRLyZREEO0kyNPqziPY7DWcYv.jpg.webp?v=1771582471', 3),
  ('abwehr-grand-ramina-official', 'https://abwehr.com.ua/storage/products/images/big/1aleLu1FC1zyJZBxPpXC9yy13eytCd3atcbBzzOp.jpg.webp?v=1771578147', 4),
  ('abwehr-grand-ramina-official', 'https://abwehr.com.ua/storage/products/images/big/APBIuSRtgn69f6lnBIJaaJmNb75tcjNUBqhRN5ci.jpg.webp?v=1771579074', 5),
  ('abwehr-grand-moderna-official', 'https://abwehr.com.ua/storage/products/images/big/9SsA6noXAf9nGj82sxwkRG8QHrcvUPcUGWr3Opi6.jpg.webp?v=1771578975', 1),
  ('abwehr-grand-moderna-official', 'https://abwehr.com.ua/storage/products/images/big/dBjOwLfblxkJrVkuDfEAjh1Mnux6DXAbB02j2fsK.jpg.webp?v=1771581972', 2),
  ('abwehr-grand-moderna-official', 'https://abwehr.com.ua/storage/products/images/big/jl3cMwrSNtFqb2C0KpbrZxuTKMGykABCbhDzKC9v.jpg.webp?v=1771582630', 3),
  ('abwehr-grand-moderna-official', 'https://abwehr.com.ua/storage/products/images/big/aGAm3NIucmP5kL0V5Rih3OkP4rYr9cBFy10Wowor.jpg.webp?v=1771581665', 4),
  ('abwehr-grand-moderna-official', 'https://abwehr.com.ua/storage/products/images/big/J5U9ZKHhXsFCWlBCSCmqW7ljGExCYzcd79LyxZmn.jpg.webp?v=1771579976', 5),
  ('abwehr-grand-lorena-official', 'https://abwehr.com.ua/storage/products/images/big/PhHt3Nss9kpk2Sk4nAGExnoJA1pYtTmAVLGKtr8p.jpg.webp?v=1787212591', 1),
  ('abwehr-grand-lorena-official', 'https://abwehr.com.ua/storage/products/images/big/hSqWHeBicZJp16Wa10Qz67WavgbH2eCUVoTVxxgI.jpg.webp?v=1787212587', 2),
  ('abwehr-grand-lorena-official', 'https://abwehr.com.ua/storage/products/images/big/6KZF6hOg3mZqor44syKnCcAB6Ze0BX4qGdPVW74i.jpg.webp?v=1787212590', 3),
  ('abwehr-grand-lorena-official', 'https://abwehr.com.ua/storage/products/images/big/rEG3vZC99h6TVcyrmGnDtTm5HZzrWf20Q5pQ1yzs.jpg.webp?v=1787212589', 4),
  ('abwehr-grand-lorena-official', 'https://abwehr.com.ua/storage/products/images/big/RNs0RhTso5NQIKXOuclUN76Bh2EzeIJ5KbNumGa4.jpg.webp?v=1787212589', 5),
  ('abwehr-grand-enigma-official', 'https://abwehr.com.ua/storage/products/images/big/zPGRSnBxwInZ9E0xAwJDYPK3pMwqOCGqRXp8suAs.jpg.webp?v=1777899661', 1),
  ('abwehr-grand-enigma-official', 'https://abwehr.com.ua/storage/products/images/big/YhIbLXaDEwCLXIcO7G8aHlDY6rVBYRs3TjSsami1.jpg.webp?v=1777899664', 2),
  ('abwehr-grand-enigma-official', 'https://abwehr.com.ua/storage/products/images/big/eD4zZyX4qRgPr15Tlm1tnOxqwR2878Odw5CpibRB.jpg.webp?v=1777899661', 3),
  ('abwehr-grand-enigma-official', 'https://abwehr.com.ua/storage/products/images/big/byIw6CpJJM7b6buHle7tMTSNkkLUlJ5RYyXDUKT6.jpg.webp?v=1777899662', 4),
  ('abwehr-grand-enigma-official', 'https://abwehr.com.ua/storage/products/images/big/6NusZUvIMc99eUs1I9M3yi1ST1roIf7DEVCPAWbq.jpg.webp?v=1777899661', 5);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0
from abwehr_grand_models model
where not exists (
  select 1 from public.product_media media
  where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image
);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select gallery.product_slug, 'gallery', 'Офіційне фото ' || gallery.sort_order, gallery.image_path, gallery.sort_order
from abwehr_grand_gallery gallery
where not exists (
  select 1 from public.product_media media
  where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path
);

commit;

select count(*) as моделей,
  count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media
   where media.product_slug in ('abwehr-grand-ramina-official', 'abwehr-grand-moderna-official', 'abwehr-grand-lorena-official', 'abwehr-grand-enigma-official')
     and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products
where slug in ('abwehr-grand-ramina-official', 'abwehr-grand-moderna-official', 'abwehr-grand-lorena-official', 'abwehr-grand-enigma-official');
