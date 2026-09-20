-- Дозволяє зберігати прості опції Rodos Steel: серію комплектації й розмір блока.
-- Наявні опції кольору, покриття, скла, кромки та комплектації лишаються без змін.
begin;

alter table public.product_options
  drop constraint if exists product_options_option_group_check;

alter table public.product_options
  add constraint product_options_option_group_check
  check (option_group in ('color', 'finish', 'glass', 'edge', 'configuration', 'series', 'size'));

commit;
