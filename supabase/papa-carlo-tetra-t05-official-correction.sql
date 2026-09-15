-- Papa Carlo T-05: звірено з офіційною карткою 15.09.2026.
-- Джерело: https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-t-05/
-- Додає відсутні ракурси та уточнює лише три характеристики.

begin;

do $$
begin
  if (select count(*) from public.products
      where slug = 'catalog-120'
        and brand = 'Papa Carlo'
        and collection = 'Tetra'
        and is_available = true) <> 1 then
    raise exception 'Не знайдено опубліковану картку Papa Carlo T-05 — змін не внесено.';
  end if;
end $$;

-- На офіційній картці: 410 / 610 / 710 / 810 / 910 мм,
-- а доступні декори: альпійський білий, чорний матовий, сірий матовий.
update public.product_specs
set value = case label
  when 'Розміри полотна' then 'ширина: 410, 610, 710, 810 або 910 мм; висота: 2000 мм, можливий нестандартний розмір під замовлення'
  when 'Доступні декори' then 'альпійський білий, чорний матовий, сірий матовий'
  when 'Варіанти скла' then 'сатин'
  else value
end
where product_slug = 'catalog-120'
  and is_active = true
  and label in ('Розміри полотна', 'Доступні декори', 'Варіанти скла');

-- У виробника шість фото; перші три вже є у нас.
insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select 'catalog-120', 'gallery', source.label, source.image_path, source.sort_order
from (values
  ('Додатковий ракурс', 'https://papa-karlo.com.ua/content/images/46/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-05-95460088911276.webp', 30),
  ('Додатковий ракурс', 'https://papa-karlo.com.ua/content/images/46/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-05-16498284706360.webp', 40),
  ('Додатковий ракурс', 'https://papa-karlo.com.ua/content/images/46/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-05-82362693202941.webp', 50)
) as source(label, image_path, sort_order)
where not exists (
  select 1
  from public.product_media media_row
  where media_row.product_slug = 'catalog-120'
    and media_row.kind = 'gallery'
    and media_row.image_path = source.image_path
);

commit;

select
  p.name as модель,
  (select count(*) from public.product_media m
    where m.product_slug = p.slug and m.is_active = true and m.kind in ('main', 'gallery')) as фото,
  (select value from public.product_specs s
    where s.product_slug = p.slug and s.is_active = true and s.label = 'Розміри полотна') as розміри,
  (select value from public.product_specs s
    where s.product_slug = p.slug and s.is_active = true and s.label = 'Доступні декори') as декори
from public.products p
where p.slug = 'catalog-120';
