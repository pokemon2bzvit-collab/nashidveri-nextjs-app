-- Rodos Grand, пакет 01: прямі картки моделей.
-- Джерело: офіційний інтернет-магазин RODOS.in.ua.
-- Перевірено 01.09.2026. Посилання ведуть на картки конкретних моделей.
-- Цей пакет НЕ прив'язує фото декорів: для цього потрібне окреме підтвердження «колір → фото».

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('catalog-19', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-delux-1/', 'Grand Delux 1', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-21', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-delux-2/', 'Grand Delux 2', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-22', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-delux-3/', 'Grand Delux 3', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-24', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-delux-4/', 'Grand Delux 4', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-25', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/migkimnatni-dveri-grand-delux-5/', 'Grand Delux 5', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-26', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-delux-6/', 'Grand Delux 6', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-30', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-lux-1/', 'Grand Lux 1', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-31', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-lux-11/', 'Grand Lux 11', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-34', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-lux-2/', 'Grand Lux 2', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-35', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-lux-3/', 'Grand Lux 3', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-37', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-lux-5/', 'Grand Lux 5', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-38', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/mizhkimnatni-dveri-grand-lux-6/', 'Grand Lux 6', 'verified', now(), 'Пряма картка моделі.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
