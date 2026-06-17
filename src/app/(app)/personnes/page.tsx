import { createClient } from "@/lib/supabase/client";
import Link from "next/link";
import { Suspense } from "react";
import { FilterBar } from "@/components/filter-bar";
import { PersonnesRows } from "./personnes-table";
import type { Personne } from "@/types/database";

type SP = { [key: string]: string | string[] | undefined };
function str(sp: SP, key: string, fallback = ""): string {
  const v = sp[key];
  return typeof v === "string" ? v : fallback;
}

function sortHref(sp: SP, key: string): string {
  const cur = str(sp, "sort", "nom");
  const dir = cur === key && str(sp, "dir", "asc") === "asc" ? "desc" : "asc";
  const p = new URLSearchParams();
  for (const [k, v] of Object.entries(sp)) {
    if (typeof v === "string" && v) p.set(k, v);
  }
  p.set("sort", key);
  p.set("dir", dir);
  return `?${p.toString()}`;
}

function SortIndicator({ sp, col }: { sp: SP; col: string }) {
  if (str(sp, "sort", "nom") !== col) return null;
  return <span className="ml-1">{str(sp, "dir", "asc") === "asc" ? "↑" : "↓"}</span>;
}

export default async function PersonnesPage({
  searchParams,
}: {
  searchParams: Promise<SP>;
}) {
  const sp   = await searchParams;
  const q    = str(sp, "q");
  const sort = str(sp, "sort", "nom");
  const dir  = str(sp, "dir", "asc") as "asc" | "desc";

  const db = createClient();

  let query = db.from("personnes").select("*");

  if (q) {
    query = query.or(`nom.ilike.%${q}%,prenom.ilike.%${q}%`);
  }

  const validSorts = ["nom", "prenom"];
  const sortCol = validSorts.includes(sort) ? sort : "nom";
  query = query.order(sortCol, { ascending: dir === "asc" });
  if (sortCol === "nom")    query = query.order("prenom", { ascending: true });
  if (sortCol === "prenom") query = query.order("nom",    { ascending: true });

  const { data, error } = await query;
  if (error) return <p className="text-red">Erreur : {error.message}</p>;

  const personnes = (data ?? []) as Personne[];

  return (
    <div>
      <h1 className="text-2xl font-semibold mb-4">
        Personnes
        <span className="ml-3 text-base font-normal text-muted">
          {personnes.length} résultat{personnes.length > 1 ? "s" : ""}
        </span>
      </h1>

      <Suspense>
        <FilterBar
          filters={[
            { key: "q", type: "text", label: "Rechercher", placeholder: "Nom ou prénom…" },
          ]}
        />
      </Suspense>

      <table className="w-full text-sm border-collapse">
        <thead>
          <tr className="border-b border-border text-left text-muted">
            <th className="pb-3 pr-8 font-medium">
              <Link href={sortHref(sp, "nom")} className="hover:text-ink inline-flex items-center">
                Nom <SortIndicator sp={sp} col="nom" />
              </Link>
            </th>
            <th className="pb-3 pr-8 font-medium">
              <Link href={sortHref(sp, "prenom")} className="hover:text-ink inline-flex items-center">
                Prénom <SortIndicator sp={sp} col="prenom" />
              </Link>
            </th>
            <th className="pb-3 pr-8 font-medium text-muted font-normal">Honorifique</th>
            <th className="pb-3" />
          </tr>
        </thead>
        <PersonnesRows personnes={personnes} />
      </table>
    </div>
  );
}
