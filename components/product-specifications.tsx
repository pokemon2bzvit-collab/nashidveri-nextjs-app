import type { ProductSpec } from "@/lib/catalog";

export function ProductSpecifications({ specs }: { specs?: ProductSpec[] }) {
  if (!specs?.length) return null;

  return (
    <section className="mt-7 rounded-2xl border border-stone-200 bg-white p-5 shadow-sm">
      <h2 className="font-display text-2xl text-stone-900">Технічні характеристики</h2>
      <dl className="mt-5 grid gap-x-7 gap-y-4 sm:grid-cols-2">
        {specs.map((spec) => (
          <div key={`${spec.label}-${spec.value}`} className="border-b border-stone-100 pb-3">
            <dt className="text-xs font-bold uppercase tracking-[.12em] text-stone-400">{spec.label}</dt>
            <dd className="mt-1 text-sm font-medium leading-6 text-stone-800">{spec.value}</dd>
          </div>
        ))}
      </dl>
    </section>
  );
}
