-- Papa Carlo Tetra: параметри, спільні для колекції.
-- Джерело: офіційний сайт Papa Carlo, сторінки колекції TETRA та моделі T-04.
-- Перевірено: 29.08.2026.

with tetra_models(product_slug) as (
  values
    ('catalog-119'), ('catalog-120'), ('catalog-121'), ('catalog-122'),
    ('catalog-123'), ('catalog-124'), ('catalog-125'), ('catalog-126'),
    ('catalog-127'), ('catalog-128'), ('catalog-129'), ('catalog-130'),
    ('catalog-131'), ('catalog-132'), ('catalog-133'), ('catalog-134'),
    ('catalog-135'), ('catalog-136'), ('catalog-137')
), tetra_specs(label, value, sort_order) as (
  values
    ('Покриття', 'Декоративне ПВХ-покриття німецького виробництва', 100),
    ('Гарантія виробника', '2 роки', 110),
    ('Стандартна ширина полотна', '610, 710, 810 або 910 мм', 120),
    ('Нестандартний розмір', 'Можливий під замовлення', 130),
    ('Система короба', 'Компланарний короб TTR', 140),
    ('Петлі', 'Накладні «метелик» — 3 шт. або приховані ANSELMI — 2 шт.', 150),
    ('Сумісні замки', 'AGB Polaris або Buonelle магнітний', 160)
)
insert into public.product_specs (product_slug, label, value, sort_order)
select product_slug, label, value, sort_order
from tetra_models cross join tetra_specs
on conflict (product_slug, label) do update set
  value = excluded.value,
  sort_order = excluded.sort_order,
  is_active = true;
