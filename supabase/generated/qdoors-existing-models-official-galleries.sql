-- Q Doors: дві перевірені офіційні фотографії для 12 опублікованих
-- моделей, у яких не було повної галереї.

begin;

with photos as (
  select * from (values
    ('catalog-54', 'https://e-c.storage.googleapis.com/res/5ae390e8-2fdb-45d9-8fba-49b9b28df493/original', 'https://e-c.storage.googleapis.com/res/48c77941-2da0-4cc5-a500-745115abf470/original'),
    ('catalog-55', 'https://e-c.storage.googleapis.com/res/ad48333f-c7fa-41b0-a526-6ab72f52a46c/original', 'https://e-c.storage.googleapis.com/res/d7a25135-021a-425e-a2c2-19fb72edd53b/original'),
    ('catalog-56', 'https://e-c.storage.googleapis.com/res/e65611e1-f065-492a-b796-2f966c803593/original', 'https://e-c.storage.googleapis.com/res/d7a25135-021a-425e-a2c2-19fb72edd53b/original'),
    ('catalog-57', 'https://e-c.storage.googleapis.com/res/a9fe7566-694c-463c-99ae-2f5fc9114624/original', 'https://e-c.storage.googleapis.com/res/48930945-56ec-4ac6-8048-91069e474a07/original'),
    ('catalog-58', 'https://e-c.storage.googleapis.com/res/4a12c5a6-fd8e-42d1-be59-8f0e2fc81422/original', 'https://e-c.storage.googleapis.com/res/48c77941-2da0-4cc5-a500-745115abf470/original'),
    ('catalog-59', 'https://e-c.storage.googleapis.com/res/7452a942-b8f0-4f6a-9eb6-8495cd04116a/original', 'https://e-c.storage.googleapis.com/res/48930945-56ec-4ac6-8048-91069e474a07/original'),
    ('catalog-62', 'https://e-c.storage.googleapis.com/res/4fa04ee9-bad4-4e80-9cbc-0116b619cc1b/original', 'https://e-c.storage.googleapis.com/res/f8660e6f-d7a2-471c-91b2-0ea55fef1273/original'),
    ('catalog-64', 'https://e-c.storage.googleapis.com/res/0faa8f85-3f1f-45c6-8338-1fd2e76f276c/original', 'https://e-c.storage.googleapis.com/res/56ac3cf8-e93a-4dab-b7f3-3933122b0b39/original'),
    ('catalog-67', 'https://e-c.storage.googleapis.com/res/4b21447c-689e-4778-b616-62f724782d98/original', 'https://e-c.storage.googleapis.com/res/c67989cd-a40d-4042-8ba2-5f870ad379ec/original'),
    ('catalog-60', 'https://e-c.storage.googleapis.com/res/715f0470-96dd-4a7d-a869-e298f91e3211/original', 'https://e-c.storage.googleapis.com/res/3d76b38e-7d60-41c5-b2d1-701ea64de6f1/original'),
    ('catalog-63', 'https://e-c.storage.googleapis.com/res/84f95cd5-3b15-4bbf-8889-a94001ca65dd/original', 'https://e-c.storage.googleapis.com/res/69239baa-2519-409d-b24b-2394a95292d0/original'),
    ('catalog-65', 'https://e-c.storage.googleapis.com/res/2f25ad7d-8367-48af-8ded-ef83da78e84d/original', 'https://e-c.storage.googleapis.com/res/141242ae-b7b7-4f28-bcd5-87c6cc61f8c9/original')
  ) as v(product_slug, main_photo, second_photo)
)
update public.products p
set image_path = photos.main_photo,
    updated_at = now()
from photos
where p.slug = photos.product_slug
  and p.brand = 'Q Doors'
  and p.is_available = true;

