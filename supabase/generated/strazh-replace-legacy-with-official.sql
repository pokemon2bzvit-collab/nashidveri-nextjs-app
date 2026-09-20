-- Страж: чиста заміна попереднього каталогу офіційними моделями.
-- ПЕРЕД ЗАПУСКОМ: переконайтеся, що всі 11 пакетів strazh-official-drafts
-- виконалися успішно. Пакет зупиниться, якщо знайде не 267 нових моделей.
--
-- Що відбудеться:
-- 1. Збережеться резервний список старих моделей у таблиці public.catalog_backup_strazh_20260920_01.
-- 2. Будуть видалені всі попередні товари бренду «Страж», окрім нових офіційних.
--    Пов'язані фото, декори, характеристики й джерела видаляться каскадно.
-- 3. 267 офіційних моделей стануть доступними в каталозі.
--
-- Файли у Storage не видаляються.

begin;

do $$
declare
  official_count integer;
  legacy_count integer;
begin
  select count(*) into official_count
  from public.products
  where brand = 'Страж'
    and slug like 'strazh-official-%';

  if official_count <> 267 then
    raise exception 'Очікувалось 267 офіційних моделей Стража, знайдено % — каталог не змінено', official_count;
  end if;

  select count(*) into legacy_count
  from public.products
  where brand = 'Страж'
    and slug not like 'strazh-official-%';

  if legacy_count = 0 then
    raise exception 'Старі моделі Стража не знайдено — каталог не змінено';
  end if;
end $$;

create table public.catalog_backup_strazh_20260920_01 as
select *
from public.products
where brand = 'Страж'
  and slug not like 'strazh-official-%';

delete from public.products
where brand = 'Страж'
  and slug not like 'strazh-official-%';

update public.products
set collection = 'Офіційний каталог Страж',
    is_available = true,
    updated_at = now()
where brand = 'Страж'
  and slug like 'strazh-official-%';

commit;

-- Перевірка після запуску: має повернути 267 доступних моделей і 0 старих.
select
  count(*) filter (where slug like 'strazh-official-%') as офіційних_моделей,
  count(*) filter (where slug not like 'strazh-official-%') as старих_моделей,
  count(*) filter (where is_available) as опубліковано
from public.products
where brand = 'Страж';
