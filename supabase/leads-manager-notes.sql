-- Внутрішні нотатки менеджера до заявок.
-- Виконайте один раз у Supabase → SQL Editor → New query → Run.

alter table public.leads
  add column if not exists manager_note text;
