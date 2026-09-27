-- Офіційний імпорт Papa Carlo Plato, сторінка 2: PL-50…PL-55.
begin;
insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values
('papa-carlo-pl-50-official', 'interior', 'Papa Carlo', 'Plato', 'Papa Carlo PL-50', 'Міжкімнатні', 'Колекція Plato', 'Варіанти декорів і скла', 'Ціна за запитом', 'Papa Carlo PL-50 — міжкімнатні двері колекції Plato: Поліпропіленова плівка Renolit (Німеччина); 40 мм; 710 мм, 810 мм, 610 мм, 910 мм. Двері мають стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні. Актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика Papa Carlo","Колекція Plato","Офіційна картка виробника"]', 'https://papa-karlo.com.ua/content/images/49/557x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-50-63021449587699.jpg', '600', 'true'),
('papa-carlo-pl-51-official', 'interior', 'Papa Carlo', 'Plato', 'Papa Carlo PL-51', 'Міжкімнатні', 'Колекція Plato', 'Варіанти декорів і скла', 'Ціна за запитом', 'Papa Carlo PL-51 — міжкімнатні двері колекції Plato: Поліпропіленова плівка Renolit (Німеччина); 40 мм; 710 мм, 810 мм, 610 мм, 910 мм. Двері мають стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні. Актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика Papa Carlo","Колекція Plato","Офіційна картка виробника"]', 'https://papa-karlo.com.ua/content/images/50/692x1567l80mc0/mizhkimnatni-dveri-papa-karlo-pl-51-94071474548867.jpg', '601', 'true'),
('papa-carlo-pl-52-official', 'interior', 'Papa Carlo', 'Plato', 'Papa Carlo PL-52', 'Міжкімнатні', 'Колекція Plato', 'Варіанти декорів і скла', 'Ціна за запитом', 'Papa Carlo PL-52 — міжкімнатні двері колекції Plato: Поліпропіленова плівка Renolit (Німеччина); 40 мм; 710 мм, 810 мм, 610 мм, 910 мм. Двері мають стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні. Актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика Papa Carlo","Колекція Plato","Офіційна картка виробника"]', 'https://papa-karlo.com.ua/content/images/1/698x1552l80mc0/mizhkimnatni-dveri-papa-karlo-pl-52-98247031602711.jpg', '602', 'true'),
('papa-carlo-pl-53-official', 'interior', 'Papa Carlo', 'Plato', 'Papa Carlo PL-53', 'Міжкімнатні', 'Колекція Plato', 'Варіанти декорів і скла', 'Ціна за запитом', 'Papa Carlo PL-53 — міжкімнатні двері колекції Plato: Поліпропіленова плівка Renolit (Німеччина); 40 мм; 710 мм, 810 мм, 610 мм, 910 мм. Двері мають стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні. Актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика Papa Carlo","Колекція Plato","Офіційна картка виробника"]', 'https://papa-karlo.com.ua/content/images/2/564x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-53-46214859065443.jpg', '603', 'true'),
('papa-carlo-pl-54-official', 'interior', 'Papa Carlo', 'Plato', 'Papa Carlo PL-54', 'Міжкімнатні', 'Колекція Plato', 'Варіанти декорів і скла', 'Ціна за запитом', 'Papa Carlo PL-54 — міжкімнатні двері колекції Plato: Поліпропіленова плівка Renolit (Німеччина); 40 мм; 710 мм, 810 мм, 610 мм, 910 мм. Двері мають стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні. Актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика Papa Carlo","Колекція Plato","Офіційна картка виробника"]', 'https://papa-karlo.com.ua/content/images/3/565x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-54-85595768775732.jpg', '604', 'true'),
('papa-carlo-pl-55-official', 'interior', 'Papa Carlo', 'Plato', 'Papa Carlo PL-55', 'Міжкімнатні', 'Колекція Plato', 'Варіанти декорів і скла', 'Ціна за запитом', 'Papa Carlo PL-55 — міжкімнатні двері колекції Plato: Поліпропіленова плівка Renolit (Німеччина); 40 мм; 710 мм, 810 мм, 610 мм, 910 мм. Двері мають стійке до пошкоджень покриття, що допомагає зберігати охайний вигляд у щоденному користуванні. Актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика Papa Carlo","Колекція Plato","Офіційна картка виробника"]', 'https://papa-karlo.com.ua/content/images/4/573x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-55-26072424225466.jpg', '605', 'true')
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style, color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path, sort_order = excluded.sort_order, is_available = true;
delete from public.product_specs where product_slug in ('papa-carlo-pl-50-official', 'papa-carlo-pl-51-official', 'papa-carlo-pl-52-official', 'papa-carlo-pl-53-official', 'papa-carlo-pl-54-official', 'papa-carlo-pl-55-official');
insert into public.product_specs (product_slug, label, value, sort_order, is_active) values
('papa-carlo-pl-50-official', 'Код виробника', '02224', '90', 'true'),
('papa-carlo-pl-50-official', 'Розміри полотна', 'ширина: 710 мм, 810 мм, 610 мм, 910 мм; висота: Будь-який (під замовлення), 2005 мм', '100', 'true'),
('papa-carlo-pl-50-official', 'Товщина полотна', '40 мм', '110', 'true'),
('papa-carlo-pl-50-official', 'Матеріал покриття', 'Поліпропіленова плівка Renolit (Німеччина)', '120', 'true'),
('papa-carlo-pl-50-official', 'Доступні декори', 'Білий матовий, ясен білий, дуб сірий, дуб кремовий, світло-сірий супермат, темно-сірий супермат', '900', 'true'),
('papa-carlo-pl-51-official', 'Код виробника', '02225', '90', 'true'),
('papa-carlo-pl-51-official', 'Розміри полотна', 'ширина: 710 мм, 810 мм, 610 мм, 910 мм; висота: Будь-який (під замовлення), 2005 мм', '100', 'true'),
('papa-carlo-pl-51-official', 'Товщина полотна', '40 мм', '110', 'true'),
('papa-carlo-pl-51-official', 'Матеріал покриття', 'Поліпропіленова плівка Renolit (Німеччина)', '120', 'true'),
('papa-carlo-pl-51-official', 'Доступні декори', 'Білий матовий, ясен білий, дуб сірий, дуб кремовий, світло-сірий супермат, темно-сірий супермат', '900', 'true'),
('papa-carlo-pl-52-official', 'Код виробника', '02226', '90', 'true'),
('papa-carlo-pl-52-official', 'Розміри полотна', 'ширина: 710 мм, 810 мм, 610 мм, 910 мм; висота: Будь-який (під замовлення), 2005 мм', '100', 'true'),
('papa-carlo-pl-52-official', 'Товщина полотна', '40 мм', '110', 'true'),
('papa-carlo-pl-52-official', 'Матеріал покриття', 'Поліпропіленова плівка Renolit (Німеччина)', '120', 'true'),
('papa-carlo-pl-52-official', 'Доступні декори', 'Білий матовий, ясен білий, дуб сірий, дуб кремовий, світло-сірий супермат, темно-сірий супермат', '900', 'true'),
('papa-carlo-pl-53-official', 'Код виробника', '02227', '90', 'true'),
('papa-carlo-pl-53-official', 'Розміри полотна', 'ширина: 710 мм, 810 мм, 610 мм, 910 мм; висота: Будь-який (під замовлення), 2005 мм', '100', 'true'),
('papa-carlo-pl-53-official', 'Товщина полотна', '40 мм', '110', 'true'),
('papa-carlo-pl-53-official', 'Матеріал покриття', 'Поліпропіленова плівка Renolit (Німеччина)', '120', 'true'),
('papa-carlo-pl-53-official', 'Доступні декори', 'Білий матовий, ясен білий, дуб сірий, дуб кремовий, світло-сірий супермат, темно-сірий супермат', '900', 'true'),
('papa-carlo-pl-54-official', 'Код виробника', '02228', '90', 'true'),
('papa-carlo-pl-54-official', 'Розміри полотна', 'ширина: 710 мм, 810 мм, 610 мм, 910 мм; висота: Будь-який (під замовлення), 2005 мм', '100', 'true'),
('papa-carlo-pl-54-official', 'Товщина полотна', '40 мм', '110', 'true'),
('papa-carlo-pl-54-official', 'Матеріал покриття', 'Поліпропіленова плівка Renolit (Німеччина)', '120', 'true'),
('papa-carlo-pl-54-official', 'Доступні декори', 'Білий матовий, ясен білий, дуб сірий, дуб кремовий, світло-сірий супермат, темно-сірий супермат', '900', 'true'),
('papa-carlo-pl-55-official', 'Код виробника', '02229', '90', 'true'),
('papa-carlo-pl-55-official', 'Розміри полотна', 'ширина: 710 мм, 810 мм, 610 мм, 910 мм; висота: Будь-який (під замовлення), 2005 мм', '100', 'true'),
('papa-carlo-pl-55-official', 'Товщина полотна', '40 мм', '110', 'true'),
('papa-carlo-pl-55-official', 'Матеріал покриття', 'Поліпропіленова плівка Renolit (Німеччина)', '120', 'true'),
('papa-carlo-pl-55-official', 'Доступні декори', 'Білий матовий, ясен білий, дуб сірий, дуб кремовий, світло-сірий супермат, темно-сірий супермат', '900', 'true');
delete from public.product_media where product_slug in ('papa-carlo-pl-50-official', 'papa-carlo-pl-51-official', 'papa-carlo-pl-52-official', 'papa-carlo-pl-53-official', 'papa-carlo-pl-54-official', 'papa-carlo-pl-55-official');
insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values
('papa-carlo-pl-50-official', 'main', 'PL-50 — головне фото', 'https://papa-karlo.com.ua/content/images/49/557x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-50-63021449587699.jpg', '0', 'true'),
('papa-carlo-pl-50-official', 'gallery', 'PL-50 — фото 2', 'https://papa-karlo.com.ua/content/images/49/562x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-50-27917204879875.jpg', '1', 'true'),
('papa-carlo-pl-50-official', 'gallery', 'PL-50 — фото 3', 'https://papa-karlo.com.ua/content/images/49/569x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-50-52361560066330.jpg', '2', 'true'),
('papa-carlo-pl-51-official', 'main', 'PL-51 — головне фото', 'https://papa-karlo.com.ua/content/images/50/692x1567l80mc0/mizhkimnatni-dveri-papa-karlo-pl-51-94071474548867.jpg', '0', 'true'),
('papa-carlo-pl-51-official', 'gallery', 'PL-51 — фото 2', 'https://papa-karlo.com.ua/content/images/50/566x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-51-15122309968369.jpg', '1', 'true'),
('papa-carlo-pl-51-official', 'gallery', 'PL-51 — фото 3', 'https://papa-karlo.com.ua/content/images/50/563x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-51-30673929002557.jpg', '2', 'true'),
('papa-carlo-pl-52-official', 'main', 'PL-52 — головне фото', 'https://papa-karlo.com.ua/content/images/1/698x1552l80mc0/mizhkimnatni-dveri-papa-karlo-pl-52-98247031602711.jpg', '0', 'true'),
('papa-carlo-pl-52-official', 'gallery', 'PL-52 — фото 2', 'https://papa-karlo.com.ua/content/images/1/568x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-52-63052956477637.jpg', '1', 'true'),
('papa-carlo-pl-52-official', 'gallery', 'PL-52 — фото 3', 'https://papa-karlo.com.ua/content/images/1/564x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-52-27210360516085.jpg', '2', 'true'),
('papa-carlo-pl-53-official', 'main', 'PL-53 — головне фото', 'https://papa-karlo.com.ua/content/images/2/564x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-53-46214859065443.jpg', '0', 'true'),
('papa-carlo-pl-53-official', 'gallery', 'PL-53 — фото 2', 'https://papa-karlo.com.ua/content/images/2/570x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-53-93317079837958.jpg', '1', 'true'),
('papa-carlo-pl-53-official', 'gallery', 'PL-53 — фото 3', 'https://papa-karlo.com.ua/content/images/2/678x1555l80mc0/mizhkimnatni-dveri-papa-karlo-pl-53-14253294173749.jpg', '2', 'true'),
('papa-carlo-pl-54-official', 'main', 'PL-54 — головне фото', 'https://papa-karlo.com.ua/content/images/3/565x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-54-85595768775732.jpg', '0', 'true'),
('papa-carlo-pl-54-official', 'gallery', 'PL-54 — фото 2', 'https://papa-karlo.com.ua/content/images/3/564x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-54-21472761651949.jpg', '1', 'true'),
('papa-carlo-pl-54-official', 'gallery', 'PL-54 — фото 3', 'https://papa-karlo.com.ua/content/images/3/566x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-54-52726992924318.jpg', '2', 'true'),
('papa-carlo-pl-55-official', 'main', 'PL-55 — головне фото', 'https://papa-karlo.com.ua/content/images/4/573x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-55-26072424225466.jpg', '0', 'true'),
('papa-carlo-pl-55-official', 'gallery', 'PL-55 — фото 2', 'https://papa-karlo.com.ua/content/images/4/567x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-55-52667486972576.jpg', '1', 'true'),
('papa-carlo-pl-55-official', 'gallery', 'PL-55 — фото 3', 'https://papa-karlo.com.ua/content/images/4/577x1280l80mc0/mizhkimnatni-dveri-papa-karlo-pl-55-39413784172835.jpg', '2', 'true')
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;
insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values
('papa-carlo-pl-50-official', 'Papa Carlo', 'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-pl-50/', 'Міжкімнатні двері Папа Карло PL-50 - Ламіновані', 'verified', now(), 'Офіційна картка Papa Carlo: фото, кольори й базові технічні параметри.'),
('papa-carlo-pl-51-official', 'Papa Carlo', 'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-pl-51/', 'Міжкімнатні двері Папа Карло PL-51 - Ламіновані', 'verified', now(), 'Офіційна картка Papa Carlo: фото, кольори й базові технічні параметри.'),
('papa-carlo-pl-52-official', 'Papa Carlo', 'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-pl-52/', 'Міжкімнатні двері Папа Карло PL-52 - Ламіновані', 'verified', now(), 'Офіційна картка Papa Carlo: фото, кольори й базові технічні параметри.'),
('papa-carlo-pl-53-official', 'Papa Carlo', 'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-pl-53/', 'Міжкімнатні двері Папа Карло PL-53 - Ламіновані', 'verified', now(), 'Офіційна картка Papa Carlo: фото, кольори й базові технічні параметри.'),
('papa-carlo-pl-54-official', 'Papa Carlo', 'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-pl-54/', 'Міжкімнатні двері Папа Карло PL-54 - Ламіновані', 'verified', now(), 'Офіційна картка Papa Carlo: фото, кольори й базові технічні параметри.'),
('papa-carlo-pl-55-official', 'Papa Carlo', 'https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-pl-55/', 'Міжкімнатні двері Папа Карло PL-55 - Ламіновані', 'verified', now(), 'Офіційна картка Papa Carlo: фото, кольори й базові технічні параметри.')
on conflict (product_slug, source_url) do update set source_product_name = excluded.source_product_name, verification_status = 'verified', verified_at = now(), notes = excluded.notes;
commit;
select count(*) as додано_моделей, count(*) filter (where is_available) as опубліковано from public.products where slug in ('papa-carlo-pl-50-official', 'papa-carlo-pl-51-official', 'papa-carlo-pl-52-official', 'papa-carlo-pl-53-official', 'papa-carlo-pl-54-official', 'papa-carlo-pl-55-official');
