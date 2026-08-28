-- RODOS Cortes Prima: реальні фото трьох конструкцій полотна.
-- Джерело: офіційна сторінка RODOS Cortes Prima та фото моделей,
-- уже завантажені в bucket catalog-images.
-- Цей скрипт не створює штучних рендерів кольорів RAL.

insert into public.product_options (product_slug, option_group, group_label, label, image_path, sort_order)
select product.slug, 'configuration', 'Вид полотна', option.label, option.image_path, option.sort_order
from public.products as product
cross join (values
  ('Глухе', 'media/catalog-207.jpg', 1),
  ('Напівскло', 'media/catalog-208.jpg', 2),
  ('Скло', 'media/catalog-209.jpg', 3)
) as option(label, image_path, sort_order)
where product.slug in ('catalog-207', 'catalog-208', 'catalog-209')
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label,
    image_path = excluded.image_path,
    sort_order = excluded.sort_order,
    is_active = true;
