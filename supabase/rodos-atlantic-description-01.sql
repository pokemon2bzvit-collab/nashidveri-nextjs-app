-- Перший перевірений опис Rodos Atlantic.
-- Джерело для внутрішньої звірки: https://rodos.ua/mezhkomnatnaya-dver-atlantic-a002
-- Не змінює картку, якщо її шаблонний опис уже відредаговано вручну.

begin;

update public.products
set description = 'Rodos Atlantic A002 — міжкімнатні двері з ПВХ-покриттям Renolit (Німеччина). Модель доступна з глухим полотном, частковим склінням або скляною вставкою; серед декорів є світлі відтінки та текстури дерева.',
    updated_at = now()
where slug = 'rodos-official-1osu0nc'
  and brand = 'Rodos'
  and collection = 'Atlantic ПВХ'
  and description = 'Міжкімнатні двері Atlantic A002 — модель фабрики Rodos для вашого інтер’єру. Детальні характеристики, доступні покриття та актуальну ціну уточнюйте у менеджера.';

commit;

select slug, name, description
from public.products
where slug = 'rodos-official-1osu0nc';
