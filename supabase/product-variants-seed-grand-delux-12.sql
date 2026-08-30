-- Grand Delux 12: підтверджені відповідності «декор → фото».
insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
  ('catalog-16', '{"color":"Беж"}'::jsonb, 'b718a51feb7e3e1c.jpg', 1),
  ('catalog-16', '{"color":"Світло-сірий"}'::jsonb, '230a17c31133a1a7.jpg', 2),
  ('catalog-16', '{"color":"Сосна крем"}'::jsonb, '8e0db6807ec0c767.jpg', 3),
  -- Повнорозмірні фото Delux 12: звірено з карткою моделі та палітрою декорів.
  ('catalog-16', '{"color":"Дрімвуд темний"}'::jsonb, 'https://misto-dverey.com/wp-content/uploads/2024/09/lux12-1755507715-2000x2000-1.jpg', 4),
  ('catalog-16', '{"color":"ПВХ білий мат"}'::jsonb, 'https://misto-dverey.com/wp-content/uploads/2024/09/lux12-1755507726-2000x2000-1.jpg', 5)
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;
