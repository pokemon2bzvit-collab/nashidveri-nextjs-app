-- ABWEHR Mira: підтверджений варіант «Бронзовий браш → фото».
-- Джерело: офіційна картка моделі код 549, Megapolis MG3.
-- Перевірено 01.09.2026. Сторінка прямо вказує колір «Бронзовий Браш».
-- Інші два декори Mira не додаються: для них поки немає підтвердженої пари
-- «назва декору → конкретне зображення».
-- Скрипт можна виконувати повторно.

insert into public.product_variants (product_slug, selections, image_path, sort_order)
values (
  'catalog-4',
  '{"finish":"Бронзовий браш"}'::jsonb,
  'https://abwehr.com.ua/storage/products/images/big/mYU5fVN3MxFA4GQ57wPpc8qCTZDpAIYZSsMl87mh.jpg.webp?v=1771582915',
  1
)
on conflict (product_slug, selections) do update set
  image_path = excluded.image_path,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.product_sources (
  product_slug,
  source_name,
  source_url,
  source_product_name,
  verification_status,
  verified_at,
  notes
)
values (
  'catalog-4',
  'ABWEHR',
  'https://abwehr.com.ua/catalog/vhidni-dveri-z-dzerkalom-model-mira-komplektaciya-megapolis-mg3-2/p1469',
  'Mira, Megapolis MG3, Бронзовий Браш (код 549)',
  'verified',
  now(),
  'Офіційна картка моделі; пряме підтвердження кольору та зображення.'
)
on conflict (product_slug, source_url) do update set
  source_name = excluded.source_name,
  source_product_name = excluded.source_product_name,
  verification_status = excluded.verification_status,
  verified_at = excluded.verified_at,
  notes = excluded.notes;
