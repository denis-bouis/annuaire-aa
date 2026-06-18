-- ============================================================
-- PURGE — vide toutes les tables en respectant les FK
-- ============================================================

truncate table
  mandats,
  instances,
  institutions_irc,
  groupes_gps,
  etablissements,
  personnes,
  organisations
restart identity cascade;
