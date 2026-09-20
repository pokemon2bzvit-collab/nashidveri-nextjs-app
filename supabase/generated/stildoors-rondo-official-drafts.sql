-- StilDoors Rondo: 5 офіційних моделей як приховані чернетки.
begin;
insert into public.catalog_collections (brand_id,name,category,description,is_active,sort_order) select id,'Rondo','interior','Міжкімнатні двері StilDoors колекції Rondo.',true,77 from public.catalog_brands where name='StilDoors' on conflict (brand_id,name,category) do update set description=excluded.description,is_active=true,updated_at=now();
insert into public.products (slug,category,brand,collection,name,material,style,color,price,description,features,image_path,sort_order,is_available) values
('stildoors-rondo-argo-official', 'interior', 'StilDoors', 'Rondo', 'StilDoors Argo', 'Міжкімнатні', 'Сучасні двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Argo — міжкімнатні двері колекції Rondo. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 38 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція Rondo","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/rondo/argo/flitvud-ays/sklo-chorne/dveri-rondo-argo-flitvud-ays-sklo-chorne.jpg', '11000', 'false'),
('stildoors-rondo-astro-official', 'interior', 'StilDoors', 'Rondo', 'StilDoors Astro', 'Міжкімнатні', 'Сучасні двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Astro — міжкімнатні двері колекції Rondo. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 38 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція Rondo","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/rondo/astro/flitvud-ays/sklo-chorne/dveri-rondo-astro-flitvud-ays-sklo-chorne.jpg', '11001', 'false'),
('stildoors-rondo-ferro-official', 'interior', 'StilDoors', 'Rondo', 'StilDoors Ferro', 'Міжкімнатні', 'Сучасні двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Ferro — міжкімнатні двері колекції Rondo. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 38 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція Rondo","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/rondo/ferro/flitvud-ays/sklo-chorne/dveri-rondo-ferro-flitvud-ays-sklo-chorne.jpg', '11002', 'false'),
('stildoors-rondo-lineo-official', 'interior', 'StilDoors', 'Rondo', 'StilDoors Lineo', 'Міжкімнатні', 'Сучасні двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Lineo — міжкімнатні двері колекції Rondo. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 38 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція Rondo","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/rondo/lineo/flitvud-ays/sklo-chorne/dveri-rondo-lineo-flitvud-ays-sklo-chorne.jpg', '11003', 'false'),
('stildoors-rondo-terno-official', 'interior', 'StilDoors', 'Rondo', 'StilDoors Terno', 'Міжкімнатні', 'Сучасні двері', 'Варіанти заводських декорів', 'Ціна за запитом', 'StilDoors Terno — міжкімнатні двері колекції Rondo. Доступні стандартні розміри: 40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см. Товщина полотна 38 мм. Для моделі передбачені заводські декори та варіанти скла; актуальну комплектацію й ціну уточнюйте у менеджера.', '["Фабрика StilDoors","Колекція Rondo","Офіційна картка виробника"]', 'https://stildoors.com.ua/images/dveri/rondo/terno/flitvud-ays/sklo-chorne/dveri-rondo-terno-flitvud-ays-sklo-chorne.jpg', '11004', 'false')
on conflict (slug) do update set name=excluded.name,description=excluded.description,image_path=excluded.image_path,is_available=false,updated_at=now();
insert into public.product_specs (product_slug,label,value,sort_order,is_active) values
('stildoors-rondo-argo-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-rondo-argo-official', 'Товщина полотна', '38 мм', '110', 'true'),
('stildoors-rondo-argo-official', 'Декори', 'флітвуд айс, флітвуд грей, флітвуд мокко, флітвуд шампань', '120', 'true'),
('stildoors-rondo-astro-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-rondo-astro-official', 'Товщина полотна', '38 мм', '110', 'true'),
('stildoors-rondo-astro-official', 'Декори', 'флітвуд айс, флітвуд грей, флітвуд мокко, флітвуд шампань', '120', 'true'),
('stildoors-rondo-ferro-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-rondo-ferro-official', 'Товщина полотна', '38 мм', '110', 'true'),
('stildoors-rondo-ferro-official', 'Декори', 'флітвуд айс, флітвуд грей, флітвуд мокко, флітвуд шампань', '120', 'true'),
('stildoors-rondo-lineo-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-rondo-lineo-official', 'Товщина полотна', '38 мм', '110', 'true'),
('stildoors-rondo-lineo-official', 'Декори', 'флітвуд айс, флітвуд грей, флітвуд мокко, флітвуд шампань', '120', 'true'),
('stildoors-rondo-terno-official', 'Розміри полотна', '40 х 200, 60 х 200, 70 х 200, 80 х 200, 90 х 200 см', '100', 'true'),
('stildoors-rondo-terno-official', 'Товщина полотна', '38 мм', '110', 'true'),
('stildoors-rondo-terno-official', 'Декори', 'флітвуд айс, флітвуд грей, флітвуд мокко, флітвуд шампань', '120', 'true')
on conflict (product_slug,label) do update set value=excluded.value,sort_order=excluded.sort_order,is_active=true;
insert into public.product_media (product_slug,kind,label,image_path,sort_order,is_active) values
('stildoors-rondo-argo-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/rondo/argo/flitvud-ays/sklo-chorne/dveri-rondo-argo-flitvud-ays-sklo-chorne.jpg', '0', 'true'),
('stildoors-rondo-astro-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/rondo/astro/flitvud-ays/sklo-chorne/dveri-rondo-astro-flitvud-ays-sklo-chorne.jpg', '0', 'true'),
('stildoors-rondo-ferro-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/rondo/ferro/flitvud-ays/sklo-chorne/dveri-rondo-ferro-flitvud-ays-sklo-chorne.jpg', '0', 'true'),
('stildoors-rondo-lineo-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/rondo/lineo/flitvud-ays/sklo-chorne/dveri-rondo-lineo-flitvud-ays-sklo-chorne.jpg', '0', 'true'),
('stildoors-rondo-terno-official', 'main', 'Головне фото', 'https://stildoors.com.ua/images/dveri/rondo/terno/flitvud-ays/sklo-chorne/dveri-rondo-terno-flitvud-ays-sklo-chorne.jpg', '0', 'true')
on conflict (product_slug,kind,image_path) do update set label=excluded.label,sort_order=excluded.sort_order,is_active=true;
insert into public.product_sources (product_slug,source_name,source_url,source_product_name,verification_status,verified_at,notes) values
('stildoors-rondo-argo-official', 'StilDoors', 'https://stildoors.com.ua/dveri/rondo/argo/flitvud-ays/sklo-chorne/', 'StilDoors Argo', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото та характеристики.'),
('stildoors-rondo-astro-official', 'StilDoors', 'https://stildoors.com.ua/dveri/rondo/astro/flitvud-ays/sklo-chorne/', 'StilDoors Astro', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото та характеристики.'),
('stildoors-rondo-ferro-official', 'StilDoors', 'https://stildoors.com.ua/dveri/rondo/ferro/flitvud-ays/sklo-chorne/', 'StilDoors Ferro', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото та характеристики.'),
('stildoors-rondo-lineo-official', 'StilDoors', 'https://stildoors.com.ua/dveri/rondo/lineo/flitvud-ays/sklo-chorne/', 'StilDoors Lineo', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото та характеристики.'),
('stildoors-rondo-terno-official', 'StilDoors', 'https://stildoors.com.ua/dveri/rondo/terno/flitvud-ays/sklo-chorne/', 'StilDoors Terno', 'verified', now(), 'Офіційна картка StilDoors: назва, головне фото та характеристики.')
on conflict (product_slug,source_url) do update set verification_status='verified',verified_at=now(),notes=excluded.notes;
commit;
select count(*) as офіційних_чернеток from public.products where brand='StilDoors' and collection='Rondo' and slug like 'stildoors-rondo-%-official' and not is_available;
