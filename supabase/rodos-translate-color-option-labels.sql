-- Rodos: перекладає назви кольорів у конфігураторі.
-- Приклад: «Цвет RAL 1013» -> «Колір RAL 1013».
-- Важливо: синхронно оновлює і опції, і JSON-вибір у фото-варіантах,
-- щоб після зміни кольору головне фото й галерея продовжили перемикатися.

begin;

do $$
begin
  if exists (
    select 1
    from public.product_options old_option
    join public.products product on product.slug = old_option.product_slug
    join public.product_options new_option
      on new_option.product_slug = old_option.product_slug
     and new_option.option_group = old_option.option_group
     and new_option.label = regexp_replace(old_option.label, '^Цвет[[:space:]]+', 'Колір ', 'i')
    where product.brand = 'Rodos'
      and old_option.option_group = 'color'
      and old_option.label ~* '^Цвет[[:space:]]+'
  ) then
    raise exception 'Є дублікати майбутніх назв кольорів. Нічого не змінено.';
  end if;
end $$;

update public.product_options option_row
set label = regexp_replace(option_row.label, '^Цвет[[:space:]]+', 'Колір ', 'i')
from public.products product
where product.slug = option_row.product_slug
  and product.brand = 'Rodos'
  and option_row.option_group = 'color'
  and option_row.label ~* '^Цвет[[:space:]]+';

update public.product_variants variant_row
set selections = jsonb_set(
  variant_row.selections,
  '{color}',
  to_jsonb(regexp_replace(variant_row.selections ->> 'color', '^Цвет[[:space:]]+', 'Колір ', 'i'))
)
from public.products product
where product.slug = variant_row.product_slug
  and product.brand = 'Rodos'
  and variant_row.selections ? 'color'
  and variant_row.selections ->> 'color' ~* '^Цвет[[:space:]]+';

commit;

select
  count(*) filter (where label ~* '^Цвет[[:space:]]+') as ще_російською,
  count(*) filter (where label ~* '^Колір[[:space:]]+') as кольорів_українською
from public.product_options option_row
join public.products product on product.slug = option_row.product_slug
where product.brand = 'Rodos'
  and option_row.option_group = 'color';
