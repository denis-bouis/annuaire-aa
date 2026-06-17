export type College      = "employeurs" | "salaries";
export type InstanceType = "federale" | "commune" | "operationnelle" | "irc" | "gps";
export type Statut       = "titulaire" | "suppleant" | "honoraire" | "invite" | "consultatif";
export type Categorie    = "interprofessionnelle" | "professionnelle" | "dom";

export type Organisation = {
  id: string; sigle: string; nom: string; college: College;
  adresse: string | null; tel: string | null; web: string | null; email: string | null;
};
export type GroupeGPS = {
  id: string; nom: string; siege: string | null; tel: string | null; web: string | null;
  directeur_general: string | null; date_creation: string | null; historique: string | null;
};
export type InstitutionIRC = {
  id: string; nom: string; code_csn: string; categorie: Categorie; gps_id: string | null;
  siege: string | null; tel: string | null; web: string | null; agrement: string | null;
  directeur_general: string | null; date_renouvellement: string | null; duree_mandat: number;
};
export type Instance = {
  id: string; nom: string; type: InstanceType;
  irc_id: string | null; gps_id: string | null;
  nb_membres: number | null; duree_mandat: number | null;
  date_renouvellement: string | null; president: string | null; vice_president: string | null;
};
export type Personne = {
  id: string; nom: string; prenom: string; honorific: string | null;
};
export type Mandat = {
  id: string; personne_id: string; instance_id: string; organisation_id: string | null;
  fonction: string | null; college: College | null; statut: Statut;
  annee_edition: number; date_debut: string | null; date_fin: string | null;
};

// supabase-js v2 requiert Row + Insert + Update + Relationships sur chaque table
type T<Row> = {
  Row: Row;
  Insert: Partial<Row>;
  Update: Partial<Row>;
  Relationships: [];
};

export type Database = {
  public: {
    Tables: {
      organisations:    T<Organisation>;
      groupes_gps:      T<GroupeGPS>;
      institutions_irc: T<InstitutionIRC>;
      instances:        T<Instance>;
      personnes:        T<Personne>;
      mandats:          T<Mandat>;
    };
    Views:          Record<string, never>;
    Functions:      Record<string, never>;
    Enums:          Record<string, never>;
    CompositeTypes: Record<string, never>;
  };
};
