-- Magda: публікація моделей 700, 700.1 та 720.1.

update public.products
set is_available = true, updated_at = now()
where slug in ('magda-700-official', 'magda-700-1-official', 'magda-720-1-official')
  and not is_available;

select slug, name as "модель", collection as "колекція", is_available as "опубліковано"
from public.products
where slug in ('magda-700-official', 'magda-700-1-official', 'magda-720-1-official')
order by name;
