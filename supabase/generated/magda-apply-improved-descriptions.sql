-- Єдиний, природніший стиль описів для всіх опублікованих моделей Magda.
-- Особливості моделі (терморозрив, склопакет, дзеркало, патина) зберігаються в тексті.

begin;

do $$
declare target_count integer;
begin
  select count(*) into target_count
  from public.products
  where brand = 'Magda' and is_available;
  if target_count < 100 then
    raise exception 'Очікувалось щонайменше 100 опублікованих моделей Magda, знайдено % — описів не змінено', target_count;
  end if;
end $$;

with magda as (
  select
    p.slug,
    p.name,
    p.collection,
    lower(concat_ws(' ', p.description, p.features::text, coalesce((
      select string_agg(concat(s.label, ' ', s.value), ' ' order by s.sort_order)
      from public.product_specs s
      where s.product_slug = p.slug and s.is_active
    ), ''))) as source_text
  from public.products p
  where p.brand = 'Magda' and p.is_available
), drafts as (
  select
    slug,
    concat_ws(' ',
      name || ' — ' || case
        when source_text ~ 'квартирн.{0,50}вуличн|вуличн.{0,50}квартирн' then 'вхідні двері, доступні у квартирному та вуличному виконанні.'
        when collection = 'Квартира' then 'вхідні двері для квартири.'
        when collection = 'Вулиця' then 'вхідні двері для приватного будинку.'
        else 'вхідні двері з офіційного каталогу виробника.'
      end,
      case
        when source_text like '%терморозрив%' then 'Для моделі доступний варіант із терморозривом.'
        when source_text like '%склопакет%' then 'Доступне виконання зі склопакетом.'
        when source_text like '%дзеркал%' then 'Доступне виконання з дзеркалом на внутрішній стороні.'
        when source_text like '%патин%' then 'Зовнішнє оздоблення доповнює патинування.'
        when collection = 'Квартира' then 'Модель представлена в заводських декорах і комплектаціях — допоможемо підібрати варіант під ваш інтер’єр.'
        when collection = 'Вулиця' then 'Модель представлена в заводських декорах і комплектаціях — допоможемо підібрати варіант для фасаду та інтер’єру.'
        else 'Доступні заводські декори та варіанти комплектації.'
      end,
      'Уточнимо розмір, комплектацію та актуальну ціну.'
    ) as description
  from magda
), updated as (
  update public.products p
  set description = d.description,
      updated_at = now()
  from drafts d
  where p.slug = d.slug
  returning p.slug
)
select count(*) as "оновлено_описів" from updated;

commit;

select slug, name as "модель", collection as "колекція", description as "опис"
from public.products
where slug in ('magda-600-official', 'magda-112-official', 'magda-151-1-official', 'magda-107-official')
order by name;
