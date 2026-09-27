-- StilDoors Riko: точні фото офіційних варіантів.
begin;
insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order,is_active) values
('stildoors-riko-dela-official', 'color', 'Колір полотна', 'клен молочний', null, 'https://stildoors.com.ua/images/dveri/riko/dela/klen-molochniy/sklo-chorne/dveri-riko-dela-klen-molochniy-sklo-chorne.jpg', '1', 'true'),
('stildoors-riko-dela-official', 'color', 'Колір полотна', 'клен французький', null, 'https://stildoors.com.ua/images/dveri/riko/dela/klen-frantsuzkiy/sklo-chorne/dveri-riko-dela-klen-frantsuzkiy-sklo-chorne.jpg', '2', 'true'),
('stildoors-riko-dela-official', 'glass', 'Варіант скла', 'біле', null, 'https://stildoors.com.ua/images/dveri/riko/dela/klen-frantsuzkiy/sklo-satin/dveri-riko-dela-klen-frantsuzkiy-sklo-satin.jpg', '1', 'true'),
('stildoors-riko-dela-official', 'glass', 'Варіант скла', 'чорне', null, 'https://stildoors.com.ua/images/dveri/riko/dela/klen-frantsuzkiy/sklo-chorne/dveri-riko-dela-klen-frantsuzkiy-sklo-chorne.jpg', '2', 'true'),
('stildoors-riko-vena-official', 'color', 'Колір полотна', 'клен молочний', null, 'https://stildoors.com.ua/images/dveri/riko/vena/klen-molochniy/sklo-chorne/dveri-riko-vena-klen-molochniy-sklo-chorne.jpg', '1', 'true'),
('stildoors-riko-vena-official', 'color', 'Колір полотна', 'клен французький', null, 'https://stildoors.com.ua/images/dveri/riko/vena/klen-frantsuzkiy/sklo-chorne/dveri-riko-vena-klen-frantsuzkiy-sklo-chorne.jpg', '2', 'true'),
('stildoors-riko-vena-official', 'glass', 'Варіант скла', 'біле', null, 'https://stildoors.com.ua/images/dveri/riko/vena/klen-frantsuzkiy/sklo-satin/dveri-riko-vena-klen-frantsuzkiy-sklo-satin.jpg', '1', 'true'),
('stildoors-riko-vena-official', 'glass', 'Варіант скла', 'чорне', null, 'https://stildoors.com.ua/images/dveri/riko/vena/klen-frantsuzkiy/sklo-chorne/dveri-riko-vena-klen-frantsuzkiy-sklo-chorne.jpg', '2', 'true')
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;
insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values
('stildoors-riko-dela-official', '{"color":"клен молочний","glass":"біле"}'::jsonb, 'https://stildoors.com.ua/images/dveri/riko/dela/klen-molochniy/sklo-satin/dveri-riko-dela-klen-molochniy-sklo-satin.jpg', '1', 'true'),
('stildoors-riko-dela-official', '{"color":"клен французький","glass":"біле"}'::jsonb, 'https://stildoors.com.ua/images/dveri/riko/dela/klen-frantsuzkiy/sklo-satin/dveri-riko-dela-klen-frantsuzkiy-sklo-satin.jpg', '2', 'true'),
('stildoors-riko-dela-official', '{"color":"клен молочний","glass":"чорне"}'::jsonb, 'https://stildoors.com.ua/images/dveri/riko/dela/klen-molochniy/sklo-chorne/dveri-riko-dela-klen-molochniy-sklo-chorne.jpg', '3', 'true'),
('stildoors-riko-dela-official', '{"color":"клен французький","glass":"чорне"}'::jsonb, 'https://stildoors.com.ua/images/dveri/riko/dela/klen-frantsuzkiy/sklo-chorne/dveri-riko-dela-klen-frantsuzkiy-sklo-chorne.jpg', '4', 'true'),
('stildoors-riko-vena-official', '{"color":"клен молочний","glass":"біле"}'::jsonb, 'https://stildoors.com.ua/images/dveri/riko/vena/klen-molochniy/sklo-satin/dveri-riko-vena-klen-molochniy-sklo-satin.jpg', '5', 'true'),
('stildoors-riko-vena-official', '{"color":"клен французький","glass":"біле"}'::jsonb, 'https://stildoors.com.ua/images/dveri/riko/vena/klen-frantsuzkiy/sklo-satin/dveri-riko-vena-klen-frantsuzkiy-sklo-satin.jpg', '6', 'true'),
('stildoors-riko-vena-official', '{"color":"клен молочний","glass":"чорне"}'::jsonb, 'https://stildoors.com.ua/images/dveri/riko/vena/klen-molochniy/sklo-chorne/dveri-riko-vena-klen-molochniy-sklo-chorne.jpg', '7', 'true'),
('stildoors-riko-vena-official', '{"color":"клен французький","glass":"чорне"}'::jsonb, 'https://stildoors.com.ua/images/dveri/riko/vena/klen-frantsuzkiy/sklo-chorne/dveri-riko-vena-klen-frantsuzkiy-sklo-chorne.jpg', '8', 'true')
on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;
commit;
select count(*) as точних_фото_варіантів from public.product_variants where product_slug like 'stildoors-riko-%-official' and is_active;
