-- ABWEHR: attach official sources and replace generic collections with verified series.
-- Safe scope: 12 unambiguous current models only.
-- No deletion, no availability changes, no photo or description changes.
-- Deliberately excluded: catalog-11 (Queen: two current official series) and catalog-5 (Rain: not found in current official catalogue).

begin;

do $$
declare
  expected_models constant integer := 12;
  matched_models integer;
begin
  select count(*) into matched_models
  from public.products
  where slug in (
    'catalog-1', 'catalog-2', 'catalog-3', 'catalog-4', 'catalog-6', 'catalog-7',
    'catalog-8', 'catalog-9', 'catalog-10', 'catalog-12', 'catalog-13', 'catalog-14'
  )
    and brand = 'Abwehr';

  if matched_models <> expected_models then
    raise exception 'Очікувалось % моделей Abwehr, знайдено %. Зміни не застосовано.', expected_models, matched_models;
  end if;
end $$;

with official_map(slug, collection, source_url, source_product_name) as (
  values
    ('catalog-1',  'Megapolis Kale', 'https://abwehr.com.ua/catalog/vhidni-dveri-model-harmonia-komplektaciya-megapolis-kale/p1565', 'Вхідні двері модель Harmonia комплектація Megapolis Kale'),
    ('catalog-2',  'Megapolis Kale', 'https://abwehr.com.ua/catalog/vhidni-dveri-model-limana-komplektaciya-megapolis-kale/p1566', 'Вхідні двері модель Limana комплектація Megapolis Kale'),
    ('catalog-3',  'Megapolis MG3',  'https://abwehr.com.ua/catalog/vhidni-dveri-model-melany-komplektaciya-megapolis-mg3/p1559', 'Вхідні двері модель Melany комплектація Megapolis MG3'),
    ('catalog-4',  'Megapolis Kale', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-dzerkalom-model-mira-komplektaciya-megapolis-kale/p1532', 'Вхідні двері з дзеркалом модель Mira комплектація Megapolis Kale'),
    ('catalog-6',  'Megapolis Kale', 'https://abwehr.com.ua/catalog/vhidni-dveri-model-riviera-komplektaciya-megapolis-kale/p1564', 'Вхідні двері модель Riviera комплектація Megapolis Kale'),
    ('catalog-7',  'Megapolis MG3',  'https://abwehr.com.ua/catalog/vhidni-dveri-z-grafitovim-dzerkalom-model-selena-komplektaciya-megapolis-mg3/p1560', 'Вхідні двері з графітовим дзеркалом модель Selena комплектація Megapolis MG3'),
    ('catalog-8',  'Grand',           'https://abwehr.com.ua/catalog/trohkonturni-vhidni-dveri-model-stella-komplektaciya-grand/p1449', 'Трьохконтурні вхідні двері модель Stella комплектація Grand'),
    ('catalog-9',  'Termix',          'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-avenue-komplektaciya-termix-1201/p1717', 'Вхідні двері з терморозривом модель Avenue комплектація Termix'),
    ('catalog-10', 'Termix',          'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-carat-komplektaciya-termix-1201-1/p1546', 'Вхідні двері з терморозривом модель Carat комплектація Termix'),
    ('catalog-12', 'Termix',          'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-revolution-komplektaciya-termix/p1571', 'Вхідні двері з терморозривом модель Revolution комплектація Termix'),
    ('catalog-13', 'Termix',          'https://abwehr.com.ua/catalog/polutorni-dveri-z-termorozrivom-model-tower-komplektaciya-termix-1200-3/p1698', 'Полуторні двері з терморозривом модель Tower комплектація Termix 1200'),
    ('catalog-14', 'Termix',          'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-tower-komplektaciya-termix-1201/p1683', 'Вхідні двері з терморозривом модель Tower комплектація Termix')
)
update public.products product
set collection = official_map.collection
from official_map
where product.slug = official_map.slug;

with official_map(slug, source_url, source_product_name) as (
  values
    ('catalog-1',  'https://abwehr.com.ua/catalog/vhidni-dveri-model-harmonia-komplektaciya-megapolis-kale/p1565', 'Вхідні двері модель Harmonia комплектація Megapolis Kale'),
    ('catalog-2',  'https://abwehr.com.ua/catalog/vhidni-dveri-model-limana-komplektaciya-megapolis-kale/p1566', 'Вхідні двері модель Limana комплектація Megapolis Kale'),
    ('catalog-3',  'https://abwehr.com.ua/catalog/vhidni-dveri-model-melany-komplektaciya-megapolis-mg3/p1559', 'Вхідні двері модель Melany комплектація Megapolis MG3'),
    ('catalog-4',  'https://abwehr.com.ua/catalog/vhidni-dveri-z-dzerkalom-model-mira-komplektaciya-megapolis-kale/p1532', 'Вхідні двері з дзеркалом модель Mira комплектація Megapolis Kale'),
    ('catalog-6',  'https://abwehr.com.ua/catalog/vhidni-dveri-model-riviera-komplektaciya-megapolis-kale/p1564', 'Вхідні двері модель Riviera комплектація Megapolis Kale'),
    ('catalog-7',  'https://abwehr.com.ua/catalog/vhidni-dveri-z-grafitovim-dzerkalom-model-selena-komplektaciya-megapolis-mg3/p1560', 'Вхідні двері з графітовим дзеркалом модель Selena комплектація Megapolis MG3'),
    ('catalog-8',  'https://abwehr.com.ua/catalog/trohkonturni-vhidni-dveri-model-stella-komplektaciya-grand/p1449', 'Трьохконтурні вхідні двері модель Stella комплектація Grand'),
    ('catalog-9',  'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-avenue-komplektaciya-termix-1201/p1717', 'Вхідні двері з терморозривом модель Avenue комплектація Termix'),
    ('catalog-10', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-carat-komplektaciya-termix-1201-1/p1546', 'Вхідні двері з терморозривом модель Carat комплектація Termix'),
    ('catalog-12', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-revolution-komplektaciya-termix/p1571', 'Вхідні двері з терморозривом модель Revolution комплектація Termix'),
    ('catalog-13', 'https://abwehr.com.ua/catalog/polutorni-dveri-z-termorozrivom-model-tower-komplektaciya-termix-1200-3/p1698', 'Полуторні двері з терморозривом модель Tower комплектація Termix 1200'),
    ('catalog-14', 'https://abwehr.com.ua/catalog/vhidni-dveri-z-termorozrivom-model-tower-komplektaciya-termix-1201/p1683', 'Вхідні двері з терморозривом модель Tower комплектація Termix')
)
insert into public.product_sources (
  product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes
)
select
  official_map.slug,
  'ABWEHR',
  official_map.source_url,
  official_map.source_product_name,
  'verified',
  now(),
  'Звірено з актуальною офіційною карткою виробника.'
from official_map
where not exists (
  select 1
  from public.product_sources source
  where source.product_slug = official_map.slug
    and source.source_url = official_map.source_url
);

select
  product.slug,
  product.name as модель,
  product.collection as офіційна_серія,
  product.is_available as опубліковано,
  source.source_url as офіційна_картка
from public.products product
join public.product_sources source
  on source.product_slug = product.slug
  and source.source_name = 'ABWEHR'
where product.slug in (
  'catalog-1', 'catalog-2', 'catalog-3', 'catalog-4', 'catalog-6', 'catalog-7',
  'catalog-8', 'catalog-9', 'catalog-10', 'catalog-12', 'catalog-13', 'catalog-14'
)
order by product.collection, product.name;

commit;
