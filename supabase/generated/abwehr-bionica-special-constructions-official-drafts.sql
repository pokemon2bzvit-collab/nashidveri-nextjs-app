-- ABWEHR BIONICA COMBO: additional distinct designs and structural versions as hidden drafts.
-- No existing product is deleted, changed, or published.

begin;

create temporary table abwehr_bionica_special_constructions (
  slug text primary key, name text not null, product_code text not null,
  source_url text not null, construction_type text not null, main_image text not null
) on commit drop;

insert into abwehr_bionica_special_constructions values
  ('abwehr-bionica-ufo-gold', 'Abwehr Ufo Gold', '478', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-ufo-gold-komplektaciya-bionica-combo/p1282', 'Вхідні двері для приватного будинку', 'https://abwehr.com.ua/storage/products/images/big/QOWlObJ7aFjGfRbI3YNwSjajqWe6QhS23uDKZNYK.jpg.webp?v=1771580656'),
  ('abwehr-bionica-ufo-transom', 'Abwehr Ufo з фрамугою', '367', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-framugoyu-ta-termorozrivom-model-ufo-komplektaciya-bionica-combo/p1511', 'Вхідні двері з фрамугою', 'https://abwehr.com.ua/storage/products/images/big/Ukt4zSFDebywnxoDwP77shSxZZPQ2Ir1vlFEHUym.jpg.webp?v=1771581123'),
  ('abwehr-bionica-queen-transom', 'Abwehr Queen з фрамугою', 'KT+LP5', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-framugoyu-ta-pokrittyam-lampre-model-queen-komplektaciya-bionica-combo/p1594', 'Вхідні двері з фрамугою', 'https://abwehr.com.ua/storage/products/images/big/fmWbwP3t4kKwzmoJEAFJYI6H5F84EWG3dpESeGP8.jpg.webp?v=1771582229'),
  ('abwehr-bionica-scandi-blank-transom', 'Abwehr Scandi з глухою фрамугою', '498', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-glukhoyu-framugoyu-ta-termorozrivom-model-scandi-komplektaciya-bionica-combo/p1500', 'Вхідні двері з глухою фрамугою', 'https://abwehr.com.ua/storage/products/images/big/ht95LSzyowC9Xyvh6cnhHjwaq4oQgTDwfpWk62So.jpg.webp?v=1771582437'),
  ('abwehr-bionica-country-inside-opening', 'Abwehr Country з внутрішнім відкриванням', '501', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-vnutrishnim-vidkrivannyam-model-country-komplektaciya-bionica-combo/p1693', 'Вхідні двері з внутрішнім відкриванням', 'https://abwehr.com.ua/storage/products/images/big/jyX0vzEUJbgMrJ2qsA8SpGDRY3wAlYbU548NR3ao.jpg.webp?v=1775738285'),
  ('abwehr-bionica-queen-1200', 'Abwehr Queen 1200', 'LP5', 'https://abwehr.com.ua/catalog/polutorni-dveri-z-termorozrivom-model-queen-komplektaciya-bionica-combo-1200/p1313', 'Напівторастулкові двері 1200 мм', 'https://abwehr.com.ua/storage/products/images/big/p0afp7lciosGCGctukgTLSQBhcy7H1BWSD2QOziI.jpg.webp?v=1781515542');

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available)
select model.slug, 'entrance', 'Abwehr', 'Bionica Combo', model.name,
  'Сталь, МДФ-накладки та заводські атмосферостійкі покриття', 'Сучасний', 'Заводські декори', 'Ціна за запитом',
  model.name || ' — ' || lower(model.construction_type) || ' колекції Bionica Combo. Терморозрив і три контури ущільнення допомагають підтримувати комфорт у приміщенні; точну комплектацію й ціну уточнюйте у менеджера.',
  jsonb_build_array('Фабрика Abwehr', 'Колекція Bionica Combo', 'Терморозрив', '3 контури ущільнення'), model.main_image, 99999, false
from abwehr_bionica_special_constructions model
on conflict (slug) do update set name = excluded.name, material = excluded.material, style = excluded.style,
  color = excluded.color, description = excluded.description, features = excluded.features, image_path = excluded.image_path;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
select model.slug, spec.label, spec.value, spec.sort_order, true
from abwehr_bionica_special_constructions model
cross join lateral (values
  ('Тип конструкції', model.construction_type, 10), ('Колекція', 'Bionica Combo', 20),
  ('Призначення', 'Для приватного будинку', 30), ('Терморозрив', 'Так', 40), ('Контури ущільнення', '3 контури', 50)
) as spec(label, value, sort_order)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
select model.slug, 'ABWEHR', model.source_url, model.name || ' · Bionica Combo · код ' || model.product_code,
  'verified', now(), 'Офіційна картка виробника: окрема модель або конструктивна версія Bionica Combo та фотогалерея.'
from abwehr_bionica_special_constructions model
where not exists (select 1 from public.product_sources source where source.product_slug = model.slug and source.source_url = model.source_url);

create temporary table abwehr_bionica_special_constructions_gallery (product_slug text not null, image_path text not null, sort_order integer not null) on commit drop;

insert into abwehr_bionica_special_constructions_gallery values
  ('abwehr-bionica-ufo-gold', 'https://abwehr.com.ua/storage/products/images/big/QOWlObJ7aFjGfRbI3YNwSjajqWe6QhS23uDKZNYK.jpg.webp?v=1771580656', 1), ('abwehr-bionica-ufo-gold', 'https://abwehr.com.ua/storage/products/images/big/tJRAHLSGW4fik1SDMLNfXdDvAlEwpvqmoDSgKD0U.jpg.webp?v=1771583670', 2), ('abwehr-bionica-ufo-gold', 'https://abwehr.com.ua/storage/products/images/big/HWxbRPoogDva3hETOOkZbxMthbl9EflAzeEVelce.jpg.webp?v=1771579836', 3), ('abwehr-bionica-ufo-gold', 'https://abwehr.com.ua/storage/products/images/big/bcUniYO5MoO6FBIcRw5gHG8Vnvi5s7GoKMGupgC1.jpg.webp?v=1771581801', 4), ('abwehr-bionica-ufo-gold', 'https://abwehr.com.ua/storage/products/images/big/i8niq4e8yd5FjOodDeqUNfJ0LuFF7M2Znmgjsa0E.jpg.webp?v=1771582465', 5),
  ('abwehr-bionica-ufo-transom', 'https://abwehr.com.ua/storage/products/images/big/Ukt4zSFDebywnxoDwP77shSxZZPQ2Ir1vlFEHUym.jpg.webp?v=1771581123', 1), ('abwehr-bionica-ufo-transom', 'https://abwehr.com.ua/storage/products/images/big/b0jWB86iLMcQioaw28EerKKcMrBa8gcbUREoGRT4.jpg.webp?v=1771581740', 2), ('abwehr-bionica-ufo-transom', 'https://abwehr.com.ua/storage/products/images/big/FHb3DUpQ4vX5HZlUEGoWcfEP9OUhkNgp6HevAbUM.jpg.webp?v=1771579599', 3), ('abwehr-bionica-ufo-transom', 'https://abwehr.com.ua/storage/products/images/big/EuebU3bwCrtAGv0I1Slg2JA6cXEYSU9weAFlOz5W.jpg.webp?v=1771579559', 4), ('abwehr-bionica-ufo-transom', 'https://abwehr.com.ua/storage/products/images/big/LgVNb2QveIYTUT1Mund4R9h9TxsUy7uml8jrp4k2.jpg.webp?v=1771580211', 5),
  ('abwehr-bionica-queen-transom', 'https://abwehr.com.ua/storage/products/images/big/fmWbwP3t4kKwzmoJEAFJYI6H5F84EWG3dpESeGP8.jpg.webp?v=1771582229', 1), ('abwehr-bionica-queen-transom', 'https://abwehr.com.ua/storage/products/images/big/gC3nsxXXznvEiX2YFeLDC7s9eRwe1UhY3K0OHH8a.jpg.webp?v=1771582280', 2),
  ('abwehr-bionica-scandi-blank-transom', 'https://abwehr.com.ua/storage/products/images/big/ht95LSzyowC9Xyvh6cnhHjwaq4oQgTDwfpWk62So.jpg.webp?v=1771582437', 1), ('abwehr-bionica-scandi-blank-transom', 'https://abwehr.com.ua/storage/products/images/big/HPRGNY7hjWLS51EzceMDdddyFBubM3eA94LzPfc1.jpg.webp?v=1771579825', 2), ('abwehr-bionica-scandi-blank-transom', 'https://abwehr.com.ua/storage/products/images/big/7ULoarHF0Oc9qbLC4lsMqtTjl85K4T7HWY1IQe24.jpg.webp?v=1771578767', 3), ('abwehr-bionica-scandi-blank-transom', 'https://abwehr.com.ua/storage/products/images/big/Tl7oqy8zZ2uINBEEOGawLk8tD9lxCvkmoLQmLEwo.jpg.webp?v=1771581026', 4), ('abwehr-bionica-scandi-blank-transom', 'https://abwehr.com.ua/storage/products/images/big/tR7emLWiwtuqVCx9zDpauYWET2aqbI4KcQNlaMOU.jpg.webp?v=1771583689', 5),
  ('abwehr-bionica-country-inside-opening', 'https://abwehr.com.ua/storage/products/images/big/jyX0vzEUJbgMrJ2qsA8SpGDRY3wAlYbU548NR3ao.jpg.webp?v=1775738285', 1), ('abwehr-bionica-country-inside-opening', 'https://abwehr.com.ua/storage/products/images/big/AEoetnpp074AMheYGbD7QcgdyDD06AgXdDMCZJic.jpg.webp?v=1775738281', 2), ('abwehr-bionica-country-inside-opening', 'https://abwehr.com.ua/storage/products/images/big/iPShh8HDnt0pu54zgcLhwdXY2pT4X0Fm4YIvtw0j.jpg.webp?v=1775738282', 3), ('abwehr-bionica-country-inside-opening', 'https://abwehr.com.ua/storage/products/images/big/vDSJAgYO15NMqJ8CCmsnIb3jKDA0DNpk54Mh3xqf.jpg.webp?v=1775738284', 4), ('abwehr-bionica-country-inside-opening', 'https://abwehr.com.ua/storage/products/images/big/cLne2UYGfhf3jLK6xEOt0cHaZcvgqYTOVythnjiD.jpg.webp?v=1775738282', 5),
  ('abwehr-bionica-queen-1200', 'https://abwehr.com.ua/storage/products/images/big/p0afp7lciosGCGctukgTLSQBhcy7H1BWSD2QOziI.jpg.webp?v=1781515542', 1), ('abwehr-bionica-queen-1200', 'https://abwehr.com.ua/storage/products/images/big/O5Z49IdR9NPgfvXzsqtDCsdHamlgZTIpeuAwqcFV.jpg.webp?v=1771580429', 2), ('abwehr-bionica-queen-1200', 'https://abwehr.com.ua/storage/products/images/big/VEtZbQeR0WLngFET3nebxYfMqxBERgawU5BeOedP.jpg.webp?v=1771581174', 3), ('abwehr-bionica-queen-1200', 'https://abwehr.com.ua/storage/products/images/big/0APCf5qBblBELfdOesviFPJGYEZcnG4IFwErAHG3.jpg.webp?v=1771578022', 4), ('abwehr-bionica-queen-1200', 'https://abwehr.com.ua/storage/products/images/big/JjPYdjPUXqCBeFGrNDlxnQqGNXwywfdpOWt0N9Io.jpg.webp?v=1771580031', 5);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select model.slug, 'main', 'Головне фото', model.main_image, 0 from abwehr_bionica_special_constructions model
where not exists (select 1 from public.product_media media where media.product_slug = model.slug and media.kind = 'main' and media.image_path = model.main_image);

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select gallery.product_slug, 'gallery', 'Офіційне фото ' || gallery.sort_order, gallery.image_path, gallery.sort_order
from abwehr_bionica_special_constructions_gallery gallery
where not exists (select 1 from public.product_media media where media.product_slug = gallery.product_slug and media.kind = 'gallery' and media.image_path = gallery.image_path);

commit;

select count(*) as моделей, count(*) filter (where is_available) as опубліковано,
  (select count(*) from public.product_media media where media.product_slug in ('abwehr-bionica-ufo-gold', 'abwehr-bionica-ufo-transom', 'abwehr-bionica-queen-transom', 'abwehr-bionica-scandi-blank-transom', 'abwehr-bionica-country-inside-opening', 'abwehr-bionica-queen-1200') and media.kind = 'gallery') as фото_в_галереях,
  count(*) filter (where image_path is not null) as моделей_з_фото
from public.products where slug in ('abwehr-bionica-ufo-gold', 'abwehr-bionica-ufo-transom', 'abwehr-bionica-queen-transom', 'abwehr-bionica-scandi-blank-transom', 'abwehr-bionica-country-inside-opening', 'abwehr-bionica-queen-1200');
