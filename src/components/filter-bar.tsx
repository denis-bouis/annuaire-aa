"use client";

import { useRouter, usePathname, useSearchParams } from "next/navigation";
import { useState, useRef, useEffect, useTransition } from "react";

export type FilterDef =
  | { key: string; label: string; type: "text"; placeholder?: string }
  | { key: string; label: string; type: "select"; options: { label: string; value: string }[] };

function SelectFilter({
  def,
  urlValue,
  onPush,
}: {
  def: Extract<FilterDef, { type: "select" }>;
  urlValue: string;
  onPush: (key: string, value: string) => void;
}) {
  return (
    <select
      value={urlValue}
      onChange={(e) => onPush(def.key, e.target.value)}
      className="border border-border rounded px-3 py-1.5 text-sm bg-surface focus:outline-none focus:ring-1 focus:ring-blue"
    >
      <option value="">Tous — {def.label}</option>
      {def.options.map((o) => (
        <option key={o.value} value={o.value}>
          {o.label}
        </option>
      ))}
    </select>
  );
}

function TextFilter({
  def,
  urlValue,
  onPush,
}: {
  def: Extract<FilterDef, { type: "text" }>;
  urlValue: string;
  onPush: (key: string, value: string) => void;
}) {
  const [value, setValue] = useState(urlValue);
  const timer = useRef<ReturnType<typeof setTimeout> | undefined>(undefined);

  useEffect(() => {
    setValue(urlValue);
  }, [urlValue]);

  return (
    <input
      type="text"
      placeholder={def.placeholder ?? def.label}
      value={value}
      onChange={(e) => {
        setValue(e.target.value);
        clearTimeout(timer.current);
        timer.current = setTimeout(() => onPush(def.key, e.target.value), 300);
      }}
      className="border border-border rounded px-3 py-1.5 text-sm bg-surface focus:outline-none focus:ring-1 focus:ring-blue w-56"
    />
  );
}

export function FilterBar({ filters }: { filters: FilterDef[] }) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const [, startTransition] = useTransition();

  function push(key: string, value: string) {
    const next = new URLSearchParams(searchParams.toString());
    if (value) next.set(key, value);
    else next.delete(key);
    startTransition(() => router.push(`${pathname}?${next.toString()}`, { scroll: false }));
  }

  return (
    <div className="flex flex-wrap gap-3 mb-6">
      {filters.map((f) =>
        f.type === "text" ? (
          <TextFilter
            key={f.key}
            def={f}
            urlValue={searchParams.get(f.key) ?? ""}
            onPush={push}
          />
        ) : (
          <SelectFilter
            key={f.key}
            def={f}
            urlValue={searchParams.get(f.key) ?? ""}
            onPush={push}
          />
        )
      )}
    </div>
  );
}
