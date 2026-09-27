-- Q Doors Преміум Бостон-M: дві перевірені фотографії з офіційної картки.

begin;

update public.products
set image_path = 'https://e-c.storage.googleapis.com/res/718d89af-dd7d-4ca2-ab00-8446d767d826/original',
    updated_at = now()
where slug = 'catalog-61'
  and brand = 'Q Doors';

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('catalog-61', 'gallery', 'Фото 1', 'https://e-c.storage.googleapis.com/res/718d89af-dd7d-4ca2-ab00-8446d767d826/original', 10, true),
  ('catalog-61', 'gallery', 'Фото 2', 'https://e-c.storage.googleapis.com/res/4f461a8e-b17e-4e76-b377-fefd98a20f28/original', 20, true)
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = excluded.is_active;

commit;

select
  p.slug,
  p.name as модель,
  count(m.id) filter (where m.kind = 'gallery' and m.is_active) as активних_фото_в_галереї
from public.products p
left join public.product_media m on m.product_slug = p.slug
where p.slug = 'catalog-61'
group by p.slug, p.name;
