-- Papa Carlo T-11: два підтверджені виконання з офіційних карток виробника.
-- Темне скло: https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-t-11/
-- Сатин:       https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-t-11/1908/

begin;

do $$
begin
  if (select count(*) from public.products
      where slug = 'papa-carlo-t-11-official'
        and name = 'Papa Carlo T-11'
        and is_available = true) <> 1 then
    raise exception 'Не знайдено опубліковану картку Papa Carlo T-11. Змін не внесено.';
  end if;
end $$;

delete from public.product_variants
where product_slug = 'papa-carlo-t-11-official';

delete from public.product_options
where product_slug = 'papa-carlo-t-11-official';

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
values
  ('papa-carlo-t-11-official', 'glass', 'Варіант скла', 'Темне скло', null,
    'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.jpg', 10),
  ('papa-carlo-t-11-official', 'glass', 'Варіант скла', 'Сатин', null,
    'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-16534560199224.webp', 20);

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
  ('papa-carlo-t-11-official', '{"glass":"Темне скло"}'::jsonb,
    'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.jpg', 10),
  ('papa-carlo-t-11-official', '{"glass":"Сатин"}'::jsonb,
    'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-16534560199224.webp', 20);

commit;

select
  option_row.group_label,
  option_row.label,
  option_row.image_path
from public.product_options option_row
where option_row.product_slug = 'papa-carlo-t-11-official'
  and option_row.is_active = true
order by option_row.sort_order;
