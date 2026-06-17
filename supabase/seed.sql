-- ============================================================
-- SEED — Données annuaire 2025
-- ============================================================

-- Organisations signataires
insert into organisations (sigle, nom, college, adresse, tel, web) values
  ('MEDEF',   'Mouvement des entreprises de France',                    'employeurs', '55, av. Bosquet — 75330 PARIS CEDEX 07',           '01 53 59 19 19', 'medef.com'),
  ('CPME',    'Confédération des petites et moyennes entreprises',      'employeurs', '10, terrasse Bellini — 92806 PUTEAUX CEDEX',        '01 47 62 73 73', 'cpme.fr'),
  ('U2P',     'Union des entreprises de proximité',                     'employeurs', '53, rue Ampère — 75017 PARIS',                     '01 47 63 31 31', 'u2p-france.fr'),
  ('CFDT',    'Confédération française démocratique du travail',        'salaries',  '4, bd de la Villette — 75955 PARIS CEDEX 19',      '01 42 03 80 00', 'cfdt.fr'),
  ('CFE-CGC', 'Confédération française de l''encadrement CGC',          'salaries',  '59, rue du Rocher — 75008 PARIS',                  '01 55 30 12 12', 'cfecgc.org'),
  ('CFTC',    'Confédération française des travailleurs chrétiens',     'salaries',  '45, rue de la Procession — 75739 PARIS CEDEX 15',  '01 73 30 49 00', 'cftc.fr'),
  ('CGT',     'Confédération générale du travail',                      'salaries',  '263, rue de Paris — 93516 MONTREUIL CEDEX',        '01 55 82 82 22', 'cgt.fr'),
  ('CGT-FO',  'Confédération générale du travail – Force ouvrière',     'salaries',  '141, av. du Maine — 75680 PARIS CEDEX 14',        '01 40 52 82 00', 'force-ouvriere.fr');

-- Groupes GPS (14)
insert into groupes_gps (nom, siege, tel, web, directeur_general, date_creation, historique) values
  ('AG2R LA MONDIALE',  '14-16, bd Malesherbes — 75379 PARIS CEDEX 08', '01 43 95 50 50', 'ag2rlamondiale.fr',   'Fabrice HEYRIES',               '2004-01-01', 'Rapprochement PRÉMALLIANCE (2013), RÉUNICA (2015)'),
  ('APICIL',            '51, bd Marius Vivier Merle — 69003 LYON',       '04 72 27 71 71', 'apicil.com',          'Philippe BARRET',               '1997-01-01', 'Ex APICIL-AGIRA'),
  ('BTPR',              'Rue Amédée-Abarre — 97139 ABYMES',              '05 90 82 22 57', null,                  'Raoul LEBRAVE',                 '2002-07-01', 'Antilles-Guyane'),
  ('CGRR',              'Immeuble Le Papillon, Bd Marsin — 97139 LES ABYMES', '05 90 21 20 20', 'cgrr.fr',       'Lionel MOUNGALI',               '1973-07-01', 'Rattaché AG2R LA MONDIALE au 01/01/2019'),
  ('CRC',               '2 bis, ruelle Pavée — 97482 SAINT-DENIS CEDEX', '02 62 90 01 00', 'groupecrc.com',      'Thierry BENBASSAT',             '1997-10-01', 'La Réunion'),
  ('IRCEM',             '261, av. des Nations-Unies — 59672 ROUBAIX',    '03 20 45 57 00', 'ircem.com',           'Serge DA MARIANA',              '2000-01-01', null),
  ('KLESIA',            '4, rue Georges Picquart — 75017 PARIS',         '01 71 39 15 15', 'klesia.fr',           'Christian SCHMIDT DE LA BRÉLIE','2012-07-04', 'Fusion D&O + MORNAY'),
  ('MALAKOFF HUMANIS',  '21, rue Laffitte — 75317 PARIS CEDEX 09',       '01 56 03 34 56', 'malakoffhumanis.com', 'Thomas SAUNIER',                '2019-01-01', 'Fusion Humanis + Malakoff Médéric (2019), renommé 2020'),
  ('GROUPE AGRICA',     '21, rue de la Bienfaisance — 75382 PARIS CEDEX 08', '01 71 21 00 00', 'groupagrica.com', 'Julien BRAMI',                  '1997-02-01', 'Associé ALLIANCE PROFESSIONNELLE'),
  ('AUDIENS',           '74, rue Jean Bleuzen — 92177 VANVES CEDEX',     '01 73 17 30 00', 'audiens.org',         'Frédéric OLIVENNES',            '2003-01-01', 'Associé ALLIANCE PROFESSIONNELLE'),
  ('B2V',               '4, pl. des Saisons — 92926 LA DÉFENSE CEDEX',   '01 49 07 30 00', 'b2v.fr',              'Denis CAMPAGNA',                '2005-01-01', 'Associé ALLIANCE PROFESSIONNELLE. Ex BCP + UCREPPSA'),
  ('IRP AUTO',          '39, av. d''Iéna — 75202 PARIS CEDEX 16',        '01 40 69 40 40', 'irp-auto.com',        'Jules SITBON',                  '1985-01-01', 'Associé ALLIANCE PROFESSIONNELLE'),
  ('LOURMEL',           '108, rue de Lourmel — 75718 PARIS CEDEX 15',    '01 40 60 20 00', 'lourmel.com',         'Yann QUÉRÉ',                    '1994-01-01', 'Associé ALLIANCE PROFESSIONNELLE'),
  ('PRO BTP',           '7, rue du Regard — 75294 PARIS CEDEX 06',       '01 49 54 40 00', 'probtp.com',          'Hervé NAERHUYSEN',              '1993-01-01', 'Associé ALLIANCE PROFESSIONNELLE');

