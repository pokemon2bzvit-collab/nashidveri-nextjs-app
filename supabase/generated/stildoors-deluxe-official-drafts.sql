-- StilDoors DELUXE: 4 офіційні моделі як приховані чернетки.
begin;
insert into public.catalog_collections (brand_id, name, category, description, is_active, sort_order) select id, 'DELUXE', 'interior', 'Міжкімнатні двері StilDoors колекції DELUXE.', true, 72 from public.catalog_brands where name='StilDoors' on conflict (brand_id, name, category) do update set description=excluded.description, is_active=true, updated_at=now();
insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values
('stildoors-deluxe-antalya-official', 'interior', 'StilDoors', 'DELUXE', 'StilDoors Antalya', 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів і скла', 'Ціна за запитом', 'StilDoors Antalya — міжкімнатні двері колекції DELUXE. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція DELUXE","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/deluxe/antalya/dub-popelyastiy/sklo-chorne/dveri-deluxe-antalya-dub-popelyastiy-sklo-chorne.jpg', '9900', 'false'),
('stildoors-deluxe-barcelona-official', 'interior', 'StilDoors', 'DELUXE', 'StilDoors Barcelona', 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів і скла', 'Ціна за запитом', 'StilDoors Barcelona — міжкімнатні двері колекції DELUXE. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція DELUXE","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/deluxe/barcelona/biliy-mat/sklo-chorne/dveri-deluxe-barcelona-biliy-mat-sklo-chorne.jpg', '9901', 'false'),
('stildoors-deluxe-sofia-official', 'interior', 'StilDoors', 'DELUXE', 'StilDoors Sofia', 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів і скла', 'Ціна за запитом', 'StilDoors Sofia — міжкімнатні двері колекції DELUXE. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція DELUXE","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/deluxe/sofia/dub-sriblyastiy/sklo-satin/dveri-deluxe-sofia-dub-sriblyastiy-sklo-satin.jpg', '9902', 'false'),
('stildoors-deluxe-tokyo-official', 'interior', 'StilDoors', 'DELUXE', 'StilDoors Tokyo', 'Міжкімнатні', 'Ламіновані двері', 'Варіанти заводських декорів і скла', 'Ціна за запитом', 'StilDoors Tokyo — міжкімнатні двері колекції DELUXE. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 40 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція DELUXE","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/deluxe/tokyo/dub-popelyastiy/sklo-chorne/dveri-deluxe-tokyo-dub-popelyastiy-sklo-chorne.jpg', '9903', 'false')
on conflict (slug) do update set name=excluded.name, material=excluded.material, style=excluded.style, color=excluded.color, description=excluded.description, features=excluded.features, image_path=excluded.image_path, sort_order=excluded.sort_order, is_available=false, updated_at=now();
insert into public.product_specs (product_slug, label, value, sort_order, is_active) values
('stildoors-deluxe-antalya-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-deluxe-antalya-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-deluxe-antalya-official', 'Декори', 'дуб попелястий, дуб сріблястий, білий кристал, білий мат, дуб альба', '120', 'true'),
('stildoors-deluxe-barcelona-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-deluxe-barcelona-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-deluxe-barcelona-official', 'Декори', 'білий мат, білий кристал, дуб альба, дуб попелястий, дуб сріблястий', '120', 'true'),
('stildoors-deluxe-sofia-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-deluxe-sofia-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-deluxe-sofia-official', 'Декори', 'дуб сріблястий, білий кристал, білий мат, дуб альба, дуб попелястий', '120', 'true'),
('stildoors-deluxe-tokyo-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-deluxe-tokyo-official', 'Товщина полотна', '40 мм', '110', 'true'),
('stildoors-deluxe-tokyo-official', 'Декори', 'дуб попелястий, білий кристал, білий мат, дуб альба, дуб сріблястий', '120', 'true')
on conflict (product_slug, label) do update set value=excluded.value, sort_order=excluded.sort_order, is_active=true;
insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active) values
('stildoors-deluxe-antalya-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/deluxe/antalya/dub-popelyastiy/sklo-chorne/dveri-deluxe-antalya-dub-popelyastiy-sklo-chorne.jpg', '0', 'true'),
('stildoors-deluxe-barcelona-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/deluxe/barcelona/biliy-mat/sklo-chorne/dveri-deluxe-barcelona-biliy-mat-sklo-chorne.jpg', '0', 'true'),
('stildoors-deluxe-sofia-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/deluxe/sofia/dub-sriblyastiy/sklo-satin/dveri-deluxe-sofia-dub-sriblyastiy-sklo-satin.jpg', '0', 'true'),
('stildoors-deluxe-tokyo-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/deluxe/tokyo/dub-popelyastiy/sklo-chorne/dveri-deluxe-tokyo-dub-popelyastiy-sklo-chorne.jpg', '0', 'true')
on conflict (product_slug, kind, image_path) do update set label=excluded.label, sort_order=excluded.sort_order, is_active=true;
insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order, is_active) values
('stildoors-deluxe-antalya-official', 'color', 'Колір полотна', 'дуб попелястий', null, null, '1', 'true'),
('stildoors-deluxe-antalya-official', 'color', 'Колір полотна', 'дуб сріблястий', null, null, '2', 'true'),
('stildoors-deluxe-antalya-official', 'color', 'Колір полотна', 'білий кристал', null, null, '3', 'true'),
('stildoors-deluxe-antalya-official', 'color', 'Колір полотна', 'білий мат', null, null, '4', 'true'),
('stildoors-deluxe-antalya-official', 'color', 'Колір полотна', 'дуб альба', null, null, '5', 'true'),
('stildoors-deluxe-barcelona-official', 'color', 'Колір полотна', 'білий мат', null, null, '1', 'true'),
('stildoors-deluxe-barcelona-official', 'color', 'Колір полотна', 'білий кристал', null, null, '2', 'true'),
('stildoors-deluxe-barcelona-official', 'color', 'Колір полотна', 'дуб альба', null, null, '3', 'true'),
('stildoors-deluxe-barcelona-official', 'color', 'Колір полотна', 'дуб попелястий', null, null, '4', 'true'),
('stildoors-deluxe-barcelona-official', 'color', 'Колір полотна', 'дуб сріблястий', null, null, '5', 'true'),
('stildoors-deluxe-sofia-official', 'color', 'Колір полотна', 'дуб сріблястий', null, null, '1', 'true'),
('stildoors-deluxe-sofia-official', 'color', 'Колір полотна', 'білий кристал', null, null, '2', 'true'),
('stildoors-deluxe-sofia-official', 'color', 'Колір полотна', 'білий мат', null, null, '3', 'true'),
('stildoors-deluxe-sofia-official', 'color', 'Колір полотна', 'дуб альба', null, null, '4', 'true'),
('stildoors-deluxe-sofia-official', 'color', 'Колір полотна', 'дуб попелястий', null, null, '5', 'true'),
('stildoors-deluxe-tokyo-official', 'color', 'Колір полотна', 'дуб попелястий', null, null, '1', 'true'),
('stildoors-deluxe-tokyo-official', 'color', 'Колір полотна', 'білий кристал', null, null, '2', 'true'),
('stildoors-deluxe-tokyo-official', 'color', 'Колір полотна', 'білий мат', null, null, '3', 'true'),
('stildoors-deluxe-tokyo-official', 'color', 'Колір полотна', 'дуб альба', null, null, '4', 'true'),
('stildoors-deluxe-tokyo-official', 'color', 'Колір полотна', 'дуб сріблястий', null, null, '5', 'true')
on conflict (product_slug, option_group, label) do update set group_label=excluded.group_label, sort_order=excluded.sort_order, is_active=true;
insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values
('stildoors-deluxe-antalya-official', 'StilDoors', 'https://stildoors.com.ua/dveri/deluxe/antalya/dub-popelyastiy/sklo-chorne/', 'StilDoors Antalya', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.'),
('stildoors-deluxe-barcelona-official', 'StilDoors', 'https://stildoors.com.ua/dveri/deluxe/barcelona/biliy-mat/sklo-chorne/', 'StilDoors Barcelona', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.'),
('stildoors-deluxe-sofia-official', 'StilDoors', 'https://stildoors.com.ua/dveri/deluxe/sofia/dub-sriblyastiy/sklo-satin/', 'StilDoors Sofia', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.'),
('stildoors-deluxe-tokyo-official', 'StilDoors', 'https://stildoors.com.ua/dveri/deluxe/tokyo/dub-popelyastiy/sklo-chorne/', 'StilDoors Tokyo', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото, розміри, товщина та доступні декори.')
on conflict (product_slug, source_url) do update set source_product_name=excluded.source_product_name, verification_status='verified', verified_at=now(), notes=excluded.notes;
commit;
select count(*) as офіційних_чернеток from public.products where brand='StilDoors' and collection='DELUXE' and slug like 'stildoors-deluxe-%-official' and not is_available;
