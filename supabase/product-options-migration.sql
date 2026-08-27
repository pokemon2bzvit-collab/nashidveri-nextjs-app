-- Запустіть один раз у Supabase → SQL Editor → New query → Run.
-- Таблиця зберігає підтверджені варіанти: декор, шпон, скло, кромку й комплектацію.

create table if not exists public.product_options (
  id uuid primary key default gen_random_uuid(),
  product_slug text not null references public.products(slug) on delete cascade,
  option_group text not null check (option_group in ('color', 'finish', 'glass', 'edge', 'configuration')),
  group_label text not null,
  label text not null,
  swatch text,
  image_path text,
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique (product_slug, option_group, label)
);

create index if not exists product_options_product_idx on public.product_options(product_slug, option_group, sort_order);
alter table public.product_options enable row level security;
grant select on table public.product_options to anon, authenticated;

drop policy if exists "Public product options are readable" on public.product_options;
create policy "Public product options are readable"
  on public.product_options for select
  using (is_active = true);
