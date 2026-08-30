-- Grand — 37 моделей у колекціях DELUX, LUX і Paint.
-- Оновлює описи. Фото та детальні характеристики вже додані попередніми пакетами.

update public.products
set description = case collection
  when 'DELUX' then name || ' — міжкімнатні двері лінійки RODOS Grand DELUX із покриттям ПВХ Renolit (Німеччина). Доступні полотна шириною 600, 700, 800 або 900 мм та фірмова система погонажу Delux.'
  when 'LUX' then name || ' — міжкімнатні двері RODOS Grand LUX у стилі гранж. Конструкція з євробрусів, МДФ-елементів і ламінованих МДФ-плит має товщину полотна 44 мм та покриття ПВХ Renolit (Німеччина).'
  when 'Paint' then name || ' — пофарбовані міжкімнатні двері RODOS Grand Paint у стилі гранж. Дерев’яне полотно товщиною 44 мм доступне у стандартних розмірах 600–900 × 2000 мм; можливе індивідуальне виготовлення.'
  else description
end
where brand = 'Grand'
  and collection in ('DELUX', 'LUX', 'Paint');
