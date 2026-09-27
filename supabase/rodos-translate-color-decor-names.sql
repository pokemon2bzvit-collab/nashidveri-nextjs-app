-- Rodos: переклад окремих назв кольорів/декорів, які прийшли російською.
-- Оновлює і кнопки, і вибір у варіантах фото.

begin;

create temporary table rodos_color_translations (
  source_label text primary key,
  target_label text not null
) on commit drop;

insert into rodos_color_translations (source_label, target_label) values
  ('Палисандр', 'Палісандр'),
  ('Орех', 'Горіх'),
  ('Дуб Белый', 'Білий дуб'),
  ('Шпон дуба LTL 6403', 'Шпон дуба LTL 6403'),
  ('Шпон дуба LTL 6515', 'Шпон дуба LTL 6515'),
  ('Шпон Дуба LTL 6908', 'Шпон дуба LTL 6908'),
  ('Шпон Дуба LTL 6112', 'Шпон дуба LTL 6112'),
  ('Шпон Дуба LTL 6907', 'Шпон дуба LTL 6907');

do $$
begin
  if exists (
    select 1
    from public.product_options old_option
    join public.products product on product.slug = old_option.product_slug
    join rodos_color_translations translation on translation.source_label = old_option.label
    join public.product_options new_option
      on new_option.product_slug = old_option.product_slug
     and new_option.option_group = old_option.option_group
     and new_option.label = translation.target_label
    where product.brand = 'Rodos'
      and old_option.option_group = 'color'
      and old_option.label <> translation.target_label
  ) then
    raise exception 'Є дублікати майбутніх назв декорів. Нічого не змінено.';
  end if;
end $$;

update public.product_options option_row
set label = translation.target_label
from public.products product,
     rodos_color_translations translation
where product.slug = option_row.product_slug
  and product.brand = 'Rodos'
  and option_row.option_group = 'color'
  and translation.source_label = option_row.label
  and option_row.label <> translation.target_label;

update public.product_variants variant_row
set selections = jsonb_set(
  variant_row.selections,
  '{color}',
  to_jsonb(translation.target_label)
)
from public.products product,
     rodos_color_translations translation
where product.slug = variant_row.product_slug
  and product.brand = 'Rodos'
  and variant_row.selections ? 'color'
  and translation.source_label = variant_row.selections ->> 'color'
  and variant_row.selections ->> 'color' <> translation.target_label;

commit;

select count(*) as перекладених_назв_декорів
from public.product_options option_row
join public.products product on product.slug = option_row.product_slug
where product.brand = 'Rodos'
  and option_row.option_group = 'color'
  and option_row.label in (
    'Палісандр', 'Горіх', 'Білий дуб',
    'Шпон дуба LTL 6403', 'Шпон дуба LTL 6515',
    'Шпон дуба LTL 6908', 'Шпон дуба LTL 6112', 'Шпон дуба LTL 6907'
  );
