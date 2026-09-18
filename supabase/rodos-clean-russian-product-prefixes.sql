-- Rodos: прибираємо лише російський службовий префікс із назв моделей.
-- Не змінюються: slug, фабрика, колекція, фото, опції, характеристики й опис.
begin;

update public.products
set name = btrim(regexp_replace(name, '^(Межкомнатная дверь|Межкомнатные двери)[[:space:]]+', '', 'i'))
where brand = 'Rodos'
  and name ~* '^(Межкомнатная дверь|Межкомнатные двери)[[:space:]]+';

commit;

select slug, collection, name
from public.products
where brand = 'Rodos'
  and name ~* '^(Cortes|Atlantic|Loft|Siena|Royal|Style|Woodmix|Modern|Liberta|Гранд)'
order by collection, name;
