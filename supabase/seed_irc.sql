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
  ('F700', '2023-01-01', 'Rémi BENARD',    'François GERMAIN'),
  ('F501', '2023-01-01', 'Éric FOURNIER',          'Denis FAURE'),
  ('F820', '2023-04-28', 'Marc MUNIER',      'Audrey ROSSIGNOL'),
  ('F810', '2023-01-17', 'Bertrand BRUNET',        'Mélodie REMY'),
  ('F830', '2022-12-15', 'Danielle FABRE',         'Corinne DUPONT'),
  ('F155', '2023-01-01', 'Noël NAVARRO',      'Christine DESCHAMPS'),
  ('F020', '2023-06-22', 'Émilie FOURNEAU',          'Isaure MARIN'),
  ('F150', '2023-06-22', 'Audrey BLANCHARD',          'Matthieu POTIER'),
  ('F509', '2024-01-01', 'Jean-François LARUE',      'Aurélie ROYER'),
  ('F280', '2023-01-01', 'Sonia CHARTON',          'André ROCHARD'),
  ('C001', '2023-06-14', 'André BERNARD',     'Jordan MAUBERT'),
  ('F800', '2022-12-09', 'Thibault DAVY',     'Wilfrid DUFOUR')
) as d(csn, renouv, president, vp)
join institutions_irc irc on irc.code_csn = d.csn;

