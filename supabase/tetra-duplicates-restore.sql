-- Відновити моделі Tetra, приховані під час попередньої звірки.
-- Без видалення або зміни фото, декорів чи характеристик.

update public.products
set is_available = true
where slug in ('catalog-146', 'catalog-147', 'catalog-148', 'catalog-149', 'catalog-150', 'catalog-151');

select slug, name, is_available, image_path
from public.products
where slug in ('catalog-146', 'catalog-147', 'catalog-148', 'catalog-149', 'catalog-150', 'catalog-151')
order by slug;
