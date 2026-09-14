-- Публікація лише перевіреної офіційної моделі Papa Carlo T-18.
-- Інші товари та колекції не змінюються.

update public.products
set is_available = true,
    updated_at = now()
where slug = 'papa-carlo-t-18-official'
  and brand = 'Papa Carlo'
  and collection = 'Tetra';

-- Перевірка результату.
select slug, name, brand, collection, is_available, image_path
from public.products
where slug = 'papa-carlo-t-18-official';
