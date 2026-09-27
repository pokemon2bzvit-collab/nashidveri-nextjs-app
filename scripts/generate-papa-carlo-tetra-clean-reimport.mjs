import { writeFileSync } from "node:fs";

const base = "https://papa-karlo.com.ua/content/images";
const commonColors = "альпійський білий, чорний матовий, сірий матовий";
const extendedColors = "білий матовий, ясен білий, дуб сірий, дуб кремовий, світло-сірий супермат, темно-сірий супермат";
const standard = { width: "410, 610, 710, 810 або 910 мм", height: "2000 мм", thickness: "38 мм", warranty: "2 роки", colors: commonColors };
const premium = { width: "610, 710, 810 або 910 мм", height: "2000 мм, можливий нестандартний розмір під замовлення", thickness: "40 мм", warranty: "5 років", colors: extendedColors };

const models = [
  ["catalog-132", "Papa Carlo T-00F", "25", "788x1800l80mc0", ["67949689341525", "77251967197463", "44088570079391"], premium],
  ["catalog-133", "Papa Carlo T-01", "23", "910x1155l80mc0", ["29371029225377", "15670833954048", "86234545310315"], standard, "t-01"],
  ["catalog-134", "Papa Carlo T-02", "24", "910x1155l80mc0", ["45452544731725", "51678145823205", "13608690299432"], standard, "t-02"],
  ["catalog-135", "Papa Carlo T-03", "25", "910x1155l80mc0", ["97050018138804", "43410764024695", "73079724059600"], { ...standard, width: "610, 710, 810 або 910 мм" }, "t-03"],
  ["catalog-119", "Papa Carlo T-04", "26", "420x940l80mc0", ["71576862243128", "67375658468979", "63250864422268"], standard],
  ["catalog-120", "Papa Carlo T-05", "46", "420x940l80mc0", ["90503585289184", "84570751530500", "41393714083043", "95460088911276", "16498284706360", "82362693202941"], standard],
  ["catalog-121", "Papa Carlo T-06", "48", "420x940l80mc0", ["97031399252530", "80544153644817", "31200408896146", "36548231422615", "58156515576842", "94095361393837"], standard],
  ["catalog-122", "Papa Carlo T-07", "50", "420x940l80mc0", ["49801207122817", "16275977082703", "39270774176468", "92939381478863", "71151072094071", "43096971383976"], standard],
  ["catalog-123", "Papa Carlo T-08", "2", "420x940l80mc0", ["44988877821209", "64286808482589", "41409850277955", "41514629820278", "75336298788379", "62776799723939"], standard],
  ["catalog-124", "Papa Carlo T-09", "4", "420x940l80mc0", ["83058754830842", "31774302579967", "34835495730766", "84387322686459", "71151002729258", "45627810483510"], standard],
  ["catalog-125", "Papa Carlo T-10", "6", "420x940l80mc0", ["36351465382345", "29616089933565", "91860650622805", "66911126700487", "44625447772088", "86673892380461"], standard],
  ["papa-carlo-t-11-official", "Papa Carlo T-11", "8", "420x940l80mc0", ["43309209179332", "27814162974724", "30576370987736", "67285372583415", "55432376583662", "28981380215974"], standard, "t-11"],
  ["catalog-136", "Papa Carlo T-12", "10", "420x940l80mc0", ["24965531693608", "48418492936138", "47500573945755", "12073841137122", "44899613876216", "58514861557262"], standard],
  ["catalog-127", "Papa Carlo T-13", "11", "420x940l80mc0", ["70146549020937", "34321362457780", "84690616896943", "66874805474632", "91538199022546", "33026771404647"], standard],
  ["catalog-128", "Papa Carlo T-14", "12", "420x940l80mc0", ["39713287838308", "72771456812852", "37703362364113", "95961136292117", "48537525464292", "36131778377974"], standard],
  ["catalog-129", "Papa Carlo T-15", "13", "420x940l80mc0", ["75734129998513", "69892578648446", "11143593701866", "64766394713459", "63556675514226", "45943823804922"], standard],
  ["catalog-130", "Papa Carlo T-16", "14", "420x940l80mc0", ["66576973833016", "85922697933870", "30124172371604", "93067139870930", "22954820049411", "78118652014272", "72851577081623", "90515201762756", "36519233090586", "78834693935601", "15655016952181", "91603156519962"], standard],
  ["catalog-131", "Papa Carlo T-17", "15", "420x940l80mc0", ["21820001148819", "66118631578171", "21270371368340", "35137438932287", "87544621459193", "51895318401356", "42821360304574", "61603892462551", "71562573382787", "42758564380394", "30863241644325", "58970593530808"], standard],
  ["papa-carlo-t-18-official", "Papa Carlo T-18", "26", "357x800l80mc0", ["91405346675505", "51903127881758", "98807295139875", "90191556262385"], { ...premium, height: "2000 мм, можливий нестандартний розмір під замовлення" }],
  ["catalog-137", "Papa Carlo T-18 BLK", "27", "357x800l80mc0", ["67442326045484", "20646996541749", "91382704145038", "42149124131260"], { ...premium, height: "2000 мм, можливий нестандартний розмір під замовлення" }],
];

