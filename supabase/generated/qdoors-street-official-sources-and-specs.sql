-- Q Doors Street: офіційні джерела та підтверджені базові параметри.
-- Не змінює доступність товарів і не видаляє наявні фото чи варіанти.

begin;

with street(slug, name, source_url, source_product_name) as (
  values
    ('catalog-54', 'Q Doors Стріт Арт', 'https://qdoors.ua/shop/qdoors-strit-flaj-ral7021bila-shagren-3k-chb-ruchka-1450-copy', 'Qdoors Стріт Арт RAL7021/біла шагрень 3к Ч/Б ручка 1450'),
    ('catalog-55', 'Q Doors Стріт Горизонталь', 'https://qdoors.ua/shop/street-gorizont', 'Qdoors Стріт 3к ручка 1450 Горизонт/Гладь біла шагрень'),
    ('catalog-56', 'Q Doors Стріт Елегант', 'https://qdoors.ua/shop/qdoors-strit-elegantglad-950-pr-bila-shagren-lakabel-chb3kruchka-1450-2', 'Qdoors Стріт Елегант RAL8019/біла шагрень 3к К/Б ручка 1450'),
    ('catalog-57', 'Q Doors Стріт Лайт', 'https://qdoors.ua/shop/qdoors-strit-flaj-ral7021bila-shagren-2k-chb', 'Qdoors Стріт Лайт RAL7021/біла шагрень 2к Ч/Б'),
    ('catalog-58', 'Q Doors Стріт Спейс', 'https://qdoors.ua/shop/qdoors-strit-elegantglad-950-pr-bila-shagren-lakabel-chb3kruchka-1450-1', 'Qdoors Стріт Спейс RAL7021/біла шагрень 3к Ч/Б ручка 1450'),
    ('catalog-59', 'Q Doors Стріт Флай', 'https://qdoors.ua/shop/qdoors-strit-2k-elegant-glad-bila-shagren', 'Qdoors Стріт Флай RAL7021/біла шагрень 2к Ч/Б')
), checked as (
  select street.*
  from street
  join public.products product on product.slug = street.slug
  where product.brand = 'Q Doors' and product.collection = 'Street'
)
insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select slug, 'Qdoors', source_url, source_product_name, 'verified', now(), 'Офіційна картка Qdoors: серія Street, фото та базові технічні параметри.'
from checked
on conflict (product_slug, source_url) do update
set source_name = excluded.source_name,
    source_product_name = excluded.source_product_name,
    verification_status = 'verified',
    verified_at = now(),
    notes = excluded.notes;

do $$
declare
  checked_count integer;
begin
  select count(*) into checked_count
  from public.products
  where slug in ('catalog-54','catalog-55','catalog-56','catalog-57','catalog-58','catalog-59')
    and brand = 'Q Doors'
    and collection = 'Street';
  if checked_count <> 6 then
    raise exception 'Очікувалось 6 моделей Q Doors Street, знайдено % — характеристики не змінено', checked_count;
  end if;
end $$;

update public.products
set description = name || ' — вуличні вхідні двері серії Street. Конструкція: полотно 100 мм, сталевий лист 1,5 мм, короб 140 мм із терморозривом та утепленням мінеральною ватою. Доступні заводські декори й комплектації; актуальну ціну уточнюйте у менеджера.',
    updated_at = now()
where slug in ('catalog-54','catalog-55','catalog-56','catalog-57','catalog-58','catalog-59')
  and brand = 'Q Doors'
  and collection = 'Street';

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select product_slug, label, value, sort_order, true
from (
  select unnest(array['catalog-54','catalog-55','catalog-56','catalog-57','catalog-58','catalog-59']) as product_slug
) products
cross join (values
  ('Товщина полотна', '100 мм', 10),
  ('Товщина металу', '1,5 мм', 20),
  ('Глибина короба', '140 мм із терморозривом', 30),
  ('Утеплення', 'Мінеральна вата', 40),
  ('Контури ущільнення', '3 контури', 50)
) as spec(label, value, sort_order)
on conflict (product_slug, label) do update
set value = excluded.value,
    sort_order = excluded.sort_order,
    is_active = true;

commit;

select
  product.name as модель,
  count(distinct source.source_url) filter (where source.source_name ilike '%qdoors%') as офіційних_джерел,
  count(distinct spec.id) filter (where spec.is_active) as характеристик
from public.products product
left join public.product_sources source on source.product_slug = product.slug
left join public.product_specs spec on spec.product_slug = product.slug
where product.slug in ('catalog-54','catalog-55','catalog-56','catalog-57','catalog-58','catalog-59')
group by product.slug, product.name
order by product.name;