with photos as (
  select * from (values
    ('catalog-54', 'https://e-c.storage.googleapis.com/res/5ae390e8-2fdb-45d9-8fba-49b9b28df493/original', 'https://e-c.storage.googleapis.com/res/48c77941-2da0-4cc5-a500-745115abf470/original'),
    ('catalog-55', 'https://e-c.storage.googleapis.com/res/ad48333f-c7fa-41b0-a526-6ab72f52a46c/original', 'https://e-c.storage.googleapis.com/res/d7a25135-021a-425e-a2c2-19fb72edd53b/original'),
    ('catalog-56', 'https://e-c.storage.googleapis.com/res/e65611e1-f065-492a-b796-2f966c803593/original', 'https://e-c.storage.googleapis.com/res/d7a25135-021a-425e-a2c2-19fb72edd53b/original'),
    ('catalog-57', 'https://e-c.storage.googleapis.com/res/a9fe7566-694c-463c-99ae-2f5fc9114624/original', 'https://e-c.storage.googleapis.com/res/48930945-56ec-4ac6-8048-91069e474a07/original'),
    ('catalog-58', 'https://e-c.storage.googleapis.com/res/4a12c5a6-fd8e-42d1-be59-8f0e2fc81422/original', 'https://e-c.storage.googleapis.com/res/48c77941-2da0-4cc5-a500-745115abf470/original'),
    ('catalog-59', 'https://e-c.storage.googleapis.com/res/7452a942-b8f0-4f6a-9eb6-8495cd04116a/original', 'https://e-c.storage.googleapis.com/res/48930945-56ec-4ac6-8048-91069e474a07/original'),
    ('catalog-62', 'https://e-c.storage.googleapis.com/res/4fa04ee9-bad4-4e80-9cbc-0116b619cc1b/original', 'https://e-c.storage.googleapis.com/res/f8660e6f-d7a2-471c-91b2-0ea55fef1273/original'),
    ('catalog-64', 'https://e-c.storage.googleapis.com/res/0faa8f85-3f1f-45c6-8338-1fd2e76f276c/original', 'https://e-c.storage.googleapis.com/res/56ac3cf8-e93a-4dab-b7f3-3933122b0b39/original'),
    ('catalog-67', 'https://e-c.storage.googleapis.com/res/4b21447c-689e-4778-b616-62f724782d98/original', 'https://e-c.storage.googleapis.com/res/c67989cd-a40d-4042-8ba2-5f870ad379ec/original'),
    ('catalog-60', 'https://e-c.storage.googleapis.com/res/715f0470-96dd-4a7d-a869-e298f91e3211/original', 'https://e-c.storage.googleapis.com/res/3d76b38e-7d60-41c5-b2d1-701ea64de6f1/original'),
    ('catalog-63', 'https://e-c.storage.googleapis.com/res/84f95cd5-3b15-4bbf-8889-a94001ca65dd/original', 'https://e-c.storage.googleapis.com/res/69239baa-2519-409d-b24b-2394a95292d0/original'),
    ('catalog-65', 'https://e-c.storage.googleapis.com/res/2f25ad7d-8367-48af-8ded-ef83da78e84d/original', 'https://e-c.storage.googleapis.com/res/141242ae-b7b7-4f28-bcd5-87c6cc61f8c9/original')
  ) as v(product_slug, main_photo, second_photo)
), media as (
  select product_slug, 'Фото 1'::text as label, main_photo as image_path, 10 as sort_order from photos
  union all
  select product_slug, 'Фото 2'::text, second_photo, 20 from photos
)
insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
select product_slug, 'gallery', label, image_path, sort_order, true
from media
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = excluded.is_active;

commit;

select
  p.collection as серія,
  count(*) as моделей,
  count(*) filter (where p.is_available) as опубліковано,
  count(*) filter (where gallery.gallery_count >= 2) as з_двома_і_більше_фото
from public.products p
left join lateral (
  select count(*) as gallery_count
  from public.product_media m
  where m.product_slug = p.slug
    and m.kind = 'gallery'
    and m.is_active
) gallery on true
where p.slug in ('catalog-54', 'catalog-55', 'catalog-56', 'catalog-57', 'catalog-58', 'catalog-59', 'catalog-60', 'catalog-62', 'catalog-63', 'catalog-64', 'catalog-65', 'catalog-67')
group by p.collection
order by p.collection;
