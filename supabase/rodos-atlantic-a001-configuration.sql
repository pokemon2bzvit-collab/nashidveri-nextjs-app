-- RODOS Atlantic A001: точний конфігуратор з офіційної картки виробника.
-- Джерело: https://rodos.ua/ua/mezhkomnatnaya-dver-atlantic-a001
-- Пакет змінює ЛИШЕ rodos-official-1osu0nf.
-- Колір та вид полотна одразу змінюють головне фото на точне фото Rodos.

do $$
begin
  if (select count(*) from public.products where slug = 'rodos-official-1osu0nf') <> 1 then
    raise exception 'Не знайдено рівно одну модель Rodos Atlantic A001 (rodos-official-1osu0nf) — нічого не змінено';
  end if;
end $$;

-- Прибираємо лише попередні варіанти цієї моделі: залишаються рівно два
-- зрозумілі покупцеві параметри — колір полотна та вид полотна.
delete from public.product_options
where product_slug = 'rodos-official-1osu0nf';

delete from public.product_variants
where product_slug = 'rodos-official-1osu0nf';

with colors(label, image_path, sort_order) as (
  values
    ('Сосна крем', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643794427-2000x2000.jpg', 1),
    ('Білий мат', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20%20%20-gluhoe--1719556923-2000x2000.jpg', 2),
    ('Крем', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20-1643795254-2000x2000.jpg', 3),
    ('Дуб сонома', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643793233-2000x2000.jpg', 4),
    ('Венге шоколадний', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643795058-2000x2000.jpg', 5),
    ('Акація темна', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643794648-2000x2000.jpg', 6),
    ('Дуб шале графіт', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20%20-1643793756-2000x2000.jpg', 7),
    ('Мрамор сірий', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20%20-1643795306-2000x2000.jpg', 8),
    ('Каштан білий', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643793880-2000x2000.jpg', 9),
    ('Каштан сірий', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643795137-2000x2000.jpg', 10),
    ('Каштан беж', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643793780-2000x2000.jpg', 11),
    ('Сосна браш браун', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643795355-2000x2000.jpg', 12),
    ('Сосна браш кобальт', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20%20-1643794255-2000x2000.jpg', 13),
    ('Сосна браш мінт', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20%20-1643794358-2000x2000.jpg', 14),
    ('Бежевий', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20-gluhoe--1719475954-2000x2000.jpg', 15),
    ('Світло сірий', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20-gluhoe-%20-1719559564-2000x2000.jpg', 16),
    ('Канадський дуб', 'https://rodos.ua/image/cache/catalog/A001%20%20-gluhoe--1715603781-2000x2000.jpg', 17),
    ('Кедр софт графіт', 'https://rodos.ua/image/cache/catalog/atlantic%201%20%20%20-gluhoe--1719487050-2000x2000.jpg', 18),
    ('Кедр софт білий', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20%20%20-gluhoe--1719481392-2000x2000.jpg', 19)
)
insert into public.product_options (product_slug, option_group, group_label, label, image_path, sort_order, is_active)
select 'rodos-official-1osu0nf', 'color', 'Колір полотна', label, image_path, sort_order, true
from colors;

insert into public.product_options (product_slug, option_group, group_label, label, sort_order, is_active)
values
  ('rodos-official-1osu0nf', 'configuration', 'Вид полотна', 'Глухе', 1, true),
  ('rodos-official-1osu0nf', 'configuration', 'Вид полотна', 'Зі склом', 2, true);

with variants(color, configuration, image_path, sort_order) as (
  values
    ('Сосна крем', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643794427-2000x2000.jpg', 1),
    ('Сосна крем', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643794427-2000x2000.jpg', 2),
    ('Білий мат', 'Глухе', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20%20%20-gluhoe--1719556923-2000x2000.jpg', 3),
    ('Білий мат', 'Зі склом', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20%20%20-gluhoe--1719556923-2000x2000.jpg', 4),
    ('Крем', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20-1643795254-2000x2000.jpg', 5),
    ('Крем', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20-1643795254-2000x2000.jpg', 6),
    ('Дуб сонома', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643793233-2000x2000.jpg', 7),
    ('Дуб сонома', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20-sosteklom-%20-1643796518-2000x2000.jpg', 8),
    ('Венге шоколадний', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643795058-2000x2000.jpg', 9),
    ('Венге шоколадний', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643795058-2000x2000.jpg', 10),
    ('Акація темна', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643794648-2000x2000.jpg', 11),
    ('Акація темна', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20-sosteklom-%20-1643796203-2000x2000.jpg', 12),
    ('Дуб шале графіт', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20%20-1643793756-2000x2000.jpg', 13),
    ('Дуб шале графіт', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20%20-1643793756-2000x2000.jpg', 14),
    ('Мрамор сірий', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20%20-1643795306-2000x2000.jpg', 15),
    ('Мрамор сірий', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20%20-1643795306-2000x2000.jpg', 16),
    ('Каштан білий', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643793880-2000x2000.jpg', 17),
    ('Каштан білий', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643793880-2000x2000.jpg', 18),
    ('Каштан сірий', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643795137-2000x2000.jpg', 19),
    ('Каштан сірий', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643795137-2000x2000.jpg', 20),
    ('Каштан беж', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643793780-2000x2000.jpg', 21),
    ('Каштан беж', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643793780-2000x2000.jpg', 22),
    ('Сосна браш браун', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643795355-2000x2000.jpg', 23),
    ('Сосна браш браун', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20-1643795355-2000x2000.jpg', 24),
    ('Сосна браш кобальт', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20%20-1643794255-2000x2000.jpg', 25),
    ('Сосна браш кобальт', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20-sosteklom-%20%20-1643796568-2000x2000.jpg', 26),
    ('Сосна браш мінт', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20%20%20-1643794358-2000x2000.jpg', 27),
    ('Сосна браш мінт', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20-sosteklom-%20%20-1643796664-2000x2000.jpg', 28),
    ('Бежевий', 'Глухе', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20-gluhoe--1719475954-2000x2000.jpg', 29),
    ('Бежевий', 'Зі склом', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20-gluhoe--1719475954-2000x2000.jpg', 30),
    ('Світло сірий', 'Глухе', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20-gluhoe-%20-1719559564-2000x2000.jpg', 31),
    ('Світло сірий', 'Зі склом', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20-gluhoe-%20-1719559564-2000x2000.jpg', 32),
    ('Канадський дуб', 'Глухе', 'https://rodos.ua/image/cache/catalog/A001%20%20-gluhoe--1715603781-2000x2000.jpg', 33),
    ('Канадський дуб', 'Зі склом', 'https://rodos.ua/image/cache/catalog/A001%20%20-gluhoe--1715603781-2000x2000.jpg', 34),
    ('Кедр софт графіт', 'Глухе', 'https://rodos.ua/image/cache/catalog/atlantic%201%20%20%20-gluhoe--1719487050-2000x2000.jpg', 35),
    ('Кедр софт графіт', 'Зі склом', 'https://rodos.ua/image/cache/catalog/atlantic%201%20%20%20-gluhoe--1719487050-2000x2000.jpg', 36),
    ('Кедр софт білий', 'Глухе', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20%20%20-gluhoe--1719481392-2000x2000.jpg', 37),
    ('Кедр софт білий', 'Зі склом', 'https://rodos.ua/image/cache/catalog/ATLANTIC%201%20%20%20-gluhoe--1719481392-2000x2000.jpg', 38)
)
insert into public.product_variants (product_slug, selections, image_path, sort_order, is_active)
select
  'rodos-official-1osu0nf',
  jsonb_build_object('color', color, 'configuration', configuration),
  image_path,
  sort_order,
  true
from variants;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values (
  'rodos-official-1osu0nf',
  'Rodos',
  'https://rodos.ua/ua/mezhkomnatnaya-dver-atlantic-a001',
  'Міжкімнатна двері Atlantic A001',
  'verified',
  now(),
  '19 кольорів і два види полотна звірені з офіційним перемикачем Rodos.'
)
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;

select
  (select count(*) from public.product_options where product_slug = 'rodos-official-1osu0nf' and is_active) as опцій,
  (select count(*) from public.product_variants where product_slug = 'rodos-official-1osu0nf' and is_active) as варіантів;
