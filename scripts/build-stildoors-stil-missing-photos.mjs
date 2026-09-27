import { mkdirSync, writeFileSync } from 'node:fs';

const base = 'https://stildoors.com.ua';
const headers = { 'user-agent': 'Mozilla/5.0 (compatible; NashiDveriCatalogAudit/1.0)' };
const targets = {
  florida: ['італійський горіх', 'вільха класична', 'горіх золотий', 'світлий бетон', 'трюфель'],
  london: ['кремове дерево', 'вільха класична', 'горіх золотий', 'сандал', 'світлий бетон', 'трюфель'],
  mexico: ['каштан New', 'кремове дерево', 'вільха класична', 'трюфель'],
  slovenia: ['італійський горіх', 'каштан New', 'горіх золотий'],
  tanzania: ['дрім вуд', 'дуб сріблястий', 'італійський горіх', 'каштан New', 'вільха класична', 'горіх золотий', 'трюфель'],
};
const slugs = {
  'італійський горіх': 'italiyskiy-gorih', 'вільха класична': 'vilha-klasichna', 'горіх золотий': 'gorih-zolotiy',
  'світлий бетон': 'svitliy-beton', 'трюфель': 'tryufel', 'кремове дерево': 'kremove-derevo', 'сандал': 'sandal',
  'каштан New': 'kashtan-new', 'дрім вуд': 'drim-vud', 'дуб сріблястий': 'dub-sriblyastiy',
};
const glasses = [['чорне', 'sklo-chorne'], ['біле', 'sklo-satin']];
const quote = (value) => `'${String(value ?? '').replaceAll("'", "''")}'`;
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const found = [];
for (const [model, colors] of Object.entries(targets)) {
  for (const color of colors) {
    for (const [glass, glassSlug] of glasses) {
      const sourceUrl = `${base}/dveri/stil/${model}/${slugs[color]}/${glassSlug}/`;
      const response = await fetch(sourceUrl, { headers });
      const html = await response.text();
      const image = html.match(/<meta\s+property=['"]og:image['"]\s+content=['"]([^'"]+)['"]/i)?.[1];
      if (response.ok && image) found.push({ productSlug: `stildoors-stil-${model}-official`, color, glass, image: new URL(image, base).href });
      await sleep(180);
    }
  }
}
const unique = [...new Map(found.map((item) => [`${item.productSlug}:${item.color}:${item.glass}`, item])).values()];
const colorOptions = [...new Map(unique.map((item) => [`${item.productSlug}:${item.color}`, item])).values()];
const optionRows = colorOptions.map((item) => [item.productSlug, 'color', 'Колір полотна', item.color, null, item.image, 90, true]);
const variantRows = unique.map((item, index) => [item.productSlug, item.color, item.glass, item.image, 200 + index, true]);
const sql = ['-- StilDoors Stil: точні фото пропущених декорів з офіційних карток.', 'begin;', 'insert into public.product_options (product_slug,option_group,group_label,label,swatch,image_path,sort_order,is_active) values', optionRows.map((row) => `(${row.map((value) => value === null ? 'null' : quote(value)).join(', ')})`).join(',\n') + '\non conflict (product_slug,option_group,label) do update set image_path=excluded.image_path,is_active=true;', 'insert into public.product_variants (product_slug,selections,image_path,sort_order,is_active) values', variantRows.map(([productSlug,color,glass,image,sortOrder,isActive]) => `(${quote(productSlug)}, '{"color":"${color}","glass":"${glass}"}'::jsonb, ${quote(image)}, ${quote(sortOrder)}, ${quote(isActive)})`).join(',\n') + '\non conflict (product_slug,selections) do update set image_path=excluded.image_path,sort_order=excluded.sort_order,is_active=true;', 'commit;', "select count(*) as додано_точних_фото from public.product_variants where product_slug in ('stildoors-stil-florida-official','stildoors-stil-london-official','stildoors-stil-mexico-official','stildoors-stil-slovenia-official','stildoors-stil-tanzania-official') and is_active;"].join('\n');
mkdirSync('supabase/generated', { recursive: true });
writeFileSync('supabase/generated/stildoors-stil-missing-decor-photos.sql', `${sql}\n`);
writeFileSync('supabase/generated/stildoors-stil-missing-decor-photos.json', `${JSON.stringify({ found: unique, count: unique.length }, null, 2)}\n`);
console.log(`Створено supabase/generated/stildoors-stil-missing-decor-photos.sql: ${unique.length} точних фото.`);
