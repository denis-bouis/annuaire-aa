-- ============================================================
-- SEED IRC — Instances et mandats des 12 CA (2025)
-- À exécuter après seed.sql
-- ============================================================

-- ============================================================
-- ORGANISATIONS SUPPLÉMENTAIRES
-- ============================================================
insert into organisations (sigle, nom, college) values
  -- Employeurs sectoriels
  ('FEPEM',       'Fédération des particuliers employeurs de France',      'employeurs'),
  ('FNTR',        'Fédération nationale des transports routiers',          'employeurs'),
  ('FNTV',        'Fédération nationale du transport de voyageurs',        'employeurs'),
  ('TLF',         'Transport et logistique de France',                     'employeurs'),
  ('OTRE',        'Organisation des transporteurs routiers européens',     'employeurs'),
  ('WAGONS-LITS', 'Wagons-Lits Tourisme',                                  'employeurs'),
  -- Employeurs DOM / BTP
  ('FRBTP-GP',    'FRBTP Guadeloupe',                                      'employeurs'),
  ('FRBTP-MT',    'FRBTP Martinique',                                      'employeurs'),
  ('FRBTP-GY',    'FRBTP Guyane',                                          'employeurs'),
  -- Salariés sectoriels
  ('FGTA-FO',     'Fédération générale des travailleurs de l''agriculture et de l''alimentation - FO', 'salaries'),
  -- Salariés DOM — Guadeloupe
  ('UTG',         'Union des travailleurs guadeloupéens',                  'salaries'),
  ('CGTG',        'Confédération générale du travail de la Guadeloupe',    'salaries'),
  ('CDTG-CFDT',   'Confédération démocratique des travailleurs de Guadeloupe', 'salaries'),
  ('FTC-CGTG',    'Fédération des travailleurs du commerce - CGTG',        'salaries'),
  -- Salariés DOM — Martinique
  ('CSTM',        'Confédération des syndicats des travailleurs de Martinique', 'salaries'),
  ('FTC-CGTM',    'Fédération des travailleurs du commerce - CGTM/FSM',    'salaries'),
  ('CGTM',        'Confédération générale du travail de la Martinique',    'salaries'),
  ('CGTM-FSM',    'Confédération générale du travail de Martinique - FSM', 'salaries'),
  ('CDMT',        'Confédération des travailleurs de la Martinique',       'salaries'),
  -- Salariés DOM — La Réunion
  ('CGTR',        'Confédération générale du travail de la Réunion',       'salaries'),
  -- Salariés DOM — partagé
  ('UD-CFTC',     'Union Départementale CFTC',                             'salaries'),
  ('UD-FO',       'Union Départementale Force Ouvrière',                   'salaries')
on conflict (sigle) do nothing;

-- ============================================================
-- INSTANCES IRC — 1 CA par institution (12)
-- ============================================================
insert into instances (nom, type, irc_id, duree_mandat, date_renouvellement, president, vice_president)
select 'Conseil d''administration', 'irc', irc.id, 4, d.renouv::date, d.president, d.vp
from (values
  ('F700', '2023-01-01', 'Pascale LEMAISTRE',    'Christian CRÉTIER'),
  ('F501', '2023-01-01', 'Jean COLOMAR',          'Jean-Laurent CHAMALY'),
  ('F820', '2023-04-28', 'Thierry GRÉGOIRE',      'Harry WALLACE'),
  ('F810', '2023-01-17', 'Alain BENJAMIN',        'Murielle JABÈS'),
  ('F830', '2022-12-15', 'Nicolas CARMI',         'Henri BÉDIER'),
  ('F155', '2023-01-01', 'Roland SCHERDING',      'Thibaut BRODIN'),
  ('F020', '2023-06-22', 'Michel CLAIR',          'René ROCHE'),
  ('F150', '2023-06-22', 'Pascal BARRE',          'Éric HUGON'),
  ('F509', '2024-01-01', 'Christophe DUMAS',      'Bernard WEILL'),
  ('F280', '2023-01-01', 'Carmen MARTY',          'Marc VEZZARO'),
  ('C001', '2023-06-14', 'Pierre BALARESQUE',     'Jean-François ROPERT'),
  ('F800', '2022-12-09', 'Stéphane MONLOUIS',     'Georges ORNEM')
) as d(csn, renouv, president, vp)
join institutions_irc irc on irc.code_csn = d.csn;

