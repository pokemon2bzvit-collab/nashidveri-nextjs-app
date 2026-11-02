-- Rodos Steel: створити окрему колекцію «Складська програма»
-- і віднести до неї 12 позицій складської програми.
-- Публікує позиції в каталозі; фактичний складський залишок не змінює.

begin;

do $$
declare
  expected_count integer := 12;
  actual_count integer;
begin
  select count(*) into actual_count
  from public.products
  where brand = 'Rodos Steel'
    and slug in (
      'rodos-official-1n92ed9', -- F 114
      'rodos-official-t7a3qa',  -- F 124 LTL 6515
      'rodos-official-1rhs1v',  -- F 124 LTL 6908
      'rodos-official-1vzimf6', -- F 144
      'rodos-official-1n92ec3', -- F 129
      'rodos-official-1jb31c9', -- F 162 RAL 7016
      'rodos-official-ug219x',  -- F 162 RAL 8017
      'rodos-official-vr68i9',  -- F 166
      'rodos-official-1va3l7w', -- F 203 графіт
      'rodos-official-1xykyfg', -- F 203 дерево
      'rodos-official-1lx612j', -- F 204 графіт
      'rodos-official-1mfx6ff'  -- F 204 дерево
    );

  if actual_count <> expected_count then
    raise exception 'Очікувалось 12 моделей Rodos Steel, знайдено % — зміни скасовано', actual_count;
  end if;
end $$;

insert into public.catalog_collections (brand_id, name, category, description, is_active, sort_order)
select
  id,
  'Складська програма',
  'entrance',
  'У складській програмі Rodos Steel зібрані моделі для квартири й будинку з різними дизайнами та комплектаціями. Тут можна порівняти варіанти оздоблення й обрати двері для свого простору.',
  true,
  30
from public.catalog_brands
where name = 'Rodos Steel'
on conflict (brand_id, name, category) do update
set description = excluded.description,
    is_active = true,
    updated_at = now();

update public.products as p
set collection = 'Складська програма',
    style = 'Колекція Складська програма',
    is_available = true,
    features = (
      select coalesce(jsonb_agg(feature), '[]'::jsonb)
      from (
        select distinct case
          when f.value like 'Колекція %' then 'Колекція Складська програма'
          else f.value
        end as feature
        from jsonb_array_elements_text(coalesce(p.features, '[]'::jsonb)) as f(value)
        union
        select 'Колекція Складська програма'
      ) as normalized_features
    ),
    updated_at = now()
where p.brand = 'Rodos Steel'
  and p.slug in (
    'rodos-official-1n92ed9',
    'rodos-official-t7a3qa',
    'rodos-official-1rhs1v',
    'rodos-official-1vzimf6',
    'rodos-official-1n92ec3',
    'rodos-official-1jb31c9',
    'rodos-official-ug219x',
    'rodos-official-vr68i9',
    'rodos-official-1va3l7w',
    'rodos-official-1xykyfg',
    'rodos-official-1lx612j',
    'rodos-official-1mfx6ff'
  );

select slug, name, collection, style, is_available as published
from public.products
where brand = 'Rodos Steel'
  and collection = 'Складська програма'
order by name;

commit;
