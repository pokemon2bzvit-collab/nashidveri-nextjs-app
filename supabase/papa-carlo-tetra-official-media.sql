-- Papa Carlo Tetra: офіційні фото та реальні перемикачі скла.
-- Перевірено 15.09.2026 за https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-t-01/ … t-18/
-- T-01, T-02 і T-03 мають два підтверджені виконання скла. Для інших моделей
-- додається лише звичайна галерея з офіційних фото, без штучних опцій.
-- Старий T-11 (BLK) тут не змінюється: його більше немає в актуальному каталозі фабрики.

begin;

create temporary table tetra_official_media (
  model_name text not null,
  image_path text not null,
  label text not null,
  sort_order integer not null
) on commit drop;

insert into tetra_official_media (model_name, image_path, label, sort_order) values
  ('Papa Carlo Т-00F', 'https://papa-karlo.com.ua/content/images/25/788x1800l80mc0/mizhkimnatni-dveri-papa-karlo-t-00f-67949689341525.jpg', 'Головне фото', 0),
  ('Papa Carlo Т-00F', 'https://papa-karlo.com.ua/content/images/25/788x1800l80mc0/mizhkimnatni-dveri-papa-karlo-t-00f-77251967197463.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo Т-00F', 'https://papa-karlo.com.ua/content/images/25/788x1800l80mc0/mizhkimnatni-dveri-papa-karlo-t-00f-44088570079391.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-01', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-29371029225377.jpg', 'Головне фото', 0),
  ('Papa Carlo T-01', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-15670833954048.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-01', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-86234545310315.jpg', 'Варіант скла', 20),
  ('Papa Carlo T-02', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-45452544731725.jpg', 'Головне фото', 0),
  ('Papa Carlo T-02', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-51678145823205.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-02', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-13608690299432.jpg', 'Варіант скла', 20),
  ('Papa Carlo T-03', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-97050018138804.jpg', 'Головне фото', 0),
  ('Papa Carlo T-03', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-43410764024695.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-03', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-73079724059600.jpg', 'Варіант скла', 20),
  ('Papa Carlo T-04', 'https://papa-karlo.com.ua/content/images/26/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-04-71576862243128.jpg', 'Головне фото', 0),
  ('Papa Carlo T-04', 'https://papa-karlo.com.ua/content/images/26/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-04-67375658468979.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-04', 'https://papa-karlo.com.ua/content/images/26/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-04-63250864422268.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-05', 'https://papa-karlo.com.ua/content/images/46/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-05-90503585289184.jpg', 'Головне фото', 0),
  ('Papa Carlo T-05', 'https://papa-karlo.com.ua/content/images/46/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-05-84570751530500.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-05', 'https://papa-karlo.com.ua/content/images/46/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-05-41393714083043.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-06', 'https://papa-karlo.com.ua/content/images/48/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-06-97031399252530.jpg', 'Головне фото', 0),
  ('Papa Carlo T-06', 'https://papa-karlo.com.ua/content/images/48/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-06-80544153644817.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-06', 'https://papa-karlo.com.ua/content/images/48/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-06-31200408896146.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-07', 'https://papa-karlo.com.ua/content/images/50/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-07-49801207122817.jpg', 'Головне фото', 0),
  ('Papa Carlo T-07', 'https://papa-karlo.com.ua/content/images/50/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-07-16275977082703.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-07', 'https://papa-karlo.com.ua/content/images/50/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-07-39270774176468.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-08', 'https://papa-karlo.com.ua/content/images/2/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-08-44988877821209.jpg', 'Головне фото', 0),
  ('Papa Carlo T-08', 'https://papa-karlo.com.ua/content/images/2/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-08-64286808482589.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-08', 'https://papa-karlo.com.ua/content/images/2/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-08-41409850277955.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-09', 'https://papa-karlo.com.ua/content/images/4/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-09-83058754830842.jpg', 'Головне фото', 0),
  ('Papa Carlo T-09', 'https://papa-karlo.com.ua/content/images/4/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-09-31774302579967.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-09', 'https://papa-karlo.com.ua/content/images/4/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-09-34835495730766.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-10', 'https://papa-karlo.com.ua/content/images/6/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-10-36351465382345.jpg', 'Головне фото', 0),
  ('Papa Carlo T-10', 'https://papa-karlo.com.ua/content/images/6/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-10-29616089933565.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-10', 'https://papa-karlo.com.ua/content/images/6/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-10-91860650622805.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-11', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-43309209179332.jpg', 'Головне фото', 0),
  ('Papa Carlo T-11', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-27814162974724.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-11', 'https://papa-karlo.com.ua/content/images/8/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-11-30576370987736.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-12', 'https://papa-karlo.com.ua/content/images/10/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-12-24965531693608.jpg', 'Головне фото', 0),
  ('Papa Carlo T-12', 'https://papa-karlo.com.ua/content/images/10/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-12-48418492936138.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-12', 'https://papa-karlo.com.ua/content/images/10/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-12-47500573945755.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-13', 'https://papa-karlo.com.ua/content/images/11/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-13-70146549020937.jpg', 'Головне фото', 0),
  ('Papa Carlo T-13', 'https://papa-karlo.com.ua/content/images/11/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-13-34321362457780.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-13', 'https://papa-karlo.com.ua/content/images/11/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-13-84690616896943.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-14', 'https://papa-karlo.com.ua/content/images/12/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-14-39713287838308.jpg', 'Головне фото', 0),
  ('Papa Carlo T-14', 'https://papa-karlo.com.ua/content/images/12/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-14-72771456812852.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-14', 'https://papa-karlo.com.ua/content/images/12/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-14-37703362364113.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-15', 'https://papa-karlo.com.ua/content/images/13/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-15-75734129998513.jpg', 'Головне фото', 0),
  ('Papa Carlo T-15', 'https://papa-karlo.com.ua/content/images/13/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-15-69892578648446.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-15', 'https://papa-karlo.com.ua/content/images/13/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-15-11143593701866.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-16', 'https://papa-karlo.com.ua/content/images/14/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-16-66576973833016.jpg', 'Головне фото', 0),
  ('Papa Carlo T-16', 'https://papa-karlo.com.ua/content/images/14/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-16-85922697933870.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-16', 'https://papa-karlo.com.ua/content/images/14/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-16-30124172371604.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-17', 'https://papa-karlo.com.ua/content/images/15/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-17-21820001148819.jpg', 'Головне фото', 0),
  ('Papa Carlo T-17', 'https://papa-karlo.com.ua/content/images/15/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-17-66118631578171.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-17', 'https://papa-karlo.com.ua/content/images/15/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-17-21270371368340.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo T-18', 'https://papa-karlo.com.ua/content/images/26/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-t-18-91405346675505.jpg', 'Головне фото', 0),
  ('Papa Carlo T-18', 'https://papa-karlo.com.ua/content/images/26/420x940l80mc0/mizhkimnatni-dveri-papa-karlo-t-18-51903127881758.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo T-18', 'https://papa-karlo.com.ua/content/images/26/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-t-18-98807295139875.jpg', 'Додатковий ракурс', 20),
  ('Papa Carlo Т-18 (BLK)', 'https://papa-karlo.com.ua/content/images/27/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-t-18-blk-67442326045484.jpg', 'Головне фото', 0),
  ('Papa Carlo Т-18 (BLK)', 'https://papa-karlo.com.ua/content/images/27/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-t-18-blk-20646996541749.jpg', 'Додатковий ракурс', 10),
  ('Papa Carlo Т-18 (BLK)', 'https://papa-karlo.com.ua/content/images/27/357x800l80mc0/mizhkimnatni-dveri-papa-karlo-t-18-blk-91382704145038.jpg', 'Додатковий ракурс', 20);

create temporary table tetra_targets on commit drop as
select p.slug, p.name
from public.products p
join (select distinct model_name from tetra_official_media) source
  on lower(source.model_name) = lower(p.name)
where p.brand = 'Papa Carlo'
  and p.collection = 'Tetra'
  and p.is_available = true;

do $$
begin
  if (select count(*) from public.products where brand = 'Papa Carlo' and collection = 'Tetra' and is_available = true) <> 21 then
    raise exception 'Очікувалось 21 опублікована модель Tetra, знайдено % — каталог не змінено', (select count(*) from public.products where brand = 'Papa Carlo' and collection = 'Tetra' and is_available = true);
  end if;
  if (select count(*) from tetra_targets) <> 20 then
    raise exception 'Не знайдено 20 моделей з актуальними офіційними фото Tetra, знайдено % — каталог не змінено', (select count(*) from tetra_targets);
  end if;
end $$;

-- Лише три моделі мають реальний вибір скла. Старі умовні кольори та варіанти прибираємо.
delete from public.product_variants variant_row using tetra_targets target where variant_row.product_slug = target.slug;
delete from public.product_options option_row using tetra_targets target where option_row.product_slug = target.slug;

-- Замінюємо головні фото й звичайні галереї точними оригіналами фабрики.
delete from public.product_media media_row using tetra_targets target
where media_row.product_slug = target.slug and media_row.kind in ('main', 'gallery');

update public.products product
set image_path = source.image_path
from tetra_official_media source
where lower(product.name) = lower(source.model_name)
  and product.brand = 'Papa Carlo'
  and product.collection = 'Tetra'
  and product.is_available = true
  and source.sort_order = 0;

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select target.slug,
  case when source.sort_order = 0 then 'main' else 'gallery' end,
  source.label,
  source.image_path,
  source.sort_order
from tetra_official_media source
join tetra_targets target on lower(target.name) = lower(source.model_name);

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order)
select target.slug, source.option_group, 'Колір скла', source.label, null, source.image_path, source.sort_order
from (values
  ('Papa Carlo T-01', 'glass', 'Сатин / Чорне', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-29371029225377.jpg', 10),
  ('Papa Carlo T-01', 'glass', 'Чорний', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-86234545310315.jpg', 20),
  ('Papa Carlo T-02', 'glass', 'Сатин / Чорне', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-45452544731725.jpg', 10),
  ('Papa Carlo T-02', 'glass', 'Сатин', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-13608690299432.jpg', 20),
  ('Papa Carlo T-03', 'glass', 'Сатин / Чорне', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-97050018138804.jpg', 10),
  ('Papa Carlo T-03', 'glass', 'Чорний', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-73079724059600.jpg', 20)
) as source(model_name, option_group, label, image_path, sort_order)
join tetra_targets target on lower(target.name) = lower(source.model_name);

insert into public.product_variants (product_slug, selections, image_path, sort_order)
select target.slug,
  jsonb_build_object('glass', source.label),
  source.image_path,
  source.sort_order
from (values
  ('Papa Carlo T-01', 'Сатин / Чорне', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-29371029225377.jpg', 10),
  ('Papa Carlo T-01', 'Чорний', 'https://papa-karlo.com.ua/content/images/23/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-01-86234545310315.jpg', 20),
  ('Papa Carlo T-02', 'Сатин / Чорне', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-45452544731725.jpg', 10),
  ('Papa Carlo T-02', 'Сатин', 'https://papa-karlo.com.ua/content/images/24/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-02-13608690299432.jpg', 20),
  ('Papa Carlo T-03', 'Сатин / Чорне', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-97050018138804.jpg', 10),
  ('Papa Carlo T-03', 'Чорний', 'https://papa-karlo.com.ua/content/images/25/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-03-73079724059600.jpg', 20)
) as source(model_name, label, image_path, sort_order)
join tetra_targets target on lower(target.name) = lower(source.model_name);

commit;

-- Перевірка: 20 моделей з актуальними фото; конфігуратор тільки в T-01, T-02, T-03.
select
  product.name as модель,
  (select count(*) from public.product_media media_row
    where media_row.product_slug = product.slug
      and media_row.is_active = true
      and media_row.kind in ('main', 'gallery')) as фото,
  (select count(*) from public.product_options option_row
    where option_row.product_slug = product.slug
      and option_row.is_active = true) as опцій_скла
from public.products product
where product.brand = 'Papa Carlo'
  and product.collection = 'Tetra'
  and product.is_available = true
order by product.name;
