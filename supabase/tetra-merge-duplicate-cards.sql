-- Papa Carlo Tetra: прибирає повторні картки, зберігаючи їхні фото.
-- Дублікати лише ховаються, не видаляються. Їх можна повернути за slug.

begin;

-- Додаткові фото зі старих карток залишаються в галереях основних моделей.
insert into public.product_media (
  product_slug, kind, label, image_path, sort_order, is_active
)
select
  map.target_slug,
  'gallery',
  'Додаткове фото моделі',
  source.image_path,
  95,
  true
from (values
  ('catalog-133', 'catalog-146'), -- T-01
  ('catalog-134', 'catalog-147'), -- T-02
  ('catalog-135', 'catalog-148'), -- T-03
  ('catalog-119', 'catalog-149'), -- T-04
  ('catalog-136', 'catalog-150'), -- T-12
  ('catalog-128', 'catalog-151')  -- T-14
) as map(target_slug, source_slug)
join public.products source on source.slug = map.source_slug
where source.image_path is not null
  and source.image_path <> ''
on conflict (product_slug, kind, image_path) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = true;

-- Повторні картки не показуються покупцям, але записи та фото залишаються у базі.
update public.products
set is_available = false,
    updated_at = now()
where slug in (
  'catalog-146', -- T-01
  'catalog-147', -- T-02
  'catalog-148', -- T-03
  'catalog-149', -- T-04
  'catalog-150', -- T-12
  'catalog-151'  -- T-14
)
and brand = 'Papa Carlo'
and collection = 'Tetra';

-- Однаковий підпис для плиток каталогу; конкретне покриття лишається в характеристиках.
update public.products
set material = 'Міжкімнатні',
    updated_at = now()
where brand = 'Papa Carlo'
  and collection = 'Tetra'
  and material is distinct from 'Міжкімнатні';

commit;

-- Контроль після виконання.
select
  p.slug,
  p.name,
  p.material,
  p.is_available,
  count(m.image_path) filter (where m.is_active = true) as фото_в_галереї
from public.products p
left join public.product_media m on m.product_slug = p.slug
where p.slug in (
  'catalog-119', 'catalog-128', 'catalog-133', 'catalog-134', 'catalog-135', 'catalog-136',
  'catalog-146', 'catalog-147', 'catalog-148', 'catalog-149', 'catalog-150', 'catalog-151'
)
group by p.slug, p.name, p.material, p.is_available
order by p.name, p.slug;
