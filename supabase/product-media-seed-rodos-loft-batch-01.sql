-- Офіційні додаткові фото RODOS, колекція Loft (фарба).
-- Джерело: офіційний каталог RODOS, rodos.md.

insert into public.product_media (product_slug, kind, label, image_path, sort_order)
select media.product_slug, media.kind, media.label, media.image_path, media.sort_order
from (values
  ('catalog-216', 'gallery', 'Rodos Loft Arrigo — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/232/arrigog.jpg', 10),
  ('catalog-216', 'gallery', 'Rodos Loft Arrigo — додатковий вигляд', 'https://www.rodos.md/assets/images/products/232/arrigo.jpg', 11),
  ('catalog-217', 'gallery', 'Rodos Loft Arte — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/279/bezyimyannyij.png', 10),
  ('catalog-217', 'gallery', 'Rodos Loft Arte — додатковий вигляд', 'https://www.rodos.md/assets/images/products/279/loft-arte-1644398431-2000x2000.jpg', 11),
  ('catalog-218', 'gallery', 'Rodos Loft Aura — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/280/bezyimyannyij.png', 10),
  ('catalog-218', 'gallery', 'Rodos Loft Aura — додатковий вигляд', 'https://www.rodos.md/assets/images/products/280/aura-1013-1644399693-2000x2000.jpg', 11),
  ('catalog-219', 'gallery', 'Rodos Loft Berta G — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/60/berta-g-%D1%88%D0%BF%D0%BE%D0%BD-%D0%B2%D1%81%D1%82%D0%B0%D0%B2%D0%BA%D0%B0-%D0%B1%D0%B5%D0%BB%D1%8B%D0%B9-%D0%BC%D0%B0%D1%82%D0%BE%D0%B2%D1%8B%D0%B9-21375.jpg', 10),
  ('catalog-219', 'gallery', 'Rodos Loft Berta G — додатковий вигляд', 'https://www.rodos.md/assets/images/products/60/berta-g-%D0%B2%D1%81%D1%82%D0%B0%D0%B2%D0%BA%D0%B0-%D0%B1%D0%B5%D0%BB%D1%8B%D0%B9-%D0%BC%D0%B0%D1%82%D0%BE%D0%B2%D1%8B%D0%B9-ral-21375.jpg', 11),
  ('catalog-220', 'gallery', 'Rodos Loft Berta GL — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/167/berta-gl.jpg', 10),
  ('catalog-220', 'gallery', 'Rodos Loft Berta GL — додатковий вигляд', 'https://www.rodos.md/assets/images/products/167/berta-gl-pe-alb.png', 11),
  ('catalog-221', 'gallery', 'Rodos Loft Berta GW — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/178/berta-gw.jpg', 10),
  ('catalog-221', 'gallery', 'Rodos Loft Berta GW — додатковий вигляд', 'https://www.rodos.md/assets/images/products/178/e9fe591368f9897843be22186bce2287.jpg', 11),
  ('catalog-222', 'gallery', 'Rodos Loft Berta V — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/127/breta-v-int.jpg', 10),
  ('catalog-222', 'gallery', 'Rodos Loft Berta V — додатковий вигляд', 'https://www.rodos.md/assets/images/products/127/berta-v-chernyij-glyanecz.png', 11),
  ('catalog-224', 'gallery', 'Rodos Loft Cosmo — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/282/bezyimyannyij.png', 10),
  ('catalog-224', 'gallery', 'Rodos Loft Cosmo — додатковий вигляд', 'https://www.rodos.md/assets/images/products/282/cortescosmo1013-1592391335-2000x2000.jpg', 11),
  ('catalog-225', 'gallery', 'Rodos Loft Lago 1 — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/276/lago-1.png', 10),
  ('catalog-225', 'gallery', 'Rodos Loft Lago 1 — додатковий вигляд', 'https://www.rodos.md/assets/images/products/276/beluy-mat-1658831756-2000x2000.jpg', 11),
  ('catalog-226', 'gallery', 'Rodos Loft Lago 2 — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/277/lago-2.png', 10),
  ('catalog-226', 'gallery', 'Rodos Loft Lago 2 — додатковий вигляд', 'https://www.rodos.md/assets/images/products/277/loft-lago2-gluhoe-belmat-1659354835-2000x2000-(1).jpg', 11),
  ('catalog-227', 'gallery', 'Rodos Loft Lago 3 — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/278/lago-3.png', 10),
  ('catalog-227', 'gallery', 'Rodos Loft Lago 3 — додатковий вигляд', 'https://www.rodos.md/assets/images/products/278/lago3-gluhoe-belmat-1659356863-2000x2000.jpg', 11),
  ('catalog-228', 'gallery', 'Rodos Loft Nikoletta — фронтальний вигляд', 'https://www.rodos.md/assets/images/products/283/bezyimyannyij.png', 10),
  ('catalog-228', 'gallery', 'Rodos Loft Nikoletta — додатковий вигляд', 'https://www.rodos.md/assets/images/products/283/loft-nicoletta-1013-1636121019-2000x2000.jpg', 11)
) as media(product_slug, kind, label, image_path, sort_order)
where not exists (
  select 1
  from public.product_media as existing
  where existing.product_slug = media.product_slug
    and existing.image_path = media.image_path
);
