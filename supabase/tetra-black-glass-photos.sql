-- Papa Carlo Tetra: додає наявне точне фото до вибору «скло чорне».
-- Працює лише з моделями, де така опція вже є у конфігураторі.

begin;

update public.product_options option_row
set image_path = product.image_path
from public.products product
where option_row.product_slug = product.slug
  and product.brand = 'Papa Carlo'
  and product.collection = 'Tetra'
  and option_row.is_active = true
  and option_row.option_group = 'glass'
  and option_row.label ~* 'скло\s+чорне'
  and product.image_path is not null
  and product.image_path <> '';

insert into public.product_variants (
  product_slug, selections, image_path, sort_order, is_active
)
select
  product.slug,
  jsonb_build_object('glass', option_row.label),
  product.image_path,
  90,
  true
from public.products product
join public.product_options option_row
  on option_row.product_slug = product.slug
 and option_row.is_active = true
 and option_row.option_group = 'glass'
 and option_row.label ~* 'скло\s+чорне'
where product.brand = 'Papa Carlo'
  and product.collection = 'Tetra'
  and product.image_path is not null
  and product.image_path <> ''
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

commit;

select
  product.name as модель,
  option_row.label as скло,
  variant.image_path as фото_в_конфігураторі
from public.products product
join public.product_options option_row
  on option_row.product_slug = product.slug
 and option_row.is_active = true
 and option_row.option_group = 'glass'
 and option_row.label ~* 'скло\s+чорне'
join public.product_variants variant
  on variant.product_slug = product.slug
 and variant.is_active = true
 and variant.selections ->> 'glass' = option_row.label
where product.brand = 'Papa Carlo'
  and product.collection = 'Tetra'
order by product.name;
