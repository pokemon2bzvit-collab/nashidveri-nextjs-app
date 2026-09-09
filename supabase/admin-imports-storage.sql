-- Приватна бібліотека sitemap-файлів для адмінки «Наші двері».
-- Виконати один раз у Supabase → SQL Editor → Run.

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('admin-imports', 'admin-imports', false, 5242880, array['application/xml', 'text/xml', 'text/plain'])
on conflict (id) do update set public = false, file_size_limit = 5242880;

drop policy if exists "Admin can manage import files" on storage.objects;
create policy "Admin can manage import files"
on storage.objects
for all
to authenticated
using (bucket_id = 'admin-imports' and auth.jwt() ->> 'email' = 'pokemon2bzvit@gmail.com')
with check (bucket_id = 'admin-imports' and auth.jwt() ->> 'email' = 'pokemon2bzvit@gmail.com');
