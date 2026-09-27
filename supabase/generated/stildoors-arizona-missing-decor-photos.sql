-- StilDoors Arizona: точні фото трьох пропущених декорів.
begin;

insert into public.product_options
  (product_slug, option_group, group_label, label, swatch, image_path, sort_order, is_active)
values
  ('stildoors-stil-arizona-official', 'color', 'Колір полотна', 'вільха класична', null, 'https://stildoors.com.ua/images/dveri/stil/arizona/vilha-klasichna/sklo-chorne/dveri-stil-arizona-vilha-klasichna-sklo-chorne.jpg', 7, true),
  ('stildoors-stil-arizona-official', 'color', 'Колір полотна', 'горіх золотий', null, 'https://stildoors.com.ua/images/dveri/stil/arizona/gorih-zolotiy/sklo-chorne/dveri-stil-arizona-gorih-zolotiy-sklo-chorne.jpg', 8, true),
  ('stildoors-stil-arizona-official', 'color', 'Колір полотна', 'трюфель', null, 'https://stildoors.com.ua/images/dveri/stil/arizona/tryufel/sklo-chorne/dveri-stil-arizona-tryufel-sklo-chorne.jpg', 9, true)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label,
    image_path = excluded.image_path,
    sort_order = excluded.sort_order,
    is_active = true;

insert into public.product_variants
  (product_slug, selections, image_path, sort_order, is_active)
values
  ('stildoors-stil-arizona-official', '{"color":"вільха класична","glass":"чорне"}'::jsonb, 'https://stildoors.com.ua/images/dveri/stil/arizona/vilha-klasichna/sklo-chorne/dveri-stil-arizona-vilha-klasichna-sklo-chorne.jpg', 11, true),
  ('stildoors-stil-arizona-official', '{"color":"вільха класична","glass":"біле"}'::jsonb, 'https://stildoors.com.ua/images/dveri/stil/arizona/vilha-klasichna/sklo-satin/dveri-stil-arizona-vilha-klasichna-sklo-satin.jpg', 12, true),
  ('stildoors-stil-arizona-official', '{"color":"горіх золотий","glass":"чорне"}'::jsonb, 'https://stildoors.com.ua/images/dveri/stil/arizona/gorih-zolotiy/sklo-chorne/dveri-stil-arizona-gorih-zolotiy-sklo-chorne.jpg', 13, true),
  ('stildoors-stil-arizona-official', '{"color":"горіх золотий","glass":"біле"}'::jsonb, 'https://stildoors.com.ua/images/dveri/stil/arizona/gorih-zolotiy/sklo-satin/dveri-stil-arizona-gorih-zolotiy-sklo-satin.jpg', 14, true),
  ('stildoors-stil-arizona-official', '{"color":"трюфель","glass":"чорне"}'::jsonb, 'https://stildoors.com.ua/images/dveri/stil/arizona/tryufel/sklo-chorne/dveri-stil-arizona-tryufel-sklo-chorne.jpg', 15, true),
  ('stildoors-stil-arizona-official', '{"color":"трюфель","glass":"біле"}'::jsonb, 'https://stildoors.com.ua/images/dveri/stil/arizona/tryufel/sklo-satin/dveri-stil-arizona-tryufel-sklo-satin.jpg', 16, true)
on conflict (product_slug, selections) do update
set image_path = excluded.image_path,
    sort_order = excluded.sort_order,
    is_active = true;

commit;

select count(*) as точних_фото_варіантів
from public.product_variants
where product_slug = 'stildoors-stil-arizona-official'
  and is_active;
