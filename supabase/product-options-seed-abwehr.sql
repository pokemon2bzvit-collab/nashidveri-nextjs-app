-- Конкретні декори, підтверджені в офіційному каталозі ABWEHR.
-- У ABWEHR декор залежить від комплектації, тому тут немає вигаданого
-- універсального списку кольорів для всіх моделей.
-- Скрипт можна виконувати повторно.

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
values
  ('catalog-1', 'finish', 'Підтверджений декор', 'Чорна шагрень + Олово супермат', 1),
  ('catalog-2', 'finish', 'Підтверджений декор', 'Кварцит + Білий супермат', 1),
  ('catalog-3', 'finish', 'Підтверджений декор', 'Вугілля + Білий супермат', 1),
  ('catalog-4', 'finish', 'Підтверджений декор', 'Білий + Білий супермат', 1),
  ('catalog-4', 'finish', 'Підтверджений декор', 'Чорна шагрень + Бетон світлий', 2),
  ('catalog-4', 'finish', 'Підтверджений декор', 'Бронзовий браш', 3)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
