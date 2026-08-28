-- RODOS Atlantic: ПВХ-покриття.
-- За каталогом RODOS та картками колекції Atlantic: доступні для замовлення
-- плівки Renolit і LG. Виробник не фіксує один короткий перелік кольорів,
-- тому конкретний декор узгоджується із зразком у салоні.

insert into public.product_options (product_slug, option_group, group_label, label, sort_order)
select product.slug, 'finish', 'ПВХ-покриття — оберіть за зразком', finish.label, finish.sort_order
from public.products as product
cross join (values
  ('Плівка Renolit', 1),
  ('Плівка LG', 2)
) as finish(label, sort_order)
where product.brand = 'Rodos' and product.collection = 'Atlantic ПВХ'
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, sort_order = excluded.sort_order, is_active = true;
