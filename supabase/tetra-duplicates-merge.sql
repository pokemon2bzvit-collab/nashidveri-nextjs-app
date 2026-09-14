-- Papa Carlo Tetra: прибрати точні дублікати з публічного каталогу.
-- Перевірено звітом tetra-duplicates-audit.sql.
-- У картках, які залишаються, уже є всі корисні дані:
--   T-01 / T-02 / T-03 — кольори, «скло сатин 2х сторонній» і фото варіантів;
--   T-04 / T-12 / T-14 — кольори та фото варіантів.
-- Цей скрипт НІЧОГО не видаляє: дублікати лише стають прихованими.

begin;

-- Канонічні картки, які залишаються показаними в каталозі.
update public.products
set name = case slug
  when 'catalog-133' then 'Papa Carlo T-01'
  when 'catalog-134' then 'Papa Carlo T-02'
  when 'catalog-135' then 'Papa Carlo T-03'
  when 'catalog-119' then 'Papa Carlo T-04'
  when 'catalog-136' then 'Papa Carlo T-12'
  when 'catalog-128' then 'Papa Carlo T-14'
  else name
end,
is_available = true
where slug in ('catalog-133', 'catalog-134', 'catalog-135', 'catalog-119', 'catalog-136', 'catalog-128');

-- Порожні дублікати лишаються в базі для можливого відновлення,
-- але зникають з каталогу та sitemap.
update public.products
set is_available = false
where slug in ('catalog-146', 'catalog-147', 'catalog-148', 'catalog-149', 'catalog-150', 'catalog-151');

commit;

-- Контрольний результат після виконання.
select slug, name, is_available
from public.products
where slug in (
  'catalog-119', 'catalog-128', 'catalog-133', 'catalog-134', 'catalog-135', 'catalog-136',
  'catalog-146', 'catalog-147', 'catalog-148', 'catalog-149', 'catalog-150', 'catalog-151'
)
order by slug;
