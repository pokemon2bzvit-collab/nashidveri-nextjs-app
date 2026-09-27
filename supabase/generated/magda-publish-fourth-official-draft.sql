-- Magda: публікація лише моделі 530.1.
-- Офіційне джерело й дві активні фотографії вже перевірені окремим запитом.

update public.products
set is_available = true, updated_at = now()
where slug = 'magda-530-1-official' and not is_available;

select slug, name as "модель", is_available as "опубліковано"
from public.products where slug = 'magda-530-1-official';
