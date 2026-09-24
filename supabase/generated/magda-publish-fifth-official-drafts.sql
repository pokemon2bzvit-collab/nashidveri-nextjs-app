-- Magda: публікація моделей 717 та 702.1.

update public.products
set is_available = true, updated_at = now()
where slug in ('magda-717-official','magda-702-1-official')
  and not is_available;

select slug, name as "модель", collection as "колекція", is_available as "опубліковано"
from public.products
where slug in ('magda-717-official','magda-702-1-official')
order by name;
