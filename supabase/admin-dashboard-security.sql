-- Адмінка «Наші двері».
-- Виконайте один раз у Supabase → SQL Editor → New query → Run.
-- Доступ на редагування отримає лише авторизований користувач із цією поштою.

create table if not exists public.product_sources (
  id uuid primary key default gen_random_uuid(),
  product_slug text not null references public.products(slug) on delete cascade,
  source_name text not null default 'Market Dveri',
  source_url text not null,
  source_product_name text,
  verification_status text not null default 'verified' check (verification_status in ('verified', 'review', 'rejected')),
  verified_at timestamptz,
  notes text,
  created_at timestamptz not null default now(),
  unique (product_slug, source_url)
);

create index if not exists product_sources_product_idx on public.product_sources(product_slug);

alter table public.products enable row level security;
alter table public.product_media enable row level security;
alter table public.product_options enable row level security;
alter table public.product_variants enable row level security;
alter table public.product_specs enable row level security;
alter table public.product_sources enable row level security;

grant select, insert, update, delete on public.products, public.product_media, public.product_options, public.product_variants, public.product_specs, public.product_sources to authenticated;

drop policy if exists "Admin manages products" on public.products;
create policy "Admin manages products" on public.products for all to authenticated
  using ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com');

drop policy if exists "Admin manages product media" on public.product_media;
create policy "Admin manages product media" on public.product_media for all to authenticated
  using ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com');

drop policy if exists "Admin manages product options" on public.product_options;
create policy "Admin manages product options" on public.product_options for all to authenticated
  using ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com');

drop policy if exists "Admin manages product variants" on public.product_variants;
create policy "Admin manages product variants" on public.product_variants for all to authenticated
  using ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com');

drop policy if exists "Admin manages product specs" on public.product_specs;
create policy "Admin manages product specs" on public.product_specs for all to authenticated
  using ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com');

drop policy if exists "Admin manages product sources" on public.product_sources;
create policy "Admin manages product sources" on public.product_sources for all to authenticated
  using ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com');

grant insert, update, delete on storage.objects to authenticated;
drop policy if exists "Admin manages catalog image uploads" on storage.objects;
create policy "Admin manages catalog image uploads" on storage.objects for all to authenticated
  using (bucket_id = 'catalog-images' and (auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com')
  with check (bucket_id = 'catalog-images' and (auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com');
