-- ABWEHR: підтверджені відповідності «єдиний декор → головне фото моделі».
-- Harmonia, Limana та Melany мають у каталозі по одному підтвердженому декору,
-- тому локальне головне фото можна безпечно використовувати у конфігураторі.
-- Для Mira запис навмисно не додається: доступні 3 декори, але є лише одне
-- фото без підтвердженого зв'язку з конкретним декором.
-- Скрипт можна виконувати повторно.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
  (
    'catalog-1',
    '{"finish":"Чорна шагрень + Олово супермат"}'::jsonb,
    'product-1.webp',
    1
  ),
  (
    'catalog-2',
    '{"finish":"Кварцит + Білий супермат"}'::jsonb,
    'product-2.webp',
    1
  ),
  (
    'catalog-3',
    '{"finish":"Вугілля + Білий супермат"}'::jsonb,
    'product-3.webp',
    1
  )
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;