const satinT11 = ["16534560199224", "59247760411503", "86310800606617", "74937320710308", "89918501200100", "48463541199636"];
const apostrophe = value => `'${String(value).replaceAll("'", "''")}'`;
const modelFileName = model => model[1].replace("Papa Carlo ", "").toLowerCase().replaceAll(" ", "-");
const image = (model, id) => `${base}/${model[2]}/${model[3]}/mizhkimnatni-dveri-papa-karlo-${modelFileName(model)}-${id}.webp`;
const t11Satin = id => `${base}/9/910x1155l80mc0/mizhkimnatni-dveri-papa-karlo-t-111908-${id}.webp`;
const description = name => `${name} — міжкімнатні двері колекції Tetra з поліпропіленовим покриттям Renolit (Німеччина). Стійке до пошкоджень покриття допомагає зберігати охайний вигляд у щоденному користуванні. Доступні декори та комплектацію уточнюйте у менеджера.`;
const specs = model => {
  const data = model[5];
  return [
    ["Розміри полотна", `ширина: ${data.width}; висота: ${data.height}`],
    ["Товщина полотна", data.thickness],
    ["Матеріал покриття", "Поліпропіленова плівка Renolit (Німеччина)"],
    ["Наповнення", "Фільонка МДФ 8 мм"],
    ["Погонаж", "Телескопічний, компланарний або алюмінієвий короб"],
    ["Стиль", "Лофт, модерн, сучасний, хай-тек"],
    ["Шумоізоляція", "Середня"],
    ["Декори", data.colors],
    ["Гарантія виробника", data.warranty],
  ];
};

const productRows = models.map((m, order) => `  (${[m[0], "interior", "Papa Carlo", "Tetra", m[1], "Поліпропіленова плівка Renolit (Німеччина)", "Сучасний", m[5].colors, "Ціна за запитом", description(m[1]), JSON.stringify(["Фабрика Papa Carlo", "Колекція Tetra"]), image(m, m[4][0]), order * 10, true].map((v, i) => i === 10 ? `${apostrophe(v)}::jsonb` : apostrophe(v)).join(", ")})`).join(",\n");

const mediaRows = models.flatMap(m => {
  const images = m[4].map(id => image(m, id));
  if (m[6] === "t-11") return [
    `  (${apostrophe(m[0])}, 'main', 'Головне фото', ${apostrophe(images[0])}, 0)`,
    ...images.map((url, i) => `  (${apostrophe(m[0])}, 'gallery', ${apostrophe(`glass:Темне скло:Фото ${i + 1}`)}, ${apostrophe(url)}, ${(i + 1) * 10})`),
    ...satinT11.map((id, i) => `  (${apostrophe(m[0])}, 'gallery', ${apostrophe(`glass:Сатин:Фото ${i + 1}`)}, ${apostrophe(t11Satin(id))}, ${(i + 7) * 10})`),
  ];
  return images.map((url, i) => `  (${apostrophe(m[0])}, ${i === 0 ? "'main'" : "'gallery'"}, ${apostrophe(i === 0 ? "Головне фото" : `Фото ${i + 1}`)}, ${apostrophe(url)}, ${i * 10})`);
}).join(",\n");

