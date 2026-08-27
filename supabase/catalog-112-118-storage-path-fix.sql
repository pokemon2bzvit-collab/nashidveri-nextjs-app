-- Supabase Storage завантажив фото колекції Style у корінь bucket,
-- тому синхронізуємо шляхи в БД з фактичним місцем файлів.

update public.product_variants
set image_path = regexp_replace(image_path, '^variants/papa-carlo/catalog-11[2-8]/', '')
where product_slug in ('catalog-112', 'catalog-113', 'catalog-114', 'catalog-115', 'catalog-116', 'catalog-117', 'catalog-118')
  and image_path like 'variants/papa-carlo/catalog-11%/%';
