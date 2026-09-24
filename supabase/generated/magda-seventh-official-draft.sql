-- Magda 175: перевірена офіційна чернетка з двома фото.

begin;

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values (
  'magda-175-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №175',
  'Сталь, МДФ-панелі та ПВХ-покриття', 'Для квартири', 'Темний оксид · світлий оксид', 'Ціна за запитом',
  'Magda 175 — надійні вхідні двері для квартири з лаконічним дизайном. Зовнішній декор — темний оксид, внутрішній — світлий оксид; доступні різні ПВХ-покриття та варіанти фурнітури під ваш інтер’єр.',
  jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'ПВХ-покриття'),
  'https://magda.com.ua/storage/app/uploads/public/ffa/88c/52a/thumb__0_0_0_0_auto.jpg', 99014, false, now()
)
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values ('magda-175-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/175', 'Модель №175', 'verified', now(), 'Для квартири; заводські ПВХ-покриття та варіанти фурнітури.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-175-official', 'gallery', 'Модель 175 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/ffa/88c/52a/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-175-official', 'gallery', 'Модель 175 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/304/5c8/f06/thumb__0_0_0_0_auto.jpg', 2, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-175-official', 'Товщина полотна', '90 мм, гнутий профіль', 1, true),
  ('magda-175-official', 'Товщина короба', '100 мм, гнутий профіль', 2, true),
  ('magda-175-official', 'Товщина металу', '1,2 мм', 3, true),
  ('magda-175-official', 'Контури ущільнення', '2', 4, true),
  ('magda-175-official', 'Наповнення', 'Мінеральна та кам’яна вата', 5, true),
  ('magda-175-official', 'Доступні декори', 'ПВХ-покриття в різних кольорах', 6, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug = 'magda-175-official'
group by p.slug, p.name, p.is_available;
