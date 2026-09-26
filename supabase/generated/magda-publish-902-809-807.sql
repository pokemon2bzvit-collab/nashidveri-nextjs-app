-- Magda: публікація моделей 902.1, 809 та 807.

update public.products
set is_available = true, updated_at = now()
where slug in ('magda-902-1-official', 'magda-809-official', 'magda-807-official')
  and not is_available;

select slug, name as "модель", collection as "колекція", is_available as "опубліковано"
from public.products
where slug in ('magda-902-1-official', 'magda-809-official', 'magda-807-official')
order by name;
