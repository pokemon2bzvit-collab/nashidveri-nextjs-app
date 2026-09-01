-- Rodos Grand, пакет 02: прямі картки моделей Grand Paint.
-- Джерело: офіційний інтернет-магазин RODOS.in.ua.
-- Перевірено 01.09.2026. Посилання ведуть на картки конкретних моделей.
-- Палітру RAL / NCS не перетворюємо на фото-варіанти: без підтвердженого
-- зображення конкретного кольору конфігуратор має залишатися інформаційним.

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('catalog-40', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/grand-paint-1/', 'ГРАНД PAINT 1', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-44', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/grand-paint-2/', 'ГРАНД PAINT 2', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-45', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/grand-paint-3/', 'ГРАНД PAINT 3', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-46', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/grand-paint-4/', 'ГРАНД PAINT 4', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-47', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/grand-paint-5/', 'ГРАНД PAINT 5', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-48', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/grand-paint-6/', 'ГРАНД PAINT 6', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-49', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/grand-paint-7/', 'ГРАНД PAINT 7', 'verified', now(), 'Пряма картка моделі.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
