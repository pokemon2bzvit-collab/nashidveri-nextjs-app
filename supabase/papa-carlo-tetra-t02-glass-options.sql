-- Papa Carlo T-02 (Tetra): на офіційній картці перемикається лише колір скла.
-- Перевірено 15.09.2026: https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-t-02/
-- «Сатин / Чорне» — темні вертикальні вставки; «Сатин» — світлі.
-- Кольори полотна лишаються характеристикою, а не кнопками конфігуратора.

do $$
declare
  target_slug text;
begin
  select p.slug
    into target_slug
  from public.products p
  where p.brand = 'Papa Carlo'
    and p.collection = 'Tetra'
    and lower(p.name) = 'papa carlo t-02'
    and p.is_available = true;

  if target_slug is null then
    raise exception 'Не знайдено опубліковану модель Papa Carlo T-02 у колекції Tetra';
  end if;

  if (
    select count(*)
    from public.products p
    where p.brand = 'Papa Carlo'
      and p.collection = 'Tetra'
      and lower(p.name) = 'papa carlo t-02'
      and p.is_available = true
  ) <> 1 then
    raise exception 'Знайдено кілька опублікованих моделей Papa Carlo T-02 — спершу приберіть дублікати';
  end if;

  -- Скидаємо старі умовні опції: виробник не дає окремих перемикачів кольору полотна.
  delete from public.product_variants where product_slug = target_slug;
  delete from public.product_options where product_slug = target_slug;

  insert into public.product_options
    (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
  values
    (
      target_slug, 'glass', 'Колір скла', 'Сатин / Чорне', null,
      'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-45452544731725.webp',
      10
    ),
    (
      target_slug, 'glass', 'Колір скла', 'Сатин', null,
      'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-13608690299432.webp',
      20
    );

  insert into public.product_variants
    (product_slug, selections, image_path, sort_order)
  values
    (
      target_slug, '{"glass":"Сатин / Чорне"}'::jsonb,
      'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-45452544731725.webp',
      10
    ),
    (
      target_slug, '{"glass":"Сатин"}'::jsonb,
      'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-13608690299432.webp',
      20
    );
end $$;

-- Після запуску має повернути два рядки — по одному для кожного виконання скла.
select
  p.slug,
  p.name,
  o.group_label,
  o.label,
  o.image_path
from public.products p
join public.product_options o on o.product_slug = p.slug
where p.brand = 'Papa Carlo'
  and p.collection = 'Tetra'
  and lower(p.name) = 'papa carlo t-02'
  and p.is_available = true
order by o.sort_order;
