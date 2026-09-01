-- Повне керування структурою каталогу з адмінки.
-- Виконайте один раз у Supabase → SQL Editor → New query → Run.
-- Скрипт не видаляє й не змінює чинні товари.

create table if not exists public.catalog_brands (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  description text not null default '',
  image_path text,
  is_active boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.catalog_collections (
  id uuid primary key default gen_random_uuid(),
  brand_id uuid not null references public.catalog_brands(id) on delete cascade,
  name text not null,
  category text not null check (category in ('interior', 'entrance', 'windows')),
  description text not null default '',
  image_path text,
  is_active boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (brand_id, name, category)
);

create index if not exists catalog_collections_brand_idx
  on public.catalog_collections(brand_id, category, sort_order);

-- Заповнюємо довідники з уже наявних товарів. Повторний запуск безпечний.
insert into public.catalog_brands (name)
select distinct brand from public.products
on conflict (name) do nothing;

insert into public.catalog_collections (brand_id, name, category)
select brands.id, products.collection, products.category
from public.products
join public.catalog_brands brands on brands.name = products.brand
group by brands.id, products.collection, products.category
on conflict (brand_id, name, category) do nothing;

alter table public.catalog_brands enable row level security;
alter table public.catalog_collections enable row level security;

grant select, insert, update, delete on public.catalog_brands, public.catalog_collections to authenticated;

drop policy if exists "Admin manages catalog brands" on public.catalog_brands;
create policy "Admin manages catalog brands" on public.catalog_brands for all to authenticated
  using ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com');

drop policy if exists "Admin manages catalog collections" on public.catalog_collections;
create policy "Admin manages catalog collections" on public.catalog_collections for all to authenticated
  using ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com');
