-- Діагностика: лише перевірка, нічого не змінює.
select
  p.slug,
  p.is_available as "опубліковано",
  exists (
    select 1 from public.product_sources s
    where s.product_slug = p.slug and s.verification_status = 'verified'
  ) as "є_перевірене_джерело",
  exists (
    select 1 from public.product_media m
    where m.product_slug = p.slug and m.kind = 'gallery' and m.is_active
  ) as "є_активне_фото",
  count(m.id) filter (where m.kind = 'gallery') as "фото_всього",
  count(m.id) filter (where m.kind = 'gallery' and m.is_active) as "активних_фото"
from public.products p
left join public.product_media m on m.product_slug = p.slug
where p.slug in ('magda-166-official', 'magda-167-official', 'magda-169-official')
group by p.slug, p.is_available
order by p.slug;