-- ============================================================
-- PERSONNES — tous les membres des 12 CA
-- ============================================================
insert into personnes (nom, prenom) values
  -- AG2R (F700)
  ('ANRACT',              'Dominique'),
  ('BOISRAMÉ',            'Bertrand'),
  ('BRASQUET',            'Céline'),
  ('CREYSSEL',            'Jacques'),
  ('HERVET',              'Lisiane'),
  ('JOUAN-AUZEBY',        'Jean-Yves'),
  ('MARTIN',              'David'),
  ('MUNCH',               'Christian'),
  ('OUITIS',              'Jean'),
  ('THOURON',             'Philippe'),
  ('VOGLEY',              'Jean-Charles'),
  ('WINCKLER',            'Sophie'),
  ('BALLESTER',           'Patrice'),
  ('BERTRAND',            'Dominique'),
  ('BÉTHIER',             'Yves'),
  ('BILLIEMAZ',           'Alain'),
  ('BRUNEL',              'Bernard'),
  ('CHEVREAU',            'Fabienne'),
  ('DEFRANCE',            'Jacques'),
  ('DONSIMONI',           'Marie-Anne'),
  ('GUYARD',              'Jean-Arnaud'),
  ('MARTINET',            'Myriam'),
  ('SAMSON',              'Christophe'),
  ('SORIN',               'Aurélie'),
  ('ZAGOURI',             'Colette'),
  -- APICIL (F501)
  ('CHAMALY',             'Jean-Laurent'),
  ('AMBROSINO',           'Laurent'),
  ('CHAMBON',             'Éric'),
  ('FAYETTE',             'Thierry'),
  ('GIAUME',              'Richard'),
  ('GITENAY',             'Jean-Pierre'),
  ('HOBLINGRE',           'Denise'),
  ('LEFEBVRE',            'Delphine'),
  ('MARCY',               'Raphaël'),
  ('MICHEL',              'Philippe'),
  ('NICVERT',             'Didier'),
  ('PELLET',              'Jean-Christophe'),
  ('PFAIFFER',            'Rodolph'),
  ('BAUP',                'Bernard'),
  ('CARADIAT',            'Jean-Pierre'),
  ('COTTET',              'Michel'),
  ('DEAL',                'Richard'),
  ('FARGEAS',             'Élisabeth'),
  ('FOURNIER',            'Yves'),
  ('GAY',                 'Alain'),
  ('JAMMES',              'Bernard'),
  ('JOUVENEL',            'Élisabeth'),
  ('MAUCLER',             'Michel'),
  ('NABTI',               'Nasséra'),
  ('SAVALL',              'Ingrid'),
  ('SCHEVEYER',           'Daniel'),
  -- BTPR (F820)
  ('WALLACE',             'Harry'),
  ('ANTOINETTE',          'Mathieu'),
  ('BAZIN DE JESSEY',     'Emmanuel'),
  ('BEAUPRES-DE-MONSALES','Renaud'),
  ('BIBRAC',              'Fortuné'),
  ('BROCQUEVIELLE',       'Patrick'),
  ('GADDARKHAN',          'José'),
  ('LABRIET',             'Pascal'),
  ('LINEL',               'Kevin'),
  ('MICHAUX',             'Philippe'),
  ('NEWTON',              'Denise'),
  ('OSTORERO',            'Carol'),
  ('PATOLE',              'Steve'),
  ('ATTICOT',             'Yannick'),
  ('BOUVILLE',            'Michel'),
  ('ERTUS',               'Danièle'),
  ('FÉLICITÉ',            'Nicolas'),
  ('JEAN-BAPTISTE',       'Claude'),
  ('JOSEPH',              'Bruno'),
  ('MALBOROUGT',          'Michaël'),
  ('MATHURIN',            'Pierre'),
  ('NICOLE',              'Roger'),
  ('RUBAL',               'Hervé'),
  -- CGRR (F810)
  ('JABÈS',               'Murielle'),
  ('DAHAN',               'Aimée'),
  ('DE POYEN',            'Jean-Luc'),
  ('DOQUIN',              'Georges'),
  ('FRANÇOIS',            'Margot'),
  ('HATCHI',              'Jocelyne'),
  ('INAMO',               'Malick'),
  ('JEAMPI',              'Pierrette'),
  ('LECLERC',             'Éric'),
  ('ALET',                'Harry'),
  ('AZEDE',               'Alain'),
  ('CHRISTINE',           'Yvon'),
  ('DATIL',               'Max'),
  ('GUIOUGOU',            'Georges-Henri'),
  ('LUNES',               'Jacques'),
  ('MALATCHOUMY',         'Dominique'),
  -- CRR (F830)
  ('BÉDIER',              'Henri'),
  ('CLAIN',               'Sylvie'),
  ('GILLES',              'Jacques'),
  ('GRONDIN',             'Katia'),
  ('MAHAMADALY',          'Arjouhoussen'),
  ('DE MENOU',            'Sandra'),
  ('NICE',                'Moïse'),
  ('PALMIERI',            'Morgane'),
  ('ROBERT',              'Dominique'),
  ('THIBAULT',            'Florent'),
  ('AMO',                 'Stéphanie'),
  ('AUDIFAX',             'Chantal'),
  ('BALMINE',             'Jacky'),
  ('BHUGON',              'Jacques'),
  ('CORBEAU',             'Mario'),
  ('LAGARRIGUE',          'Johny'),
  ('LAURENT',             'Jean Yannis'),
  ('NATIVEL',             'Alain'),
  ('RAMSAMY',             'Matthias'),
  -- IRCEM (F155)
  ('BRODIN',              'Thibaut'),
  ('BERTHIER',            'Lise'),
  ('DUPUY',               'Françoise'),
  ('JOLY',                'Dorothée'),
  ('KERRAD',              'Michèle'),
  ('LEBRUN',              'Stéphane'),
  ('TOUDY',               'Éric'),
  ('VERGNAUD',            'Jean'),
  ('VERSPIEREN',          'Arnaud'),
  ('BLANPAIN',            'Véronique'),
  ('GOUIN',               'Chantal'),
  ('JOBERT',              'Françoise'),
  ('JOURNO',              'Danielle'),
  ('LIOT',                'Dominique-Sophie'),
  ('MARÉCHAL',            'Danièle'),
  ('MINET',               'Gaëtane'),
  ('ROGER',               'Chantal'),
  ('SAGEZ',               'Aurélie'),
  -- KLESIA (F020)
  ('ROCHE',               'René'),
  ('BARTHELEMY',          'Laurent'),
  ('BURLET',              'Daniel'),
  ('CÔTÉ-PEOVER',         'Suzanne'),
  ('DE BRUYNE',           'Catherine'),
  ('GUERIN-LAFFINEUR',    'Pascale'),
  ('LAJOANIE',            'Antoine'),
  ('LEGENDRE',            'Farell'),
  ('LEJOSNE',             'Richard'),
  ('MORIN',               'David'),
  ('PALLE-GUILLABERT',    'Françoise'),
  ('RAES',                'Clotilde'),
  ('SAINT-OUEN',          'Marc'),
  ('TULARD',              'Pierre'),
  ('BILLEBAULT',          'Christian'),
  ('BRAJEVIC',            'Diana'),
  ('COUTAUD',             'Patrick'),
  ('FRANCESCHINI',        'Laurence'),
  ('HAMDAOUI',            'Jamel'),
  ('ITIM',                'Ourida'),
  ('LOUVET',              'Raphaël'),
  ('PARINET',             'Michel'),
  ('PELLARIN',            'Pascale'),
  ('PERIOU',              'Mickael'),
  ('RASSIF',              'Mohamed'),
  ('SEGURA',              'Laurence'),
  ('TECHER',              'Jacques'),
  ('VEITL',               'Sylvia'),
  -- CARCEPT (F150)
  ('HUGON',               'Éric'),
  ('BARRAULT',            'Jean-Sébastien'),
  ('BRES',                'Jean-Luc'),
  ('CHARGROS',            'Olivier'),
  ('DUPONT',              'Hubert'),
  ('GACIA',               'Nicolas'),
  ('GRAVELLIER',          'Patrice'),
  ('LECHAPTOIS',          'Laurence'),
  ('LEFEBVRE',            'Nadine'),
  ('MAGAR',               'Nicole'),
  ('NOËL',                'Nancy'),
  ('PELLETIER',           'Yannick'),
  ('RIVERA',              'Jean-Marc'),
  ('SEYT',                'Michel'),
  ('BOURGEON',            'Stéphane'),
  ('BRUCHON-BIENFAIT',    'Frédéric'),
  ('CADART',              'Guillaume'),
  ('DELAUNAY',            'Jean-Louis'),
  ('DROGOUL-SPANU',       'David'),
  ('DOS SANTOS',          'Jean-Pierre'),
  ('DOUINE',              'Thierry'),
  ('DUBAU',               'Jean-Marc'),
  ('MARTINS',             'Fernando'),
  ('NUZZO',               'Christian'),
  ('SAADOUNE',            'Driss'),
  ('SCHIRM',              'Denis'),
  ('TERNOIS',             'Pierrick'),
  ('THIEFAINE',           'Aniela'),
  ('BACHY',               'Sandrine'),
  ('BERNON',              'Marion'),
  ('DICOSTANZO',          'Christophe'),
  ('GILBERT-PERRON',      'Herveline'),
  ('HUNAULT',             'Dominique'),
  ('ETHEVE',              'Olivier'),
  ('FLOQUET',             'Yves'),
  ('GERMANY',             'François'),
  ('PEYROT',              'Nicolas'),
  ('POTKRAJAC',           'Ksenija'),
  -- MALAKOFF HUMANIS (F509)
  ('WEILL',               'Bernard'),
  ('BERTHIER',            'Lysiane'),
  ('BUTTERBACH',          'Mikaël'),
  ('CHAUVET',             'Bertand'),
  ('DAUBIGNEY',           'Pierre-Luc'),
  ('DEDRICHE',            'Isabelle'),
  ('FERRAND',             'Sabine'),
  ('GARCZYNSKI',          'Gilles'),
  ('GROISY',              'Pierre'),
  ('LAQUEILLE',           'Yves'),
  ('LECLERCQ',            'Philippe'),
  ('MAGNAN',              'Géraldine'),
  ('RENAUD',              'Hélène'),
  ('SEVAULT',             'Patricia'),
  ('BELQASMI',            'Rachida'),
  ('BZIOUI',              'Nada'),
  ('COUSIN',              'Carole'),
  ('CRAPAT',              'Karine'),
  ('DEHELLE-MIGNOT',      'Valérie'),
  ('FRAYSSE',             'Philippe'),
  ('GAUTRON',             'Alain'),
  ('LE COQ',              'Xavier'),
  ('NINGRES',             'Catherine'),
  ('PELLE',               'Denis'),
  ('ROUSSET',             'Marie-Pierre'),
  ('TALDIR',              'Sonia'),
  -- MALAKOFF HUMANIS INTERNATIONAL (F280)
  ('VEZZARO',             'Marc'),
  ('BENOIST',             'Xavier'),
  ('COTTALORDA',          'Thierry'),
  ('DALY',                'Mimsy'),
  ('DE DAMAS-NOTTIN',     'Odile'),
  ('JAMBIN MOREAU',       'Mary'),
  ('LAFLEUR',             'Alexandre'),
  ('LLORET',              'Sylvie'),
  ('OCHIDA',              'Daniel'),
  ('ZAOUI',               'Valérie'),
  ('CERAN JERUSALEMY',    'Huimata'),
  ('KADOOKA',             'Thierry'),
  ('LEFEBVRE BLAISOT',    'Jordane'),
  ('PIGNAULT',            'Sonia'),
  ('SERIEYSSOL',          'Evelyne'),
  ('WEJIEME',             'Victor'),
  ('YAN',                 'Tu'),
  -- ALLIANCE PROFESSIONNELLE (C001)
  ('ROPERT',              'Jean-François'),
  ('BARTHOLOMÉ',          'Francis'),
  ('DAUNE',               'Philippe'),
  ('DUCROT',              'Pascal'),
  ('LAMAISON',            'Valérie'),
  ('LECHNER',             'Joseph'),
  ('LOMBRY',              'Jean-Hugues'),
  ('MEYER',               'Alexis'),
  ('POSTEL',              'Corine'),
  ('POUDEROUX',           'Noël'),
  ('ROUX',                'Patrick'),
  ('SIBILLE',             'Frédéric'),
  ('THAMIN',              'Bertrand'),
  ('TRIAS',               'Guillaume'),
  ('VINÉ',                'Pascal'),
  ('BRONDINO',            'Jean-Claude'),
  ('DELÉTOILE',           'Emmanuel'),
  ('LÉ',                  'Sylvain'),
  ('LEROUX',              'Catherine'),
  ('MERCY',               'Patrick'),
  ('MONPEURT',            'Alain'),
  ('NOLEVAL',             'Thierry'),
  ('PANTANELLA',          'Bruno'),
  ('PINEAU',              'Valérie'),
  ('ROUSSEL',             'Pascal'),
  ('SABATIER',            'Rolland'),
  ('SACQUÉPÉE',           'Patrice'),
  ('SERPAUD',             'François'),
  ('SOUDIERE',            'Jean-Luc'),
  -- IRCOM (F800)
  ('ORNEM',               'Georges'),
  ('DUVAL',               'Jean-François'),
  ('FICHAU',              'Xavier'),
  ('GIRARDOT',            'Jérôme'),
  ('JACQUIER',            'Fabrice'),
  ('LEFRANC',             'Reine-Véronique'),
  ('PAVIUS',              'Valérie'),
  ('ADOLPHE',             'Agnès'),
  ('CHEVIOT',             'Marcus'),
  ('DETONNE',             'Patrick'),
  ('GALIBOU',             'Louis-Pascal'),
  ('HERVE',               'Louis-Jean'),
  ('JEAN-GILLES',         'Carole')
