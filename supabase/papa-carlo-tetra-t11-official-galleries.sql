-- Повні офіційні галереї для двох виконань Papa Carlo T-11.
-- Після вибору варіанта скла сайт показує лише фото саме цього виконання.

begin;

delete from public.product_media
where product_slug = 'papa-carlo-t-11-official'
  and kind = 'gallery';

insert into public.product_media (product_slug, kind, label, image_path, sort_order) values
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 1', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.jpg', 110),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 2', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-27814162974724.jpg', 120),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 3', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-30576370987736.jpg', 130),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 4', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-67285372583415.jpg', 140),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 5', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-55432376583662.jpg', 150),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Темне скло:Фото 6', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-28981380215974.jpg', 160),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 1', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-16534560199224.webp', 210),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 2', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-59247760411503.webp', 220),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 3', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-86310800606617.webp', 230),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 4', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-74937320710308.webp', 240),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 5', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-89918501200100.webp', 250),
  ('papa-carlo-t-11-official', 'gallery', 'glass:Сатин:Фото 6', 'https://papa-karlo.com.ua/content/images/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-48463541199636.webp', 260);

commit;

select label, image_path
from public.product_media
where product_slug = 'papa-carlo-t-11-official'
  and kind = 'gallery'
  and label like 'glass:%'
  and is_active = true
order by sort_order;
