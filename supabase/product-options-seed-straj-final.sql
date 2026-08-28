-- STRAJ: фінально підтверджені декори решти моделей.

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
values
  ('catalog-277', 'color', 'Варіант декору — уточнюйте доступність', 'Антрацит / антрацит', '#363b3d', 1),
  ('catalog-278', 'color', 'Варіант декору — уточнюйте доступність', 'Мармур темний / білий сатин', '#4c4a47', 1),
  ('catalog-282', 'color', 'Варіант декору — уточнюйте доступність', 'Мусонне дерево софт тач / софт мілк', '#766b60', 1)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;

insert into public.product_options (product_slug, option_group, group_label, label, swatch, sort_order)
values
  ('catalog-275', 'color', 'Декор на замовлення', 'Антрацит', '#363b3d', 1),
  ('catalog-275', 'color', 'Декор на замовлення', 'Біле дерево', '#e5dfd2', 2),
  ('catalog-275', 'color', 'Декор на замовлення', 'Дуб табак', '#6c4a32', 3),
  ('catalog-275', 'color', 'Декор на замовлення', 'Бетон темний', '#4b4844', 4),
  ('catalog-275', 'color', 'Декор на замовлення', 'Графіт', '#4c5050', 5),
  ('catalog-275', 'color', 'Декор на замовлення', 'Спил дерева коньячний', '#75472e', 6),
  ('catalog-275', 'color', 'Декор на замовлення', 'Білий сніг софт тач', '#f7f6f0', 7)
on conflict (product_slug, option_group, label) do update
set group_label = excluded.group_label, swatch = excluded.swatch, sort_order = excluded.sort_order, is_active = true;
