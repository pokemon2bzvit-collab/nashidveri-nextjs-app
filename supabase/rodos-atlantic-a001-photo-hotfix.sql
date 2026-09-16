-- Rodos Atlantic A001: точкове виправлення фото варіантів.
-- Запускати після rodos-atlantic-a001-configuration.sql.
-- Джерело: точні фото моделі Atlantic A001 у партнера Rodos (Homedoors).

do $$
declare
  target_slug constant text := 'rodos-official-1osu0nf';
begin
  if (select count(*) from public.products where slug = target_slug) <> 1 then
    raise exception 'Не знайдено єдину модель Atlantic A001: %', target_slug;
  end if;
end $$;

-- Мініатюра кольору: щоб «Мрамор сірий» був видимим у ряді кольорів.
update public.product_options
set image_path = 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/2/661177615-megkomnatnaya-dver-atlantic-a001-so-steklom-mramor-seryj.jpg'
where product_slug = 'rodos-official-1osu0nf'
  and option_group = 'color'
  and label = 'Мрамор сірий';

-- Фото проблемних виконань. У старому URL «Мрамор сірий» було два зайві
-- закодовані пробіли, через які не завантажувався навіть варіант «Глухе».
update public.product_variants
set image_path = case
  when selections = '{"color":"Мрамор сірий","configuration":"Глухе"}'::jsonb
    then 'https://rodos.ua/image/cache/catalog/atlantic%20001%20%20%20-1643795306-2000x2000.jpg'
  when selections = '{"color":"Мрамор сірий","configuration":"Зі склом"}'::jsonb
    then 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/2/661177615-megkomnatnaya-dver-atlantic-a001-so-steklom-mramor-seryj.jpg'
  when selections = '{"color":"Каштан беж","configuration":"Зі склом"}'::jsonb
    then 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/5/4723261-megkomnatnaya-dver-atlantic-a001-so-steklom-kashtan-beg.jpg'
  else image_path
end
where product_slug = 'rodos-official-1osu0nf'
  and selections in (
    '{"color":"Мрамор сірий","configuration":"Глухе"}'::jsonb,
    '{"color":"Мрамор сірий","configuration":"Зі склом"}'::jsonb,
    '{"color":"Каштан беж","configuration":"Зі склом"}'::jsonb
  );

select
  selections->>'color' as color,
  selections->>'configuration' as variant,
  image_path
from public.product_variants
where product_slug = 'rodos-official-1osu0nf'
  and selections in (
    '{"color":"Мрамор сірий","configuration":"Глухе"}'::jsonb,
    '{"color":"Мрамор сірий","configuration":"Зі склом"}'::jsonb,
    '{"color":"Каштан беж","configuration":"Зі склом"}'::jsonb
  )
order by color;
