-- Magda: точні відповідності «покриття → фото» без завантаження у Storage.
-- Фото звірено з назвами карток дилера: назва моделі й покриття збігаються.
-- Офіційні сторінки Magda підтверджують моделі 711.1 і 945.
-- Скрипт можна виконувати повторно.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
  (
    'catalog-52',
    '{"finish":"Дуб бронзовий + емаль біла"}'::jsonb,
    'https://metaldoors.com.ua/3573-large_default/magda-mg7111-tip6.jpg',
    1
  ),
  (
    'catalog-53',
    '{"finish":"Крафт золотий + Т183 чорний / Дуб крафт + шагрень чорна"}'::jsonb,
    'https://metaldoors.com.ua/3942-large_default/magda-945-655-tip6.jpg',
    1
  )
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  (
    'catalog-52',
    'MetalDoors / Magda',
    'https://metaldoors.com.ua/ua/vkhidni-dveri/804-magda-mg7111-tip6.html',
    'Magda 711.1, Тип 6.3, Дуб бронзовий / Емаль біла',
    'verified',
    now(),
    'Точний збіг моделі, типу та покриття; фото використано для варіанта.'
  ),
  (
    'catalog-53',
    'MetalDoors / Magda',
    'https://metaldoors.com.ua/vkhodnye-dveri/885-magda-945-655-tip6.html',
    'Magda 945/655, Тип 6, Крафт золотий + Т183 / Дуб крафт + шагрень чорна',
    'verified',
    now(),
    'Точний збіг моделі, типу та покриття; фото використано для варіанта.'
  )
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
