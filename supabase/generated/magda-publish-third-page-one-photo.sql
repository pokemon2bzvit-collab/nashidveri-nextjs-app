-- Magda: публікація трьох перевірених моделей з одним офіційним фото.

update public.products
set is_available = true, updated_at = now()
where slug in ('magda-605-official', 'magda-608-official', 'magda-612-official')
  and not is_available;

select slug, name as "модель", collection as "колекція", is_available as "опубліковано"
from public.products
where slug in ('magda-605-official', 'magda-608-official', 'magda-612-official')
order by name;
