-- Q Doors Ультра: три моделі з підтвердженими офіційними картками.

begin;

with ultra(slug, official_name, source_url, source_product_name) as (
  values
    ('catalog-60', 'Q Doors Аккорд АС', 'https://qdoors.ua/shop/ultra-frost', 'Ультра Аккорд-Ас (008)'),
    ('catalog-63', 'Q Doors Лаунж AK', 'https://qdoors.ua/shop/ultra-mirou', 'Ультра Лаунж-Аk (008)'),
    ('catalog-65', 'Q Doors Міроу', 'https://qdoors.ua/shop/ultra-ukkord-as', 'Ультра Міроу (008)')
)
update public.products product
set name = ultra.official_name,
    description = ultra.official_name || ' — вхідні двері серії Ультра для квартири. Полотно 95 мм, сталевий лист 1,8 мм, короб 130 мм та утеплення мінеральною ватою формують посилену конструкцію. Доступні заводські декори й комплектації; актуальну ціну уточнюйте у менеджера.',
    updated_at = now()
from ultra
where product.slug = ultra.slug
  and product.brand = 'Q Doors'
  and product.collection = 'Ультра';

do $$
declare
  checked_count integer;
begin
  select count(*) into checked_count
  from public.products
  where slug in ('catalog-60','catalog-63','catalog-65')
    and brand = 'Q Doors' and collection = 'Ультра';
  if checked_count <> 3 then
    raise exception 'Очікувалось 3 моделі Q Doors Ультра, знайдено % — каталог не змінено', checked_count;
  end if;
end $$;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('catalog-60', 'Qdoors', 'https://qdoors.ua/shop/ultra-frost', 'Ультра Аккорд-Ас (008)', 'verified', now(), 'Офіційна картка Qdoors: назва, серія, фото та технічні параметри.'),
  ('catalog-63', 'Qdoors', 'https://qdoors.ua/shop/ultra-mirou', 'Ультра Лаунж-Аk (008)', 'verified', now(), 'Офіційна картка Qdoors: назва, серія, фото та технічні параметри.'),
  ('catalog-65', 'Qdoors', 'https://qdoors.ua/shop/ultra-ukkord-as', 'Ультра Міроу (008)', 'verified', now(), 'Офіційна картка Qdoors: назва, серія, фото та технічні параметри.')
on conflict (product_slug, source_url) do update
set source_name = excluded.source_name,
    source_product_name = excluded.source_product_name,
    verification_status = 'verified',
    verified_at = now(),
    notes = excluded.notes;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select product_slug, label, value, sort_order, true
from (select unnest(array['catalog-60','catalog-63','catalog-65']) as product_slug) products
cross join (values
  ('Товщина полотна', '95 мм', 10),
  ('Товщина металу', '1,8 мм', 20),
  ('Глибина короба', '130 мм', 30),
  ('Утеплення', 'Мінеральна вата', 40),
  ('Контури ущільнення', '2 контури на полотні', 50),
  ('МДФ-накладки', '16 + 16 мм', 60),
  ('Верхній замок', 'Securemme (Італія)', 70),
  ('Нижній замок', 'Securemme (Італія)', 80),
  ('Циліндр', 'Hardlock 50 × 50 або аналог', 90),
  ('Нічна засувка', 'Apecs', 100)
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
where product.slug in ('catalog-60','catalog-63','catalog-65')
group by product.slug, product.name
order by product.name;
