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
  ),
  (
    'catalog-60',
    '{"finish":"Дуб табак + біле дерево"}'::jsonb,
    'https://e-c.storage.googleapis.com/res/715f0470-96dd-4a7d-a869-e298f91e3211/original',
    1
  ),
  (
    'catalog-64',
    '{"finish":"Спил дерева коньячний"}'::jsonb,
    'https://e-c.storage.googleapis.com/res/0faa8f85-3f1f-45c6-8338-1fd2e76f276c/original',
    1
  ),
  (
    'catalog-65',
    '{"finish":"Мрамор темний + біла емаль","glass":"Дзеркало"}'::jsonb,
    'https://e-c.storage.googleapis.com/res/2f25ad7d-8367-48af-8ded-ef83da78e84d/original',
    1
  ),
  (
    'catalog-56',
    '{"finish":"RAL 8019 + гладь дуб темний, лакобель"}'::jsonb,
    'https://e-c.storage.googleapis.com/res/7b2e8fa1-eaac-4f36-bde3-dfa7d871ee26/original',
    1
  ),
  (
    'catalog-66',
    '{"finish":"Венге сірий горизонтальний + білий"}'::jsonb,
    'https://e-c.storage.googleapis.com/res/0af5b6a2-51e6-4141-9198-79db9e26f496/original',
    1
  ),
  (
    'catalog-55',
    '{"finish":"RAL 8019 + гладь дуб темний, лакобель"}'::jsonb,
    'https://e-c.storage.googleapis.com/res/af68049c-73f5-4a0a-b9d1-4c5dc04652d6/original',
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
  ),
  (
    'catalog-60',
    'Q Doors',
    'https://qdoors.ua/shop',
    'Ультра Аккорд-Ас — дуб табак / біле дерево',
    'verified', now(), 'Офіційний каталог: модель, обидва кольори й прев’ю збігаються.'
  ),
  (
    'catalog-64',
    'Q Doors',
    'https://qdoors.ua/shop',
    'Преміум Люксор — спил дерева коньячний',
    'verified', now(), 'Офіційний каталог: модель, декор і прев’ю збігаються.'
  ),
  (
    'catalog-65',
    'Q Doors',
    'https://qdoors.ua/shop/ultra-ukkord-as',
    'Ультра Міроу — мрамор темний / біла емаль + дзеркало',
    'verified', now(), 'Офіційна картка: модель, кольори, дзеркало й основне фото збігаються.'
  ),
  (
    'catalog-56',
    'Q Doors',
    'https://qdoors.ua/shop/qdoors-strit-elegantglad-950-pr-bila-shagren-lakabel-chb3kruchka-1450',
    'Qdoors Стріт Елегант — RAL 8019 / гладь дуб темний, лакобель',
    'verified', now(), 'Офіційна картка: модель, кольори, лакобель і основне фото збігаються.'
  ),
  (
    'catalog-66',
    'Q Doors',
    'https://qdoors.ua/shop/premium-provans',
    'Преміум Стиль-М — венге сірий горизонтальний / білий',
    'verified', now(), 'Офіційна картка: модель, обидва кольори й основне фото збігаються.'
  ),
  (
    'catalog-55',
    'Q Doors',
    'https://qdoors.ua/shop/qdoors-strit-elegantglad-dub-temnij-lakobel-kb-3k-8019-ruchka-1450',
    'Qdoors Стріт Горизонталь — RAL 8019 / гладь дуб темний, лакобель',
    'verified', now(), 'Офіційна картка: модель, кольори, лакобель і основне фото збігаються.'
  )
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
