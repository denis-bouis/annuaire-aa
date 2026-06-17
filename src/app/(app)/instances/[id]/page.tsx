import { createClient } from "@/lib/supabase/client";
import Link from "next/link";
import { notFound } from "next/navigation";
import type { Instance, Mandat, Personne, Organisation, InstitutionIRC } from "@/types/database";

type InstanceFull = Instance & {
  institutions_irc: Pick<InstitutionIRC, "nom" | "code_csn"> | null;
};

type MandatJoined = Mandat & {
  personnes: Personne;
  organisations: Organisation | null;
};

function roleRank(m: MandatJoined): number {
  const fn = (m.fonction ?? "").toLowerCase();
  if (fn.includes("prés") && !fn.includes("vice")) return 0;
  if (fn.includes("vice")) return 1;
  if (m.statut === "titulaire") return 2;
  if (m.statut === "suppleant") return 3;
  return 4;
}

function roleBadge(m: MandatJoined) {
  const fn = (m.fonction ?? "").toLowerCase();
  if (fn.includes("prés") && !fn.includes("vice"))
    return <span className="text-xs font-semibold text-orange-600 ml-1">★ Prés.</span>;
  if (fn.includes("vice"))
    return <span className="text-xs font-semibold text-orange-400 ml-1">★ VP</span>;
  return null;
}

function statutTag(statut: string) {
  if (statut === "suppleant")
    return <span className="text-xs text-muted ml-1">(Supp.)</span>;
  return null;
}

function CollegeColumn({
  label,
  college,
  mandats,
}: {
  label: string;
  college: "employeurs" | "salaries";
  mandats: MandatJoined[];
}) {
  const color = college === "employeurs" ? "bg-blue-bg text-blue" : "bg-green-bg text-green";
  return (
    <div className="border border-border rounded-lg p-4">
      <div className="flex items-center gap-2 mb-3">
        <span className={`rounded-full px-2 py-0.5 text-xs font-semibold ${color}`}>
          {college === "employeurs" ? "E" : "S"}
        </span>
        <span className="font-semibold text-sm">{label}</span>
        <span className="text-xs text-muted ml-auto">{mandats.length}</span>
      </div>
      {mandats.length === 0 ? (
        <p className="text-muted text-xs">Aucun membre</p>
      ) : (
        <ul className="space-y-1.5">
          {mandats.map((m) => (
            <li key={m.id} className="text-sm flex items-baseline gap-1">
              <span className={m.statut === "suppleant" ? "text-muted" : "font-medium"}>
                {m.personnes.prenom} {m.personnes.nom}
              </span>
              {roleBadge(m)}
              {statutTag(m.statut)}
              {m.organisations && (
                <span className="text-xs text-muted ml-1">· {m.organisations.sigle}</span>
              )}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default async function InstanceDetailPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const db = createClient();

  const [{ data: instanceRaw }, { data: mandatsRaw }] = await Promise.all([
    db.from("instances").select("*, institutions_irc(nom, code_csn)").eq("id", id).single(),
    db
      .from("mandats")
      .select("*, personnes(*), organisations(*)")
      .eq("instance_id", id)
      .eq("annee_edition", 2025),
  ]);

  if (!instanceRaw) notFound();

  const instance = instanceRaw as unknown as InstanceFull;
  const mandats  = (mandatsRaw ?? []) as MandatJoined[];

  const employeurs = [...mandats.filter((m) => m.college === "employeurs")].sort(
    (a, b) => roleRank(a) - roleRank(b)
  );
  const salaries = [...mandats.filter((m) => m.college === "salaries")].sort(
    (a, b) => roleRank(a) - roleRank(b)
  );
  const invites = mandats.filter((m) => !m.college);

  const hasMandats = mandats.length > 0;

  return (
    <div className="max-w-4xl">
      <Link href="/instances" className="text-sm text-muted hover:text-blue mb-6 inline-block">
        ← Toutes les instances
      </Link>

      <h1 className="text-2xl font-semibold mb-1">{instance.nom}</h1>
      {instance.type === "irc" && instance.institutions_irc && (
        <p className="text-base text-muted mb-1">{instance.institutions_irc.nom}</p>
      )}
      <p className="text-muted text-sm mb-6">
        {instance.type}
        {instance.nb_membres ? ` · ${instance.nb_membres} membres` : ""}
        {instance.date_renouvellement
          ? ` · Renouvellement ${new Date(instance.date_renouvellement).toLocaleDateString(
              "fr-FR",
              { month: "long", year: "numeric" }
            )}`
          : ""}
        {hasMandats && (
          <span className="ml-2 text-green font-medium">
            · {mandats.length} mandat{mandats.length > 1 ? "s" : ""} renseigné
            {mandats.length > 1 ? "s" : ""}
          </span>
        )}
      </p>

      {/* Présidence — données issues de la table instances */}
      {(instance.president || instance.vice_president) && !hasMandats && (
        <div className="bg-surface border border-border rounded-lg p-4 mb-8 grid grid-cols-2 gap-4 text-sm">
          {instance.president && (
            <div>
              <p className="text-muted text-xs mb-0.5">Président(e)</p>
              <p className="font-medium">{instance.president}</p>
            </div>
          )}
          {instance.vice_president && (
            <div>
              <p className="text-muted text-xs mb-0.5">Vice-président(e)</p>
              <p className="font-medium">{instance.vice_president}</p>
            </div>
          )}
        </div>
      )}

      {hasMandats ? (
        <div className="space-y-6">
          {/* Deux collèges côte à côte */}
          <div className="grid grid-cols-2 gap-4">
            <CollegeColumn label="Collège employeurs" college="employeurs" mandats={employeurs} />
            <CollegeColumn label="Collège salariés"   college="salaries"  mandats={salaries} />
          </div>

          {/* Invités et DG en bas */}
          {invites.length > 0 && (
            <div className="border border-border rounded-lg p-4">
              <p className="text-xs font-semibold text-muted uppercase tracking-wide mb-3">
                Invités / Directeur général
              </p>
              <ul className="space-y-1.5">
                {invites.map((m) => (
                  <li key={m.id} className="text-sm flex items-baseline gap-1 text-muted">
                    <span>
                      {m.personnes.prenom} {m.personnes.nom}
                    </span>
                    {m.fonction && (
                      <span className="text-xs ml-1">· {m.fonction}</span>
                    )}
                  </li>
                ))}
              </ul>
            </div>
          )}
        </div>
      ) : (
        <div className="border border-border rounded-lg p-6 text-sm text-muted bg-surface">
          <p className="font-medium text-ink mb-1">Membres non renseignés</p>
          <p>
            Les mandats détaillés de cette instance ne sont pas encore importés.
            {instance.nb_membres
              ? ` L'instance compte ${instance.nb_membres} membres selon l'annuaire 2025.`
              : ""}
          </p>
        </div>
      )}
    </div>
  );
}
