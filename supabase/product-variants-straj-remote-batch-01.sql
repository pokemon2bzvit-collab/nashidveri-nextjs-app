-- Страж, пакет 01: лише точні відповідності «декор → віддалене фото».
-- Відповідність звірена за назвою файлу та підтвердженим декором моделі.
-- Джерело: Market Dveri. Не потребує Supabase Storage.
-- Скрипт можна виконувати повторно.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
  (
    'catalog-269',
    '{"color":"Антрацит / антрацит"}'::jsonb,
    'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/210232/dveri-delica-al-antratsit-strazh-main.jpg',
    1
  ),
  (
    'catalog-281',
    '{"color":"Бетон темний / біла емаль"}'::jsonb,
    'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/210231/dveri-delica-al-beton-temnij-7806-al-black-bila-emal-vg-strazh-main.jpg',
    1
  ),
  (
    'catalog-282',
    '{"color":"Мусонне дерево софт тач / софт мілк"}'::jsonb,
    'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/27276/dveri-prestizh-lux-matrix-mussonne-derevo-softtach-soft-milk-straj-main.jpg',
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
  ('catalog-269', 'Market Dveri', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/210232/dveri-delica-al-antratsit-strazh-main.jpg', 'Страж Delica AL Mono — антрацит', 'verified', now(), 'Точний декор і фото моделі.'),
  ('catalog-281', 'Market Dveri', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/210231/dveri-delica-al-beton-temnij-7806-al-black-bila-emal-vg-strazh-main.jpg', 'Страж Prestige Delica AL Mono — бетон темний / біла емаль', 'verified', now(), 'Точний декор і фото моделі.'),
  ('catalog-282', 'Market Dveri', 'https://market-dveri.ua/image/catalog/product/vhidni-dveri/strazh/27276/dveri-prestizh-lux-matrix-mussonne-derevo-softtach-soft-milk-straj-main.jpg', 'Страж Prestige Matrix — мусонне дерево / софт мілк', 'verified', now(), 'Точний декор і фото моделі.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
