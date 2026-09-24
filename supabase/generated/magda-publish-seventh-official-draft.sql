-- Magda: публікація моделі 175.

update public.products
set is_available = true, updated_at = now()
where slug = 'magda-175-official' and not is_available;

select slug, name as "модель", collection as "колекція", is_available as "опубліковано"
from public.products where slug = 'magda-175-official';