-- ============================================================
-- PERSONNES — tous les membres des 12 CA
-- ============================================================
insert into personnes (nom, prenom) values
  -- AG2R (F700)
  ('AUGER', 'Alexia'),
  ('CORNET', 'Céline'),
  ('DELARUE', 'Christian'),
  ('GERARD', 'Florence'),
  ('PICARD', 'Martine'),
  ('ROUSSEL', 'Nathalie'),
  ('CAILLE', 'Serge'),
  ('DENIZET', 'Tiphaine'),
  ('DUJARDIN', 'Willy'),
  ('POULAIN', 'Alain'),
  ('ROSIER', 'Arthur'),
  ('SALMON', 'Axelle'),
  ('BERTRAND', 'Antoine'),
  ('CHARPENTIER', 'Bruno'),
  ('DURAND', 'Cyrille'),
  ('COLIN', 'Catherine'),
  ('DUBOIS', 'Claude'),
  ('FORGET', 'Élisabeth'),
  ('GUILLON', 'Guy'),
  ('HUMBERT', 'Inès'),
  ('PAGEOT', 'Marie-Claire'),
  ('CAZIN', 'Simon'),
  ('MOUTIER', 'Mikaël'),
  ('PENOT', 'Timour'),
  ('SARRAZIN', 'Bénédicte'),
  -- APICIL (F501)
  ('FAURE', 'Denis'),
  ('AUBERT', 'Albert'),
  ('FERRAND', 'Diego'),
  ('LEROY', 'Joëlle'),
  ('MEUNIER', 'Lionel'),
  ('MONNET', 'Lucas'),
  ('POIRIER', 'Mathilde'),
  ('BALLAND', 'Priscille'),
  ('BREDEL', 'Sara'),
  ('COMBE', 'Sylvie'),
  ('DION', 'Victor'),
  ('FRADET', 'Adrienne'),
  ('GOURDIN', 'Arsène'),
  ('BOUCHER', 'Baptiste'),
  ('DUVAL', 'Daniel'),
  ('GAILLARD', 'Évelyne'),
  ('GUICHARD', 'Guillaume'),
  ('LEMOINE', 'Jeanne'),
  ('LOISEL', 'Juliette'),
  ('MERCIER', 'Léonie'),
  ('RENAULT', 'Michèle'),
  ('ROY', 'Nicolas'),
  ('CHRETIEN', 'Stéphane'),
  ('DERVAUX', 'Tony'),
  ('NAVARRE', 'Muriel'),
  ('NICOT', 'Olivier-Jean'),
  -- BTPR (F820)
  ('ROSSIGNOL', 'Audrey'),
  ('BARBIER', 'Alexis'),
  ('BOUDIN', 'Bénédicte'),
  ('BOUTIN', 'Benoît'),
  ('CHEVALIER', 'Caroline'),
  ('DEMAILLY', 'Christophe'),
  ('MARQUET', 'Laura'),
  ('THOMAS', 'Nora'),
  ('BICHON', 'Renaud'),
  ('COLLIN', 'Sylvain'),
  ('DETREZ', 'Valentin'),
  ('DUGAST', 'William'),
  ('FLAMENT', 'Yvonne'),
  ('BARON', 'Alice'),
  ('DAUPHIN', 'Charlotte'),
  ('LEGRAND', 'Jean-Pierre'),
  ('MARECHAL', 'Kevin'),
  ('RICHER', 'Morgane'),
  ('ROUSSEAU', 'Natasha'),
  ('BRAULT', 'Sandrine'),
  ('CHATEL', 'Stefan'),
  ('DIDIER', 'Vanessa'),
  ('MICHON', 'Malo'),
  -- CGRR (F810)
  ('REMY', 'Mélodie'),
  ('GIRAUD', 'Frédéric'),
  ('GUERIN', 'Grégoire'),
  ('JACQUET', 'Ingrid'),
  ('LUCAS', 'Karine'),
  ('PERRIN', 'Marion'),
  ('PREVOST', 'Maxime'),
  ('RICHARD', 'Monique'),
  ('AYMARD', 'Pierre-Louis'),
  ('ALLARD', 'Adrien'),
  ('BAZIN', 'Amélie'),
  ('FOUCHARD', 'Élise'),
  ('GODARD', 'Gaëtan'),
  ('NOEL', 'Marie'),
  ('BLAIN', 'Roland'),
  ('BOUSQUET', 'Sandra'),
  -- CRR (F830)
  ('DUPONT', 'Corinne'),
  ('FOULON', 'Emmanuel'),
  ('MICHARD', 'Loïc'),
  ('MORIN', 'Manon'),
  ('BOSSE', 'Samuel'),
  ('GROS', 'Gilles'),
  ('DEVOS', 'Valérie'),
  ('DUPUIS', 'Yann'),
  ('MARCHAND', 'Gwenola'),
  ('POMMIER', 'Achille'),
  ('AUBRY', 'Alexandre'),
  ('BAUDRY', 'Alicia'),
  ('BESNARD', 'Arnaud'),
  ('CHAUVIN', 'Camille'),
  ('FRANC', 'Estelle'),
  ('VALETTE', 'Océane'),
  ('VINCENT', 'Pascale'),
  ('DESPREZ', 'Valentine'),
  ('MANCEAU', 'Florian'),
  -- IRCEM (F155)
  ('DESCHAMPS', 'Christine'),
  ('CARON', 'Brice'),
  ('LEBRUN', 'Jean-Luc'),
  ('ROLLAND', 'Nadia'),
  ('SIMON', 'Noémie'),
  ('ZIMMERMANN', 'Pauline'),
  ('PRIEUR', 'Albert'),
  ('RIOU', 'Amélie'),
  ('RIVET', 'Anaïs'),
  ('COLLET', 'Cécile'),
  ('MONTEIL', 'Lucie'),
  ('ROBIN', 'Nadège'),
  ('ROUX', 'Nathan'),
  ('BIGOT', 'Richard'),
  ('CHATELIN', 'Sophie'),
  ('DANET', 'Théo'),
  ('MARTEL', 'Jocelyne'),
  ('MONNIER', 'Maureen'),
  -- KLESIA (F020)
  ('MARIN', 'Isaure'),
  ('BOISSET', 'Axel'),
  ('DUCHEMIN', 'Clément'),
  ('GILLES', 'François-Xavier'),
  ('GOULET', 'Georges'),
  ('NICOLAS', 'Margot'),
  ('VALLET', 'Odile'),
  ('BEAUMONT', 'Régine'),
  ('BELLANGER', 'Régis'),
  ('DELORME', 'Thomas'),
  ('DUPAS', 'Xavier'),
  ('MAGNIN', 'Fanny'),
  ('MOULIN', 'Michaël'),
  ('RENON', 'Alexis'),
  ('CLEMENT', 'Carole'),
  ('DAVID', 'Chloé'),
  ('GAUDIN', 'Fabrice'),
  ('LOMBARD', 'Julien'),
  ('PAGET', 'Marie-Hélène'),
  ('QUINTIN', 'Mélanie'),
  ('BINET', 'Rodolphe'),
  ('FERRIER', 'Yvette'),
  ('FORTIER', 'Zacharie'),
  ('GAVARD', 'Ambroise'),
  ('MANGIN', 'Geoffroy'),
  ('PARIS', 'Rebecca'),
  ('PEYROT', 'Wenceslas'),
  ('RIGAUD', 'Alicia'),
  -- CARCEPT (F150)
  ('POTIER', 'Matthieu'),
  ('BLANC', 'Arthur'),
  ('DELAUNAY', 'Christelle'),
  ('FERRET', 'Dominique'),
  ('LEBLANC', 'Jean-Jacques'),
  ('MARIN', 'Karl'),
  ('MOREL', 'Ludovic'),
  ('AMIOT', 'Philippe'),
  ('BASTIEN', 'Rachel'),
  ('BORDES', 'Romane'),
  ('DROUET', 'Vincent'),
  ('GAULTIER', 'Alric'),
  ('MARAVAL', 'Gladys'),
  ('PAYAN', 'Tania'),
  ('COUSIN', 'Charles'),
  ('DOUCET', 'Clara'),
  ('DURIEUX', 'Damien'),
  ('HENRY', 'Henri'),
  ('LACROIX', 'Jean'),
  ('JOLY', 'Irène'),
  ('JOUBERT', 'Isabelle'),
  ('LAMBERT', 'Jean-Baptiste'),
  ('CHARLES', 'Solène'),
  ('DUBREUIL', 'Virginie'),
  ('MIGNOT', 'Marguerite'),
  ('NOEL', 'Patrice'),
  ('PICHON', 'Yael'),
  ('PORCHER', 'Adrien'),
  ('BERGER', 'Anaïs'),
  ('BUREAU', 'Boris'),
  ('HUET', 'Hugo'),
  ('MEYER', 'Lise'),
  ('POULIN', 'Maxence'),
  ('LEMAIRE', 'Jean-Yves'),
  ('LOISEAU', 'Julie'),
  ('MERLE', 'Léonard'),
  ('GILBERT', 'Anatole'),
  ('JOLLY', 'Eloïse'),
  -- MALAKOFF HUMANIS (F509)
  ('ROYER', 'Aurélie'),
  ('CARREL', 'Brigitte'),
  ('DUFRESNE', 'Colette'),
  ('FLEURY', 'Édith'),
  ('GODIN', 'Gabriel'),
  ('GUILLET', 'Gwenaëlle'),
  ('LEVEQUE', 'Jonathan'),
  ('MASSON', 'Laurence'),
  ('MOREAU', 'Madeleine'),
  ('VIDAL', 'Pascal'),
  ('BACHELET', 'Pierre-Yves'),
  ('BORY', 'Sabine'),
  ('MANSARD', 'Gérard'),
  ('PAYEN', 'Séverine'),
  ('BOYER', 'Bernadette'),
  ('DUMONT', 'Corentin'),
  ('GARNIER', 'Fabien'),
  ('GAUTHIER', 'Ferdinand'),
  ('HARDY', 'Hélène'),
  ('MALLET', 'Katia'),
  ('MAURY', 'Léa'),
  ('VIOLET', 'Patricia'),
  ('DONZE', 'Victorine'),
  ('FOSSE', 'Zoé'),
  ('MAURY', 'Léa-Marie'),
  ('PERROT', 'Vérane'),
  -- MALAKOFF HUMANIS INTERNATIONAL (F280)
  ('ROCHARD', 'André'),
  ('BUFFET', 'Blanche'),
  ('FREMONT', 'Étienne'),
  ('GIRAULT', 'Gaël'),
  ('GRASSET', 'Ghislaine'),
  ('RENAUD', 'Michel'),
  ('TISSERAND', 'Norbert'),
  ('BILLARD', 'Robert'),
  ('DUCHENE', 'Viviane'),
  ('SAVANT', 'Benjamin'),
  ('FAUCHER', 'David'),
  ('SALIN', 'Nicole'),
  ('BATY', 'Raphaël'),
  ('GUERRIER', 'Augustin'),
  ('PASCAL', 'Roseline'),
  ('RUBIN', 'Axel'),
  ('SANSON', 'Baptiste'),
  -- ALLIANCE PROFESSIONNELLE (C001)
  ('MAUBERT', 'Jordan'),
  ('BONNET', 'Axelle'),
  ('GONTIER', 'Geneviève'),
  ('LARCHER', 'Jean-Claude'),
  ('VASSEUR', 'Olivier'),
  ('ANGLADE', 'Pierre'),
  ('BILLET', 'Robin'),
  ('COLLIGNON', 'Suzanne'),
  ('JARRY', 'Elodie'),
  ('LACAN', 'Emeric'),
  ('MENARD', 'Lucile'),
  ('PELLETIER', 'Théodore'),
  ('PLANTIN', 'Zia'),
  ('REGNARD', 'Alexia'),
  ('ROQUES', 'Arnaud'),
  ('DEVAUX', 'Claire'),
  ('HERBIN', 'Hervé'),
  ('BONIN', 'Romain'),
  ('BERTON', 'René'),
  ('CLAVREUL', 'Stéphanie'),
  ('DELATTRE', 'Thierry'),
  ('DORMOY', 'Véronique'),
  ('FAVIER', 'Yolande'),
  ('GUIMARD', 'Aurélien'),
  ('MAUFRAS', 'Judith'),
  ('MILLOT', 'Marilène'),
  ('MOLINIER', 'Maud'),
  ('PATRY', 'Roxane'),
  ('PEREZ', 'Typhaine'),
  -- IRCOM (F800)
  ('DUFOUR', 'Wilfrid'),
  ('LEFEBVRE', 'Jean-Paul'),
  ('LEVY', 'Joël'),
  ('MOISAN', 'Luc'),
  ('RENARD', 'Mélissa'),
  ('BAUER', 'Raoul'),
  ('FOREST', 'Yves'),
  ('ADAM', 'Achille'),
  ('FONTAINE', 'Édouard'),
  ('HUBERT', 'Hubert'),
  ('MARTIN', 'Laure'),
  ('PEYRE', 'Marjorie'),
  ('ROBIC', 'Mylène')
