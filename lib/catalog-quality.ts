export type QualityProduct = { slug: string; name: string; brand: string; category: string; collection: string; image_path: string | null; description: string | null; is_available: boolean };
export type QualityRow = { product_slug: string; label?: string; value?: string; option_group?: string; image_path?: string; source_url?: string; selections?: Record<string, string>; is_active?: boolean };
export type QualityIssue = { kind: string; text: string; tab: "basic" | "configuration" | "sources" };

export function auditProduct(product: QualityProduct, rows: { specs: QualityRow[]; options: QualityRow[]; variants: QualityRow[]; sources: QualityRow[] }): QualityIssue[] {
  const issues: QualityIssue[] = [];
  const add = (kind: string, text: string, tab: QualityIssue["tab"]) => issues.push({ kind, text, tab });
  if (!product.image_path?.trim()) add("photo", "Додати головне фото", "basic");
  const description = product.description?.trim() || "";
  if (!description) add("description", "Додати опис моделі", "basic");
  else if (description.length < 100 || /детальні характеристики.*уточнюйте|характеристики та актуальну ціну уточнюйте/i.test(description)) add("description", "Переглянути короткий або шаблонний опис", "basic");
  if (!rows.sources.some(row => /^https?:\/\//i.test(row.source_url || ""))) add("source", "Додати посилання на картку виробника", "sources");
  const specs = rows.specs.filter(row => row.is_active !== false && row.value?.trim() && !/^(уточнюється|немає даних|—|-)$/i.test(row.value.trim()));
  const has = (pattern: RegExp) => specs.some(row => pattern.test(row.label || "") && /\d/.test(row.value || ""));
  if (!has(/розмір|габарит/i) && !(has(/ширина/i) && has(/висота/i))) add("dimensions", "Додати розміри або ширину й висоту", "configuration");
  const required = product.category === "entrance"
    ? [[/товщина.*полот/i, "товщину полотна"], [/товщина.*метал|товщина.*стал/i, "товщину металу"], [/замок|замки/i, "замки"], [/утеп|теплоізоляц|наповнен/i, "утеплення"], [/ущіль|контур/i, "ущільнення"]] as const
    : product.category === "interior" ? [[/товщина.*полот/i, "товщину полотна"], [/покрит|оздоблен/i, "покриття"], [/погонаж|короб/i, "погонаж або коробку"]] as const : [];
  const missing = required.filter(([pattern]) => !specs.some(row => pattern.test(row.label || ""))).map(([, title]) => title);
  if (missing.length) add("specs", `Доповнити: ${missing.join(", ")}`, "configuration");
  const options = rows.options.filter(row => row.is_active !== false);
  const variants = rows.variants.filter(row => row.is_active !== false && row.image_path?.trim() && Object.keys(row.selections || {}).length);
  if (!options.length && product.category !== "windows") add("decor", "Уточнити доступні декори й варіанти", "configuration");
  const uncovered = options.filter(option => !variants.some(variant => variant.selections?.[option.option_group || ""] === option.label));
  if (uncovered.length) add("decor", `Без прив’язаного фото: ${uncovered.map(row => row.label).join(", ")}`, "configuration");
  const incomplete = variants.filter(variant => options.some(option => !variant.selections?.[option.option_group || ""]));
  if (incomplete.length) add("decor", `У ${incomplete.length} фото не зазначено всі параметри: перевірити колір, скло й виконання`, "configuration");
  return issues;
}
