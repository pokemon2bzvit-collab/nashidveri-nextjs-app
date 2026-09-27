-- Попередній перегляд нового єдиного стилю описів Magda.
-- НІЧОГО НЕ ЗМІНЮЄ у каталозі.

with magda as (
  select
    p.slug,
    p.name,
    p.collection,
    p.description as "поточний_опис",
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
    name,
    collection,
    "поточний_опис",
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
        when source_text like '%патин%' then 'Зовнішнє оздоблення може бути виконане з патинуванням.'
        else 'Доступні заводські декори та варіанти комплектації.'
      end,
      'Допоможемо підібрати декор, розмір і актуальну комплектацію для вашого об’єкта.'
    ) as "новий_опис"
  from magda
)
select slug, name as "модель", collection as "колекція", "новий_опис"
from drafts
order by name
limit 24;