on conflict (nom, prenom) do nothing;

-- ============================================================
-- MANDATS IRC 1 — AG2R Agirc-Arrco (F700)
-- ============================================================
insert into mandats (personne_id, instance_id, organisation_id, fonction, college, statut, annee_edition)
select p.id,
  (select i.id from instances i join institutions_irc irc on irc.id = i.irc_id where irc.code_csn = 'F700' and i.nom = 'Conseil d''administration'),
  o.id, m.fonction, m.college, m.statut, 2025
from (values
  ('BENARD', 'Rémi',     'MEDEF',   'employeurs', 'titulaire', 'Présidente'),
  ('GERMAIN', 'François',   'CGT-FO',  'salaries',   'titulaire', 'Vice-président'),
  ('PICOT', 'Mathieu',     null::text,null::text,   'invite',    'Directeur général'),
  ('AUGER', 'Alexia',   'U2P',     'employeurs', 'titulaire', null::text),
  ('CORNET', 'Céline',    'MEDEF',   'employeurs', 'titulaire', null),
  ('DELARUE', 'Christian',      'MEDEF',   'employeurs', 'titulaire', null),
  ('GERARD', 'Florence',     'MEDEF',   'employeurs', 'titulaire', null),
  ('PICARD', 'Martine',     'U2P',     'employeurs', 'titulaire', null),
  ('ROUSSEL', 'Nathalie',   'MEDEF',   'employeurs', 'titulaire', null),
  ('CAILLE', 'Serge',       'U2P',     'employeurs', 'titulaire', null),
  ('DENIZET', 'Tiphaine',   'CPME',    'employeurs', 'titulaire', null),
  ('DUJARDIN', 'Willy',        'MEDEF',   'employeurs', 'titulaire', null),
  ('POULAIN', 'Alain',    'CPME',    'employeurs', 'titulaire', null),
  ('ROSIER', 'Arthur','CPME',    'employeurs', 'titulaire', null),
  ('SALMON', 'Axelle',      'MEDEF',   'employeurs', 'titulaire', null),
  ('BERTRAND', 'Antoine',     'CGT',     'salaries',   'titulaire', null),
  ('CHARPENTIER', 'Bruno',   'CFTC',    'salaries',   'titulaire', null),
  ('DURAND', 'Cyrille',        'CFTC',    'salaries',   'titulaire', null),
  ('COLIN', 'Catherine',       'CGT-FO',  'salaries',   'titulaire', null),
  ('DUBOIS', 'Claude',     'CGT',     'salaries',   'titulaire', null),
  ('FORGET', 'Élisabeth',    'CGT-FO',  'salaries',   'titulaire', null),
  ('GUILLON', 'Guy',     'CFE-CGC', 'salaries',   'titulaire', null),
  ('HUMBERT', 'Inès',  'CFDT',    'salaries',   'titulaire', null),
  ('PAGEOT', 'Marie-Claire', 'CFE-CGC', 'salaries',   'titulaire', null),
  ('CAZIN', 'Simon',      'CGT',     'salaries',   'titulaire', null),
  ('HAAS', 'Bastien',    'CFDT',    'salaries',   'titulaire', null),
  ('MOUTIER', 'Mikaël',  'CFDT',    'salaries',   'titulaire', null),
  ('PENOT', 'Timour',     'CFTC',    'salaries',   'titulaire', null),
  ('SARRAZIN', 'Bénédicte',     'CFE-CGC', 'salaries',   'titulaire', null)
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
  ('FOURNIER', 'Éric',          'CGT',     'salaries',   'titulaire', 'Président'),
  ('FAURE', 'Denis',  'MEDEF',   'employeurs', 'titulaire', 'Vice-Président'),
  ('BLONDEL', 'Aurélie',      null::text,null::text,   'invite',    'Directeur général'),
  ('AUBERT', 'Albert',       'MEDEF',   'employeurs', 'titulaire', null::text),
  ('FERRAND', 'Diego',          'MEDEF',   'employeurs', 'titulaire', null),
  ('LEROY', 'Joëlle',       'MEDEF',   'employeurs', 'titulaire', null),
  ('MEUNIER', 'Lionel',       'MEDEF',   'employeurs', 'titulaire', null),
  ('MONNET', 'Lucas',   'MEDEF',   'employeurs', 'titulaire', null),
  ('POIRIER', 'Mathilde',        'MEDEF',   'employeurs', 'titulaire', null),
  ('BALLAND', 'Priscille',      'MEDEF',   'employeurs', 'titulaire', null),
  ('BREDEL', 'Sara',       'MEDEF',   'employeurs', 'titulaire', null),
  ('COMBE', 'Sylvie',      'MEDEF',   'employeurs', 'titulaire', null),
  ('DION', 'Victor',        'MEDEF',   'employeurs', 'titulaire', null),
  ('FRADET', 'Adrienne','MEDEF',  'employeurs', 'titulaire', null),
  ('GOURDIN', 'Arsène',       'MEDEF',   'employeurs', 'titulaire', null),
  ('ROLLIN', 'Antoine',  'CPME',    'employeurs', 'titulaire', null),
  ('BOUCHER', 'Baptiste',       'CFTC',    'salaries',   'titulaire', null),
  ('DUVAL', 'Daniel',   'CFE-CGC', 'salaries',   'titulaire', null),
  ('GAILLARD', 'Évelyne',        'CGT-FO',  'salaries',   'titulaire', null),
  ('GUICHARD', 'Guillaume',       'CGT',     'salaries',   'titulaire', null),
  ('LEMOINE', 'Jeanne',     'CFDT',    'salaries',   'titulaire', null),
  ('LOISEL', 'Juliette',          'CGT-FO',  'salaries',   'titulaire', null),
  ('MERCIER', 'Léonie',         'CFDT',    'salaries',   'titulaire', null),
  ('RENAULT', 'Michèle',       'CFTC',    'salaries',   'titulaire', null),
  ('ROY', 'Nicolas',     'CFTC',    'salaries',   'titulaire', null),
  ('CHRETIEN', 'Stéphane',        'CFDT',    'salaries',   'titulaire', null),
  ('DERVAUX', 'Tony',       'CGT',     'salaries',   'titulaire', null),
  ('NAVARRE', 'Muriel',        'CGT-FO',  'salaries',   'titulaire', null),
  ('NICOT', 'Olivier-Jean',        'CFE-CGC', 'salaries',   'titulaire', null)
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
  ('MUNIER', 'Marc',  'FRBTP-MT', 'employeurs', 'titulaire', 'Président'),
  ('ROSSIGNOL', 'Audrey',    'FTC-CGTG', 'salaries',   'titulaire', 'Vice-président'),
  ('WEBER', 'Paul',    null::text,  null::text,  'invite',    'Directeur général'),
  ('BARBIER', 'Alexis',  'FRBTP-GY', 'employeurs', 'titulaire', null::text),
  ('BOUDIN', 'Bénédicte', 'FRBTP-GY', 'employeurs', 'titulaire', null),
  ('BOUTIN', 'Benoît',   'FRBTP-MT', 'employeurs', 'titulaire', null),
  ('CHEVALIER', 'Caroline',  'FRBTP-GP', 'employeurs', 'titulaire', null),
  ('DEMAILLY', 'Christophe',  'FRBTP-GP', 'employeurs', 'titulaire', null),
  ('MARQUET', 'Laura',     'FRBTP-GP', 'employeurs', 'titulaire', null),
  ('THOMAS', 'Nora',   'FRBTP-GP', 'employeurs', 'titulaire', null),
  ('BICHON', 'Renaud',    'FRBTP-MT', 'employeurs', 'titulaire', null),
  ('COLLIN', 'Sylvain', 'FRBTP-GP', 'employeurs', 'titulaire', null),
  ('DETREZ', 'Valentin',   'FRBTP-MT', 'employeurs', 'titulaire', null),
  ('DUGAST', 'William',    'FRBTP-GY', 'employeurs', 'titulaire', null),
  ('FLAMENT', 'Yvonne',    'FRBTP-MT', 'employeurs', 'titulaire', null),
  ('BARON', 'Alice',  'UTG',      'salaries',   'titulaire', null),
  ('DAUPHIN', 'Charlotte',   'CSTM',     'salaries',   'titulaire', null),
  ('LEGRAND', 'Jean-Pierre',  'UD-CFTC',  'salaries',   'titulaire', null),
  ('MARECHAL', 'Kevin',  'FTC-CGTM', 'salaries',   'titulaire', null),
  ('RICHER', 'Morgane',   'CDTG-CFDT','salaries',   'titulaire', null),
  ('ROUSSEAU', 'Natasha',    'FTC-CGTG', 'salaries',   'titulaire', null),
  ('BRAULT', 'Sandrine',  'FTC-CGTG', 'salaries',   'titulaire', null),
  ('CHATEL', 'Stefan',   'UTG',      'salaries',   'titulaire', null),
  ('DIDIER', 'Vanessa',    'CGTM',     'salaries',   'titulaire', null),
  ('MICHON', 'Malo',    'UD-FO',    'salaries',   'titulaire', null)
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
  ('BRUNET', 'Bertrand',       'CFE-CGC', 'salaries',   'titulaire', 'Président'),
  ('REMY', 'Mélodie',    'MEDEF',   'employeurs', 'titulaire', 'Vice-présidente'),
  ('DENIS', 'Timothée',      null::text,null::text,   'invite',    'Directeur général'),
  ('GIRAUD', 'Frédéric',       'MEDEF',   'employeurs', 'titulaire', null::text),
  ('GUERIN', 'Grégoire',    'MEDEF',   'employeurs', 'titulaire', null),
  ('JACQUET', 'Ingrid',     'MEDEF',   'employeurs', 'titulaire', null),
  ('LUCAS', 'Karine',      'MEDEF',   'employeurs', 'titulaire', null),
  ('PERRIN', 'Marion',    'MEDEF',   'employeurs', 'titulaire', null),
  ('PREVOST', 'Maxime',      'U2P',     'employeurs', 'titulaire', null),
  ('RICHARD', 'Monique',   'CPME',    'employeurs', 'titulaire', null),
  ('AYMARD', 'Pierre-Louis',        'MEDEF',   'employeurs', 'titulaire', null),
  ('ALLARD', 'Adrien',       'CGTG',    'salaries',   'titulaire', null),
  ('BAZIN', 'Amélie',       'CFDT',    'salaries',   'titulaire', null),
  ('FOUCHARD', 'Élise',        'CGTG',    'salaries',   'titulaire', null),
  ('GODARD', 'Gaëtan',         'CFTC',    'salaries',   'titulaire', null),
  ('NOEL', 'Marie','CFTC',   'salaries',   'titulaire', null),
  ('BLAIN', 'Roland',     'CFE-CGC', 'salaries',   'titulaire', null),
  ('BOUSQUET', 'Sandra',   'CFDT',    'salaries',   'titulaire', null)
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
  ('FABRE', 'Danielle',       'UD-FO',   'salaries',   'titulaire', 'Président'),
  ('DUPONT', 'Corinne',         'MEDEF',   'employeurs', 'titulaire', 'Vice-président'),
  ('BRUN', 'Bernard',       null::text,null::text,   'invite',    'Directeur général'),
  ('FOULON', 'Emmanuel',        'MEDEF',   'employeurs', 'titulaire', null::text),
  ('MICHARD', 'Loïc',       'U2P',     'employeurs', 'titulaire', null),
  ('MORIN', 'Manon',         'MEDEF',   'employeurs', 'titulaire', null),
  ('BOSSE', 'Samuel',  'MEDEF',   'employeurs', 'titulaire', null),
  ('GROS', 'Gilles',        'MEDEF',   'employeurs', 'titulaire', null),
  ('DEVOS', 'Valérie',         'CPME',    'employeurs', 'titulaire', null),
  ('DUPUIS', 'Yann',       'CPME',    'employeurs', 'titulaire', null),
  ('MARCHAND', 'Gwenola',     'CPME',    'employeurs', 'titulaire', null),
  ('POMMIER', 'Achille',       'MEDEF',   'employeurs', 'titulaire', null),
  ('AUBRY', 'Alexandre',     'UD-FO',   'salaries',   'titulaire', null),
  ('BAUDRY', 'Alicia',       'CFTC',    'salaries',   'titulaire', null),
  ('BESNARD', 'Arnaud',         'CGTR',    'salaries',   'titulaire', null),
  ('CHAUVIN', 'Camille',       'CGTR',    'salaries',   'titulaire', null),
  ('FRANC', 'Estelle',         'CFDT',    'salaries',   'titulaire', null),
  ('VALETTE', 'Océane',         'CFDT',    'salaries',   'titulaire', null),
  ('VINCENT', 'Pascale',   'CFTC',    'salaries',   'titulaire', null),
  ('DESPREZ', 'Valentine',         'CFE-CGC', 'salaries',   'titulaire', null),
  ('MANCEAU', 'Florian',      'CFE-CGC', 'salaries',   'titulaire', null)
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
  ('NAVARRO', 'Noël',        'CFTC',    'salaries',   'titulaire', 'Président'),
  ('DESCHAMPS', 'Christine',       'FEPEM',   'employeurs', 'titulaire', 'Vice-président'),
  ('GIRARD', 'Françoise',         null::text,null::text,   'invite',    'Directeur général'),
  ('CARON', 'Brice',          'FEPEM',   'employeurs', 'titulaire', null::text),
  ('LEBRUN', 'Jean-Luc',     'FEPEM',   'employeurs', 'titulaire', null),
  ('ROLLAND', 'Nadia',      'FEPEM',   'employeurs', 'titulaire', null),
  ('SIMON', 'Noémie',       'FEPEM',   'employeurs', 'titulaire', null),
  ('ZIMMERMANN', 'Pauline',      'FEPEM',   'employeurs', 'titulaire', null),
  ('PRIEUR', 'Albert',          'FEPEM',   'employeurs', 'titulaire', null),
  ('RIOU', 'Amélie',          'FEPEM',   'employeurs', 'titulaire', null),
  ('RIVET', 'Anaïs',        'FEPEM',   'employeurs', 'titulaire', null),
  ('COLLET', 'Cécile',     'FGTA-FO', 'salaries',   'titulaire', null),
  ('MONTEIL', 'Lucie',       'CGT',     'salaries',   'titulaire', null),
  ('ROBIN', 'Nadège',     'CFE-CGC', 'salaries',   'titulaire', null),
  ('ROUX', 'Nathan',      'CGT',     'salaries',   'titulaire', null),
  ('BIGOT', 'Richard','CFE-CGC','salaries',  'titulaire', null),
  ('CHATELIN', 'Sophie',       'CFDT',    'salaries',   'titulaire', null),
  ('DANET', 'Théo',       'CFDT',    'salaries',   'titulaire', null),
  ('MARTEL', 'Jocelyne',       'FGTA-FO', 'salaries',   'titulaire', null),
  ('MONNIER', 'Maureen',       'CFTC',    'salaries',   'titulaire', null)
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
  ('FOURNEAU', 'Émilie',      'MEDEF',   'employeurs', 'titulaire', 'Président'),
  ('MARIN', 'Isaure',        'CFE-CGC', 'salaries',   'titulaire', 'Vice-président'),
  ('PARET', 'Quentin',  null::text,null::text,   'invite',    'Directeur général'),
  ('BOISSET', 'Axel',     'CPME',    'employeurs', 'titulaire', null::text),
  ('DUCHEMIN', 'Clément',      'CPME',    'employeurs', 'titulaire', null),
  ('GILLES', 'François-Xavier',     'CPME',    'employeurs', 'titulaire', null),
  ('GOULET', 'Georges',   'CPME',    'employeurs', 'titulaire', null),
  ('NICOLAS', 'Margot',     'MEDEF',   'employeurs', 'titulaire', null),
  ('VALLET', 'Odile',     'MEDEF',   'employeurs', 'titulaire', null),
  ('BEAUMONT', 'Régine',      'U2P',     'employeurs', 'titulaire', null),
  ('VOIRIN', 'Patrick',      'MEDEF',   'employeurs', 'titulaire', null),
  ('BELLANGER', 'Régis',     'MEDEF',   'employeurs', 'titulaire', null),
  ('DELORME', 'Thomas',       'MEDEF',   'employeurs', 'titulaire', null),
  ('DUPAS', 'Xavier',   'MEDEF',   'employeurs', 'titulaire', null),
  ('MAGNIN', 'Fanny',    'CPME',    'employeurs', 'titulaire', null),
  ('MOULIN', 'Michaël',        'MEDEF',   'employeurs', 'titulaire', null),
  ('RENON', 'Alexis',      'MEDEF',   'employeurs', 'titulaire', null),
  ('CLEMENT', 'Carole',   'CFTC',    'salaries',   'titulaire', null),
  ('DAVID', 'Chloé',       'CFTC',    'salaries',   'titulaire', null),
  ('GAUDIN', 'Fabrice',     'CGT-FO',  'salaries',   'titulaire', null),
  ('LOMBARD', 'Julien',    'CFE-CGC', 'salaries',   'titulaire', null),
  ('PAGET', 'Marie-Hélène',       'CFE-CGC', 'salaries',   'titulaire', null),
  ('QUINTIN', 'Mélanie',      'CFDT',    'salaries',   'titulaire', null),
  ('BINET', 'Rodolphe',     'CGT',     'salaries',   'titulaire', null),
  ('FERRIER', 'Yvette',      'CFTC',    'salaries',   'titulaire', null),
  ('FORTIER', 'Zacharie',     'CFDT',    'salaries',   'titulaire', null),
  ('GAVARD', 'Ambroise',     'CGT',     'salaries',   'titulaire', null),
  ('MANGIN', 'Geoffroy',     'CGT',     'salaries',   'titulaire', null),
  ('PARIS', 'Rebecca',    'CFDT',    'salaries',   'titulaire', null),
  ('PEYROT', 'Wenceslas',     'CGT-FO',  'salaries',   'titulaire', null),
  ('RIGAUD', 'Alicia',      'CGT-FO',  'salaries',   'titulaire', null)
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
  ('BLANCHARD', 'Audrey',        'FNTR',   'employeurs', 'titulaire', 'Président'),
  ('POTIER', 'Matthieu',          'CFDT',   'salaries',   'titulaire', 'Vice-président'),
  ('PARET', 'Quentin',   null::text,null::text,  'invite',    'Directeur général'),
  ('BLANC', 'Arthur','FNTV',   'employeurs', 'titulaire', null::text),
  ('DELAUNAY', 'Christelle',      'FNTR',   'employeurs', 'titulaire', null),
  ('FERRET', 'Dominique',       'TLF',    'employeurs', 'titulaire', null),
  ('LEBLANC', 'Jean-Jacques',        'FNTR',   'employeurs', 'titulaire', null),
  ('MARIN', 'Karl',       'FNTR',   'employeurs', 'titulaire', null),
  ('MOREL', 'Ludovic',       'TLF',    'employeurs', 'titulaire', null),
  ('AMIOT', 'Philippe',      'FNTR',   'employeurs', 'titulaire', null),
  ('BASTIEN', 'Rachel',        'WAGONS-LITS','employeurs','titulaire',null),
  ('BORDES', 'Romane',        'OTRE',   'employeurs', 'titulaire', null),
  ('DROUET', 'Vincent',         'TLF',    'employeurs', 'titulaire', null),
  ('GAULTIER', 'Alric',       'TLF',    'employeurs', 'titulaire', null),
  ('MARAVAL', 'Gladys',     'OTRE',   'employeurs', 'titulaire', null),
  ('PAYAN', 'Tania',        'FNTV',   'employeurs', 'titulaire', null),
  ('COUSIN', 'Charles',      'CFDT',   'salaries',   'titulaire', null),
  ('DOUCET', 'Clara',      'CGT-FO', 'salaries',   'titulaire', null),
  ('DURIEUX', 'Damien',     'CFTC',   'salaries',   'titulaire', null),
  ('HENRY', 'Henri',    'CGT',    'salaries',   'titulaire', null),
  ('LACROIX', 'Jean',         'CGT',    'salaries',   'titulaire', null),
  ('JOLY', 'Irène',   'CFE-CGC','salaries',   'titulaire', null),
  ('JOUBERT', 'Isabelle',       'CFTC',   'salaries',   'titulaire', null),
  ('LAMBERT', 'Jean-Baptiste',     'CFDT',   'salaries',   'titulaire', null),
  ('CHARLES', 'Solène',      'CGT-FO', 'salaries',   'titulaire', null),
  ('DUBREUIL', 'Virginie',     'CGT-FO', 'salaries',   'titulaire', null),
  ('MIGNOT', 'Marguerite',         'CGT',    'salaries',   'titulaire', null),
  ('NOEL', 'Patrice',         'CFDT',   'salaries',   'titulaire', null),
  ('PICHON', 'Yael',      'CFDT',   'salaries',   'titulaire', null),
  ('PORCHER', 'Adrien',        'CGT',    'salaries',   'titulaire', null),
  ('BERGER', 'Anaïs',      'FNTR',   'employeurs', 'suppleant', null),
  ('BUREAU', 'Boris',        'TLF',    'employeurs', 'suppleant', null),
  ('HUET', 'Hugo',    'OTRE',   'employeurs', 'suppleant', null),
  ('MEYER', 'Lise',     'FNTR',   'employeurs', 'suppleant', null),
  ('POULIN', 'Maxence',     'FNTV',   'employeurs', 'suppleant', null),
  ('LEMAIRE', 'Jean-Yves',       'CFDT',   'salaries',   'suppleant', null),
  ('LOISEAU', 'Julie',          'CFE-CGC','salaries',   'suppleant', null),
  ('MERLE', 'Léonard',      'CGT',    'salaries',   'suppleant', null),
  ('GILBERT', 'Anatole',       'CFTC',   'salaries',   'suppleant', null),
  ('JOLLY', 'Eloïse',       'CGT-FO', 'salaries',   'suppleant', null)
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
  ('LARUE', 'Jean-François',  'CFE-CGC', 'salaries',   'titulaire', 'Président'),
  ('ROYER', 'Aurélie',     'MEDEF',   'employeurs', 'titulaire', 'Vice-président'),
  ('NARBONNE', 'Mireille',      null::text,null::text,   'invite',    'Directeur général'),
  ('CARREL', 'Brigitte',     'MEDEF',   'employeurs', 'titulaire', null::text),
  ('COSTE', 'Chantal',     'MEDEF',   'employeurs', 'titulaire', null),
  ('DUFRESNE', 'Colette',      'MEDEF',   'employeurs', 'titulaire', null),
  ('FLEURY', 'Édith',     'MEDEF',   'employeurs', 'titulaire', null),
  ('GODIN', 'Gabriel',  'CPME',    'employeurs', 'titulaire', null),
  ('GUILLET', 'Gwenaëlle',    'MEDEF',   'employeurs', 'titulaire', null),
  ('LEVEQUE', 'Jonathan',      'CPME',    'employeurs', 'titulaire', null),
  ('MASSON', 'Laurence',      'MEDEF',   'employeurs', 'titulaire', null),
  ('MOREAU', 'Madeleine',      'MEDEF',   'employeurs', 'titulaire', null),
  ('VIDAL', 'Pascal',        'MEDEF',   'employeurs', 'titulaire', null),
  ('BACHELET', 'Pierre-Yves',    'U2P',     'employeurs', 'titulaire', null),
  ('BORY', 'Sabine',   'MEDEF',   'employeurs', 'titulaire', null),
  ('MANSARD', 'Gérard',      'MEDEF',   'employeurs', 'titulaire', null),
  ('PAYEN', 'Séverine',    'MEDEF',   'employeurs', 'titulaire', null),
  ('BOYER', 'Bernadette',     'CGT',     'salaries',   'titulaire', null),
  ('DUMONT', 'Corentin',        'CGT-FO',  'salaries',   'titulaire', null),
  ('GARNIER', 'Fabien',      'CFTC',    'salaries',   'titulaire', null),
  ('GAUTHIER', 'Ferdinand',      'CFTC',    'salaries',   'titulaire', null),
  ('HARDY', 'Hélène',     'CFE-CGC', 'salaries',   'titulaire', null),
  ('MALLET', 'Katia',    'CGT-FO',  'salaries',   'titulaire', null),
  ('MAURY', 'Léa',       'CGT-FO',  'salaries',   'titulaire', null),
  ('VIOLET', 'Patricia',      'CFE-CGC', 'salaries',   'titulaire', null),
  ('DONZE', 'Victorine',   'CGT',     'salaries',   'titulaire', null),
  ('FOSSE', 'Zoé',       'CFDT',    'salaries',   'titulaire', null),
  ('JANIN', 'Coralie',      'CGT',     'salaries',   'titulaire', null),
  ('MATHON', 'Jonas',    'CFTC',    'salaries',   'titulaire', null),
  ('MAURY', 'Léa-Marie','CFDT',    'salaries',   'titulaire', null),
  ('PERROT', 'Vérane',       'CFDT',    'salaries',   'titulaire', null)
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
  ('CHARTON', 'Sonia',    'CFDT',    'salaries',   'titulaire', 'Présidente'),
  ('ROCHARD', 'André',      'MEDEF',   'employeurs', 'titulaire', 'Vice-président'),
  ('NARBONNE', 'Mireille',    null::text,null::text,   'invite',    'Directeur général'),
  ('BUFFET', 'Blanche',    'CPME',    'employeurs', 'titulaire', null::text),
  ('FREMONT', 'Étienne',   'MEDEF',   'employeurs', 'titulaire', null),
  ('GIRAULT', 'Gaël',     'MEDEF',   'employeurs', 'titulaire', null),
  ('GRASSET', 'Ghislaine',     'MEDEF',   'employeurs', 'titulaire', null),
  ('RENAUD', 'Michel',      'MEDEF',   'employeurs', 'titulaire', null),
  ('TISSERAND', 'Norbert', 'MEDEF',   'employeurs', 'titulaire', null),
  ('BILLARD', 'Robert',    'MEDEF',   'employeurs', 'titulaire', null),
  ('DUCHENE', 'Viviane',    'MEDEF',   'employeurs', 'titulaire', null),
  ('SAVANT', 'Benjamin',   'MEDEF',   'employeurs', 'titulaire', null),
  ('FAUCHER', 'David',   'CGT-FO',  'salaries',   'titulaire', null),
  ('SALIN', 'Nicole',   'CFE-CGC', 'salaries',   'titulaire', null),
  ('BATY', 'Raphaël',   'CFE-CGC', 'salaries',   'titulaire', null),
  ('GUERRIER', 'Augustin',     'CGT',     'salaries',   'titulaire', null),
  ('PASCAL', 'Roseline',   'CFTC',    'salaries',   'titulaire', null),
  ('RUBIN', 'Axel',    'CGT',     'salaries',   'titulaire', null),
  ('SANSON', 'Baptiste',        'CFDT',    'salaries',   'titulaire', null)
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
  ('BERNARD', 'André',        'MEDEF',   'employeurs', 'titulaire', 'Président'),
  ('MAUBERT', 'Jordan', 'CGT',     'salaries',   'titulaire', 'Vice-président'),
  ('DESMARAIS', 'Tristan',         null::text,null::text,   'invite',    'Directeur général'),
  ('BONNET', 'Axelle',       'CPME',    'employeurs', 'titulaire', null::text),
  ('GONTIER', 'Geneviève',      'MEDEF',   'employeurs', 'titulaire', null),
  ('LARCHER', 'Jean-Claude',        'MEDEF',   'employeurs', 'titulaire', null),
  ('VASSEUR', 'Olivier',       'MEDEF',   'employeurs', 'titulaire', null),
  ('ANGLADE', 'Pierre',        'MEDEF',   'employeurs', 'titulaire', null),
  ('BILLET', 'Robin',   'MEDEF',   'employeurs', 'titulaire', null),
  ('COLLIGNON', 'Suzanne',        'MEDEF',   'employeurs', 'titulaire', null),
  ('JARRY', 'Elodie',        'U2P',     'employeurs', 'titulaire', null),
  ('LACAN', 'Emeric',          'U2P',     'employeurs', 'titulaire', null),
  ('MENARD', 'Lucile',       'CPME',    'employeurs', 'titulaire', null),
  ('PELLETIER', 'Théodore',      'MEDEF',   'employeurs', 'titulaire', null),
  ('PLANTIN', 'Zia',      'MEDEF',   'employeurs', 'titulaire', null),
  ('REGNARD', 'Alexia',     'MEDEF',   'employeurs', 'titulaire', null),
  ('ROQUES', 'Arnaud',        'MEDEF',   'employeurs', 'titulaire', null),
  ('DEVAUX', 'Claire',   'CFTC',    'salaries',   'titulaire', null),
  ('HERBIN', 'Hervé',      'CFDT',    'salaries',   'titulaire', null),
  ('BONIN', 'Romain',       'CGT-FO',  'salaries',   'titulaire', null),
  ('BERTON', 'René',     'CFE-CGC', 'salaries',   'titulaire', null),
  ('CLAVREUL', 'Stéphanie',       'CGT',     'salaries',   'titulaire', null),
  ('DELATTRE', 'Thierry',         'CFE-CGC', 'salaries',   'titulaire', null),
  ('DORMOY', 'Véronique',       'CGT-FO',  'salaries',   'titulaire', null),
  ('FAVIER', 'Yolande',         'CFDT',    'salaries',   'titulaire', null),
  ('GUIMARD', 'Aurélien',       'CGT',     'salaries',   'titulaire', null),
  ('MAUFRAS', 'Judith',        'CFDT',    'salaries',   'titulaire', null),
  ('MILLOT', 'Marilène',       'CFTC',    'salaries',   'titulaire', null),
  ('MOLINIER', 'Maud',       'CGT-FO',  'salaries',   'titulaire', null),
  ('PATRY', 'Roxane',      'CFE-CGC', 'salaries',   'titulaire', null),
  ('PEREZ', 'Typhaine',      'CFTC',    'salaries',   'titulaire', null)
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
  ('DAVY', 'Thibault',      'MEDEF',    'employeurs', 'titulaire', 'Président'),
  ('DUFOUR', 'Wilfrid',       'CFTC',     'salaries',   'titulaire', 'Vice-président'),
  ('GENET', 'Floriane',          null::text,  null::text,  'invite',    'Directeur général'),
  ('LEFEBVRE', 'Jean-Paul', 'MEDEF',    'employeurs', 'titulaire', null::text),
  ('LEVY', 'Joël',        'MEDEF',    'employeurs', 'titulaire', null),
  ('MOISAN', 'Luc',        'MEDEF',    'employeurs', 'titulaire', null),
  ('RENARD', 'Mélissa',       'CPME',     'employeurs', 'titulaire', null),
  ('BAUER', 'Raoul','CPME',    'employeurs', 'titulaire', null),
  ('FOREST', 'Yves',       'MEDEF',    'employeurs', 'titulaire', null),
  ('ADAM', 'Achille',         'CGTM-FSM', 'salaries',   'titulaire', null),
  ('FONTAINE', 'Édouard',        'CSTM',     'salaries',   'titulaire', null),
  ('HUBERT', 'Hubert',       'CFDT',     'salaries',   'titulaire', null),
  ('MARTIN', 'Laure',  'CDMT',     'salaries',   'titulaire', null),
  ('PEYRE', 'Marjorie',    'CFE-CGC',  'salaries',   'titulaire', null),
  ('ROBIC', 'Mylène',        'CGT-FO',   'salaries',   'titulaire', null)
) as m(nom, prenom, org, college, statut, fonction)
join personnes p on p.nom = m.nom and p.prenom = m.prenom
left join organisations o on o.sigle = m.org;
