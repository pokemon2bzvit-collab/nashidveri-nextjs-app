-- Papa Carlo Milenium: пакет 81–82 з 82.
begin;
insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values
('papa-carlo-ml-720-official', 'interior', 'Papa Carlo', 'Milenium', 'Papa Carlo ML-720', 'Міжкімнатні', 'Колекція Milenium', 'Варіанти декорів і скла', 'Ціна за запитом', 'ML-720 — міжкімнатні двері колекції Milenium з поліпропіленовим покриттям Renolit (Німеччина). Покриття стійке до повсякденних пошкоджень і допомагає зберігати охайний вигляд дверей. Для моделі доступні різні кольори та варіанти оздоблення. Актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика Papa Carlo","Колекція Milenium"]', 'https://papa-karlo.com.ua/content/images/30/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-ml-720-22218239606906.jpg', '780', 'true'),
('papa-carlo-ml-720-blk-official', 'interior', 'Papa Carlo', 'Milenium', 'Papa Carlo ML-720 BLK', 'Міжкімнатні', 'Колекція Milenium', 'Варіанти декорів і скла', 'Ціна за запитом', 'ML-720 BLK — міжкімнатні двері колекції Milenium з поліпропіленовим покриттям Renolit (Німеччина). Покриття стійке до повсякденних пошкоджень і допомагає зберігати охайний вигляд дверей. Для моделі доступні різні кольори та варіанти оздоблення. Актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика Papa Carlo","Колекція Milenium"]', 'https://papa-karlo.com.ua/content/images/31/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-ml-720-blk-99555268982207.jpg', '781', 'true')
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path, sort_order = excluded.sort_order, is_available = true;
insert into public.product_specs (product_slug, label, value, sort_order, is_active) values
('papa-carlo-ml-720-official', 'Розміри полотна', 'ширина: 710 мм, 810 мм, 610 мм, 910 мм; висота: Будь-який (під замовлення), 2006 мм', '100', 'true'),
('papa-carlo-ml-720-official', 'Товщина полотна', '40 мм', '110', 'true'),
('papa-carlo-ml-720-official', 'Матеріал покриття', 'Поліпропіленова плівка Renolit (Німеччина)', '120', 'true'),
('papa-carlo-ml-720-official', 'Стиль', 'Лофт, Модерн, Сучасний, Хай-тек', '140', 'true'),
('papa-carlo-ml-720-official', 'Декор', 'Білий матовий, ясен білий, дуб сірий, дуб кремовий, світло-сірий супермат, темно-сірий супермат', '900', 'true'),
('papa-carlo-ml-720-blk-official', 'Розміри полотна', 'ширина: 710 мм, 810 мм, 610 мм, 910 мм; висота: Будь-який (під замовлення), 2007 мм', '100', 'true'),
('papa-carlo-ml-720-blk-official', 'Товщина полотна', '40 мм', '110', 'true'),
('papa-carlo-ml-720-blk-official', 'Матеріал покриття', 'Поліпропіленова плівка Renolit (Німеччина)', '120', 'true'),
('papa-carlo-ml-720-blk-official', 'Стиль', 'Лофт, Модерн, Сучасний, Хай-тек', '140', 'true'),
('papa-carlo-ml-720-blk-official', 'Декор', 'Білий матовий, ясен білий, дуб сірий, дуб кремовий, світло-сірий супермат, темно-сірий супермат', '900', 'true');
insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values
('papa-carlo-ml-720-official', 'main', 'ML-720 — головне фото', 'https://papa-karlo.com.ua/content/images/30/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-ml-720-22218239606906.jpg', '0', 'true'),
('papa-carlo-ml-720-official', 'gallery', 'ML-720 — фото 2', 'https://papa-karlo.com.ua/content/images/30/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-ml-720-24385934171724.jpg', '1', 'true'),
('papa-carlo-ml-720-official', 'gallery', 'ML-720 — фото 3', 'https://papa-karlo.com.ua/content/images/30/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-ml-720-26383263856874.jpg', '2', 'true'),
('papa-carlo-ml-720-blk-official', 'main', 'ML-720 BLK — головне фото', 'https://papa-karlo.com.ua/content/images/31/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-ml-720-blk-99555268982207.jpg', '0', 'true'),
('papa-carlo-ml-720-blk-official', 'gallery', 'ML-720 BLK — фото 2', 'https://papa-karlo.com.ua/content/images/31/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-ml-720-blk-38326764666861.jpg', '1', 'true'),
('papa-carlo-ml-720-blk-official', 'gallery', 'ML-720 BLK — фото 3', 'https://papa-karlo.com.ua/content/images/31/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-ml-720-blk-47154426180182.jpg', '2', 'true')
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;
insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values
('papa-carlo-ml-720-official', 'Papa Carlo', 'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-ml-720', 'Міжкімнатні двері Папа Карло ML-720 - Ламіновані', 'verified', now(), 'Офіційна картка Papa Carlo: фото, галерея, декори й базові технічні параметри.'),
('papa-carlo-ml-720-blk-official', 'Papa Carlo', 'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-ml-720-blk', 'Міжкімнатні двері Папа Карло ML-720 BLK - Ламіновані', 'verified', now(), 'Офіційна картка Papa Carlo: фото, галерея, декори й базові технічні параметри.')
on conflict (product_slug, source_url) do update set source_product_name = excluded.source_product_name, verification_status = 'verified', verified_at = now(), notes = excluded.notes;
commit;
