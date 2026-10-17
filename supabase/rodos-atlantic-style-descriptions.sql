-- Погоджений опис для всієї серії Rodos Atlantic (A001–A006).
-- Повторне виконання безпечне; назва моделі підставляється з її картки.
begin;

do $$
declare
  model_count integer;
begin
  select count(*) into model_count
  from public.products
  where brand = 'Rodos'
    and collection in ('Atlantic ПВХ', 'Atlantic')
    and slug in (
      'rodos-official-1osu0nf', 'rodos-official-1osu0nc',
      'rodos-official-16d044a', 'rodos-official-bf2ks0',
      'rodos-official-1osu0nj', 'rodos-official-lnsyln'
    );
  if model_count <> 6 then
    raise exception 'Очікувалось 6 моделей Rodos Atlantic, знайдено % — описи не змінено', model_count;
  end if;
end $$;

update public.products
set description = name || ' від Rodos — міжкімнатні двері для інтер’єру, де цінують простоту й гармонію. Стримана геометрія полотна доповнює сучасний стиль, мінімалізм і скандинавські інтер’єри, створюючи відчуття порядку та затишку.'
    || E'\n\n'
    || 'Глухе виконання підкреслює лаконічність дизайну, а напівскло чи скляні вставки додають візуальної легкості. Вибір декорів дозволяє поєднати двері з оздобленням кімнати, а покриття Renolit зручне у щоденному догляді.',
    updated_at = now()
where brand = 'Rodos'
  and collection in ('Atlantic ПВХ', 'Atlantic')
  and slug in (
    'rodos-official-1osu0nf', 'rodos-official-1osu0nc',
    'rodos-official-16d044a', 'rodos-official-bf2ks0',
    'rodos-official-1osu0nj', 'rodos-official-lnsyln'
  );

commit;

select slug, name, description
from public.products
where brand = 'Rodos'
  and collection in ('Atlantic ПВХ', 'Atlantic')
  and slug in (
    'rodos-official-1osu0nf', 'rodos-official-1osu0nc',
    'rodos-official-16d044a', 'rodos-official-bf2ks0',
    'rodos-official-1osu0nj', 'rodos-official-lnsyln'
  )
order by name;
