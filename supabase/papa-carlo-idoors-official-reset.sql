-- Резервна копія та очищення лише Papa Carlo / iDoors.
begin;
create table if not exists public.catalog_import_backups (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  scope text not null,
  payload jsonb not null
);
insert into public.catalog_import_backups (scope, payload)
select 'Papa Carlo / iDoors before official replacement', jsonb_build_object(
  'products', coalesce((select jsonb_agg(to_jsonb(p)) from public.products p where p.brand = 'Papa Carlo' and p.collection = 'iDoors'), '[]'::jsonb),
  'product_specs', coalesce((select jsonb_agg(to_jsonb(s)) from public.product_specs s join public.products p on p.slug = s.product_slug where p.brand = 'Papa Carlo' and p.collection = 'iDoors'), '[]'::jsonb),
  'product_options', coalesce((select jsonb_agg(to_jsonb(o)) from public.product_options o join public.products p on p.slug = o.product_slug where p.brand = 'Papa Carlo' and p.collection = 'iDoors'), '[]'::jsonb),
  'product_variants', coalesce((select jsonb_agg(to_jsonb(v)) from public.product_variants v join public.products p on p.slug = v.product_slug where p.brand = 'Papa Carlo' and p.collection = 'iDoors'), '[]'::jsonb),
  'product_media', coalesce((select jsonb_agg(to_jsonb(m)) from public.product_media m join public.products p on p.slug = m.product_slug where p.brand = 'Papa Carlo' and p.collection = 'iDoors'), '[]'::jsonb),
  'product_sources', coalesce((select jsonb_agg(to_jsonb(src)) from public.product_sources src join public.products p on p.slug = src.product_slug where p.brand = 'Papa Carlo' and p.collection = 'iDoors'), '[]'::jsonb)
);
delete from public.products where brand = 'Papa Carlo' and collection = 'iDoors';
commit;
