-- RODOS Cortes Galant: реальні фото трьох конструкцій полотна.
-- Фото моделей уже завантажені в bucket catalog-images.

insert into public.product_options (product_slug, option_group, group_label, label, image_path, sort_order)
select product.slug, 'configuration', 'Вид полотна', option.label, option.image_path, option.sort_order
from public.products as product
cross join (values
  ('Глухе', 'media/catalog-197.jpg', 1),
  ('Напівскло', 'media/catalog-198.jpg', 2),
  ('Скло', 'media/catalog-199.jpg', 3)
) as option(label, image_path, sort_order)
where product.slug in ('catalog-197', 'catalog-198', 'catalog-199')
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label,
    image_path = excluded.image_path,
    sort_order = excluded.sort_order,
    is_active = true;
