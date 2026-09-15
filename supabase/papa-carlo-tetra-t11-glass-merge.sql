-- Papa Carlo T-11: об'єднання старої окремої картки T-11 (BLK) з T-11.
-- BLK більше не має актуальної сторінки виробника, тому картку не видаляємо,
-- а залишаємо прихованою як резерв. Її наявне фото стає варіантом «Чорне скло».

begin;

create temporary table tetra_t11_merge on commit drop as
select
  't11'::text as role,
  product.slug,
  coalesce(
    (select media_row.image_path from public.product_media media_row
      where media_row.product_slug = product.slug
        and media_row.kind = 'main'
        and media_row.is_active = true
      order by media_row.sort_order
      limit 1),
    product.image_path
  ) as image_path
from public.products product
where product.brand = 'Papa Carlo'
  and product.collection = 'Tetra'
  and product.name = 'Papa Carlo T-11'
  and product.is_available = true
union all
select
  'blk'::text,
  product.slug,
  coalesce(
    (select media_row.image_path from public.product_media media_row
      where media_row.product_slug = product.slug
        and media_row.kind = 'main'
        and media_row.is_active = true
      order by media_row.sort_order
      limit 1),
    product.image_path
  )
from public.products product
where product.brand = 'Papa Carlo'
  and product.collection = 'Tetra'
  and product.name = 'Papa Carlo T-11 (BLK)'
  and product.is_available = true;

do $$
begin
  if (select count(*) from tetra_t11_merge) <> 2 then
    raise exception 'Потрібні дві опубліковані картки: T-11 і T-11 (BLK). Змін не внесено.';
  end if;
  if exists (select 1 from tetra_t11_merge where image_path is null or image_path = '') then
    raise exception 'Не знайдено фото для T-11 або T-11 (BLK). Змін не внесено.';
  end if;
end $$;

-- У T-11 лишаються тільки два зрозумілі виконання скла.
delete from public.product_variants
where product_slug = (select slug from tetra_t11_merge where role = 't11');

delete from public.product_options
where product_slug = (select slug from tetra_t11_merge where role = 't11');

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
select target.slug, 'glass', 'Колір скла', source.label, null, source.image_path, source.sort_order
from (values
  ('t11', 'Сатин', (select image_path from tetra_t11_merge where role = 't11'), 10),
  ('t11', 'Чорне скло', (select image_path from tetra_t11_merge where role = 'blk'), 20)
) as source(role, label, image_path, sort_order)
join tetra_t11_merge target on target.role = source.role;

insert into public.product_variants (product_slug, selections, image_path, sort_order)
select target.slug, jsonb_build_object('glass', source.label), source.image_path, source.sort_order
from (values
  ('t11', 'Сатин', (select image_path from tetra_t11_merge where role = 't11'), 10),
  ('t11', 'Чорне скло', (select image_path from tetra_t11_merge where role = 'blk'), 20)
) as source(role, label, image_path, sort_order)
join tetra_t11_merge target on target.role = source.role;

-- Стара картка лишається в базі, але не дублюється у каталозі та sitemap.
update public.products
set is_available = false
where slug = (select slug from tetra_t11_merge where role = 'blk');

commit;

select
  product.slug,
  product.name,
  product.is_available,
  option_row.group_label,
  option_row.label,
  option_row.image_path
from public.products product
left join public.product_options option_row
  on option_row.product_slug = product.slug and option_row.is_active = true
where product.brand = 'Papa Carlo'
  and product.collection = 'Tetra'
  and product.name in ('Papa Carlo T-11', 'Papa Carlo T-11 (BLK)')
order by product.is_available desc, option_row.sort_order;
