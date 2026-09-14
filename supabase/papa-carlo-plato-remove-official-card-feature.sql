-- Прибирає службову позначку з клієнтського блоку «Основна інформація».
update public.products
set features = coalesce(
  (
    select jsonb_agg(item)
    from jsonb_array_elements_text(coalesce(features, '[]'::jsonb)) as item
    where item <> 'Офіційна картка виробника'
  ),
  '[]'::jsonb
)
where brand = 'Papa Carlo'
  and collection = 'Plato';

select count(*) filter (where features::text ilike '%Офіційна картка виробника%') as пунктів_що_залишилось
from public.products
where brand = 'Papa Carlo'
  and collection = 'Plato';