-- Institutions IRC (12)
with gps as (select id, nom from groupes_gps)
insert into institutions_irc (nom, code_csn, categorie, gps_id, siege, tel, agrement, directeur_general, date_renouvellement)
select
  i.nom, i.code_csn, i.categorie::text, gps.id,
  i.siege, i.tel, i.agrement, i.dg, i.renouvellement::date
from (values
  ('AG2R Agirc-Arrco',                           'F700', 'interprofessionnelle', 'AG2R LA MONDIALE',  '14-16, bd Malesherbes — 75379 PARIS',    '01 43 95 50 50', '6 jan 1951 – n°530',     'Fabrice HEYRIES',               '2023-01-01'),
  ('APICIL Agirc-Arrco',                         'F501', 'interprofessionnelle', 'APICIL',            '51, bd Marius Vivier Merle — 69003 LYON','04 72 27 71 71', null,                      'Philippe BARRET',               '2023-01-01'),
  ('BTPR Agirc-Arrco',                           'F820', 'dom',                  'BTPR',              'Rue Amédée-Abarre — 97139 ABYMES',       '05 90 82 22 57', '7 août 1975 – n°932/A',   'Raoul LEBRAVE',                 '2023-04-28'),
  ('CARCEPT',                                    'F150', 'interprofessionnelle', 'KLESIA',            '4, rue Georges Picquart — 75017 PARIS',  '01 71 39 15 15', '3 oct 1955 – n°150',      'Christian SCHMIDT DE LA BRÉLIE','2023-06-22'),
  ('CGRR Agirc-Arrco',                           'F810', 'dom',                  'CGRR',              'Lieu-dit Dothémare — 97139 LES ABYMES',  '05 90 21 20 20', '10 mai 1974 – n°926/A',   'Lionel MOUNGALI',               '2023-01-17'),
  ('CRR Agirc-Arrco',                            'F830', 'dom',                  'CRC',               '2 bis, ruelle Pavée — 97482 SAINT-DENIS','02 62 90 01 00', '22 juil 1977 – n°944/A',  'Thierry BENBASSAT',             '2022-12-15'),
  ('IRCEM Agirc-Arrco',                          'F155', 'professionnelle',      'IRCEM',             '261, av. des Nations-Unies — 59672 ROUBAIX','03 20 45 57 00','14 fév 1973 – n°920',   'Serge DA MARIANA',              '2023-01-01'),
  ('IRCOM Agirc-Arrco',                          'F800', 'dom',                  null,                'Immeuble La Verrière — 97205 FORT-DE-FRANCE','05 96 55 61 00',null,                   'Jeff CRESSON',                  '2022-12-09'),
  ('KLESIA Agirc-Arrco',                         'F020', 'interprofessionnelle', 'KLESIA',            '4, rue Georges Picquart — 75017 PARIS',  '01 71 39 15 15', '4 juin 1952 – n°576/A',   'Christian SCHMIDT DE LA BRÉLIE','2023-06-22'),
  ('MALAKOFF HUMANIS Agirc-Arrco',               'F509', 'interprofessionnelle', 'MALAKOFF HUMANIS',  '21, rue Laffitte — 75317 PARIS',         '01 56 03 34 56', '26 sept 1957 – n°743',    'Thomas SAUNIER',                '2024-01-01'),
  ('MALAKOFF HUMANIS INTERNATIONAL Agirc-Arrco', 'F280', 'interprofessionnelle', 'MALAKOFF HUMANIS',  '21, rue Laffitte — 75317 PARIS',         '01 56 03 34 56', '19 nov 1949 – n°369',     'Thomas SAUNIER',                '2023-01-01'),
  ('ALLIANCE PROFESSIONNELLE RETRAITE Agirc-Arrco','C001','interprofessionnelle',null,                '7, rue du Regard — 75006 PARIS',         '01 49 54 40 00', '26 mars 2018 – n°812',    'Hervé NAERHUYSEN',              '2023-06-14')
) as i(nom, code_csn, categorie, gps_nom, siege, tel, agrement, dg, renouvellement)
left join gps on gps.nom = i.gps_nom;

