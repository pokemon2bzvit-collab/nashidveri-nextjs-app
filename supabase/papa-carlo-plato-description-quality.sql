-- Доповнює описи всіх моделей Papa Carlo / Plato без дублювання тексту.
update public.products
set description = trim(concat_ws(' ', description,
  'Двері відрізняються високою якістю й елегантним дизайном, тому гармонійно доповнюють сучасний інтер''єр. Доступні різні кольори та варіанти оздоблення, щоб підібрати модель під ваш простір.'))
where brand = 'Papa Carlo'
  and collection = 'Plato'
  and coalesce(description, '') not ilike '%Двері відрізняються високою якістю%';

select count(*) as моделей_з_оновленим_описом
from public.products
where brand = 'Papa Carlo'
  and collection = 'Plato'
  and description ilike '%Двері відрізняються високою якістю%';
