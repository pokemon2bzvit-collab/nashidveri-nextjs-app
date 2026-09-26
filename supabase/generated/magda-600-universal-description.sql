-- Уточнення опису Magda №600: модель має квартирні та вуличні комплектації.

begin;

update public.products
set description = 'Magda Модель №600 — вхідні двері з офіційного каталогу виробника. Для моделі доступні квартирне та вуличне виконання, зокрема варіант із терморозривом. Підкажемо тип комплектації, декор і розмір для вашого об’єкта.',
    updated_at = now()
where slug = 'magda-600-official'
  and brand = 'Magda';

commit;

select slug, name as "модель", collection as "колекція", description as "опис"
from public.products
where slug = 'magda-600-official';