-- Instances fédérales
insert into instances (nom, type, nb_membres, duree_mandat, date_renouvellement, president, vice_president) values
  ('Commission paritaire',               'federale',      30, null, null,         null,                        null),
  ('Assemblée générale',                 'federale',      60,    4, '2024-01-01', null,                        null),
  ('Conseil d''administration',          'federale',      50,    4, '2023-01-01', 'Diane MILLERON-DEPERROIS',  'Brigitte PISA'),
  ('Bureau du conseil d''administration','federale',      10,    2, null,         'Diane MILLERON-DEPERROIS',  'Brigitte PISA'),
  ('Commission administrative et informatique','federale',20, null, null,         'Gérard MARDINÉ',            'Diane MILLERON-DEPERROIS'),
  ('Commission technique et financière', 'federale',      20, null, null,         'André-Guy TUROCHE',         'Marc AMBIAUX'),
  ('Commission d''action sociale',       'federale',      20, null, null,         'Pierre PLUQUIN',            'Pascal LE GUYADER'),
  ('Commission d''audit et des risques', 'federale',      10,    4, null,         'Nicolas BONDONNEAU',        'Frédéric ROMAIN'),
  ('Instance de coordination Agirc-Arrco–CTIP','commune', 10, null, null,         null,                        null),
  ('Comité des directeurs généraux',     'operationnelle',null,null, null,        'François-Xavier SELLERET',  null),
  ('Comité des opérations',              'operationnelle',null,null, null,        'François-Xavier SELLERET',  null);

-- Personnes
insert into personnes (nom, prenom) values
  ('SELLERET',             'François-Xavier'),
  ('AMAR',                 'Frédéric'),
  ('MILLERON-DEPERROIS',   'Diane'),
  ('PISA',                 'Brigitte'),
  ('BONDONNEAU',           'Nicolas'),
  ('GAULTIER',             'Nadège'),
  ('GINDRE',               'Denis'),
  ('MICOR',                'Thierry'),
  ('TOUSCH',               'Clara'),
  ('SOUPIZET',             'Christophe'),
  ('VIGNON',               'Jean-Jacques'),
  ('HAUTIN',               'Agnès'),
  ('MARDINÉ',              'Gérard'),
  ('THIEFFINNE',           'Christelle'),
  ('LECERF',               'Christine'),
  ('ROMAIN',               'Frédéric'),
  ('CRÉTIER',              'Christian'),
  ('BEAUGAS',              'Michel'),
  ('DRIEU',                'Alain'),
  ('DURANT',               'Sylvie'),
  ('LEMAISTRE',            'Pascale'),
  ('COLOMAR',              'Jean'),
  ('GRÉGOIRE',             'Thierry'),
  ('BENJAMIN',             'Alain'),
  ('CARMI',                'Nicolas'),
  ('SCHERDING',            'Roland'),
  ('CLAIR',                'Michel'),
  ('BARRE',                'Pascal'),
  ('DUMAS',                'Christophe'),
  ('MARTY',                'Carmen'),
  ('BALARESQUE',           'Pierre'),
  ('MONLOUIS',             'Stéphane'),
  ('HEYRIES',              'Fabrice'),
  ('BARRET',               'Philippe'),
  ('LEBRAVE',              'Raoul'),
  ('MOUNGALI',             'Lionel'),
  ('BENBASSAT',            'Thierry'),
  ('DA MARIANA',           'Serge'),
  ('SCHMIDT DE LA BRÉLIE', 'Christian'),
  ('SAUNIER',              'Thomas'),
  ('NAERHUYSEN',           'Hervé'),
  ('CRESSON',              'Jeff'),
  ('TUROCHE',              'André-Guy'),
  ('AMBIAUX',              'Marc'),
  ('LE GUYADER',           'Pascal'),
  ('PLUQUIN',              'Pierre');

