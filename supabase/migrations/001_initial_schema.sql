-- ============================================================
-- EXTENSIONS
-- ============================================================
create extension if not exists "uuid-ossp";

-- ============================================================
-- TABLE : organisations
-- ============================================================
create table organisations (
  id      uuid primary key default uuid_generate_v4(),
  sigle   text not null unique,
  nom     text not null,
  college text not null check (college in ('employeurs', 'salaries')),
  adresse text,
  tel     text,
  web     text,
  email   text
);

-- ============================================================
-- TABLE : groupes_gps
-- ============================================================
create table groupes_gps (
  id                uuid primary key default uuid_generate_v4(),
  nom               text not null unique,
  siege             text,
  tel               text,
  web               text,
  directeur_general text,
  date_creation     text,
  historique        text
);

-- ============================================================
-- TABLE : institutions_irc
-- ============================================================
create table institutions_irc (
  id                  uuid primary key default uuid_generate_v4(),
  nom                 text not null unique,
  code_csn            text not null unique,
  categorie           text not null check (categorie in ('interprofessionnelle','professionnelle','dom')),
  gps_id              uuid references groupes_gps(id),
  siege               text,
  tel                 text,
  web                 text,
  agrement            text,
  directeur_general   text,
  date_renouvellement date,
  duree_mandat        int default 4
);

-- ============================================================
-- TABLE : etablissements
-- ============================================================
create table etablissements (
  id       uuid primary key default uuid_generate_v4(),
  ville    text not null,
  adresse  text not null,
  tel      text,
  is_siege boolean default false
);

-- ============================================================
-- TABLE : instances
-- ============================================================
create table instances (
  id                  uuid primary key default uuid_generate_v4(),
  nom                 text not null,
  type                text not null check (type in ('federale','commune','operationnelle','irc','gps')),
  irc_id              uuid references institutions_irc(id),
  gps_id              uuid references groupes_gps(id),
  nb_membres          int,
  duree_mandat        int,
  date_renouvellement date,
  president           text,
  vice_president      text
);

-- ============================================================
-- TABLE : personnes
-- ============================================================
create table personnes (
  id        uuid primary key default uuid_generate_v4(),
  nom       text not null,
  prenom    text not null,
  honorific text
);

create unique index on personnes (nom, prenom);

-- ============================================================
-- TABLE : mandats
-- ============================================================
create table mandats (
  id              uuid primary key default uuid_generate_v4(),
  personne_id     uuid not null references personnes(id),
  instance_id     uuid not null references instances(id),
  organisation_id uuid references organisations(id),
  fonction        text,
  college         text check (college in ('employeurs','salaries',null)),
  statut          text not null default 'titulaire'
                  check (statut in ('titulaire','suppleant','honoraire','invite','consultatif')),
  annee_edition   int  not null default 2025,
  date_debut      date,
  date_fin        date
);

create index on mandats (personne_id);
create index on mandats (instance_id);
create index on mandats (annee_edition);
create index on mandats (organisation_id);
