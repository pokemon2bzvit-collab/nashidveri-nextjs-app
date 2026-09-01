-- Заявки з сайту «Наші двері».
-- Виконайте один раз у Supabase → SQL Editor → New query → Run.

create table if not exists public.leads (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  name text not null,
  phone text not null check (phone ~ '^\+380[0-9]{9}$'),
  contact_method text not null default 'phone' check (contact_method in ('phone', 'viber', 'telegram')),
  message text,
  request_type text not null default 'consultation' check (request_type in ('consultation', 'measurement', 'price_request', 'contact_form')),
  product_slug text references public.products(slug) on delete set null,
  product_name text,
  source_path text,
  status text not null default 'new' check (status in ('new', 'in_progress', 'measurement', 'offer_sent', 'won', 'lost')),
  consent boolean not null default false,
  updated_at timestamptz not null default now()
);

create index if not exists leads_status_created_idx on public.leads(status, created_at desc);
create index if not exists leads_phone_idx on public.leads(phone);

alter table public.leads enable row level security;

grant insert on public.leads to anon, authenticated;
grant select, update, delete on public.leads to authenticated;

drop policy if exists "Visitors can create consented leads" on public.leads;
create policy "Visitors can create consented leads" on public.leads for insert to anon, authenticated
  with check (consent = true);

drop policy if exists "Admin manages leads" on public.leads;
create policy "Admin manages leads" on public.leads for all to authenticated
  using ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'pokemon2bzvit@gmail.com');
