-- Magda: поточний стан каталогу (лише читання, нічого не змінює).
-- Виконай увесь запит у Supabase SQL Editor і надішли результат.

with magda_products as (
  select
    p.slug,
    p.name,
    p.collection,
    p.is_available,
    p.image_path,
    count(distinct s.id) filter (
      where s.verification_status = 'verified'
        and s.source_url ilike '%magda.com.ua%'
    ) as official_sources,
    count(distinct m.id) filter (
      where m.kind = 'gallery' and m.is_active = true
    ) as gallery_photos,
    count(distinct ps.id) filter (
      where ps.is_active = true
    ) as active_specs,
    count(distinct o.id) filter (
      where o.is_active = true
    ) as active_options,
    string_agg(distinct s.source_url, E'\n') filter (
      where s.source_url ilike '%magda.com.ua%'
    ) as magda_sources
  from public.products p
  left join public.product_sources s on s.product_slug = p.slug
  left join public.product_media m on m.product_slug = p.slug
  left join public.product_specs ps on ps.product_slug = p.slug
  left join public.product_options o on o.product_slug = p.slug
  where p.brand = 'Magda'
  group by p.slug, p.name, p.collection, p.is_available, p.image_path
)
select
  slug as "slug",
  name as "модель",
  collection as "поточна_колекція",
  is_available as "опубліковано",
  (image_path is not null and image_path <> '') as "має_головне_фото",
  official_sources as "офіційних_джерел",
  gallery_photos as "фото_в_галереї",
  active_specs as "характеристик",
  active_options as "активних_опцій",
  magda_sources as "посилання_magda"
from magda_products
order by is_available desc, name;
