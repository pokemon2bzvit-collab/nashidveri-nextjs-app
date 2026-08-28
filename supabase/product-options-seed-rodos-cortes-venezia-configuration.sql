-- RODOS Cortes Venezia: реальні фото двох конструкцій полотна.

insert into public.product_options (product_slug, option_group, group_label, label, image_path, sort_order)
select product_slug, 'configuration', 'Вид полотна', option.label, option.image_path, option.sort_order
from (values
  ('catalog-214', 'Глухе', 'media/catalog-214.jpg', 1),
  ('catalog-214', 'Напівскло', 'media/catalog-215.jpg', 2),
  ('catalog-215', 'Глухе', 'media/catalog-214.jpg', 1),
  ('catalog-215', 'Напівскло', 'media/catalog-215.jpg', 2)
) as option(product_slug, label, image_path, sort_order)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label,
    image_path = excluded.image_path,
    sort_order = excluded.sort_order,
    is_active = true;
