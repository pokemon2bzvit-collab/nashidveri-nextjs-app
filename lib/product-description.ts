type ProductDescriptionInput = { name: string; brand: string; collection: string; category: string };
type DescriptionSpec = { label?: string; value?: string };
type DescriptionOption = { option_group?: string; group_label?: string; group?: string; groupLabel?: string; label?: string; is_active?: boolean };

const clean = (value: string) => value.replace(/\s+/g, " ").trim();
const lowerFirst = (value: string) => value ? value[0].toLocaleLowerCase("uk") + value.slice(1) : value;
const valueFor = (specs: DescriptionSpec[], pattern: RegExp) => specs.find((spec) => pattern.test(spec.label || ""))?.value?.trim();

export function createProductDescription(product: ProductDescriptionInput, specs: DescriptionSpec[], options: DescriptionOption[]) {
  const purpose = valueFor(specs, /призначенн|тип виробу/i);
  const covering = valueFor(specs, /покрит|оздоблен/i);
  const thickness = valueFor(specs, /товщина.*полот/i);
  const dimensions = valueFor(specs, /^(розмір|розміри|розміри полотна|ширина полотна)$/i);
  const construction = valueFor(specs, /конструкц|наповнен/i);
  const coveringProperties = valueFor(specs, /властивост.*покрит|стійк.*покрит|зносостійк|вологостійк/i);
  const insulation = valueFor(specs, /теплоізоляц|утеплен/i);
  const metal = valueFor(specs, /товщина.*метал|товщина.*стал/i);
  const interior = product.category === "interior";
  const base = interior ? "міжкімнатні двері" : product.category === "entrance" ? "вхідні двері" : "виріб для вашого простору";
  const intro = purpose ? `${product.name} — ${base.toLowerCase()} ${purpose.toLocaleLowerCase("uk")}.` : `${product.name} — ${base.toLowerCase()} фабрики ${product.brand} з колекції «${product.collection}».`;
  const facts = [
    covering && `покриття ${covering}`,
    thickness && `полотно ${thickness}`,
    dimensions && `розміри ${dimensions}`,
    construction && construction.toLocaleLowerCase("uk"),
    !interior && metal && `сталь ${metal}`,
    !interior && insulation && `теплоізоляція ${insulation}`,
  ].filter(Boolean) as string[];
  const activeOptions = options.filter((option) => option.is_active !== false && option.label?.trim());
  const groups = new Map<string, string[]>();
  activeOptions.forEach((option) => {
    const group = option.group_label || option.groupLabel || option.option_group || option.group || "Варіанти";
    groups.set(group, [...(groups.get(group) || []), option.label!.trim()]);
  });
  const optionText = [...groups.entries()].map(([group, values]) => `${group.toLocaleLowerCase("uk")}: ${values.slice(0, 4).join(", ")}${values.length > 4 ? ` та ще ${values.length - 4}` : ""}`).join("; ");
  const factSentence = facts.length ? `Модель має ${facts.join(", ")}.` : "Модель доступна у заводських виконаннях, а комплектацію допоможе підібрати менеджер.";
  const durabilitySentence = coveringProperties ? ` Покриття ${lowerFirst(coveringProperties)} — це допомагає дверям зберігати охайний вигляд у щоденному користуванні.` : " Стійке до пошкоджень покриття допомагає дверям зберігати привабливий вигляд у щоденному користуванні.";
  const ending = optionText ? ` Доступні варіанти: ${optionText}.` : " Доступні заводські варіанти комплектації; актуальну ціну уточнюйте у менеджера.";
  return clean(`${intro} ${factSentence}${durabilitySentence}${ending}`);
}

export function shouldUseGeneratedDescription(description: string | null | undefined, specs: DescriptionSpec[], options: DescriptionOption[]) {
  const text = clean(description || "");
  if (!text) return Boolean(specs.length || options.length);
  return text.length < 115 || /характеристики та актуальну ціну уточнюйте|доступні заводські виконання; актуальну комплектацію/i.test(text);
}
