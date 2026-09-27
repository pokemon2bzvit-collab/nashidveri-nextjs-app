-- StilDoors Simpli Loft: точні фото офіційних варіантів.
begin;
insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order,is_active) values
('stildoors-simpli-loft-03-official', 'color', 'Колір полотна', 'білий супермат', null, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-03/biliy-supermat/dveri-simpli-loft-simpli-loft-03-biliy-supermat.jpg', '1', 'true'),
('stildoors-simpli-loft-05-official', 'color', 'Колір полотна', 'білий супермат', null, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-05/biliy-supermat/dveri-simpli-loft-simpli-loft-05-biliy-supermat.jpg', '1', 'true'),
('stildoors-simpli-loft-06-official', 'color', 'Колір полотна', 'білий супермат', null, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-06/biliy-supermat/dveri-simpli-loft-simpli-loft-06-biliy-supermat.jpg', '1', 'true'),
('stildoors-simpli-loft-07-official', 'color', 'Колір полотна', 'білий супермат', null, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-07/biliy-supermat/dveri-simpli-loft-simpli-loft-07-biliy-supermat.jpg', '1', 'true'),
('stildoors-simpli-loft-08-official', 'color', 'Колір полотна', 'білий супермат', null, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-08/biliy-supermat/dveri-simpli-loft-simpli-loft-08-biliy-supermat.jpg', '1', 'true'),
('stildoors-simpli-loft-09-official', 'color', 'Колір полотна', 'білий супермат', null, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-09/biliy-supermat/dveri-simpli-loft-simpli-loft-09-biliy-supermat.jpg', '1', 'true'),
('stildoors-simpli-loft-10-official', 'color', 'Колір полотна', 'білий супермат', null, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-10/biliy-supermat/dveri-simpli-loft-simpli-loft-10-biliy-supermat.jpg', '1', 'true')
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;
insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values
('stildoors-simpli-loft-03-official', '{"color":"білий супермат"}'::jsonb, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-03/biliy-supermat/dveri-simpli-loft-simpli-loft-03-biliy-supermat.jpg', '1', 'true'),
('stildoors-simpli-loft-05-official', '{"color":"білий супермат"}'::jsonb, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-05/biliy-supermat/dveri-simpli-loft-simpli-loft-05-biliy-supermat.jpg', '2', 'true'),
('stildoors-simpli-loft-06-official', '{"color":"білий супермат"}'::jsonb, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-06/biliy-supermat/dveri-simpli-loft-simpli-loft-06-biliy-supermat.jpg', '3', 'true'),
('stildoors-simpli-loft-07-official', '{"color":"білий супермат"}'::jsonb, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-07/biliy-supermat/dveri-simpli-loft-simpli-loft-07-biliy-supermat.jpg', '4', 'true'),
('stildoors-simpli-loft-08-official', '{"color":"білий супермат"}'::jsonb, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-08/biliy-supermat/dveri-simpli-loft-simpli-loft-08-biliy-supermat.jpg', '5', 'true'),
('stildoors-simpli-loft-09-official', '{"color":"білий супермат"}'::jsonb, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-09/biliy-supermat/dveri-simpli-loft-simpli-loft-09-biliy-supermat.jpg', '6', 'true'),
('stildoors-simpli-loft-10-official', '{"color":"білий супермат"}'::jsonb, 'https://stildoors.com.ua/images/dveri/simpli-loft/simpli-loft-10/biliy-supermat/dveri-simpli-loft-simpli-loft-10-biliy-supermat.jpg', '7', 'true')
on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;
commit;
select count(*) as точних_фото_варіантів from public.product_variants where product_slug like 'stildoors-simpli-loft-%-official' and is_active;
