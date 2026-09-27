-- StilDoors Classic Carolina: точні фото офіційних варіантів.
begin;
insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order,is_active) values
('stildoors-classic-carolina-official', 'color', 'Колір полотна', 'білий мат', null, 'https://stildoors.com.ua/images/dveri/classic/carolina/biliy-mat/sklo-z-prozorim-malyunkom/dveri-classic-carolina-biliy-mat-sklo-z-prozorim-malyunkom.jpg', '1', 'true'),
('stildoors-classic-carolina-official', 'glass', 'Варіант скла', 'біле', null, 'https://stildoors.com.ua/images/dveri/classic/carolina/biliy-mat/sklo-satin/dveri-classic-carolina-biliy-mat-sklo-satin.jpg', '1', 'true'),
('stildoors-classic-carolina-official', 'glass', 'Варіант скла', 'з малюнком', null, 'https://stildoors.com.ua/images/dveri/classic/carolina/biliy-mat/sklo-z-prozorim-malyunkom/dveri-classic-carolina-biliy-mat-sklo-z-prozorim-malyunkom.jpg', '2', 'true')
on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;
insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values
('stildoors-classic-carolina-official', '{"color":"білий мат","glass":"біле"}'::jsonb, 'https://stildoors.com.ua/images/dveri/classic/carolina/biliy-mat/sklo-satin/dveri-classic-carolina-biliy-mat-sklo-satin.jpg', '1', 'true'),
('stildoors-classic-carolina-official', '{"color":"білий мат"}'::jsonb, 'https://stildoors.com.ua/images/dveri/classic/carolina/biliy-mat/gluhe/dveri-classic-carolina-biliy-mat-gluhe.jpg', '2', 'true'),
('stildoors-classic-carolina-official', '{"color":"білий мат","glass":"з малюнком"}'::jsonb, 'https://stildoors.com.ua/images/dveri/classic/carolina/biliy-mat/sklo-z-prozorim-malyunkom/dveri-classic-carolina-biliy-mat-sklo-z-prozorim-malyunkom.jpg', '3', 'true')
on conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;
commit;
select count(*) as точних_фото_варіантів from public.product_variants where product_slug='stildoors-classic-carolina-official' and is_active;
