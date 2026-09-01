-- RODOS Atlantic, пакет 01: 13 прямих карток моделей з офіційного RODOS.in.ua.
-- Перевірено 01.09.2026. Посилання відповідають назві моделі та типу полотна.
-- Atlantic 003 напівскло (catalog-186) навмисно не додається: у поточному
-- офіційному каталозі є A003 G, але не підтверджено відповідність «напівскло».
-- Скрипт можна виконувати повторно.

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  ('catalog-180', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/migkimnatni-dveri-z-pvh-pokrittyam-atlantic-zi-sklom-a001g/', 'Atlantic A001 G', 'verified', now(), 'Пряма картка: скло.'),
  ('catalog-181', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-gluhi-a001c/', 'Atlantic A001 C', 'verified', now(), 'Пряма картка: глухе полотно.'),
  ('catalog-182', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-gluhi-a002c/', 'Atlantic A002 C', 'verified', now(), 'Пряма картка: глухе полотно.'),
  ('catalog-183', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-napivsklo-a002h/', 'Atlantic A002 H', 'verified', now(), 'Пряма картка: напівскло.'),
  ('catalog-184', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-zi-sklom-a002g/', 'Atlantic A002 G', 'verified', now(), 'Пряма картка: скло.'),
  ('catalog-185', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-gluhi-a003c/', 'Atlantic A003 C', 'verified', now(), 'Пряма картка: глухе полотно.'),
  ('catalog-187', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-gluhi-a004c/', 'Atlantic A004 C', 'verified', now(), 'Пряма картка: глухе полотно.'),
  ('catalog-188', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-napivsklo-a004h/', 'Atlantic A004 H', 'verified', now(), 'Пряма картка: напівскло.'),
  ('catalog-189', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-zi-sklom-a004g/', 'Atlantic A004 G', 'verified', now(), 'Пряма картка: скло.'),
  ('catalog-190', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-gluhi-a005c/', 'Atlantic A005 C', 'verified', now(), 'Пряма картка: глухе полотно.'),
  ('catalog-191', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-zi-sklom-a005g/', 'Atlantic A005 G', 'verified', now(), 'Пряма картка: скло.'),
  ('catalog-192', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-gluhi-a006c/', 'Atlantic A006 C', 'verified', now(), 'Пряма картка: глухе полотно.'),
  ('catalog-193', 'RODOS.in.ua', 'https://rodos.in.ua/mizhkimnatni-dveri/dveri-z-pvh-pokryttyam/kolektsiya-atlantic/dveri-migkimnatni-z-pvh-pokrittyam-atlantic-zi-sklom-a006g/', 'Atlantic A006 G', 'verified', now(), 'Пряма картка: скло.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
