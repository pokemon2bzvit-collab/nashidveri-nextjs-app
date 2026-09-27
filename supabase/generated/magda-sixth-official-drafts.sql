-- Magda: моделі 529.1 і 178 з другої сторінки офіційного каталогу.
-- Обидві створюються прихованими чернетками, по 2 офіційні фото.

begin;

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available, updated_at)
values
  ('magda-529-1-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №529.1',
   'Сталь, МДФ-панелі та заводські покриття', 'Для квартири', 'Дрімвуд коричневий · дрімвуд світлий', 'Ціна за запитом',
   'Magda 529.1 — вхідні двері для квартири з поєднанням декорів «дрімвуд коричневий» зовні та «дрімвуд світлий» в інтер’єрі. Доступні кілька типів комплектації; актуальну ціну уточнюйте у менеджера.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Гнутий профіль'),
   'https://magda.com.ua/storage/app/uploads/public/d87/6fc/811/thumb__0_0_0_0_auto.jpg', 99012, false, now()),
  ('magda-178-official', 'entrance', 'Magda', 'Квартира', 'Magda Модель №178',
   'Сталь, МДФ-панелі та заводські покриття', 'Для квартири', 'Венге горизонт сірий · астана попелясто-білий', 'Ціна за запитом',
   'Magda 178 — вхідні двері для квартири з лаконічним дизайном і надійним захистом. Зовнішній декор — венге горизонт сірий, внутрішній — астана попелясто-білий горизонт; фурнітуру й плівку можна підібрати під інтер’єр.',
   jsonb_build_array('Офіційна модель Magda', 'Для квартири', 'Заводські декори'),
   'https://magda.com.ua/storage/app/uploads/public/7c4/43f/8cf/thumb__0_0_0_0_auto.jpg', 99013, false, now())
on conflict (slug) do update set
  collection = excluded.collection, name = excluded.name, material = excluded.material,
  style = excluded.style, color = excluded.color, description = excluded.description,
  features = excluded.features, image_path = excluded.image_path, updated_at = now();

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes)
values
  ('magda-529-1-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/5281-2', 'Модель №529.1', 'verified', now(), 'Для квартири; типи 2.24, 3.23, 5, 13.'),
  ('magda-178-official', 'Офіційний каталог Magda', 'https://magda.com.ua/uk/catalog/item/178', 'Модель №178', 'verified', now(), 'Для квартири; доступні конструктивні типи та заводські декори.')
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name, source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status, verified_at = excluded.verified_at, notes = excluded.notes;

insert into public.product_media (product_slug, kind, label, image_path, sort_order, is_active)
values
  ('magda-529-1-official', 'gallery', 'Модель 529.1 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/d87/6fc/811/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-529-1-official', 'gallery', 'Модель 529.1 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/6a0/29d/1e1/thumb__0_0_0_0_auto.jpg', 2, true),
  ('magda-178-official', 'gallery', 'Модель 178 — фото 1', 'https://magda.com.ua/storage/app/uploads/public/7c4/43f/8cf/thumb__0_0_0_0_auto.jpg', 1, true),
  ('magda-178-official', 'gallery', 'Модель 178 — фото 2', 'https://magda.com.ua/storage/app/uploads/public/b1f/59d/bc2/thumb__0_0_0_0_auto.jpg', 2, true)
on conflict (product_slug, kind, image_path) do update set label = excluded.label, sort_order = excluded.sort_order, is_active = true;

insert into public.product_specs (product_slug, label, value, sort_order, is_active)
values
  ('magda-529-1-official', 'Типи комплектації', 'Тип 2.24, 3.23, 5 або 13', 1, true),
  ('magda-529-1-official', 'Товщина полотна', '90 мм, гнутий профіль', 2, true),
  ('magda-529-1-official', 'Товщина короба', '100 мм, гнутий профіль', 3, true),
  ('magda-529-1-official', 'Товщина металу', '1,2 мм', 4, true),
  ('magda-529-1-official', 'Контури ущільнення', '2', 5, true),
  ('magda-529-1-official', 'Наповнення', 'Мінеральна та кам’яна вата', 6, true),
  ('magda-178-official', 'Товщина полотна', '90 мм', 1, true),
  ('magda-178-official', 'Товщина короба', '125–130 мм залежно від комплектації', 2, true),
  ('magda-178-official', 'Товщина металу', '1,2–2 мм залежно від комплектації', 3, true),
  ('magda-178-official', 'Контури ущільнення', '2 або 3 залежно від комплектації', 4, true),
  ('magda-178-official', 'Наповнення', 'Мінеральна та кам’яна вата', 5, true),
  ('magda-178-official', 'Доступні комплектації', 'Заводські типи з різним рівнем замків і захисту', 6, true)
on conflict (product_slug, label) do update set value = excluded.value, sort_order = excluded.sort_order, is_active = true;

commit;

select p.slug, p.name as "модель", p.collection as "колекція", p.is_available as "опубліковано",
  count(distinct m.id) filter (where m.kind = 'gallery' and m.is_active) as "фото_в_галереї",
  count(distinct s.id) filter (where s.verification_status = 'verified') as "офіційних_джерел"
from public.products p
left join public.product_media m on m.product_slug = p.slug
left join public.product_sources s on s.product_slug = p.slug
where p.slug in ('magda-529-1-official','magda-178-official')
group by p.slug, p.name, p.collection, p.is_available
order by p.name;
