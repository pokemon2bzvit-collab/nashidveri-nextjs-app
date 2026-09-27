-- Rodos Delux: приховуємо тільки дублікати базових карток.
-- Картки BLK не чіпаємо: їх потрібно буде об'єднати з основними моделями як варіант чорного скла.
do $$
begin
  if (select count(*) from public.products where slug in ('rodos-official-vhyp9y', 'rodos-official-vhypa0')) <> 2 then
    raise exception 'Не знайдено обидва дублікати Delux — каталог не змінено';
  end if;
end $$;

begin;

update public.products
set is_available = false
where slug in (
  'rodos-official-vhyp9y', -- Delux 6: дубль картки без позначки «без порога»
  'rodos-official-vhypa0'  -- Delux 8: акційна дубльована картка
);

commit;

select slug, name, is_available
from public.products
where slug in (
  'rodos-official-1ojjofj', -- Delux 6 без порога — основна
  'rodos-official-vhyp9y',  -- Delux 6 дубль — прихована
  'rodos-official-1qspkip', -- Delux 8 без порога — основна
  'rodos-official-vhypa0'   -- Delux 8 акція — прихована
)
order by slug;
