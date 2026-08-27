-- Запустіть один раз у Supabase → SQL Editor → New query → Run.
-- Зберігає фото точних комбінацій: наприклад, колір + кромка + скло.

create table if not exists public.product_variants (
  id uuid primary key default gen_random_uuid(),
  product_slug text not null references public.products(slug) on delete cascade,
  selections jsonb not null,
  image_path text not null,
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique (product_slug, selections)
);

create index if not exists product_variants_product_idx on public.product_variants(product_slug, sort_order);
alter table public.product_variants enable row level security;
grant select on table public.product_variants to anon, authenticated;

drop policy if exists "Public product variants are readable" on public.product_variants;
create policy "Public product variants are readable"
  on public.product_variants for select
  using (is_active = true);
