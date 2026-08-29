-- Grand Delux 11: підтверджені відповідності «декор → фото».
-- Фото завантажено в bucket catalog-images 29.08.2026 з карток офіційного дилера.
-- Не додаємо варіанти, для яких немає достовірної окремої фотографії.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values
  ('catalog-15', '{"color":"Беж"}'::jsonb, '7cdbe4463372a4dd.jpg', 1),
  ('catalog-15', '{"color":"Світло-сірий"}'::jsonb, '467e16892deb82a9.jpg', 2),
  ('catalog-15', '{"color":"Сосна крем"}'::jsonb, '67db3245bf030a94.jpg', 3)
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;
