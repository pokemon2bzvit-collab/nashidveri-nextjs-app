-- Підтверджені варіанти моделей Magda 711.1 та 945.
-- Джерело: офіційні картки Magda Doors і актуальні картки дилерів.
-- Не створює варіантів фото: виробник не публікує достовірний зв'язок
-- кожної комбінації покриття з окремим зображенням моделі.

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
values
  ('catalog-52', 'configuration', 'Тип дверей', 'Тип 6.23 — з терморозривом', 1),
  ('catalog-52', 'configuration', 'Тип дверей', 'Тип 16', 2),
  ('catalog-52', 'finish', 'Підтверджені покриття', 'Дуб бронзовий + емаль біла', 1),
  ('catalog-52', 'finish', 'Підтверджені покриття', 'Графіт + білий мат', 2),
  ('catalog-52', 'glass', 'Склопакет', 'Склопакет №00', 1),
  ('catalog-53', 'configuration', 'Тип дверей', 'Тип 6.23 — з терморозривом', 1),
  ('catalog-53', 'finish', 'Підтверджені покриття', 'Крафт золотий + чорний металік', 1),
  ('catalog-53', 'finish', 'Підтверджені покриття', 'Крафт золотий + Т183 чорний / Дуб крафт + шагрень чорна', 2)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
