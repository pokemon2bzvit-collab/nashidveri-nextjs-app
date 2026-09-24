-- Q Doors Преміум: лише три моделі з точно підтвердженими офіційними картками.
-- «Стиль M» навмисно не змінюється: під цією назвою його не знайдено в актуальному каталозі.

begin;

with premium(slug, source_url, source_product_name) as (
  values
    ('catalog-61', 'https://qdoors.ua/shop/premium-stil-m-1', 'Преміум Бостон-М (008)'),
    ('catalog-64', 'https://qdoors.ua/shop/premium-provans-1', 'Преміум Люксор (008)'),
    ('catalog-67', 'https://qdoors.ua/shop/premium-kombi-ak', 'Преміум Тріоні-Аk (008)')
)
insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select slug, 'Qdoors', source_url, source_product_name, 'verified', now(), 'Офіційна картка Qdoors: назва, серія, фото та технічні параметри.'
from premium
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
  where slug in ('catalog-61','catalog-64','catalog-67')
    and brand = 'Q Doors' and collection = 'Преміум';
  if checked_count <> 3 then
    raise exception 'Очікувалось 3 підтверджені моделі Q Doors Преміум, знайдено % — каталог не змінено', checked_count;
  end if;
end $$;

update public.products
set description = name || ' — вхідні двері серії Преміум для квартири. Полотно 85 мм, сталевий лист 1,5 мм, короб 115 мм та утеплення мінеральною ватою забезпечують практичну комплектацію для щоденного користування. Доступні заводські декори; актуальну ціну уточнюйте у менеджера.',
    updated_at = now()
where slug in ('catalog-61','catalog-64','catalog-67')
  and brand = 'Q Doors' and collection = 'Преміум';

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select product_slug, label, value, sort_order, true
from (select unnest(array['catalog-61','catalog-64','catalog-67']) as product_slug) products
cross join (values
  ('Товщина полотна', '85 мм', 10),
  ('Товщина металу', '1,5 мм', 20),
  ('Глибина короба', '115 мм', 30),
  ('Утеплення', 'Мінеральна вата', 40),
  ('Контури ущільнення', '2 контури на полотні', 50),
  ('МДФ-накладки', '16 + 16 мм', 60),
  ('Верхній замок', 'Kale 257', 70),
  ('Нижній замок', 'Kale 252', 80)
) as spec(label, value, sort_order)
on conflict (product_slug, label) do update
set value = excluded.value,
    sort_order = excluded.sort_order,
    is_active = true;

commit;

select product.name as модель,
       count(distinct source.source_url) filter (where source.source_name = 'Qdoors') as офіційних_джерел,
       count(distinct spec.id) filter (where spec.is_active) as характеристик
from public.products product
left join public.product_sources source on source.product_slug = product.slug
left join public.product_specs spec on spec.product_slug = product.slug
where product.slug in ('catalog-61','catalog-64','catalog-67')
group by product.slug, product.name
order by product.name;
