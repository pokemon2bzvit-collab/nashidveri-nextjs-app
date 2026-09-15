-- Papa Carlo Tetra: точні фотогалереї для ВСІХ моделей із реальним вибором скла.
-- T-01, T-02, T-03 та T-11. Перевірено в офіційному каталозі 15.09.2026.
-- Запускати ЗАМІСТЬ окремого papa-carlo-tetra-t03-exact-glass-galleries.sql.
-- Інші Tetra не мають підтвердженого перемикача скла — їх не змінюємо.

begin;

do $$
begin
  if (select count(*) from public.products
      where slug in ('catalog-133', 'catalog-134', 'catalog-135', 'papa-carlo-t-11-official')
        and brand = 'Papa Carlo' and collection = 'Tetra' and is_available = true) <> 4 then
    raise exception 'Не знайдено чотири опубліковані моделі Tetra зі склом — змін не внесено.';
  end if;
end $$;

delete from public.product_media
where product_slug in ('catalog-133', 'catalog-134', 'catalog-135', 'papa-carlo-t-11-official')
  and kind in ('main', 'gallery');

insert into public.product_media (product_slug, kind, label, image_path, sort_order) values
  -- T-01: «Сатин / чорне» та «Чорне скло».
  ('catalog-133', 'main', 'Головне фото', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-29371029225377.webp', 0),
  ('catalog-133', 'gallery', 'glass:Сатин / чорне скло:Фото 1', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-29371029225377.webp', 10),
  ('catalog-133', 'gallery', 'glass:Сатин / чорне скло:Фото 2', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-15670833954048.webp', 20),
  ('catalog-133', 'gallery', 'glass:Сатин / чорне скло:Фото 3', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-86234545310315.webp', 30),
  ('catalog-133', 'gallery', 'glass:Чорне скло:Фото 1', 'https://papa-karlo.com.ua/content/images/27/910x1155l80mc0/73924890933368.webp', 40),
  ('catalog-133', 'gallery', 'glass:Чорне скло:Фото 2', 'https://papa-karlo.com.ua/content/images/27/910x1155l80mc0/24253475528603.webp', 50),
  ('catalog-133', 'gallery', 'glass:Чорне скло:Фото 3', 'https://papa-karlo.com.ua/content/images/27/910x1155l80mc0/99422323816216.webp', 60),

  -- T-02: «Сатин / чорне» та «Сатин».
  ('catalog-134', 'main', 'Головне фото', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-45452544731725.webp', 0),
  ('catalog-134', 'gallery', 'glass:Сатин / чорне скло:Фото 1', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-45452544731725.webp', 10),
  ('catalog-134', 'gallery', 'glass:Сатин / чорне скло:Фото 2', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-51678145823205.webp', 20),
  ('catalog-134', 'gallery', 'glass:Сатин / чорне скло:Фото 3', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-13608690299432.webp', 30),
  ('catalog-134', 'gallery', 'glass:Сатин:Фото 1', 'https://papa-karlo.com.ua/content/images/28/910x1155l80mc0/86769510063307.webp', 40),
  ('catalog-134', 'gallery', 'glass:Сатин:Фото 2', 'https://papa-karlo.com.ua/content/images/28/910x1155l80mc0/35569199178360.webp', 50),
  ('catalog-134', 'gallery', 'glass:Сатин:Фото 3', 'https://papa-karlo.com.ua/content/images/28/910x1155l80mc0/27753967922526.webp', 60),

  -- T-03: «Сатин / чорне» та «Чорне скло».
  ('catalog-135', 'main', 'Головне фото', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-97050018138804.webp', 0),
  ('catalog-135', 'gallery', 'glass:Сатин / чорне скло:Фото 1', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-97050018138804.webp', 10),
  ('catalog-135', 'gallery', 'glass:Сатин / чорне скло:Фото 2', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-43410764024695.webp', 20),
  ('catalog-135', 'gallery', 'glass:Сатин / чорне скло:Фото 3', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-73079724059600.webp', 30),
  ('catalog-135', 'gallery', 'glass:Чорне скло:Фото 1', 'https://papa-karlo.com.ua/content/images/29/910x1155l80mc0/70511584023903.webp', 40),
  ('catalog-135', 'gallery', 'glass:Чорне скло:Фото 2', 'https://papa-karlo.com.ua/content/images/29/910x1155l80mc0/49343575279727.webp', 50),
  ('catalog-135', 'gallery', 'glass:Чорне скло:Фото 3', 'https://papa-karlo.com.ua/content/images/29/910x1155l80mc0/93565460450101.webp', 60),

  -- T-11: «Темне скло» та «Сатин» — по шість офіційних ракурсів.
  ('papa-carlo-t-11-official', 'main', 'Головне фото', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.webp', 0),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 1', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.webp', 10),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 2', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-27814162974724.webp', 20),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 3', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-30576370987736.webp', 30),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 4', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-67285372583415.webp', 40),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 5', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-55432376583662.webp', 50),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 6', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-28981380215974.webp', 60),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 1', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-16534560199224.webp', 70),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 2', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-59247760411503.webp', 80),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 3', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-86310800606617.webp', 90),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 4', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-74937320710308.webp', 100),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 5', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-89918501200100.webp', 110),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 6', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-48463541199636.webp', 120);

delete from public.product_variants where product_slug in ('catalog-133', 'catalog-134', 'catalog-135', 'papa-carlo-t-11-official');
delete from public.product_options where product_slug in ('catalog-133', 'catalog-134', 'catalog-135', 'papa-carlo-t-11-official');

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order) values
  ('catalog-133', 'glass', 'Варіант скла', 'Сатин / чорне скло', null, 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-29371029225377.webp', 10),
  ('catalog-133', 'glass', 'Варіант скла', 'Чорне скло', null, 'https://papa-karlo.com.ua/content/images/27/910x1155l80mc0/73924890933368.webp', 20),
  ('catalog-134', 'glass', 'Варіант скла', 'Сатин / чорне скло', null, 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-45452544731725.webp', 10),
  ('catalog-134', 'glass', 'Варіант скла', 'Сатин', null, 'https://papa-karlo.com.ua/content/images/28/910x1155l80mc0/86769510063307.webp', 20),
  ('catalog-135', 'glass', 'Варіант скла', 'Сатин / чорне скло', null, 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-97050018138804.webp', 10),
  ('catalog-135', 'glass', 'Варіант скла', 'Чорне скло', null, 'https://papa-karlo.com.ua/content/images/29/910x1155l80mc0/70511584023903.webp', 20),
  ('papa-carlo-t-11-official', 'glass', 'Варіант скла', 'Темне скло', null, 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.webp', 10),
  ('papa-carlo-t-11-official', 'glass', 'Варіант скла', 'Сатин', null, 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-16534560199224.webp', 20);

insert into public.product_variants (product_slug, selections, image_path, sort_order) values
  ('catalog-133', '{"glass":"Сатин / чорне скло"}'::jsonb, 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-29371029225377.webp', 10),
  ('catalog-133', '{"glass":"Чорне скло"}'::jsonb, 'https://papa-karlo.com.ua/content/images/27/910x1155l80mc0/73924890933368.webp', 20),
  ('catalog-134', '{"glass":"Сатин / чорне скло"}'::jsonb, 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-45452544731725.webp', 10),
  ('catalog-134', '{"glass":"Сатин"}'::jsonb, 'https://papa-karlo.com.ua/content/images/28/910x1155l80mc0/86769510063307.webp', 20),
  ('catalog-135', '{"glass":"Сатин / чорне скло"}'::jsonb, 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-97050018138804.webp', 10),
  ('catalog-135', '{"glass":"Чорне скло"}'::jsonb, 'https://papa-karlo.com.ua/content/images/29/910x1155l80mc0/70511584023903.webp', 20),
  ('papa-carlo-t-11-official', '{"glass":"Темне скло"}'::jsonb, 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.webp', 10),
  ('papa-carlo-t-11-official', '{"glass":"Сатин"}'::jsonb, 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-16534560199224.webp', 20);

commit;

select
  p.name as модель,
  (select count(*) from public.product_media m where m.product_slug = p.slug and m.kind in ('main', 'gallery') and m.is_active = true) as фото,
  (select count(*) from public.product_media m where m.product_slug = p.slug and m.label like 'glass:%' and m.is_active = true) as фото_за_варіантами,
  (select count(*) from public.product_options o where o.product_slug = p.slug and o.is_active = true) as варіантів_скла
from public.products p
where p.slug in ('catalog-133', 'catalog-134', 'catalog-135', 'papa-carlo-t-11-official')
order by p.sort_order;
