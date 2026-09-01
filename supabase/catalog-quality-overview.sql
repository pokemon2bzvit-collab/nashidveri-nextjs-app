-- Коротке зведення якості каталогу одним результатом.
-- Безпечний: тільки читає дані. Запустіть цей файл повністю у Supabase SQL Editor.

with product_data as (
  select
    p.slug,
    p.brand,
    p.category,
    p.description,
    p.image_path,
    exists (
      select 1 from public.product_media m
      where m.product_slug = p.slug and m.kind = 'main' and m.is_active = true
        and (m.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = m.image_path))
    ) or (p.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = p.image_path)) as has_main_photo,
    (select count(*) from public.product_specs s where s.product_slug = p.slug and s.is_active = true) as specs_count,
    (select count(*) from public.product_options x where x.product_slug = p.slug and x.is_active = true) as options_count,
    (select count(*) from public.product_variants v where v.product_slug = p.slug and v.is_active = true and (v.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = v.image_path))) as visual_variants_count,
    exists (select 1 from public.product_sources src where src.product_slug = p.slug) as has_source
  from public.products p
), report as (
  select
    'Увесь каталог'::text as scope,
    null::text as brand,
    null::text as category,
    count(*)::integer as models,
    count(*) filter (where not has_main_photo)::integer as no_main_photo,
    count(*) filter (where description is null or btrim(description) = '')::integer as no_description,
    count(*) filter (where coalesce(description, '') ilike '%характеристики та актуальну ціну уточнюйте у менеджера%')::integer as generic_description,
    count(*) filter (where specs_count = 0)::integer as no_specs,
    count(*) filter (where specs_count between 1 and 2)::integer as few_specs,
    count(*) filter (where options_count > 0 and visual_variants_count = 0)::integer as options_without_photos,
    count(*) filter (where not has_source)::integer as no_source
  from product_data
  union all
  select
    'Фабрика'::text,
    brand,
    category,
    count(*)::integer,
    count(*) filter (where not has_main_photo)::integer,
    count(*) filter (where description is null or btrim(description) = '')::integer,
    count(*) filter (where coalesce(description, '') ilike '%характеристики та актуальну ціну уточнюйте у менеджера%')::integer,
    count(*) filter (where specs_count = 0)::integer,
    count(*) filter (where specs_count between 1 and 2)::integer,
    count(*) filter (where options_count > 0 and visual_variants_count = 0)::integer,
    count(*) filter (where not has_source)::integer
  from product_data
  group by brand, category
)
select * from report
order by case when scope = 'Увесь каталог' then 0 else 1 end, (no_main_photo + no_description + generic_description + no_specs + options_without_photos) desc, brand;
