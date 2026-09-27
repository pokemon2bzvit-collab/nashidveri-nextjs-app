-- Термінус · Caro: прибрати застарілі загальні декори й типи скла.
-- Для цих п'яти моделей уже є точні варіанти з фото у групах
-- «Декор полотна» та «Варіант полотна». Старі групи дублюють їх і
-- заважають прямому перемиканню фото на картці товару.

begin;

do $$
declare
  exact_models integer;
begin
  select count(*) into exact_models
  from public.products
  where slug in ('catalog-295', 'catalog-296', 'catalog-297', 'catalog-298', 'catalog-299')
    and brand = 'Термінус'
    and collection = 'Caro';

  if exact_models <> 5 then
    raise exception 'Очікувалось 5 моделей Caro з точними варіантами, знайдено % — дані не змінено', exact_models;
  end if;
end $$;

-- Лишаємо тільки точні групи color/configuration, завантажені разом із фото.
delete from public.product_options
where product_slug in ('catalog-295', 'catalog-296', 'catalog-297', 'catalog-298', 'catalog-299')
  and option_group in ('finish', 'glass');

commit;

select
  product_slug as slug,
  string_agg(distinct group_label, ' · ' order by group_label) as групи_вибору,
  count(*) as опцій
from public.product_options
where product_slug in ('catalog-295', 'catalog-296', 'catalog-297', 'catalog-298', 'catalog-299')
  and is_active
group by product_slug
order by product_slug;
