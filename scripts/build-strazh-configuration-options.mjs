import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";

const batch = Number(process.argv.find((value) => value.startsWith("--batch="))?.split("=")[1] || "1");
const outputDir = join(process.cwd(), "supabase", "generated");
const imported = JSON.parse(await readFile(join(outputDir, `strazh-official-drafts-batch-${String(batch).padStart(2, "0")}.json`), "utf8"));
function sql(value = "") { return `'${String(value).replaceAll("'", "''")}'`; }
function hash(value) { let output = 2166136261; for (const character of value) output = Math.imul(output ^ character.charCodeAt(0), 16777619); return (output >>> 0).toString(36); }
function clean(value = "") { return value.replace(/<[^>]+>/gu, " ").replace(/&nbsp;/giu, " ").replace(/&amp;/giu, "&").replace(/\s+/gu, " ").trim(); }

function configurations(html) {
  const table = html.match(/<table[^>]*>[\s\S]*?<div class=["']collection-title["'][\s\S]*?<\/table>/iu)?.[0] || "";
  const headings = [...table.matchAll(/<th[^>]*>\s*<p[^>]*>([\s\S]*?)<\/p>/giu)]
    .map((match) => clean(match[1]))
    .filter((value) => value && value.length <= 80 && !/^колекція$/iu.test(value));
  return [...new Set(headings)];
}

const records = [];
for (let index = 0; index < imported.records.length; index += 1) {
  const item = imported.records[index];
  try {
    const response = await fetch(item.url, { headers: { "user-agent": "Mozilla/5.0 (compatible; NashidveriCatalog/1.0)" }, signal: AbortSignal.timeout(25_000) });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const options = configurations(await response.text());
    records.push({ ...item, options });
    console.log(`[${index + 1}/${imported.records.length}] ${item.name}: ${options.length} комплектацій`);
  } catch (error) { console.log(`[${index + 1}/${imported.records.length}] пропущено ${item.name}: ${error instanceof Error ? error.message : "помилка"}`); }
  await new Promise((resolve) => setTimeout(resolve, 350));
}

const lines = [`-- Страж: заводські комплектації, пакет ${batch}.`, "begin;"];
for (const record of records) {
  const slug = `strazh-official-${hash(record.url)}`;
  for (const [index, label] of record.options.entries()) {
    lines.push(`insert into public.product_options (product_slug,option_group,group_label,label,sort_order,is_active) values (${sql(slug)},'configuration','Комплектація виробника',${sql(label)},${index + 1},true) on conflict (product_slug,option_group,label) do update set group_label=excluded.group_label,sort_order=excluded.sort_order,is_active=true;`);
  }
}
lines.push("commit;", `-- Підсумок: ${records.reduce((sum, record) => sum + record.options.length, 0)} опцій для ${records.filter((record) => record.options.length).length} моделей.`);
await mkdir(outputDir, { recursive: true });
await writeFile(join(outputDir, `strazh-configuration-options-batch-${String(batch).padStart(2, "0")}.sql`), lines.join("\n"));
await writeFile(join(outputDir, `strazh-configuration-options-batch-${String(batch).padStart(2, "0")}.json`), JSON.stringify({ batch, records }, null, 2));
console.log(`Готово: ${records.reduce((sum, record) => sum + record.options.length, 0)} опцій.`);