-- Mandats 2025
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id, i.id, o.id, m.fonction, m.college, m.statut, 2025
from (values
  -- Direction fédération
  ('SELLERET',           'François-Xavier', 'Conseil d''administration',           null,      null,         'invite',    'Directeur général'),
  -- Présidence CA
  ('MILLERON-DEPERROIS', 'Diane',           'Conseil d''administration',           'MEDEF',   'employeurs', 'titulaire', 'Présidente'),
  ('PISA',               'Brigitte',        'Conseil d''administration',           'CFDT',    'salaries',   'titulaire', 'Vice-présidente'),
  -- Bureau CA
  ('MILLERON-DEPERROIS', 'Diane',           'Bureau du conseil d''administration', 'MEDEF',   'employeurs', 'titulaire', 'Présidente'),
  ('PISA',               'Brigitte',        'Bureau du conseil d''administration', 'CFDT',    'salaries',   'titulaire', 'Vice-présidente'),
  ('BONDONNEAU',         'Nicolas',         'Bureau du conseil d''administration', 'MEDEF',   'employeurs', 'titulaire', 'Membre'),
  ('HAUTIN',             'Agnès',           'Bureau du conseil d''administration', 'U2P',     'employeurs', 'titulaire', 'Membre'),
  ('SOUPIZET',           'Christophe',      'Bureau du conseil d''administration', 'CPME',    'employeurs', 'titulaire', 'Membre'),
  ('BEAUGAS',            'Michel',          'Bureau du conseil d''administration', 'CGT-FO',  'salaries',   'titulaire', 'Membre'),
  ('MARDINÉ',            'Gérard',          'Bureau du conseil d''administration', 'CFE-CGC', 'salaries',   'titulaire', 'Membre'),
  ('PLUQUIN',            'Pierre',          'Bureau du conseil d''administration', 'CGT',     'salaries',   'titulaire', 'Membre'),
  ('ROMAIN',             'Frédéric',        'Bureau du conseil d''administration', 'CFTC',    'salaries',   'titulaire', 'Membre'),
  -- Commission paritaire — employeurs
  ('BONDONNEAU',         'Nicolas',         'Commission paritaire',               'MEDEF',   'employeurs', 'titulaire', 'Membre'),
  ('GAULTIER',           'Nadège',          'Commission paritaire',               'MEDEF',   'employeurs', 'titulaire', 'Membre'),
  ('GINDRE',             'Denis',           'Commission paritaire',               'MEDEF',   'employeurs', 'titulaire', 'Membre'),
  ('MICOR',              'Thierry',         'Commission paritaire',               'MEDEF',   'employeurs', 'titulaire', 'Membre'),
  ('MILLERON-DEPERROIS', 'Diane',           'Commission paritaire',               'MEDEF',   'employeurs', 'titulaire', 'Membre'),
  ('TOUSCH',             'Clara',           'Commission paritaire',               'MEDEF',   'employeurs', 'titulaire', 'Membre'),
  ('SOUPIZET',           'Christophe',      'Commission paritaire',               'CPME',    'employeurs', 'titulaire', 'Membre'),
  ('VIGNON',             'Jean-Jacques',    'Commission paritaire',               'CPME',    'employeurs', 'titulaire', 'Membre'),
  ('HAUTIN',             'Agnès',           'Commission paritaire',               'U2P',     'employeurs', 'titulaire', 'Membre'),
  -- Commission paritaire — salariés
  ('PISA',               'Brigitte',        'Commission paritaire',               'CFDT',    'salaries',   'titulaire', 'Membre'),
  ('MARDINÉ',            'Gérard',          'Commission paritaire',               'CFE-CGC', 'salaries',   'titulaire', 'Membre'),
  ('THIEFFINNE',         'Christelle',      'Commission paritaire',               'CFE-CGC', 'salaries',   'titulaire', 'Membre'),
  ('LECERF',             'Christine',       'Commission paritaire',               'CFTC',    'salaries',   'titulaire', 'Membre'),
  ('ROMAIN',             'Frédéric',        'Commission paritaire',               'CFTC',    'salaries',   'titulaire', 'Membre'),
  ('CRÉTIER',            'Christian',       'Commission paritaire',               'CGT-FO',  'salaries',   'titulaire', 'Membre'),
  ('BEAUGAS',            'Michel',          'Commission paritaire',               'CGT-FO',  'salaries',   'titulaire', 'Membre'),
  ('DRIEU',              'Alain',           'Commission paritaire',               'CGT',     'salaries',   'titulaire', 'Membre'),
  ('DURANT',             'Sylvie',          'Commission paritaire',               'CGT',     'salaries',   'titulaire', 'Membre')
) as m(nom, prenom, instance_nom, org_sigle, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
join instances i on i.nom = m.instance_nom
left join organisations o on o.sigle = m.org_sigle;
