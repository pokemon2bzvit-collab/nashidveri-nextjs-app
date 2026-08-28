-- RODOS Atlantic 001–006: реальні фото конструкцій полотна.
-- Використовуються тільки моделі, які окремо присутні в каталозі та bucket catalog-images.

with variants(product_slugs, label, image_path, sort_order) as (
  values
    (array['catalog-180', 'catalog-181'], 'Глухе', 'media/catalog-181.jpg', 1),
    (array['catalog-180', 'catalog-181'], 'Скло', 'media/catalog-180.jpg', 2),
    (array['catalog-182', 'catalog-183', 'catalog-184'], 'Глухе', 'media/catalog-182.jpg', 1),
    (array['catalog-182', 'catalog-183', 'catalog-184'], 'Напівскло', 'media/catalog-183.jpg', 2),
    (array['catalog-182', 'catalog-183', 'catalog-184'], 'Скло', 'media/catalog-184.jpg', 3),
    (array['catalog-185', 'catalog-186'], 'Глухе', 'media/catalog-185.jpg', 1),
    (array['catalog-185', 'catalog-186'], 'Напівскло', 'media/catalog-186.jpg', 2),
    (array['catalog-187', 'catalog-188', 'catalog-189'], 'Глухе', 'media/catalog-187.jpg', 1),
    (array['catalog-187', 'catalog-188', 'catalog-189'], 'Напівскло', 'media/catalog-188.jpg', 2),
    (array['catalog-187', 'catalog-188', 'catalog-189'], 'Скло', 'media/catalog-189.jpg', 3),
    (array['catalog-190', 'catalog-191'], 'Глухе', 'media/catalog-190.jpg', 1),
    (array['catalog-190', 'catalog-191'], 'Скло', 'media/catalog-191.jpg', 2),
    (array['catalog-192', 'catalog-193'], 'Глухе', 'media/catalog-192.jpg', 1),
    (array['catalog-192', 'catalog-193'], 'Скло', 'media/catalog-193.jpg', 2)
)
insert into public.product_options (product_slug, option_group, group_label, label, image_path, sort_order)
select product_slug, 'configuration', 'Вид полотна', variants.label, variants.image_path, variants.sort_order
from variants
cross join unnest(variants.product_slugs) as product_slug
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label,
    image_path = excluded.image_path,
    sort_order = excluded.sort_order,
    is_active = true;
