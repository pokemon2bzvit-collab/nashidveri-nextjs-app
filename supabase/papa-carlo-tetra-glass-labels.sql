-- Papa Carlo Tetra: зрозумілі назви варіантів скла для покупця.
-- Не змінює фото, моделі або інші характеристики.

begin;

update public.product_options option_row
set label = case option_row.label
  when 'Чорний' then 'Чорне скло'
  when 'Сатин / Чорне' then 'Сатин / чорне скло'
  else option_row.label
end
where option_row.product_slug in (
  select slug
  from public.products
  where brand = 'Papa Carlo'
    and collection = 'Tetra'
    and is_available = true
)
and option_row.option_group = 'glass'
and option_row.label in ('Чорний', 'Сатин / Чорне');

update public.product_variants variant_row
set selections = jsonb_set(
  variant_row.selections,
  '{glass}',
  to_jsonb(case variant_row.selections ->> 'glass'
    when 'Чорний' then 'Чорне скло'
    when 'Сатин / Чорне' then 'Сатин / чорне скло'
  end)
)
where variant_row.product_slug in (
  select slug
  from public.products
  where brand = 'Papa Carlo'
    and collection = 'Tetra'
    and is_available = true
)
and variant_row.selections ->> 'glass' in ('Чорний', 'Сатин / Чорне');

commit;

select p.name as модель, o.label as варіант_скла
from public.products p
join public.product_options o on o.product_slug = p.slug
where p.brand = 'Papa Carlo'
  and p.collection = 'Tetra'
  and p.is_available = true
  and o.is_active = true
  and o.option_group = 'glass'
order by p.name, o.sort_order;
