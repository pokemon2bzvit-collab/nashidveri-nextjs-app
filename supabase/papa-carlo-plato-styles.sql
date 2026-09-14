-- Офіційні стилі моделей Papa Carlo Plato.
begin;
delete from public.product_specs where label = 'Стиль' and product_slug in (select slug from public.products where brand = 'Papa Carlo' and collection = 'Plato');
insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select p.slug, 'Стиль', source.style, 140, true
from (values
('papa-carlo-pl-01c-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-04-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-30-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-01-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-02-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-05-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-06-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-07-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-08-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-09-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-10-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-11-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-12-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-13-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-14-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-15-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-21-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-22-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-23-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-24-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-25-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-29-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-31-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-32-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-33-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-34-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-35-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-36-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-37-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-38-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-39-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-40-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-41-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-42-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-43-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-44-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-45-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-46-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-47-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-48-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-50-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-51-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-52-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-53-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-54-official', 'Лофт , Модерн , Сучасний , Хай-тек'),
('papa-carlo-pl-55-official', 'Лофт , Модерн , Сучасний , Хай-тек')
) as source(slug, style)
join public.products p on p.slug = source.slug
where p.brand = 'Papa Carlo' and p.collection = 'Plato';
update public.product_specs
set value = regexp_replace(value, '\s*,\s*', ', ', 'g')
where label = 'Стиль'
  and product_slug in (
    select slug from public.products where brand = 'Papa Carlo' and collection = 'Plato'
  );
commit;
select value as стиль, count(*) as моделей from public.product_specs where label = 'Стиль' and product_slug in (select slug from public.products where brand = 'Papa Carlo' and collection = 'Plato') group by value order by value;
