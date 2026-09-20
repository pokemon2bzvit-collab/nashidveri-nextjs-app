-- Страж: прибирає дубль назви фабрики з імпортованих офіційних моделей.
-- На сторінці бренд виводиться окремо, тому «Страж Страж Abris» стає «Страж Abris».

begin;

update public.products
set name = regexp_replace(name, '^Страж\\s+', '', 'i'),
    updated_at = now()
where brand = 'Страж'
  and slug like 'strazh-official-%'
  and name ~* '^Страж\\s+';

commit;

select count(*) as моделей_без_дубля_бренду
from public.products
where brand = 'Страж'
  and slug like 'strazh-official-%'
  and name !~* '^Страж\\s+';
