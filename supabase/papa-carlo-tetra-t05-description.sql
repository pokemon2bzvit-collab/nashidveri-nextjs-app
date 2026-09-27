-- Papa Carlo T-05: опис синхронізовано з точними розмірами фабрики.

update public.products
set description = 'Papa Carlo T-05 — міжкімнатні двері колекції Tetra з поліпропіленовим покриттям Renolit (Німеччина). Стійке до пошкоджень покриття допомагає зберігати охайний вигляд у щоденному користуванні. Доступні ширини полотна 410, 610, 710, 810 або 910 мм, стандартна висота 2000 мм; можливий нестандартний розмір під замовлення. Актуальну комплектацію й ціну уточнюйте у менеджера.'
where slug = 'catalog-120'
  and brand = 'Papa Carlo'
  and collection = 'Tetra';

select name, description
from public.products
where slug = 'catalog-120';
