-- Запустіть один раз у Supabase → SQL Editor → New query → Run.
-- Наявні 363 товари та їхні фото не будуть змінені.

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

alter table public.product_media enable row level security;
grant select on table public.product_media to anon, authenticated;

drop policy if exists "Public product media is readable" on public.product_media;
create policy "Public product media is readable"
  on public.product_media for select
  using (is_active = true);

-- Приклад після завантаження файлу до bucket `catalog-images`:
-- insert into public.product_media (product_slug, kind, label, image_path, sort_order)
-- values ('catalog-237', 'palette', 'Палітра RAL', 'media/rodos/loft-surf/ral.jpg', 0);
