-- Q Doors: додає друге перевірене фото до 15 нових моделей.
-- Також виправляє головне фото «Ультра Крос-AK», яке раніше вказувало
-- на іншу модель через неточний alt-текст в офіційному каталозі.

begin;

update public.products
set image_path = 'https://e-c.storage.googleapis.com/res/711fce63-6fec-4f54-8b11-66b061ba201b/original',
    updated_at = now()
where slug = 'qdoors-ultra-cross-ak-official'
  and brand = 'Q Doors';

-- Не видаляємо помилково прив''язане старе фото: лише прибираємо його з показу.
update public.product_media
set is_active = false
where product_slug = 'qdoors-ultra-cross-ak-official'
  and kind = 'gallery'
  and image_path = 'https://e-c.storage.googleapis.com/res/715f0470-96dd-4a7d-a869-e298f91e3211/original';

with photos as (
  select * from (values
    ('qdoors-premium-tracey-m-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/be274677-ce68-4cb6-a3ad-c9340281997d/original', 20),
    ('qdoors-premium-horizontal-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/6b2ebeb5-1e41-4019-b28c-6913ae358521/original', 20),
    ('qdoors-premium-accent-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/cf5f537c-4aef-459c-bc7e-8427ef42abc0/original', 20),
    ('qdoors-premium-combi-ak-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/463a511f-6545-4f47-9737-3134df51f0fb/original', 20),
    ('qdoors-premium-vertical-ak-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/e2456a83-63e2-4aa7-8c7e-1dac0682954b/original', 20),
    ('qdoors-premium-provans-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/52ea246e-2635-450a-b142-4ee77e58ec1b/original', 20),
    ('qdoors-ultra-flash-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/56dbcc0c-0858-446c-bf9b-9670e00e3216/original', 20),
    ('qdoors-ultra-cross-ak-official', 'Фото 1', 'https://e-c.storage.googleapis.com/res/711fce63-6fec-4f54-8b11-66b061ba201b/original', 10),
    ('qdoors-ultra-cross-ak-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/8abbdd47-7ae5-48a0-8386-0e59599fe341/original', 20),
    ('qdoors-ultra-frost-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/7a91fc9e-1cf8-4245-834c-5148cdc2a138/original', 20),
    ('qdoors-avangard-converse-ak-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/ab0a2e0d-d553-4b38-a20f-e5405baabfaf/original', 20),
    ('qdoors-avangard-horizontal-al-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/7de1e8fc-c5e4-4211-acff-0db2f90cd96e/original', 20),
    ('qdoors-avangard-bacardi-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/5ee38150-9844-40af-ac37-c7678b42e8d0/original', 20),
    ('qdoors-avangard-tiffani-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/8ff4e9d8-952f-4e00-9355-a12088faa3e2/original', 20),
    ('qdoors-avangard-trino-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/277ab993-c7d7-4982-abd4-f3d932a02ddf/original', 20),
    ('qdoors-avangard-galant-ak-official', 'Фото 2', 'https://e-c.storage.googleapis.com/res/f2157121-6052-476f-8b97-3094d542ba5f/original', 20)
  ) as v(product_slug, label, image_path, sort_order)
)
insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
select product_slug, 'gallery', label, image_path, sort_order, true
from photos
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = excluded.is_active;

commit;

select
  p.collection as серія,
  count(distinct p.slug) as моделей,
  count(m.id) filter (where m.kind = 'gallery' and m.is_active) as активних_фото_в_галереях
from public.products p
left join public.product_media m on m.product_slug = p.slug
where p.slug in (
  'qdoors-premium-tracey-m-official',
  'qdoors-premium-horizontal-official',
  'qdoors-premium-accent-official',
  'qdoors-premium-combi-ak-official',
  'qdoors-premium-vertical-ak-official',
  'qdoors-premium-provans-official',
  'qdoors-ultra-flash-official',
  'qdoors-ultra-cross-ak-official',
  'qdoors-ultra-frost-official',
  'qdoors-avangard-converse-ak-official',
  'qdoors-avangard-horizontal-al-official',
  'qdoors-avangard-bacardi-official',
  'qdoors-avangard-tiffani-official',
  'qdoors-avangard-trino-official',
  'qdoors-avangard-galant-ak-official'
)
group by p.collection
order by p.collection;
