-- Прибрати застарілий дубль фабрики KFD після переходу на KORFAD.
-- Зберігає повний резервний знімок товарів та їхніх даних у
-- public.catalog_backup_kfd_20260921, після чого видаляє ТІЛЬКИ товари KFD.
-- KORFAD та інші бренди не змінюються. Об'єкти фотографій у Storage не видаляються.

begin;

do $$
declare
  kfd_models integer;
begin
  select count(*) into kfd_models
  from public.products
  where brand = 'KFD';

  if kfd_models <> 50 then
    raise exception 'Очікувалось 50 застарілих моделей KFD, знайдено % — видалення скасовано', kfd_models;
  end if;

  if to_regclass('public.catalog_backup_kfd_20260921') is not null then
    raise exception 'Резервна таблиця KFD уже існує — видалення скасовано, щоб не перезаписати backup';
  end if;
end $$;

create table public.catalog_backup_kfd_20260921 as
select
  now() as backed_up_at,
  to_jsonb(p) as product,
  coalesce((select jsonb_agg(to_jsonb(m) order by m.sort_order, m.id)
            from public.product_media m
            where m.product_slug = p.slug), '[]'::jsonb) as media,
  coalesce((select jsonb_agg(to_jsonb(o) order by o.option_group, o.sort_order, o.id)
            from public.product_options o
            where o.product_slug = p.slug), '[]'::jsonb) as options,
  coalesce((select jsonb_agg(to_jsonb(v) order by v.sort_order, v.id)
            from public.product_variants v
            where v.product_slug = p.slug), '[]'::jsonb) as variants,
  coalesce((select jsonb_agg(to_jsonb(s) order by s.sort_order, s.id)
            from public.product_specs s
            where s.product_slug = p.slug), '[]'::jsonb) as specs,
  coalesce((select jsonb_agg(to_jsonb(src) order by src.created_at, src.id)
            from public.product_sources src
            where src.product_slug = p.slug), '[]'::jsonb) as sources
from public.products p
where p.brand = 'KFD';

delete from public.products
where brand = 'KFD';

commit;

select
  (select count(*) from public.catalog_backup_kfd_20260921) as моделей_у_backup,
  (select count(*) from public.products where brand = 'KFD') as залишилось_kfd,
  (select count(*) from public.products where brand = 'KORFAD' and is_available) as опубліковано_korfad;
