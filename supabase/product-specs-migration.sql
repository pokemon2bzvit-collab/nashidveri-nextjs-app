-- Структуровані технічні характеристики моделей.
-- Виконати в Supabase SQL Editor перед завантаженням даних з seed-файлів.

create table if not exists public.product_specs (
  id uuid primary key default gen_random_uuid(),
  product_slug text not null references public.products(slug) on delete cascade,
  label text not null,
  value text not null,
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique (product_slug, label)
);

alter table public.product_specs enable row level security;

drop policy if exists "Public product specs are readable" on public.product_specs;
create policy "Public product specs are readable"
  on public.product_specs for select
  using (is_active = true);
