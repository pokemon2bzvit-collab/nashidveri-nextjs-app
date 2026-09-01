-- RODOS Cortes, пакет 01: прямі картки моделей з офіційного RODOS.in.ua.
-- Перевірено 01.09.2026. Додані лише моделі з точним збігом назви.
-- Скрипт можна виконувати повторно.

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  ('catalog-202', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/farbovani-migkimnatni-dveri-cortes-jazz-gluhi-jazz-h/', 'Cortes Jazz H', 'verified', now(), 'Пряма картка: глухе полотно.'),
  ('catalog-203', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/farbovani-migkimnatni-dveri-cortes-prima-1g-gluhi-prima1g-h/', 'Cortes Prima 1G H', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-205', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/farbovani-migkimnatni-dveri-cortes-prima-3v-gluhi-prima3v-h/', 'Cortes Prima 3V H', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-206', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/farbovani-migkimnatni-dveri-cortes-prima-3v1-gluhi-prima3v1-h/', 'Cortes Prima 3V1 H', 'verified', now(), 'Пряма картка моделі.'),
  ('catalog-207', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/farbovani-migkimnatni-dveri-cortes-prima-gluhi-prima-h/', 'Cortes Prima H', 'verified', now(), 'Пряма картка: глухе полотно.'),
  ('catalog-213', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/farbovani-dveri/farbovani-migkimnatni-dveri-cortes-tango-gluhi-tango-h/', 'Cortes Tango H', 'verified', now(), 'Пряма картка: глухе полотно.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
