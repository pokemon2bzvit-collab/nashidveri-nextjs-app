-- Перенесення колишньої фабрики Grand до Rodos.
-- Лінійки DELUX, LUX і Paint є RODOS Grand, а не окремою фабрикою Grand.
-- Скрипт не видаляє моделі, фото, декори, характеристики або URL джерел.
-- Виконати один раз: Supabase → SQL Editor → New query → Run.

begin;

do $$
declare
  grand_products integer;
begin
  select count(*) into grand_products from public.products where brand = 'Grand';

  if grand_products = 0 then
    raise exception 'Товарів фабрики Grand не знайдено. Скрипт уже виконано або дані змінилися.';
  end if;

  if not exists (select 1 from public.products where brand = 'Rodos') then
    raise exception 'Фабрика Rodos не знайдена серед товарів. Зупинено без змін.';
  end if;
end $$;

create temporary table moved_grand_products on commit drop as
select slug from public.products where brand = 'Grand';

-- Назва моделі зберігає лінійку Grand, але показує правильну фабрику Rodos.
update public.products
set
  brand = 'Rodos',
  name = regexp_replace(name, '^Grand[[:space:]]+', 'Rodos Grand ', 'i'),
  description = regexp_replace(description, '^Grand(,|[[:space:]])', 'Rodos Grand\1', 'i'),
  features = coalesce(
    (
      select jsonb_agg(
        case when item.value = 'Фабрика Grand' then 'Фабрика Rodos' else item.value end
        order by item.ordinality
      )
      from jsonb_array_elements_text(products.features) with ordinality as item(value, ordinality)
    ),
    '[]'::jsonb
  ),
  updated_at = now()
where brand = 'Grand';

-- У технічних характеристиках також оновлюємо фабрику, не змінюючи лінійку RODOS Grand.
update public.product_specs specs
set value = 'Rodos'
where specs.product_slug in (select slug from moved_grand_products)
  and lower(specs.label) in ('фабрика', 'виробник')
  and lower(specs.value) = 'grand';

-- Переносимо довідникові колекції в структуру Rodos, зберігаючи опис, фото та порядок.
insert into public.catalog_collections (brand_id, name, category, description, image_path, is_active, sort_order)
select rodos.id, collections.name, collections.category, collections.description, collections.image_path, collections.is_active, collections.sort_order
from public.catalog_collections collections
join public.catalog_brands grand on grand.id = collections.brand_id and grand.name = 'Grand'
join public.catalog_brands rodos on rodos.name = 'Rodos'
on conflict (brand_id, name, category) do update set
  description = excluded.description,
  image_path = coalesce(excluded.image_path, catalog_collections.image_path),
  is_active = excluded.is_active,
  sort_order = excluded.sort_order,
  updated_at = now();

delete from public.catalog_collections
where brand_id in (select id from public.catalog_brands where name = 'Grand');

update public.catalog_brands
set description = 'Міжкімнатні двері Rodos, зокрема лінійки RODOS Grand DELUX, LUX і Paint.', updated_at = now()
where name = 'Rodos';

-- Після перенесення товарів і колекцій Grand більше не є фабрикою каталогу.
delete from public.catalog_brands
where name = 'Grand'
  and not exists (select 1 from public.products where brand = 'Grand');

commit;

-- Контрольний результат: Grand має бути 0, Rodos — на 37 моделей більше.
select brand, count(*) as models
from public.products
where brand in ('Grand', 'Rodos')
group by brand
order by brand;
