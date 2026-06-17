import { createClient } from "@/lib/supabase/client";
import Link from "next/link";
import { Suspense } from "react";
import { FilterBar } from "@/components/filter-bar";
import type { InstitutionIRC, GroupeGPS } from "@/types/database";

type IRCJoined = InstitutionIRC & { groupes_gps: Pick<GroupeGPS, "nom"> | null };

const CAT_LABEL: Record<InstitutionIRC["categorie"], string> = {
  interprofessionnelle: "Interpro.",
  professionnelle:      "Pro.",
  dom:                  "DOM",
};

const CAT_OPTIONS = [
  { value: "interprofessionnelle", label: "Interprofessionnelle" },
  { value: "professionnelle",      label: "Professionnelle" },
  { value: "dom",                  label: "DOM" },
];

type SP = { [key: string]: string | string[] | undefined };
function str(sp: SP, key: string, fallback = ""): string {
  const v = sp[key];
  return typeof v === "string" ? v : fallback;
}

function sortHref(sp: SP, key: string): string {
  const cur = str(sp, "sort", "categorie");
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
  if (str(sp, "sort", "categorie") !== col) return null;
  return <span className="ml-1">{str(sp, "dir", "asc") === "asc" ? "↑" : "↓"}</span>;
}

export default async function IRCPage({
  searchParams,
}: {
  searchParams: Promise<SP>;
}) {
  const sp        = await searchParams;
  const q         = str(sp, "q");
  const categorie = str(sp, "categorie");
  const gpsId     = str(sp, "gps");
  const sort      = str(sp, "sort", "categorie");
  const dir       = str(sp, "dir", "asc") as "asc" | "desc";

  const db = createClient();

  // GPS pour le filtre — toujours toute la liste
  const { data: gpsAll } = await db
    .from("groupes_gps")
    .select("id, nom")
    .order("nom");

  const gpsOptions = ((gpsAll ?? []) as Pick<GroupeGPS, "id" | "nom">[]).map((g) => ({
    value: g.id,
    label: g.nom,
  }));

  let query = db.from("institutions_irc").select("*, groupes_gps(nom)");

  if (q)         query = query.ilike("nom", `%${q}%`);
  if (categorie) query = query.eq("categorie", categorie);
  if (gpsId)     query = query.eq("gps_id", gpsId);

  const validSorts = ["nom", "code_csn", "categorie", "date_renouvellement"];
  const sortCol = validSorts.includes(sort) ? sort : "categorie";
  query = query.order(sortCol, { ascending: dir === "asc" });
  if (sortCol !== "nom") query = query.order("nom", { ascending: true });

  const { data, error } = await query;
  if (error) return <p className="text-red">Erreur : {error.message}</p>;

  const ircs = (data ?? []) as IRCJoined[];

  return (
    <div>
      <h1 className="text-2xl font-semibold mb-4">
        Institutions de retraite complémentaire
        <span className="ml-3 text-base font-normal text-muted">{ircs.length} résultat{ircs.length > 1 ? "s" : ""}</span>
      </h1>

      <Suspense>
        <FilterBar
          filters={[
            { key: "q",         type: "text",   label: "Rechercher", placeholder: "Nom de l'institution…" },
            { key: "categorie", type: "select", label: "Catégorie",  options: CAT_OPTIONS },
            { key: "gps",       type: "select", label: "Groupe GPS", options: gpsOptions },
          ]}
        />
      </Suspense>

      <table className="w-full text-sm border-collapse">
        <thead>
          <tr className="border-b border-border text-left text-muted">
            <th className="pb-3 pr-4 font-medium">
              <Link href={sortHref(sp, "nom")} className="hover:text-ink inline-flex items-center">
                Institution <SortIndicator sp={sp} col="nom" />
              </Link>
            </th>
            <th className="pb-3 pr-4 font-medium">
              <Link href={sortHref(sp, "code_csn")} className="hover:text-ink inline-flex items-center">
                CSN <SortIndicator sp={sp} col="code_csn" />
              </Link>
            </th>
            <th className="pb-3 pr-4 font-medium">
              <Link href={sortHref(sp, "categorie")} className="hover:text-ink inline-flex items-center">
                Cat. <SortIndicator sp={sp} col="categorie" />
              </Link>
            </th>
            <th className="pb-3 pr-4 font-medium">Groupe GPS</th>
            <th className="pb-3 pr-4 font-medium">Directeur général</th>
            <th className="pb-3 font-medium">
              <Link href={sortHref(sp, "date_renouvellement")} className="hover:text-ink inline-flex items-center">
                Renouvellement <SortIndicator sp={sp} col="date_renouvellement" />
              </Link>
            </th>
          </tr>
        </thead>
        <tbody>
          {ircs.length === 0 ? (
            <tr>
              <td colSpan={6} className="py-8 text-center text-muted">
                Aucune institution ne correspond aux critères.
              </td>
            </tr>
          ) : (
            ircs.map((irc) => (
              <tr key={irc.id} className="border-b border-border hover:bg-blue-bg/40 transition-colors">
                <td className="py-3 pr-4 font-medium">
                  <Link href={`/irc/${irc.id}`} className="text-blue hover:underline">
                    {irc.nom}
                  </Link>
                </td>
                <td className="py-3 pr-4 font-mono text-muted">{irc.code_csn}</td>
                <td className="py-3 pr-4">
                  <span
                    className={`rounded-full px-2 py-0.5 text-xs ${
                      irc.categorie === "dom" ? "bg-red-bg text-red" : "bg-blue-bg text-blue"
                    }`}
                  >
                    {CAT_LABEL[irc.categorie]}
                  </span>
                </td>
                <td className="py-3 pr-4 text-muted">{irc.groupes_gps?.nom ?? "—"}</td>
                <td className="py-3 pr-4 text-muted">{irc.directeur_general ?? "—"}</td>
                <td className="py-3 text-muted">
                  {irc.date_renouvellement
                    ? new Date(irc.date_renouvellement).toLocaleDateString("fr-FR", {
                        year: "numeric",
                        month: "short",
                      })
                    : "—"}
                </td>
              </tr>
            ))
          )}
        </tbody>
      </table>
    </div>
  );
}
