-- Q Doors Авангард: Босфор AK з офіційної картки виробника.
-- Оновлює лише наявну модель catalog-62.

begin;

do $$
begin
  if not exists (
    select 1 from public.products
    where slug = 'catalog-62' and brand = 'Q Doors' and collection = 'Авангард'
  ) then
    raise exception 'Модель Q Doors Босфор AK у серії Авангард не знайдена — нічого не змінено';
  end if;
end $$;

update public.products
set description = 'Q Doors Босфор AK — вхідні двері серії Авангард для квартири. Полотно 95 мм, сталевий лист 1,8 мм, короб 130 мм та утеплення мінеральною ватою поєднують захист і комфорт. Доступні заводські декори та комплектація; актуальну ціну уточнюйте у менеджера.',
    updated_at = now()
where slug = 'catalog-62' and brand = 'Q Doors';

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values ('catalog-62', 'Qdoors', 'https://qdoors.ua/shop/avangard-tiffani-1', 'Авангард Босфор-АК (002)', 'verified', now(), 'Офіційна картка Qdoors: назва, серія, фото та технічні параметри.')
on conflict (product_slug, source_url) do update
set source_name = excluded.source_name,
    source_product_name = excluded.source_product_name,
    verification_status = 'verified',
    verified_at = now(),
    notes = excluded.notes;

insert into public.product_specs (product_slug, label, value, sort_order, is_active) values
  ('catalog-62', 'Товщина полотна', '95 мм', 10, true),
  ('catalog-62', 'Товщина металу', '1,8 мм', 20, true),
  ('catalog-62', 'Глибина короба', '130 мм', 30, true),
  ('catalog-62', 'Утеплення', 'Мінеральна вата', 40, true),
  ('catalog-62', 'Контури ущільнення', '2 контури на полотні', 50, true),
  ('catalog-62', 'МДФ-накладки', '16 + 16 мм', 60, true),
  ('catalog-62', 'Замкова система', 'Mottura 54 787 TSBM Z55', 70, true)
on conflict (product_slug, label) do update
set value = excluded.value,
    sort_order = excluded.sort_order,
    is_active = true;

commit;

select product.name as модель,
       source.source_url as офіційна_картка,
       count(spec.id) filter (where spec.is_active) as характеристик
from public.products product
left join public.product_sources source on source.product_slug = product.slug and source.source_name = 'Qdoors'
left join public.product_specs spec on spec.product_slug = product.slug
where product.slug = 'catalog-62'
group by product.name, source.source_url;
