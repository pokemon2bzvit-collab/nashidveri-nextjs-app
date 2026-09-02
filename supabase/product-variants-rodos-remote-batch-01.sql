-- RODOS, пакет 01: лише підтверджені відповідності «модель + декор → фото».
-- Джерело: картки RODOS на HOMEDOORS. На кожній сторінці декор підписано
-- біля саме того зображення моделі. URL ведуть на оригінали, без мініатюр.
-- Скрипт можна безпечно виконувати повторно.

-- Для двох моделей Atlantic замінюємо загальні «Плівка Renolit / LG»
-- на конкретні декори, для яких знайдено точне фото моделі.
update public.product_options
set is_active = false
where product_slug in ('catalog-180', 'catalog-193')
  and option_group = 'finish';

with colors(product_slug, label, image_path, sort_order) as (
  values
    ('catalog-180', 'Сосна браш мінт', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/9/35597379-megkomnatnaya-dver-atlantic-a001-so-steklom-sosna-brash-mint.jpg', 1),
    ('catalog-180', 'Сосна браш кобальт', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/0/896101507-megkomnatnaya-dver-atlantic-a001-so-steklom-sosna-brash-kobalt.jpg', 2),
    ('catalog-180', 'Сосна браш браун', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/1/511734620-megkomnatnaya-dver-atlantic-a001-so-steklom-sosna-brash-braun.jpg', 3),
    ('catalog-180', 'Мармур сірий', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/2/661177615-megkomnatnaya-dver-atlantic-a001-so-steklom-mramor-seryj.jpg', 4),
    ('catalog-180', 'Каштан сірий', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/3/495266190-megkomnatnaya-dver-atlantic-a001-so-steklom-kashtan-seryj.jpg', 5),
    ('catalog-180', 'Каштан білий', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/4/821810584-megkomnatnaya-dver-atlantic-a001-so-steklom-kashtan-belyj.jpg', 6),
    ('catalog-180', 'Каштан беж', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/5/4723261-megkomnatnaya-dver-atlantic-a001-so-steklom-kashtan-beg.jpg', 7),
    ('catalog-180', 'Дуб шале графіт', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/6/395837107-megkomnatnaya-dver-atlantic-a001-so-steklom-dub-shale-grafit.jpg', 8),
    ('catalog-180', 'Дуб сонома', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/7/457861942-megkomnatnaya-dver-atlantic-a001-so-steklom-dub-sonoma.jpg', 9),
    ('catalog-180', 'Венге шоколадний', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/8/826758608-megkomnatnaya-dver-atlantic-a001-so-steklom-venge-shokoladnyj.jpg', 10),
    ('catalog-180', 'Акація темна', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/9/69738423-megkomnatnaya-dver-atlantic-a001-so-steklom-akatsiya-temnaya.jpg', 11),
    ('catalog-193', 'Мармур сірий', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/0/1996682-megkomnatnaya-dver-atlantic-a006-steklo-mramor-seryj.jpg', 1),
    ('catalog-193', 'Сосна крем', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/6/336566996-megkomnatnaya-dver-atlantic-a006-steklo-sosna-krem.jpg', 2),
    ('catalog-193', 'Сосна браш мінт', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/7/407898545-megkomnatnaya-dver-atlantic-a006-steklo-sosna-brash-mint.jpg', 3),
    ('catalog-193', 'Сосна браш кобальт', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/8/488450145-megkomnatnaya-dver-atlantic-a006-steklo-sosna-brash-kobalt.jpg', 4),
    ('catalog-193', 'Сосна браш браун', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/9/88959034-megkomnatnaya-dver-atlantic-a006-steklo-sosna-brash-braun.jpg', 5),
    ('catalog-193', 'Крем', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/1/835384427-megkomnatnaya-dver-atlantic-a006-steklo-krem.jpg', 6),
    ('catalog-193', 'Каштан сірий', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/2/972638416-megkomnatnaya-dver-atlantic-a006-steklo-kashtan-seryj.jpg', 7),
    ('catalog-193', 'Каштан беж', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/4/956749569-megkomnatnaya-dver-atlantic-a006-steklo-kashtan-beg.jpg', 8),
    ('catalog-193', 'Дуб шале графіт', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/5/892922617-megkomnatnaya-dver-atlantic-a006-steklo-dub-shale-grafit.jpg', 9),
    ('catalog-193', 'Дуб сонома', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/6/412881056-megkomnatnaya-dver-atlantic-a006-steklo-dub-sonoma.jpg', 10),
    ('catalog-193', 'Венге шоколадний', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/7/678227578-megkomnatnaya-dver-atlantic-a006-steklo-venge-shokoladnyj.jpg', 11),
    ('catalog-193', 'Акація темна', 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/8/961249158-megkomnatnaya-dver-atlantic-a006-steklo-akatsiya-temnaya.jpg', 12)
)
insert into public.product_options (product_slug, option_group, group_label, label, image_path, sort_order)
select product_slug, 'color', 'Декор полотна', label, image_path, sort_order
from colors
on conflict (product_slug, option_group, label) do update set
  group_label = excluded.group_label,
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

with variants(product_slug, selections, image_path, sort_order) as (
  values
    ('catalog-180', '{"configuration":"Скло","color":"Сосна браш мінт"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/9/35597379-megkomnatnaya-dver-atlantic-a001-so-steklom-sosna-brash-mint.jpg', 1),
    ('catalog-180', '{"configuration":"Скло","color":"Сосна браш кобальт"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/0/896101507-megkomnatnaya-dver-atlantic-a001-so-steklom-sosna-brash-kobalt.jpg', 2),
    ('catalog-180', '{"configuration":"Скло","color":"Сосна браш браун"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/1/511734620-megkomnatnaya-dver-atlantic-a001-so-steklom-sosna-brash-braun.jpg', 3),
    ('catalog-180', '{"configuration":"Скло","color":"Мармур сірий"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/2/661177615-megkomnatnaya-dver-atlantic-a001-so-steklom-mramor-seryj.jpg', 4),
    ('catalog-180', '{"configuration":"Скло","color":"Каштан сірий"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/3/495266190-megkomnatnaya-dver-atlantic-a001-so-steklom-kashtan-seryj.jpg', 5),
    ('catalog-180', '{"configuration":"Скло","color":"Каштан білий"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/4/821810584-megkomnatnaya-dver-atlantic-a001-so-steklom-kashtan-belyj.jpg', 6),
    ('catalog-180', '{"configuration":"Скло","color":"Каштан беж"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/5/4723261-megkomnatnaya-dver-atlantic-a001-so-steklom-kashtan-beg.jpg', 7),
    ('catalog-180', '{"configuration":"Скло","color":"Дуб шале графіт"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/6/395837107-megkomnatnaya-dver-atlantic-a001-so-steklom-dub-shale-grafit.jpg', 8),
    ('catalog-180', '{"configuration":"Скло","color":"Дуб сонома"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/7/457861942-megkomnatnaya-dver-atlantic-a001-so-steklom-dub-sonoma.jpg', 9),
    ('catalog-180', '{"configuration":"Скло","color":"Венге шоколадний"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/8/826758608-megkomnatnaya-dver-atlantic-a001-so-steklom-venge-shokoladnyj.jpg', 10),
    ('catalog-180', '{"configuration":"Скло","color":"Акація темна"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/9/69738423-megkomnatnaya-dver-atlantic-a001-so-steklom-akatsiya-temnaya.jpg', 11),
    ('catalog-193', '{"configuration":"Скло","color":"Мармур сірий"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/0/1996682-megkomnatnaya-dver-atlantic-a006-steklo-mramor-seryj.jpg', 1),
    ('catalog-193', '{"configuration":"Скло","color":"Сосна крем"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/6/336566996-megkomnatnaya-dver-atlantic-a006-steklo-sosna-krem.jpg', 2),
    ('catalog-193', '{"configuration":"Скло","color":"Сосна браш мінт"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/7/407898545-megkomnatnaya-dver-atlantic-a006-steklo-sosna-brash-mint.jpg', 3),
    ('catalog-193', '{"configuration":"Скло","color":"Сосна браш кобальт"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/8/488450145-megkomnatnaya-dver-atlantic-a006-steklo-sosna-brash-kobalt.jpg', 4),
    ('catalog-193', '{"configuration":"Скло","color":"Сосна браш браун"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/9/88959034-megkomnatnaya-dver-atlantic-a006-steklo-sosna-brash-braun.jpg', 5),
    ('catalog-193', '{"configuration":"Скло","color":"Крем"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/1/835384427-megkomnatnaya-dver-atlantic-a006-steklo-krem.jpg', 6),
    ('catalog-193', '{"configuration":"Скло","color":"Каштан сірий"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/2/972638416-megkomnatnaya-dver-atlantic-a006-steklo-kashtan-seryj.jpg', 7),
    ('catalog-193', '{"configuration":"Скло","color":"Каштан беж"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/4/956749569-megkomnatnaya-dver-atlantic-a006-steklo-kashtan-beg.jpg', 8),
    ('catalog-193', '{"configuration":"Скло","color":"Дуб шале графіт"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/5/892922617-megkomnatnaya-dver-atlantic-a006-steklo-dub-shale-grafit.jpg', 9),
    ('catalog-193', '{"configuration":"Скло","color":"Дуб сонома"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/6/412881056-megkomnatnaya-dver-atlantic-a006-steklo-dub-sonoma.jpg', 10),
    ('catalog-193', '{"configuration":"Скло","color":"Венге шоколадний"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/7/678227578-megkomnatnaya-dver-atlantic-a006-steklo-venge-shokoladnyj.jpg', 11),
    ('catalog-193', '{"configuration":"Скло","color":"Акація темна"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/8/961249158-megkomnatnaya-dver-atlantic-a006-steklo-akatsiya-temnaya.jpg', 12),
    ('catalog-194', '{"color":"RAL 7040"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/1/984094735-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-7040.jpg', 1),
    ('catalog-194', '{"color":"RAL 9010"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/6/214055247-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-9010.jpg', 2),
    ('catalog-194', '{"color":"RAL 9004"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/7/995484953-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-9004.jpg', 3),
    ('catalog-194', '{"color":"RAL 9001"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/8/917400784-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-9001.jpg', 4),
    ('catalog-194', '{"color":"RAL 8014"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/9/772061853-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-8014.jpg', 5),
    ('catalog-194', '{"color":"RAL 7047"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/0/656789852-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-7047.jpg', 6),
    ('catalog-194', '{"color":"RAL 7037"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/2/505678647-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-7037.jpg', 7),
    ('catalog-194', '{"color":"RAL 6019"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/3/829401925-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-6019.jpg', 8),
    ('catalog-194', '{"color":"RAL 5024"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/4/125812880-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-5024.jpg', 9),
    ('catalog-194', '{"color":"RAL 5022"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/5/358404019-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-5022.jpg', 10),
    ('catalog-194', '{"color":"RAL 5014"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/6/385278992-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-5014.jpg', 11),
    ('catalog-194', '{"color":"RAL 5012"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/7/20623514-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-5012.jpg', 12),
    ('catalog-194', '{"color":"RAL 5010"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/8/684142885-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-5010.jpg', 13),
    ('catalog-194', '{"color":"RAL 4001"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/9/183960004-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-4001.jpg', 14),
    ('catalog-194', '{"color":"RAL 1019"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/0/869155530-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-1019.jpg', 15),
    ('catalog-194', '{"color":"RAL 1015"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/1/704352738-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-1015.jpg', 16),
    ('catalog-194', '{"color":"RAL 1013"}'::jsonb, 'https://homedoors.com.ua/image/catalog/tovary/rodos/all_foto/2/228817749-megkomnatnye-dveri-cortes-dolce-polusteklo-3-ral-1013.jpg', 17)
)
insert into public.product_variants (product_slug, selections, image_path, sort_order)
select product_slug, selections, image_path, sort_order
from variants
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name,
  verification_status, verified_at, notes
)
values
  ('catalog-180', 'HOMEDOORS', 'https://homedoors.com.ua/uk/mizhkimnatna-dver-rodos-atlantic-a001-po-krem-sosna-ua.html', 'RODOS Atlantic A001 зі склом', 'verified', now(), 'Варіанти декорів на сторінці мають окремі підписані фото цієї моделі.'),
  ('catalog-193', 'HOMEDOORS', 'https://homedoors.com.ua/uk/dveri-migkimnatni-atlantic-a006-sklo-kashtan-bilij-uk.html', 'RODOS Atlantic A006 скло', 'verified', now(), 'Варіанти декорів на сторінці мають окремі підписані фото цієї моделі.'),
  ('catalog-194', 'HOMEDOORS', 'https://homedoors.com.ua/megkomnatnye-dveri-cortes-dolce-polusteklo-3-belyj-mat-ru.html', 'RODOS Cortes Dolce-3', 'verified', now(), 'Варіанти RAL на сторінці мають окремі підписані фото моделі Dolce-3.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
