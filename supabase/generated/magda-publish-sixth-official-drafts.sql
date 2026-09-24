-- Magda: публікація моделей 178 та 529.1.

update public.products
set is_available = true, updated_at = now()
where slug in ('magda-178-official','magda-529-1-official')
  and not is_available;

select slug, name as "модель", collection as "колекція", is_available as "опубліковано"
from public.products
where slug in ('magda-178-official','magda-529-1-official')
order by name;
