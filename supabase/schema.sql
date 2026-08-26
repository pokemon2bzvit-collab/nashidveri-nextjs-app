-- «Наші двері»: каталог товарів
-- Вставте цей файл у Supabase → SQL Editor → New query → Run.

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  category text not null check (category in ('interior', 'entrance', 'windows')),
  brand text not null,
  collection text not null,
  name text not null,
  material text not null,
  style text not null,
  color text not null,
  price text not null default 'Ціна за запитом',
  description text not null,
  features jsonb not null default '[]'::jsonb,
  image_path text not null,
  is_available boolean not null default true,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists products_category_idx on public.products(category);
create index if not exists products_brand_collection_idx on public.products(brand, collection);
create index if not exists products_available_idx on public.products(is_available);

-- Додаткові матеріали моделі: головне фото, варіанти дверей і палітри.
-- image_path — шлях усередині bucket `catalog-images`, наприклад
-- `media/rodos/loft-surf/main.jpg`.
create table if not exists public.product_media (
  id uuid primary key default gen_random_uuid(),
  product_slug text not null references public.products(slug) on delete cascade,
  kind text not null check (kind in ('main', 'gallery', 'palette')),
  label text,
  image_path text not null,
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create index if not exists product_media_product_idx on public.product_media(product_slug, kind, sort_order);
create unique index if not exists product_media_unique_file_idx on public.product_media(product_slug, kind, image_path);

alter table public.products enable row level security;

-- Дозволяємо публічному каталогу читати лише рядки, які пройшли RLS-політику нижче.
grant usage on schema public to anon, authenticated;
grant select on table public.products to anon, authenticated;
grant select on table public.product_media to anon, authenticated;

drop policy if exists "Public catalog is readable" on public.products;
create policy "Public catalog is readable"
  on public.products for select
  using (is_available = true);

alter table public.product_media enable row level security;

drop policy if exists "Public product media is readable" on public.product_media;
create policy "Public product media is readable"
  on public.product_media for select
  using (is_active = true);

-- Публічний bucket для фотографій каталогу.
-- Для прямих public URL окрема SELECT-політика не потрібна: вона дозволила б
-- через API отримувати список усіх файлів у bucket.
insert into storage.buckets (id, name, public)
values ('catalog-images', 'catalog-images', true)
on conflict (id) do update set public = true;

drop policy if exists "Public catalog images are readable" on storage.objects;