on conflict (nom, prenom) do nothing;

-- ============================================================
-- MANDATS IRC 1 — AG2R Agirc-Arrco (F700)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F700' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('LEMAISTRE',    'Pascale',     'MEDEF',   'employeurs', 'titulaire', 'Présidente'),
  ('CRÉTIER',      'Christian',   'CGT-FO',  'salaries',   'titulaire', 'Vice-président'),
  ('HEYRIES',      'Fabrice',     null::text,null::text,   'invite',    'Directeur général'),
  ('ANRACT',       'Dominique',   'U2P',     'employeurs', 'titulaire', null::text),
  ('BOISRAMÉ',     'Bertrand',    'MEDEF',   'employeurs', 'titulaire', null),
  ('BRASQUET',     'Céline',      'MEDEF',   'employeurs', 'titulaire', null),
  ('CREYSSEL',     'Jacques',     'MEDEF',   'employeurs', 'titulaire', null),
  ('HERVET',       'Lisiane',     'U2P',     'employeurs', 'titulaire', null),
  ('JOUAN-AUZEBY', 'Jean-Yves',   'MEDEF',   'employeurs', 'titulaire', null),
  ('MARTIN',       'David',       'U2P',     'employeurs', 'titulaire', null),
  ('MUNCH',        'Christian',   'CPME',    'employeurs', 'titulaire', null),
  ('OUITIS',       'Jean',        'MEDEF',   'employeurs', 'titulaire', null),
  ('THOURON',      'Philippe',    'CPME',    'employeurs', 'titulaire', null),
  ('VOGLEY',       'Jean-Charles','CPME',    'employeurs', 'titulaire', null),
  ('WINCKLER',     'Sophie',      'MEDEF',   'employeurs', 'titulaire', null),
  ('BALLESTER',    'Patrice',     'CGT',     'salaries',   'titulaire', null),
  ('BERTRAND',     'Dominique',   'CFTC',    'salaries',   'titulaire', null),
  ('BÉTHIER',      'Yves',        'CFTC',    'salaries',   'titulaire', null),
  ('BILLIEMAZ',    'Alain',       'CGT-FO',  'salaries',   'titulaire', null),
  ('BRUNEL',       'Bernard',     'CGT',     'salaries',   'titulaire', null),
  ('CHEVREAU',     'Fabienne',    'CGT-FO',  'salaries',   'titulaire', null),
  ('DEFRANCE',     'Jacques',     'CFE-CGC', 'salaries',   'titulaire', null),
  ('DONSIMONI',    'Marie-Anne',  'CFDT',    'salaries',   'titulaire', null),
  ('GUYARD',       'Jean-Arnaud', 'CFE-CGC', 'salaries',   'titulaire', null),
  ('MARTINET',     'Myriam',      'CGT',     'salaries',   'titulaire', null),
  ('PISA',         'Brigitte',    'CFDT',    'salaries',   'titulaire', null),
  ('SAMSON',       'Christophe',  'CFDT',    'salaries',   'titulaire', null),
  ('SORIN',        'Aurélie',     'CFTC',    'salaries',   'titulaire', null),
  ('ZAGOURI',      'Colette',     'CFE-CGC', 'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 2 — APICIL Agirc-Arrco (F501)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F501' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('COLOMAR',      'Jean',          'CGT',     'salaries',   'titulaire', 'Président'),
  ('CHAMALY',      'Jean-Laurent',  'MEDEF',   'employeurs', 'titulaire', 'Vice-Président'),
  ('BARRET',       'Philippe',      null::text,null::text,   'invite',    'Directeur général'),
  ('AMBROSINO',    'Laurent',       'MEDEF',   'employeurs', 'titulaire', null::text),
  ('CHAMBON',      'Éric',          'MEDEF',   'employeurs', 'titulaire', null),
  ('FAYETTE',      'Thierry',       'MEDEF',   'employeurs', 'titulaire', null),
  ('GIAUME',       'Richard',       'MEDEF',   'employeurs', 'titulaire', null),
  ('GITENAY',      'Jean-Pierre',   'MEDEF',   'employeurs', 'titulaire', null),
  ('HOBLINGRE',    'Denise',        'MEDEF',   'employeurs', 'titulaire', null),
  ('LEFEBVRE',     'Delphine',      'MEDEF',   'employeurs', 'titulaire', null),
  ('MARCY',        'Raphaël',       'MEDEF',   'employeurs', 'titulaire', null),
  ('MICHEL',       'Philippe',      'MEDEF',   'employeurs', 'titulaire', null),
  ('NICVERT',      'Didier',        'MEDEF',   'employeurs', 'titulaire', null),
  ('PELLET',       'Jean-Christophe','MEDEF',  'employeurs', 'titulaire', null),
  ('PFAIFFER',     'Rodolph',       'MEDEF',   'employeurs', 'titulaire', null),
  ('VIGNON',       'Jean-Jacques',  'CPME',    'employeurs', 'titulaire', null),
  ('BAUP',         'Bernard',       'CFTC',    'salaries',   'titulaire', null),
  ('CARADIAT',     'Jean-Pierre',   'CFE-CGC', 'salaries',   'titulaire', null),
  ('COTTET',       'Michel',        'CGT-FO',  'salaries',   'titulaire', null),
  ('DEAL',         'Richard',       'CGT',     'salaries',   'titulaire', null),
  ('FARGEAS',      'Élisabeth',     'CFDT',    'salaries',   'titulaire', null),
  ('FOURNIER',     'Yves',          'CGT-FO',  'salaries',   'titulaire', null),
  ('GAY',          'Alain',         'CFDT',    'salaries',   'titulaire', null),
  ('JAMMES',       'Bernard',       'CFTC',    'salaries',   'titulaire', null),
  ('JOUVENEL',     'Élisabeth',     'CFTC',    'salaries',   'titulaire', null),
  ('MAUCLER',      'Michel',        'CFDT',    'salaries',   'titulaire', null),
  ('NABTI',        'Nasséra',       'CGT',     'salaries',   'titulaire', null),
  ('SAVALL',       'Ingrid',        'CGT-FO',  'salaries',   'titulaire', null),
  ('SCHEVEYER',    'Daniel',        'CFE-CGC', 'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 3 — BTPR Agirc-Arrco (F820)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F820' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('GRÉGOIRE',            'Thierry',  'FRBTP-MT', 'employeurs', 'titulaire', 'Président'),
  ('WALLACE',             'Harry',    'FTC-CGTG', 'salaries',   'titulaire', 'Vice-président'),
  ('LEBRAVE',             'Raoul',    null::text,  null::text,  'invite',    'Directeur général'),
  ('ANTOINETTE',          'Mathieu',  'FRBTP-GY', 'employeurs', 'titulaire', null::text),
  ('BAZIN DE JESSEY',     'Emmanuel', 'FRBTP-GY', 'employeurs', 'titulaire', null),
  ('BEAUPRES-DE-MONSALES','Renaud',   'FRBTP-MT', 'employeurs', 'titulaire', null),
  ('BIBRAC',              'Fortuné',  'FRBTP-GP', 'employeurs', 'titulaire', null),
  ('BROCQUEVIELLE',       'Patrick',  'FRBTP-GP', 'employeurs', 'titulaire', null),
  ('GADDARKHAN',          'José',     'FRBTP-GP', 'employeurs', 'titulaire', null),
  ('LABRIET',             'Pascal',   'FRBTP-GP', 'employeurs', 'titulaire', null),
  ('LINEL',               'Kevin',    'FRBTP-MT', 'employeurs', 'titulaire', null),
  ('MICHAUX',             'Philippe', 'FRBTP-GP', 'employeurs', 'titulaire', null),
  ('NEWTON',              'Denise',   'FRBTP-MT', 'employeurs', 'titulaire', null),
  ('OSTORERO',            'Carol',    'FRBTP-GY', 'employeurs', 'titulaire', null),
  ('PATOLE',              'Steve',    'FRBTP-MT', 'employeurs', 'titulaire', null),
  ('ATTICOT',             'Yannick',  'UTG',      'salaries',   'titulaire', null),
  ('BOUVILLE',            'Michel',   'CSTM',     'salaries',   'titulaire', null),
  ('ERTUS',               'Danièle',  'UD-CFTC',  'salaries',   'titulaire', null),
  ('FÉLICITÉ',            'Nicolas',  'FTC-CGTM', 'salaries',   'titulaire', null),
  ('JEAN-BAPTISTE',       'Claude',   'CDTG-CFDT','salaries',   'titulaire', null),
  ('JOSEPH',              'Bruno',    'FTC-CGTG', 'salaries',   'titulaire', null),
  ('MALBOROUGT',          'Michaël',  'FTC-CGTG', 'salaries',   'titulaire', null),
  ('MATHURIN',            'Pierre',   'UTG',      'salaries',   'titulaire', null),
  ('NICOLE',              'Roger',    'CGTM',     'salaries',   'titulaire', null),
  ('RUBAL',               'Hervé',    'UD-FO',    'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 4 — CGRR Agirc-Arrco (F810)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F810' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('BENJAMIN',      'Alain',       'CFE-CGC', 'salaries',   'titulaire', 'Président'),
  ('JABÈS',         'Murielle',    'MEDEF',   'employeurs', 'titulaire', 'Vice-présidente'),
  ('MOUNGALI',      'Lionel',      null::text,null::text,   'invite',    'Directeur général'),
  ('DAHAN',         'Aimée',       'MEDEF',   'employeurs', 'titulaire', null::text),
  ('DE POYEN',      'Jean-Luc',    'MEDEF',   'employeurs', 'titulaire', null),
  ('DOQUIN',        'Georges',     'MEDEF',   'employeurs', 'titulaire', null),
  ('FRANÇOIS',      'Margot',      'MEDEF',   'employeurs', 'titulaire', null),
  ('HATCHI',        'Jocelyne',    'MEDEF',   'employeurs', 'titulaire', null),
  ('INAMO',         'Malick',      'U2P',     'employeurs', 'titulaire', null),
  ('JEAMPI',        'Pierrette',   'CPME',    'employeurs', 'titulaire', null),
  ('LECLERC',       'Éric',        'MEDEF',   'employeurs', 'titulaire', null),
  ('ALET',          'Harry',       'CGTG',    'salaries',   'titulaire', null),
  ('AZEDE',         'Alain',       'CFDT',    'salaries',   'titulaire', null),
  ('CHRISTINE',     'Yvon',        'CGTG',    'salaries',   'titulaire', null),
  ('DATIL',         'Max',         'CFTC',    'salaries',   'titulaire', null),
  ('GUIOUGOU',      'Georges-Henri','CFTC',   'salaries',   'titulaire', null),
  ('LUNES',         'Jacques',     'CFE-CGC', 'salaries',   'titulaire', null),
  ('MALATCHOUMY',   'Dominique',   'CFDT',    'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 5 — CRR Agirc-Arrco (F830)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F830' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('CARMI',       'Nicolas',       'UD-FO',   'salaries',   'titulaire', 'Président'),
  ('BÉDIER',      'Henri',         'MEDEF',   'employeurs', 'titulaire', 'Vice-président'),
  ('BENBASSAT',   'Thierry',       null::text,null::text,   'invite',    'Directeur général'),
  ('CLAIN',       'Sylvie',        'MEDEF',   'employeurs', 'titulaire', null::text),
  ('GILLES',      'Jacques',       'U2P',     'employeurs', 'titulaire', null),
  ('GRONDIN',     'Katia',         'MEDEF',   'employeurs', 'titulaire', null),
  ('MAHAMADALY',  'Arjouhoussen',  'MEDEF',   'employeurs', 'titulaire', null),
  ('DE MENOU',    'Sandra',        'MEDEF',   'employeurs', 'titulaire', null),
  ('NICE',        'Moïse',         'CPME',    'employeurs', 'titulaire', null),
  ('PALMIERI',    'Morgane',       'CPME',    'employeurs', 'titulaire', null),
  ('ROBERT',      'Dominique',     'CPME',    'employeurs', 'titulaire', null),
  ('THIBAULT',    'Florent',       'MEDEF',   'employeurs', 'titulaire', null),
  ('AMO',         'Stéphanie',     'UD-FO',   'salaries',   'titulaire', null),
  ('AUDIFAX',     'Chantal',       'CFTC',    'salaries',   'titulaire', null),
  ('BALMINE',     'Jacky',         'CGTR',    'salaries',   'titulaire', null),
  ('BHUGON',      'Jacques',       'CGTR',    'salaries',   'titulaire', null),
  ('CORBEAU',     'Mario',         'CFDT',    'salaries',   'titulaire', null),
  ('LAGARRIGUE',  'Johny',         'CFDT',    'salaries',   'titulaire', null),
  ('LAURENT',     'Jean Yannis',   'CFTC',    'salaries',   'titulaire', null),
  ('NATIVEL',     'Alain',         'CFE-CGC', 'salaries',   'titulaire', null),
  ('RAMSAMY',     'Matthias',      'CFE-CGC', 'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 6 — IRCEM Agirc-Arrco (F155)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F155' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('SCHERDING',   'Roland',        'CFTC',    'salaries',   'titulaire', 'Président'),
  ('BRODIN',      'Thibaut',       'FEPEM',   'employeurs', 'titulaire', 'Vice-président'),
  ('DA MARIANA',  'Serge',         null::text,null::text,   'invite',    'Directeur général'),
  ('BERTHIER',    'Lise',          'FEPEM',   'employeurs', 'titulaire', null::text),
  ('DUPUY',       'Françoise',     'FEPEM',   'employeurs', 'titulaire', null),
  ('JOLY',        'Dorothée',      'FEPEM',   'employeurs', 'titulaire', null),
  ('KERRAD',      'Michèle',       'FEPEM',   'employeurs', 'titulaire', null),
  ('LEBRUN',      'Stéphane',      'FEPEM',   'employeurs', 'titulaire', null),
  ('TOUDY',       'Éric',          'FEPEM',   'employeurs', 'titulaire', null),
  ('VERGNAUD',    'Jean',          'FEPEM',   'employeurs', 'titulaire', null),
  ('VERSPIEREN',  'Arnaud',        'FEPEM',   'employeurs', 'titulaire', null),
  ('BLANPAIN',    'Véronique',     'FGTA-FO', 'salaries',   'titulaire', null),
  ('GOUIN',       'Chantal',       'CGT',     'salaries',   'titulaire', null),
  ('JOBERT',      'Françoise',     'CFE-CGC', 'salaries',   'titulaire', null),
  ('JOURNO',      'Danielle',      'CGT',     'salaries',   'titulaire', null),
  ('LIOT',        'Dominique-Sophie','CFE-CGC','salaries',  'titulaire', null),
  ('MARÉCHAL',    'Danièle',       'CFDT',    'salaries',   'titulaire', null),
  ('MINET',       'Gaëtane',       'CFDT',    'salaries',   'titulaire', null),
  ('ROGER',       'Chantal',       'FGTA-FO', 'salaries',   'titulaire', null),
  ('SAGEZ',       'Aurélie',       'CFTC',    'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 7 — KLESIA Agirc-Arrco (F020)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F020' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('CLAIR',              'Michel',      'MEDEF',   'employeurs', 'titulaire', 'Président'),
  ('ROCHE',              'René',        'CFE-CGC', 'salaries',   'titulaire', 'Vice-président'),
  ('SCHMIDT DE LA BRÉLIE','Christian',  null::text,null::text,   'invite',    'Directeur général'),
  ('BARTHELEMY',         'Laurent',     'CPME',    'employeurs', 'titulaire', null::text),
  ('BURLET',             'Daniel',      'CPME',    'employeurs', 'titulaire', null),
  ('CÔTÉ-PEOVER',        'Suzanne',     'CPME',    'employeurs', 'titulaire', null),
  ('DE BRUYNE',          'Catherine',   'CPME',    'employeurs', 'titulaire', null),
  ('GUERIN-LAFFINEUR',   'Pascale',     'MEDEF',   'employeurs', 'titulaire', null),
  ('LAJOANIE',           'Antoine',     'MEDEF',   'employeurs', 'titulaire', null),
  ('LEGENDRE',           'Farell',      'U2P',     'employeurs', 'titulaire', null),
  ('LE GUYADER',         'Pascal',      'MEDEF',   'employeurs', 'titulaire', null),
  ('LEJOSNE',            'Richard',     'MEDEF',   'employeurs', 'titulaire', null),
  ('MORIN',              'David',       'MEDEF',   'employeurs', 'titulaire', null),
  ('PALLE-GUILLABERT',   'Françoise',   'MEDEF',   'employeurs', 'titulaire', null),
  ('RAES',               'Clotilde',    'CPME',    'employeurs', 'titulaire', null),
  ('SAINT-OUEN',         'Marc',        'MEDEF',   'employeurs', 'titulaire', null),
  ('TULARD',             'Pierre',      'MEDEF',   'employeurs', 'titulaire', null),
  ('BILLEBAULT',         'Christian',   'CFTC',    'salaries',   'titulaire', null),
  ('BRAJEVIC',           'Diana',       'CFTC',    'salaries',   'titulaire', null),
  ('COUTAUD',            'Patrick',     'CGT-FO',  'salaries',   'titulaire', null),
  ('FRANCESCHINI',       'Laurence',    'CFE-CGC', 'salaries',   'titulaire', null),
  ('HAMDAOUI',           'Jamel',       'CFE-CGC', 'salaries',   'titulaire', null),
  ('ITIM',               'Ourida',      'CFDT',    'salaries',   'titulaire', null),
  ('LOUVET',             'Raphaël',     'CGT',     'salaries',   'titulaire', null),
  ('PARINET',            'Michel',      'CFTC',    'salaries',   'titulaire', null),
  ('PELLARIN',           'Pascale',     'CFDT',    'salaries',   'titulaire', null),
  ('PERIOU',             'Mickael',     'CGT',     'salaries',   'titulaire', null),
  ('RASSIF',             'Mohamed',     'CGT',     'salaries',   'titulaire', null),
  ('SEGURA',             'Laurence',    'CFDT',    'salaries',   'titulaire', null),
  ('TECHER',             'Jacques',     'CGT-FO',  'salaries',   'titulaire', null),
  ('VEITL',              'Sylvia',      'CGT-FO',  'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 8 — CARCEPT (F150)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F150' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('BARRE',             'Pascal',        'FNTR',   'employeurs', 'titulaire', 'Président'),
  ('HUGON',             'Éric',          'CFDT',   'salaries',   'titulaire', 'Vice-président'),
  ('SCHMIDT DE LA BRÉLIE','Christian',   null::text,null::text,  'invite',    'Directeur général'),
  ('BARRAULT',          'Jean-Sébastien','FNTV',   'employeurs', 'titulaire', null::text),
  ('BRES',              'Jean-Luc',      'FNTR',   'employeurs', 'titulaire', null),
  ('CHARGROS',          'Olivier',       'TLF',    'employeurs', 'titulaire', null),
  ('DUPONT',            'Hubert',        'FNTR',   'employeurs', 'titulaire', null),
  ('GACIA',             'Nicolas',       'FNTR',   'employeurs', 'titulaire', null),
  ('GRAVELLIER',        'Patrice',       'TLF',    'employeurs', 'titulaire', null),
  ('LECHAPTOIS',        'Laurence',      'FNTR',   'employeurs', 'titulaire', null),
  ('LEFEBVRE',          'Nadine',        'WAGONS-LITS','employeurs','titulaire',null),
  ('MAGAR',             'Nicole',        'OTRE',   'employeurs', 'titulaire', null),
  ('NOËL',              'Nancy',         'TLF',    'employeurs', 'titulaire', null),
  ('PELLETIER',         'Yannick',       'TLF',    'employeurs', 'titulaire', null),
  ('RIVERA',            'Jean-Marc',     'OTRE',   'employeurs', 'titulaire', null),
  ('SEYT',              'Michel',        'FNTV',   'employeurs', 'titulaire', null),
  ('BOURGEON',          'Stéphane',      'CFDT',   'salaries',   'titulaire', null),
  ('BRUCHON-BIENFAIT',  'Frédéric',      'CGT-FO', 'salaries',   'titulaire', null),
  ('CADART',            'Guillaume',     'CFTC',   'salaries',   'titulaire', null),
  ('DELAUNAY',          'Jean-Louis',    'CGT',    'salaries',   'titulaire', null),
  ('DROGOUL-SPANU',     'David',         'CGT',    'salaries',   'titulaire', null),
  ('DOS SANTOS',        'Jean-Pierre',   'CFE-CGC','salaries',   'titulaire', null),
  ('DOUINE',            'Thierry',       'CFTC',   'salaries',   'titulaire', null),
  ('DUBAU',             'Jean-Marc',     'CFDT',   'salaries',   'titulaire', null),
  ('MARTINS',           'Fernando',      'CGT-FO', 'salaries',   'titulaire', null),
  ('NUZZO',             'Christian',     'CGT-FO', 'salaries',   'titulaire', null),
  ('SAADOUNE',          'Driss',         'CGT',    'salaries',   'titulaire', null),
  ('SCHIRM',            'Denis',         'CFDT',   'salaries',   'titulaire', null),
  ('TERNOIS',           'Pierrick',      'CFDT',   'salaries',   'titulaire', null),
  ('THIEFAINE',         'Aniela',        'CGT',    'salaries',   'titulaire', null),
  ('BACHY',             'Sandrine',      'FNTR',   'employeurs', 'suppleant', null),
  ('BERNON',            'Marion',        'TLF',    'employeurs', 'suppleant', null),
  ('DICOSTANZO',        'Christophe',    'OTRE',   'employeurs', 'suppleant', null),
  ('GILBERT-PERRON',    'Herveline',     'FNTR',   'employeurs', 'suppleant', null),
  ('HUNAULT',           'Dominique',     'FNTV',   'employeurs', 'suppleant', null),
  ('ETHEVE',            'Olivier',       'CFDT',   'salaries',   'suppleant', null),
  ('FLOQUET',           'Yves',          'CFE-CGC','salaries',   'suppleant', null),
  ('GERMANY',           'François',      'CGT',    'salaries',   'suppleant', null),
  ('PEYROT',            'Nicolas',       'CFTC',   'salaries',   'suppleant', null),
  ('POTKRAJAC',         'Ksenija',       'CGT-FO', 'salaries',   'suppleant', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 9 — MALAKOFF HUMANIS Agirc-Arrco (F509)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F509' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('DUMAS',          'Christophe',  'CFE-CGC', 'salaries',   'titulaire', 'Président'),
  ('WEILL',          'Bernard',     'MEDEF',   'employeurs', 'titulaire', 'Vice-président'),
  ('SAUNIER',        'Thomas',      null::text,null::text,   'invite',    'Directeur général'),
  ('BERTHIER',       'Lysiane',     'MEDEF',   'employeurs', 'titulaire', null::text),
  ('BONDONNEAU',     'Nicolas',     'MEDEF',   'employeurs', 'titulaire', null),
  ('BUTTERBACH',     'Mikaël',      'MEDEF',   'employeurs', 'titulaire', null),
  ('CHAUVET',        'Bertand',     'MEDEF',   'employeurs', 'titulaire', null),
  ('DAUBIGNEY',      'Pierre-Luc',  'CPME',    'employeurs', 'titulaire', null),
  ('DEDRICHE',       'Isabelle',    'MEDEF',   'employeurs', 'titulaire', null),
  ('FERRAND',        'Sabine',      'CPME',    'employeurs', 'titulaire', null),
  ('GARCZYNSKI',     'Gilles',      'MEDEF',   'employeurs', 'titulaire', null),
  ('GROISY',         'Pierre',      'MEDEF',   'employeurs', 'titulaire', null),
  ('LAQUEILLE',      'Yves',        'MEDEF',   'employeurs', 'titulaire', null),
  ('LECLERCQ',       'Philippe',    'U2P',     'employeurs', 'titulaire', null),
  ('MAGNAN',         'Géraldine',   'MEDEF',   'employeurs', 'titulaire', null),
  ('RENAUD',         'Hélène',      'MEDEF',   'employeurs', 'titulaire', null),
  ('SEVAULT',        'Patricia',    'MEDEF',   'employeurs', 'titulaire', null),
  ('BELQASMI',       'Rachida',     'CGT',     'salaries',   'titulaire', null),
  ('BZIOUI',         'Nada',        'CGT-FO',  'salaries',   'titulaire', null),
  ('COUSIN',         'Carole',      'CFTC',    'salaries',   'titulaire', null),
  ('CRAPAT',         'Karine',      'CFTC',    'salaries',   'titulaire', null),
  ('DEHELLE-MIGNOT', 'Valérie',     'CFE-CGC', 'salaries',   'titulaire', null),
  ('FRAYSSE',        'Philippe',    'CGT-FO',  'salaries',   'titulaire', null),
  ('GAUTRON',        'Alain',       'CGT-FO',  'salaries',   'titulaire', null),
  ('LE COQ',         'Xavier',      'CFE-CGC', 'salaries',   'titulaire', null),
  ('NINGRES',        'Catherine',   'CGT',     'salaries',   'titulaire', null),
  ('PELLE',          'Denis',       'CFDT',    'salaries',   'titulaire', null),
  ('PLUQUIN',        'Pierre',      'CGT',     'salaries',   'titulaire', null),
  ('ROMAIN',         'Frédéric',    'CFTC',    'salaries',   'titulaire', null),
  ('ROUSSET',        'Marie-Pierre','CFDT',    'salaries',   'titulaire', null),
  ('TALDIR',         'Sonia',       'CFDT',    'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 10 — MALAKOFF HUMANIS INTERNATIONAL (F280)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F280' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('MARTY',             'Carmen',    'CFDT',    'salaries',   'titulaire', 'Présidente'),
  ('VEZZARO',           'Marc',      'MEDEF',   'employeurs', 'titulaire', 'Vice-président'),
  ('SAUNIER',           'Thomas',    null::text,null::text,   'invite',    'Directeur général'),
  ('BENOIST',           'Xavier',    'CPME',    'employeurs', 'titulaire', null::text),
  ('COTTALORDA',        'Thierry',   'MEDEF',   'employeurs', 'titulaire', null),
  ('DALY',              'Mimsy',     'MEDEF',   'employeurs', 'titulaire', null),
  ('DE DAMAS-NOTTIN',   'Odile',     'MEDEF',   'employeurs', 'titulaire', null),
  ('JAMBIN MOREAU',     'Mary',      'MEDEF',   'employeurs', 'titulaire', null),
  ('LAFLEUR',           'Alexandre', 'MEDEF',   'employeurs', 'titulaire', null),
  ('LLORET',            'Sylvie',    'MEDEF',   'employeurs', 'titulaire', null),
  ('OCHIDA',            'Daniel',    'MEDEF',   'employeurs', 'titulaire', null),
  ('ZAOUI',             'Valérie',   'MEDEF',   'employeurs', 'titulaire', null),
  ('CERAN JERUSALEMY',  'Huimata',   'CGT-FO',  'salaries',   'titulaire', null),
  ('KADOOKA',           'Thierry',   'CFE-CGC', 'salaries',   'titulaire', null),
  ('LEFEBVRE BLAISOT',  'Jordane',   'CFE-CGC', 'salaries',   'titulaire', null),
  ('PIGNAULT',          'Sonia',     'CGT',     'salaries',   'titulaire', null),
  ('SERIEYSSOL',        'Evelyne',   'CFTC',    'salaries',   'titulaire', null),
  ('WEJIEME',           'Victor',    'CGT',     'salaries',   'titulaire', null),
  ('YAN',               'Tu',        'CFDT',    'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 11 — ALLIANCE PROFESSIONNELLE RETRAITE (C001)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'C001' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('BALARESQUE',  'Pierre',        'MEDEF',   'employeurs', 'titulaire', 'Président'),
  ('ROPERT',      'Jean-François', 'CGT',     'salaries',   'titulaire', 'Vice-président'),
  ('NAERHUYSEN',  'Hervé',         null::text,null::text,   'invite',    'Directeur général'),
  ('BARTHOLOMÉ',  'Francis',       'CPME',    'employeurs', 'titulaire', null::text),
  ('DAUNE',       'Philippe',      'MEDEF',   'employeurs', 'titulaire', null),
  ('DUCROT',      'Pascal',        'MEDEF',   'employeurs', 'titulaire', null),
  ('LAMAISON',    'Valérie',       'MEDEF',   'employeurs', 'titulaire', null),
  ('LECHNER',     'Joseph',        'MEDEF',   'employeurs', 'titulaire', null),
  ('LOMBRY',      'Jean-Hugues',   'MEDEF',   'employeurs', 'titulaire', null),
  ('MEYER',       'Alexis',        'MEDEF',   'employeurs', 'titulaire', null),
  ('POSTEL',      'Corine',        'U2P',     'employeurs', 'titulaire', null),
  ('POUDEROUX',   'Noël',          'U2P',     'employeurs', 'titulaire', null),
  ('ROUX',        'Patrick',       'CPME',    'employeurs', 'titulaire', null),
  ('SIBILLE',     'Frédéric',      'MEDEF',   'employeurs', 'titulaire', null),
  ('THAMIN',      'Bertrand',      'MEDEF',   'employeurs', 'titulaire', null),
  ('TRIAS',       'Guillaume',     'MEDEF',   'employeurs', 'titulaire', null),
  ('VINÉ',        'Pascal',        'MEDEF',   'employeurs', 'titulaire', null),
  ('BRONDINO',    'Jean-Claude',   'CFTC',    'salaries',   'titulaire', null),
  ('DELÉTOILE',   'Emmanuel',      'CFDT',    'salaries',   'titulaire', null),
  ('LÉ',          'Sylvain',       'CGT-FO',  'salaries',   'titulaire', null),
  ('LEROUX',      'Catherine',     'CFE-CGC', 'salaries',   'titulaire', null),
  ('MERCY',       'Patrick',       'CGT',     'salaries',   'titulaire', null),
  ('MONPEURT',    'Alain',         'CFE-CGC', 'salaries',   'titulaire', null),
  ('NOLEVAL',     'Thierry',       'CGT-FO',  'salaries',   'titulaire', null),
  ('PANTANELLA',  'Bruno',         'CFDT',    'salaries',   'titulaire', null),
  ('PINEAU',      'Valérie',       'CGT',     'salaries',   'titulaire', null),
  ('ROUSSEL',     'Pascal',        'CFDT',    'salaries',   'titulaire', null),
  ('SABATIER',    'Rolland',       'CFTC',    'salaries',   'titulaire', null),
  ('SACQUÉPÉE',   'Patrice',       'CGT-FO',  'salaries',   'titulaire', null),
  ('SERPAUD',     'François',      'CFE-CGC', 'salaries',   'titulaire', null),
  ('SOUDIERE',    'Jean-Luc',      'CFTC',    'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;

-- ============================================================
-- MANDATS IRC 12 — IRCOM Agirc-Arrco (F800)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F800' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('MONLOUIS',     'Stéphane',      'MEDEF',    'employeurs', 'titulaire', 'Président'),
  ('ORNEM',        'Georges',       'CFTC',     'salaries',   'titulaire', 'Vice-président'),
  ('CRESSON',      'Jeff',          null::text,  null::text,  'invite',    'Directeur général'),
  ('DUVAL',        'Jean-François', 'MEDEF',    'employeurs', 'titulaire', null::text),
  ('FICHAU',       'Xavier',        'MEDEF',    'employeurs', 'titulaire', null),
  ('GIRARDOT',     'Jérôme',        'MEDEF',    'employeurs', 'titulaire', null),
  ('JACQUIER',     'Fabrice',       'CPME',     'employeurs', 'titulaire', null),
  ('LEFRANC',      'Reine-Véronique','CPME',    'employeurs', 'titulaire', null),
  ('PAVIUS',       'Valérie',       'MEDEF',    'employeurs', 'titulaire', null),
  ('ADOLPHE',      'Agnès',         'CGTM-FSM', 'salaries',   'titulaire', null),
  ('CHEVIOT',      'Marcus',        'CSTM',     'salaries',   'titulaire', null),
  ('DETONNE',      'Patrick',       'CFDT',     'salaries',   'titulaire', null),
  ('GALIBOU',      'Louis-Pascal',  'CDMT',     'salaries',   'titulaire', null),
  ('HERVE',        'Louis-Jean',    'CFE-CGC',  'salaries',   'titulaire', null),
  ('JEAN-GILLES',  'Carole',        'CGT-FO',   'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;
