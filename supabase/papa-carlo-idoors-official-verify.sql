select
  (select count(*) from public.products where brand = 'Papa Carlo' and collection = 'iDoors') as моделей,
  (select count(*) from public.products where brand = 'Papa Carlo' and collection = 'iDoors' and is_available) as опубліковано,
  (select count(*) from public.product_media m join public.products p on p.slug = m.product_slug where p.brand = 'Papa Carlo' and p.collection = 'iDoors') as фото_у_галереях,
  (select count(distinct m.product_slug) from public.product_media m join public.products p on p.slug = m.product_slug where p.brand = 'Papa Carlo' and p.collection = 'iDoors') as моделей_з_фото,
  (select count(*) from public.product_options o join public.products p on p.slug = o.product_slug where p.brand = 'Papa Carlo' and p.collection = 'iDoors') as опцій_конфігуратора,
  (select count(*) from public.product_variants v join public.products p on p.slug = v.product_slug where p.brand = 'Papa Carlo' and p.collection = 'iDoors') as варіантів_конфігуратора;
