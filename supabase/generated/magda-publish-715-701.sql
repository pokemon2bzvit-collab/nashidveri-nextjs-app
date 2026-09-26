-- Magda: публікація моделей 715 та 701.
-- Модель 807 уже була опублікована; цей запит її не змінює.

update public.products
set is_available = true, updated_at = now()
where slug in ('magda-715-thermal-official', 'magda-701-official')
  and not is_available;

select slug, name as "модель", collection as "колекція", is_available as "опубліковано"
from public.products
where slug in ('magda-715-thermal-official', 'magda-701-official')
order by name;
