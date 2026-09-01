-- Аудит якості каталогу «Наші двері».
-- Безпечний файл: лише читає дані, нічого не змінює.
-- Запустіть у Supabase → SQL Editor → New query → Run.
-- Результати кожного блоку можна експортувати або надіслати сюди текстом/скриншотом.

-- 1. Загальна картина каталогу.
with product_data as (
  select
    p.slug,
    p.brand,
    p.collection,
    p.name,
    p.category,
    p.is_available,
    p.description,
    p.image_path,
    exists (
      select 1 from public.product_media m
      where m.product_slug = p.slug
        and m.kind = 'main'
        and m.is_active = true
        and (m.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = m.image_path))
    ) or (p.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = p.image_path)) as has_main_photo,
    (select count(*) from public.product_specs s where s.product_slug = p.slug and s.is_active = true) as specs_count,
    (select count(*) from public.product_options x where x.product_slug = p.slug and x.is_active = true) as options_count,
    (select count(*) from public.product_variants v where v.product_slug = p.slug and v.is_active = true and (v.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = v.image_path))) as visual_variants_count,
    exists (select 1 from public.product_sources src where src.product_slug = p.slug) as has_source
  from public.products p
)
select
  count(*) as total_models,
  count(*) filter (where is_available) as visible_on_site,
  count(*) filter (where not has_main_photo) as without_valid_main_photo,
  count(*) filter (where description is null or btrim(description) = '') as without_description,
  count(*) filter (where coalesce(description, '') ilike '%характеристики та актуальну ціну уточнюйте у менеджера%') as generic_description,
  count(*) filter (where specs_count = 0) as without_specs,
  count(*) filter (where specs_count between 1 and 2) as with_only_1_or_2_specs,
  count(*) filter (where options_count > 0 and visual_variants_count = 0) as options_without_visual_variants,
  count(*) filter (where not has_source) as without_source
from product_data;

-- 2. Якість за фабриками: з цього блоку визначаємо порядок роботи.
with product_data as (
  select
    p.slug, p.brand, p.category, p.description, p.image_path,
    exists (select 1 from public.product_media m where m.product_slug = p.slug and m.kind = 'main' and m.is_active = true and (m.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = m.image_path))) or (p.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = p.image_path)) as has_main_photo,
    (select count(*) from public.product_specs s where s.product_slug = p.slug and s.is_active = true) as specs_count,
    (select count(*) from public.product_options x where x.product_slug = p.slug and x.is_active = true) as options_count,
    (select count(*) from public.product_variants v where v.product_slug = p.slug and v.is_active = true and (v.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = v.image_path))) as visual_variants_count,
    exists (select 1 from public.product_sources src where src.product_slug = p.slug) as has_source
  from public.products p
)
select
  brand,
  category,
  count(*) as models,
  count(*) filter (where not has_main_photo) as no_photo,
  count(*) filter (where description is null or btrim(description) = '' or description ilike '%характеристики та актуальну ціну уточнюйте у менеджера%') as needs_better_description,
  count(*) filter (where specs_count = 0) as no_specs,
  count(*) filter (where specs_count between 1 and 2) as few_specs,
  count(*) filter (where options_count > 0 and visual_variants_count = 0) as options_without_photos,
  count(*) filter (where not has_source) as no_source
from product_data
group by brand, category
order by (count(*) filter (where not has_main_photo) + count(*) filter (where specs_count = 0) + count(*) filter (where description is null or btrim(description) = '' or description ilike '%характеристики та актуальну ціну уточнюйте у менеджера%')) desc, brand;

-- 3. Пріоритет №1: моделі без робочого головного фото.
select p.slug, p.brand, p.collection, p.name, p.image_path as fallback_image_path
from public.products p
where not (
  exists (select 1 from public.product_media m where m.product_slug = p.slug and m.kind = 'main' and m.is_active = true and (m.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = m.image_path)))
  or p.image_path ~ '^https?://'
  or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = p.image_path)
)
order by p.brand, p.collection, p.name;

-- 4. Пріоритет №2: описи, які потрібно написати або зробити конкретнішими.
select p.slug, p.brand, p.collection, p.name,
  case when p.description is null or btrim(p.description) = '' then 'Немає опису' else 'Шаблонний опис' end as issue,
  p.description
from public.products p
where p.description is null
   or btrim(p.description) = ''
   or p.description ilike '%характеристики та актуальну ціну уточнюйте у менеджера%'
order by p.brand, p.collection, p.name;

-- 5. Пріоритет №3: повні технічні характеристики.
select p.slug, p.brand, p.collection, p.name, count(s.id) as specs_count
from public.products p
left join public.product_specs s on s.product_slug = p.slug and s.is_active = true
group by p.slug, p.brand, p.collection, p.name
having count(s.id) < 3
order by specs_count, p.brand, p.collection, p.name;

-- 6. Пріоритет №4: є декори/опції, але немає підтвердженого фото жодного варіанта.
select p.slug, p.brand, p.collection, p.name,
  count(distinct x.id) as options_count,
  count(distinct v.id) filter (where v.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = v.image_path)) as visual_variants_count
from public.products p
join public.product_options x on x.product_slug = p.slug and x.is_active = true
left join public.product_variants v on v.product_slug = p.slug and v.is_active = true
group by p.slug, p.brand, p.collection, p.name
having count(distinct v.id) filter (where v.image_path ~ '^https?://' or exists (select 1 from storage.objects o where o.bucket_id = 'catalog-images' and o.name = v.image_path)) = 0
order by p.brand, p.collection, p.name;

-- 7. Джерела: моделі, для яких ще не збережене посилання на першоджерело.
select p.slug, p.brand, p.collection, p.name
from public.products p
where not exists (select 1 from public.product_sources src where src.product_slug = p.slug)
order by p.brand, p.collection, p.name;
