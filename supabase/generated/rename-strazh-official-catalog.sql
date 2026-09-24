-- Страж: службову назву колекції замінюємо на зрозумілу покупцеві.
-- Моделі, фото, характеристики та джерела не видаляються.

begin;

do $$
declare
  old_count integer;
begin
  select count(*) into old_count
  from public.products
  where brand = 'Страж'
    and collection in ('Офіційний каталог Страж', 'Офіційний каталог — перевірити');

  if old_count = 0 then
    raise exception 'Не знайдено моделей Страж зі старою назвою колекції — нічого не змінено';
  end if;
end $$;

update public.products
set collection = 'Усі моделі Страж',
    style = case when style in ('Офіційний каталог', 'Офіційний каталог — перевірити') then 'Офіційний каталог Страж' else style end,
    description = replace(replace(description, 'Офіційний каталог — перевірити', 'Усі моделі Страж'), 'Офіційний каталог Страж', 'Усі моделі Страж'),
    features = (
      select jsonb_agg(
        case
          when item #>> '{}' in ('Колекція Офіційний каталог Страж', 'Колекція Офіційний каталог — перевірити') then to_jsonb('Колекція Усі моделі Страж'::text)
          else item
        end
      )
      from jsonb_array_elements(features) as item
    ),
    updated_at = now()
where brand = 'Страж'
  and collection in ('Офіційний каталог Страж', 'Офіційний каталог — перевірити');

delete from public.catalog_collections
where category = 'entrance'
  and name in ('Офіційний каталог Страж', 'Офіційний каталог — перевірити')
  and brand_id = (select id from public.catalog_brands where name = 'Страж');

insert into public.catalog_collections (brand_id, name, category, description, is_active, sort_order)
select id, 'Усі моделі Страж', 'entrance', 'Повний офіційний каталог вхідних дверей фабрики Страж.', true, 80
from public.catalog_brands
where name = 'Страж'
on conflict (brand_id, name, category) do update
set description = excluded.description,
    is_active = true,
    updated_at = now();

commit;

select
  collection as колекція,
  count(*) as моделей,
  count(*) filter (where is_available) as опубліковано
from public.products
where brand = 'Страж'
group by collection
order by collection;
