-- Papa Carlo Tetra: пошук моделей, що відрізняються лише вставкою зі склом.
-- Безпечний запит: нічого не змінює.
-- Шукає пари на зразок «T-11» і «T-11 (BLK)», «глухе» / «зі склом».

with tetra as (
  select
    p.slug,
    p.name,
    p.is_available,
    p.image_path,
    -- Основа назви без позначення скла або типу полотна.
    lower(regexp_replace(
      translate(p.name, 'Тт', 'Tt'),
      '\s*(\(?\s*(blk|скло|сатин|матов[еа]|прозор[еа]|дзеркал[оа]?|глух[еа]?|пг|по)\s*\)?).*$',
      '',
      'i'
    )) as base_model,
    coalesce((select string_agg(o.label, ', ' order by o.sort_order)
      from public.product_options o
      where o.product_slug = p.slug and o.is_active = true and o.option_group = 'glass'), '—') as скло_в_конфігураторі,
    coalesce((select string_agg(s.value, ' | ' order by s.sort_order)
      from public.product_specs s
      where s.product_slug = p.slug and s.is_active = true and s.label ~* 'скло|тип полотна'), '—') as дані_про_скло,
    (select count(*) from public.product_variants v
      where v.product_slug = p.slug and v.is_active = true) as фото_варіантів
  from public.products p
  where p.brand = 'Papa Carlo'
    and p.collection = 'Tetra'
), candidates as (
  select base_model
  from tetra
  group by base_model
  having count(*) > 1
)
select
  t.base_model as базова_модель,
  t.slug,
  t.name as назва,
  case when t.is_available then 'показується' else 'прихована' end as статус,
  t.скло_в_конфігураторі,
  t.дані_про_скло,
  t.фото_варіантів,
  t.image_path as головне_фото
from tetra t
join candidates c using (base_model)
order by t.base_model, t.name;
