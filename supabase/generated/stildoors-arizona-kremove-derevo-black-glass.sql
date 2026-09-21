-- StilDoors Arizona: кремове дерево з чорним склом, офіційне фото.
begin;

insert into public.product_variants
  (product_slug, selections, image_path, sort_order, is_active)
values
  (
    'stildoors-stil-arizona-official',
    '{"color":"кремове дерево","glass":"чорне"}'::jsonb,
    'https://stildoors.com.ua/images/dveri/stil/arizona/kremove-derevo/sklo-chorne/dveri-stil-arizona-kremove-derevo-sklo-chorne.jpg',
    17,
    true
  )
on conflict (product_slug, selections) do update
set image_path = excluded.image_path,
    sort_order = excluded.sort_order,
    is_active = true;

commit;

select count(*) as точних_фото_варіантів
from public.product_variants
where product_slug = 'stildoors-stil-arizona-official'
  and is_active;
