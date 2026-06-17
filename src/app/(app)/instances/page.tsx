import { createClient } from "@/lib/supabase/client";
import Link from "next/link";
import { Suspense } from "react";
import { FilterBar } from "@/components/filter-bar";
import type { Instance, InstitutionIRC } from "@/types/database";

type InstanceJoined = Instance & {
  institutions_irc: Pick<InstitutionIRC, "nom" | "code_csn"> | null;
};

const TYPE_LABEL: Record<Instance["type"], string> = {
  federale:       "Fédérale",
  commune:        "Commune",
  operationnelle: "Opérationnelle",
  irc:            "IRC",
  gps:            "GPS",
};

const TYPE_OPTIONS = Object.entries(TYPE_LABEL).map(([value, label]) => ({ value, label }));

type SP = { [key: string]: string | string[] | undefined };
function str(sp: SP, key: string, fallback = ""): string {
  const v = sp[key];
  return typeof v === "string" ? v : fallback;
}

function sortHref(sp: SP, key: string): string {
  const cur = str(sp, "sort", "type");
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
  if (str(sp, "sort", "type") !== col) return null;
  return <span className="ml-1">{str(sp, "dir", "asc") === "asc" ? "↑" : "↓"}</span>;
}

type CollegeInfo = { name: string; role: string };
type PresMap = Map<string, { employeurs: CollegeInfo | null; salaries: CollegeInfo | null }>;

function CollegeBadge({ info }: { info: CollegeInfo | null }) {
  if (!info) return <span className="text-muted">—</span>;
  return (
    <span className="inline-flex flex-col gap-0.5">
      <span className="font-medium text-ink">{info.name}</span>
      <span className="text-xs text-muted">{info.role}</span>
    </span>
  );
}

export default async function InstancesPage({
  searchParams,
}: {
  searchParams: Promise<SP>;
}) {
  const sp   = await searchParams;
  const q    = str(sp, "q");
  const type = str(sp, "type");
  const sort = str(sp, "sort", "type");
  const dir  = str(sp, "dir", "asc") as "asc" | "desc";

  const db = createClient();

  let query = db
    .from("instances")
    .select("*, institutions_irc(nom, code_csn)");

  if (q)    query = query.ilike("nom", `%${q}%`);
  if (type) query = query.eq("type", type);

  const validSorts = ["nom", "type", "date_renouvellement"];
  const sortCol = validSorts.includes(sort) ? sort : "type";
  query = query.order(sortCol, { ascending: dir === "asc" });
  if (sortCol !== "nom") query = query.order("nom", { ascending: true });

  const [{ data, error }, { data: mandatsRaw }] = await Promise.all([
    query,
    db
      .from("mandats")
      .select("instance_id, college, fonction, personnes(nom, prenom)")
      .eq("annee_edition", 2025)
      .not("college", "is", null)
      .not("fonction", "is", null),
  ]);

  if (error) return <p className="text-red">Erreur : {error.message}</p>;

  type RawPres = {
    instance_id: string;
    college: string;
    fonction: string;
    personnes: { nom: string; prenom: string };
  };

  const presMap: PresMap = new Map();
  for (const raw of (mandatsRaw ?? []) as unknown as RawPres[]) {
    const fn = raw.fonction.toLowerCase();
    const isPresident = fn.includes("prés") && !fn.includes("vice");
    const isVP = fn.includes("vice");
    if (!isPresident && !isVP) continue;
    const entry = presMap.get(raw.instance_id) ?? { employeurs: null, salaries: null };
    const info: CollegeInfo = {
      name: `${raw.personnes.prenom} ${raw.personnes.nom}`,
      role: isPresident ? "Président(e)" : "Vice-président(e)",
    };
    if (raw.college === "employeurs") entry.employeurs = entry.employeurs ?? info;
    if (raw.college === "salaries")   entry.salaries   = entry.salaries   ?? info;
    presMap.set(raw.instance_id, entry);
  }

  const instances = (data ?? []) as unknown as InstanceJoined[];

  return (
    <div>
      <h1 className="text-2xl font-semibold mb-4">
        Instances de gouvernance
        <span className="ml-3 text-base font-normal text-muted">{instances.length} résultat{instances.length > 1 ? "s" : ""}</span>
      </h1>

      <Suspense>
        <FilterBar
          filters={[
            { key: "q",    type: "text",   label: "Rechercher", placeholder: "Nom de l'instance…" },
            { key: "type", type: "select", label: "Type", options: TYPE_OPTIONS },
          ]}
        />
      </Suspense>

      <table className="w-full text-sm border-collapse">
        <thead>
          <tr className="border-b border-border text-left text-muted">
            <th className="pb-3 pr-4 font-medium">
              <Link href={sortHref(sp, "nom")} className="hover:text-ink inline-flex items-center">
                Instance <SortIndicator sp={sp} col="nom" />
              </Link>
            </th>
            <th className="pb-3 pr-4 font-medium">
              <Link href={sortHref(sp, "type")} className="hover:text-ink inline-flex items-center">
                Type <SortIndicator sp={sp} col="type" />
              </Link>
            </th>
            <th className="pb-3 pr-4 font-medium">
              <span className="inline-flex items-center gap-1">
                <span className="rounded-full px-1.5 py-0.5 bg-blue-bg text-blue text-xs">E</span>
                Collège employeurs
              </span>
            </th>
            <th className="pb-3 pr-4 font-medium">
              <span className="inline-flex items-center gap-1">
                <span className="rounded-full px-1.5 py-0.5 bg-green-bg text-green text-xs">S</span>
                Collège salariés
              </span>
            </th>
            <th className="pb-3 font-medium">
              <Link href={sortHref(sp, "date_renouvellement")} className="hover:text-ink inline-flex items-center">
                Renouvellement <SortIndicator sp={sp} col="date_renouvellement" />
              </Link>
            </th>
          </tr>
        </thead>
        <tbody>
          {instances.length === 0 ? (
            <tr>
              <td colSpan={5} className="py-8 text-center text-muted">
                Aucune instance ne correspond aux critères.
              </td>
            </tr>
          ) : (
            instances.map((inst) => {
              const cols = presMap.get(inst.id);
              return (
                <tr key={inst.id} className="border-b border-border hover:bg-blue-bg/40 transition-colors">
                  <td className="py-3 pr-4">
                    <Link href={`/instances/${inst.id}`} className="text-blue hover:underline font-medium">
                      {inst.nom}
                    </Link>
                    {inst.nb_membres && (
                      <span className="ml-2 text-xs text-muted">({inst.nb_membres})</span>
                    )}
                    {inst.type === "irc" && inst.institutions_irc && (
                      <p className="text-xs text-muted mt-0.5">{inst.institutions_irc.nom}</p>
                    )}
                  </td>
                  <td className="py-3 pr-4">
                    <span className="rounded-full px-2 py-0.5 text-xs bg-blue-bg text-blue">
                      {TYPE_LABEL[inst.type]}
                    </span>
                  </td>
                  <td className="py-3 pr-4">
                    <CollegeBadge info={cols?.employeurs ?? null} />
                  </td>
                  <td className="py-3 pr-4">
                    <CollegeBadge info={cols?.salaries ?? null} />
                  </td>
                  <td className="py-3 text-muted">
                    {inst.date_renouvellement
                      ? new Date(inst.date_renouvellement).toLocaleDateString("fr-FR", {
                          year: "numeric",
                          month: "short",
                        })
                      : "—"}
                  </td>
                </tr>
              );
            })
          )}
        </tbody>
      </table>
    </div>
  );
}