const optionConfig = [
  ["catalog-133", "Сатин / чорне скло", image(models[1], models[1][4][0]), 10], ["catalog-133", "Чорне скло", image(models[1], models[1][4][2]), 20],
  ["catalog-134", "Сатин / чорне скло", image(models[2], models[2][4][0]), 10], ["catalog-134", "Сатин", image(models[2], models[2][4][2]), 20],
  ["catalog-135", "Сатин / чорне скло", image(models[3], models[3][4][0]), 10], ["catalog-135", "Чорне скло", image(models[3], models[3][4][2]), 20],
  ["papa-carlo-t-11-official", "Темне скло", image(models[11], models[11][4][0]), 10], ["papa-carlo-t-11-official", "Сатин", t11Satin(satinT11[0]), 20],
];
const optionRows = optionConfig.map(([slug, label, path, order]) => `  (${apostrophe(slug)}, 'glass', 'Варіант скла', ${apostrophe(label)}, null, ${apostrophe(path)}, ${order})`).join(",\n");
const variantRows = optionConfig.map(([slug, label, path, order]) => `  (${apostrophe(slug)}, jsonb_build_object('glass', ${apostrophe(label)}), ${apostrophe(path)}, ${order})`).join(",\n");
const specRows = models.flatMap(m => specs(m).map(([label, value], index) => `  (${apostrophe(m[0])}, ${apostrophe(label)}, ${apostrophe(value)}, ${(index + 1) * 10})`)).join(",\n");
const sourceRows = models.map(m => `  (${apostrophe(m[0])}, 'Papa Carlo', ${apostrophe(`https://papa-karlo.com.ua/mizhkimnatni-dveri-papa-karlo-${modelFileName(m)}/`)}, ${apostrophe(m[1])}, 'verified', now(), 'Офіційна картка Papa Carlo; каталог Tetra звірено 15.09.2026.')`).join(",\n");

const sql = `-- Papa Carlo Tetra: чисте переімпортування з офіційного каталогу.
-- Перевірено 15.09.2026: https://papa-karlo.com.ua/tetra/
-- ВАЖЛИВО: цей файл замінює всі попередні точкові SQL для Tetra. Старі файли після нього не запускати.
-- Зберігаються стабільні slug активних моделей, тому звичні посилання не зламаються.

begin;

create table if not exists public.catalog_backup_papa_carlo_tetra_20260915 (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  snapshot jsonb not null
);

insert into public.catalog_backup_papa_carlo_tetra_20260915 (snapshot)
select jsonb_build_object(
  'products', coalesce((select jsonb_agg(to_jsonb(p)) from public.products p where p.brand = 'Papa Carlo' and p.collection = 'Tetra'), '[]'::jsonb),
  'media', coalesce((select jsonb_agg(to_jsonb(m)) from public.product_media m join public.products p on p.slug = m.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Tetra'), '[]'::jsonb),
  'options', coalesce((select jsonb_agg(to_jsonb(o)) from public.product_options o join public.products p on p.slug = o.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Tetra'), '[]'::jsonb),
  'variants', coalesce((select jsonb_agg(to_jsonb(v)) from public.product_variants v join public.products p on p.slug = v.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Tetra'), '[]'::jsonb),
  'specs', coalesce((select jsonb_agg(to_jsonb(s)) from public.product_specs s join public.products p on p.slug = s.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Tetra'), '[]'::jsonb)
)
where not exists (select 1 from public.catalog_backup_papa_carlo_tetra_20260915);

delete from public.products where brand = 'Papa Carlo' and collection = 'Tetra';

insert into public.products (slug, category, brand, collection, name, material, style, color, price, description, features, image_path, sort_order, is_available) values
${productRows};

insert into public.product_media (product_slug, kind, label, image_path, sort_order) values
${mediaRows};

insert into public.product_specs (product_slug, label, value, sort_order) values
${specRows};

insert into public.product_options (product_slug, option_group, group_label, label, swatch, image_path, sort_order) values
${optionRows};

insert into public.product_variants (product_slug, selections, image_path, sort_order) values
${variantRows};

insert into public.product_sources (product_slug, source_name, source_url, source_product_name, verification_status, verified_at, notes) values
${sourceRows};

commit;

-- Має повернути: 20 моделей, 20 опубліковано, 120 фото, 8 опцій і 8 варіантів.
select
  (select count(*) from public.products where brand = 'Papa Carlo' and collection = 'Tetra') as моделей,
  (select count(*) from public.products where brand = 'Papa Carlo' and collection = 'Tetra' and is_available = true) as опубліковано,
  (select count(*) from public.product_media m join public.products p on p.slug = m.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Tetra') as фото_у_галереях,
  (select count(distinct m.product_slug) from public.product_media m join public.products p on p.slug = m.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Tetra') as моделей_з_фото,
  (select count(*) from public.product_options o join public.products p on p.slug = o.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Tetra') as опцій_конфігуратора,
  (select count(*) from public.product_variants v join public.products p on p.slug = v.product_slug where p.brand = 'Papa Carlo' and p.collection = 'Tetra') as варіантів_конфігуратора;
`;

writeFileSync("supabase/papa-carlo-tetra-clean-reimport.sql", sql, "utf8");
