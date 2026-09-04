-- Пріоритети заявок для адмінки «Наші двері».
-- Виконайте один раз у Supabase → SQL Editor → New query → Run.

alter table public.leads
  add column if not exists priority text not null default 'normal'
  check (priority in ('normal', 'important', 'urgent'));

create index if not exists leads_priority_created_idx
  on public.leads(priority, created_at desc);
