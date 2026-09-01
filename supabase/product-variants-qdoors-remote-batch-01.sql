-- Q Doors, пакет 01: лише підтверджені відповідності «модель + декор → фото».
-- Зображення завантажуються напряму з офіційного каталогу Q Doors,
-- тому не займають місце в Supabase Storage.
-- Скрипт можна безпечно виконувати повторно.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
  (
    'catalog-57',
    '{"finish":"RAL 7021 + біла шагрень"}'::jsonb,
    'https://e-c.storage.googleapis.com/res/a9fe7566-694c-463c-99ae-2f5fc9114624/original',
    1
  ),
  (
    'catalog-58',
    '{"finish":"RAL 7021 + біла шагрень"}'::jsonb,
    'https://e-c.storage.googleapis.com/res/4a12c5a6-fd8e-42d1-be59-8f0e2fc81422/original',
    1
  ),
  (
    'catalog-61',
    '{"finish":"Бетон темний + бетон світлий"}'::jsonb,
    'https://e-c.storage.googleapis.com/res/718d89af-dd7d-4ca2-ab00-8446d767d826/original',
    1
  ),
  (
    'catalog-62',
    '{"finish":"Дуб артизан + біла емаль"}'::jsonb,
    'https://e-c.storage.googleapis.com/res/4fa04ee9-bad4-4e80-9cbc-0116b619cc1b/original',
    1
  )
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  (
    'catalog-57',
    'Q Doors',
    'https://qdoors.ua/shop/qdoors-strit-flaj-ral7021bila-shagren-2k-chb',
    'Qdoors Стріт Лайт RAL7021 / біла шагрень',
    'verified', now(), 'Офіційна картка: модель, обидва кольори й основне фото збігаються.'
  ),
  (
    'catalog-58',
    'Q Doors',
    'https://qdoors.ua/shop/qdoors-strit-elegantglad-950-pr-bila-shagren-lakabel-chb3kruchka-1450-1',
    'Qdoors Стріт Спейс RAL7021 / біла шагрень',
    'verified', now(), 'Офіційна картка: модель, обидва кольори й основне фото збігаються.'
  ),
  (
    'catalog-61',
    'Q Doors',
    'https://qdoors.ua/shop/premium-stil-m-1',
    'Преміум Бостон-М — бетон темний / бетон світлий',
    'verified', now(), 'Офіційна картка: модель, обидва кольори й основне фото збігаються.'
  ),
  (
    'catalog-62',
    'Q Doors',
    'https://qdoors.ua/shop/avangard-tiffani-1',
    'Авангард Босфор-АК — дуб артизан / біла емаль',
    'verified', now(), 'Офіційна картка: модель, обидва кольори й основне фото збігаються.'
  )
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
