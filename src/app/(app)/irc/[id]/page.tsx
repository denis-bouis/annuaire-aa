import { createClient } from "@/lib/supabase/client";
import Link from "next/link";
import { notFound } from "next/navigation";
import type { InstitutionIRC, GroupeGPS, Instance, Mandat, Personne, Organisation } from "@/types/database";

type IRCFull = InstitutionIRC & { groupes_gps: Pick<GroupeGPS, "nom" | "web"> | null };

type MandatJoined = Mandat & {
  personnes: Personne;
  organisations: Organisation | null;
};

type InstanceWithMandats = Instance & { mandats: MandatJoined[] };

const CAT_LABEL: Record<InstitutionIRC["categorie"], string> = {
  interprofessionnelle: "Interprofessionnelle",
  professionnelle:      "Professionnelle",
  dom:                  "DOM",
};

function roleRank(m: MandatJoined): number {
  const fn = (m.fonction ?? "").toLowerCase();
  if (fn.includes("prés") && !fn.includes("vice")) return 0;
  if (fn.includes("vice")) return 1;
  if (m.statut === "titulaire") return 2;
  if (m.statut === "suppleant") return 3;
  return 4;
}

function RoleBadge({ m }: { m: MandatJoined }) {
  const fn = (m.fonction ?? "").toLowerCase();
  if (fn.includes("prés") && !fn.includes("vice"))
    return <span className="text-xs font-semibold text-orange-600 ml-1">★ Prés.</span>;
  if (fn.includes("vice"))
    return <span className="text-xs font-semibold text-orange-400 ml-1">★ VP</span>;
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
  if (mandats.length === 0) return null;
  return (
    <div>
      <div className="flex items-center gap-1.5 mb-2">
        <span className={`rounded-full px-1.5 py-0.5 text-xs font-semibold ${color}`}>
          {college === "employeurs" ? "E" : "S"}
        </span>
        <span className="text-xs font-semibold text-muted uppercase tracking-wide">{label}</span>
        <span className="text-xs text-muted ml-auto">{mandats.length}</span>
      </div>
      <ul className="space-y-1">
        {mandats.map((m) => (
          <li key={m.id} className="text-sm flex items-baseline gap-1 flex-wrap">
            <span className={m.statut === "suppleant" ? "text-muted" : "font-medium"}>
              {m.personnes.prenom} {m.personnes.nom}
            </span>
            <RoleBadge m={m} />
            {m.statut === "suppleant" && (
              <span className="text-xs text-muted">(Supp.)</span>
            )}
            {m.organisations && (
              <span className="text-xs text-muted">· {m.organisations.sigle}</span>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}

function InstanceCard({ inst }: { inst: InstanceWithMandats }) {
  const employeurs = [...inst.mandats.filter((m) => m.college === "employeurs")].sort(
    (a, b) => roleRank(a) - roleRank(b)
  );
  const salaries = [...inst.mandats.filter((m) => m.college === "salaries")].sort(
    (a, b) => roleRank(a) - roleRank(b)
  );
  const invites = inst.mandats.filter((m) => !m.college);

  const hasBothColleges = employeurs.length > 0 || salaries.length > 0;

  return (
    <div className="border border-border rounded-lg p-4">
      <div className="flex items-baseline justify-between mb-4">
        <h3 className="font-semibold">{inst.nom}</h3>
        <div className="flex gap-3 text-xs text-muted">
          {inst.nb_membres && <span>{inst.nb_membres} membres</span>}
          {inst.date_renouvellement && (
            <span>
              Renouv.{" "}
              {new Date(inst.date_renouvellement).toLocaleDateString("fr-FR", {
                month: "short",
                year: "numeric",
              })}
            </span>
          )}
          <Link href={`/instances/${inst.id}`} className="text-blue hover:underline">
            Voir détail →
          </Link>
        </div>
      </div>

      {inst.mandats.length === 0 ? (
        <p className="text-muted text-sm">Aucun mandat enregistré.</p>
      ) : (
        <div className="space-y-4">
          {hasBothColleges && (
            <div className="grid grid-cols-2 gap-4">
              <CollegeColumn label="Collège employeurs" college="employeurs" mandats={employeurs} />
              <CollegeColumn label="Collège salariés"   college="salaries"  mandats={salaries} />
            </div>
          )}
          {invites.length > 0 && (
            <div className="pt-3 border-t border-border">
              <p className="text-xs font-semibold text-muted uppercase tracking-wide mb-2">
                Invités / Directeur général
              </p>
              <ul className="space-y-1">
                {invites.map((m) => (
                  <li key={m.id} className="text-sm text-muted flex items-baseline gap-1">
                    <span>{m.personnes.prenom} {m.personnes.nom}</span>
                    {m.fonction && <span className="text-xs">· {m.fonction}</span>}
                  </li>
                ))}
              </ul>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

export default async function IRCDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const db = createClient();

  const [{ data: ircRaw }, { data: instancesRaw }] = await Promise.all([
    db.from("institutions_irc").select("*, groupes_gps(nom, web)").eq("id", id).single(),
    db
      .from("instances")
      .select("*, mandats(*, personnes(*), organisations(*))")
      .eq("irc_id", id)
      .order("nom"),
  ]);

  if (!ircRaw) notFound();

  const irc       = ircRaw as IRCFull;
  const instances = (instancesRaw ?? []) as InstanceWithMandats[];

  return (
    <div className="max-w-4xl">
      <Link href="/irc" className="text-sm text-muted hover:text-blue mb-6 inline-block">
        ← Toutes les IRC
      </Link>

      <h1 className="text-2xl font-semibold mb-1">{irc.nom}</h1>
      <div className="flex flex-wrap gap-3 text-sm text-muted mb-6">
        <span className="rounded-full px-2 py-0.5 bg-blue-bg text-blue text-xs">
          {CAT_LABEL[irc.categorie]}
        </span>
        <span>CSN {irc.code_csn}</span>
        {irc.groupes_gps && <span>Groupe {irc.groupes_gps.nom}</span>}
        {irc.date_renouvellement && (
          <span>
            Renouvellement{" "}
            {new Date(irc.date_renouvellement).toLocaleDateString("fr-FR", {
              month: "long",
              year: "numeric",
            })}
          </span>
        )}
      </div>

      <div className="bg-surface border border-border rounded-lg p-4 mb-8 grid grid-cols-2 gap-3 text-sm">
        {irc.directeur_general && (
          <div>
            <p className="text-muted text-xs mb-0.5">Directeur général</p>
            <p className="font-medium">{irc.directeur_general}</p>
          </div>
        )}
        {irc.siege && (
          <div>
            <p className="text-muted text-xs mb-0.5">Siège</p>
            <p>{irc.siege}</p>
          </div>
        )}
        {irc.tel && (
          <div>
            <p className="text-muted text-xs mb-0.5">Téléphone</p>
            <p>{irc.tel}</p>
          </div>
        )}
        {irc.agrement && (
          <div>
            <p className="text-muted text-xs mb-0.5">Agrément</p>
            <p>{irc.agrement}</p>
          </div>
        )}
      </div>

      <h2 className="text-lg font-semibold mb-4">Instances et membres</h2>

      {instances.length === 0 ? (
        <p className="text-muted text-sm">
          Aucune instance enregistrée pour cette institution.{" "}
          <span className="text-xs">(À compléter avec les données du CA et des commissions.)</span>
        </p>
      ) : (
        <div className="flex flex-col gap-6">
          {instances.map((inst) => (
            <InstanceCard key={inst.id} inst={inst} />
          ))}
        </div>
      )}
    </div>
  );
}
