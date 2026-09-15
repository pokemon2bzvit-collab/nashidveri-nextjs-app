-- Прибирає конфігуратор декорів лише з Papa Carlo / Milenium.
-- Галереї у product_media та технічні характеристики не змінюються.
begin;

delete from public.product_variants
where product_slug in (
  select slug from public.products
  where brand = 'Papa Carlo' and collection = 'Milenium'
);

delete from public.product_options
where product_slug in (
  select slug from public.products
  where brand = 'Papa Carlo' and collection = 'Milenium'
);

commit;

select
  (select count(*) from public.product_options o join public.products p on p.slug = o.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Milenium') as опцій_залишилось,
  (select count(*) from public.product_variants v join public.products p on p.slug = v.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Milenium') as варіантів_залишилось;
