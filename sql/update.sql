DELIMITER |

-- Mise à jour à partir de la version 2.1c
CREATE PROCEDURE post_2_1c
BEGIN
	ALTER TABLE TBL_USERS DROP gid;
	-- Création d'une table pour lister les différentes affectations (centre, team, grade)
	CREATE TABLE IF NOT EXISTS `TBL_CONFIG_AFFECTATIONS` (
		`caid` int(11) NOT NULL AUTO_INCREMENT,
		`type` varchar(64) NOT NULL,
		`nom` varchar(64) NOT NULL,
		`description` text NOT NULL,
		PRIMARY KEY (`caid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE IF NOT EXISTS `TBL_ANCIENNETE_EQUIPE` (
		`ancid` int(11) NOT NULL AUTO_INCREMENT,
		`uid` int(11) NOT NULL,
		`centre` varchar(50) NOT NULL,
		`team` varchar(10) NOT NULL,
		`beginning` date NOT NULL,
		`end` date DEFAULT NULL,
		`global` BOOLEAN DEFAULT FALSE,
		PRIMARY KEY (`ancid`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE IF NOT EXISTS TBL_SIGNUP_ON_HOLD (
		id INT(11) NOT NULL AUTO_INCREMENT,
		nom varchar(64) NOT NULL,
		prenom VARCHAR(64) NOT NULL,
		email VARCHAR(128) NOT NULL,
		centre VARCHAR(50) NOT NULL,
		team VARCHAR(10) NOT NULL,
		beginning DATE,
		end DATE,
		timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
		url VARCHAR(40) NULL DEFAULT NULL,
		grade VARCHAR(64) NULL DEFAULT NULL,
		classe VARCHAR(10) NULL DEFAULT NULL,
		PRIMARY KEY (id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--	INSERT INTO TBL_CONFIG_AFFECTATIONS
--	(caid, type, nom, description)
--	VALUES
--	(NULL, 'classe', 'c', 'Élève'),
--	(NULL, 'classe', 'pc', 'Premier contrôleur'),
--	(NULL, 'classe', 'ce', "Chef d''équipe"),
--	(NULL, 'classe', 'dtch', 'détaché'),
--	(NULL, 'classe', 'fmp', 'Adjoint chef de salle'),
--	(NULL, 'classe', 'cds', 'Chef de salle');
--
--	INSERT INTO `ttm`.`TBL_ARTICLES` (`idx`, `titre`, `description`, `texte`, `analyse`, `creation`, `modification`, `restricted`, `actif`) VALUES (NULL, 'Création de votre compte', '', 'Votre compte a été créé. Vous pouvez vous connecter dès maintenant en cliquant sur « Connexion ».', '', NOW(), CURRENT_TIMESTAMP, '0', '1');

	-- Relations pour les utilisateurs (uid)
	DELETE FROM TBL_CLASSE WHERE classe = 'détaché' OR classe = 'théorique' OR classe = 'theo' OR classe = 'teamEdit';

	ALTER TABLE `TBL_ROLES` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_ROLES_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_CLASSE` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_CLASSE_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_AFFECTATION` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_AFFECTATION_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_ANCIENNETE_EQUIPE` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_ANCIENNETE_EQUIPE_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_PHONE` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_PHONE_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_ADRESSES` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_ADRESSES_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_REMPLA` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_REMPLA_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_EVENEMENTS_SPECIAUX` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_EVENEMENTS_SPECIAUX_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_HEURES` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_HEURES_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_VACANCES_A_ANNULER` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_VACANCES_A_ANNULER_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_TIPOFTHEDAY` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_TIPOFTHEDAY_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_LOG` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_LOG_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_L_SHIFT_DISPO` CHANGE `uid` `uid` SMALLINT NOT NULL, ADD KEY `uid` (`uid`), ADD CONSTRAINT `TBL_L_SHIFT_DISPO_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `TBL_USERS` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

	-- Relations pour les activités (did)
	ALTER TABLE `TBL_L_SHIFT_DISPO` CHANGE `did` `did` SMALLINT NOT NULL, ADD KEY `did` (`did`), ADD CONSTRAINT `TBL_L_SHIFT_DISPO_ibfk_2` FOREIGN KEY (`did`) REFERENCES `TBL_DISPO` (`did`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_VACANCES` ADD KEY `sdid` (`sdid`), ADD CONSTRAINT `TBL_VACANCES_ibfk_1` FOREIGN KEY (`sdid`) REFERENCES `TBL_L_SHIFT_DISPO` (`sdid`) ON DELETE CASCADE ON UPDATE CASCADE;

	-- Relations pour les menus
	ALTER TABLE `TBL_MENUS_ELEMS_MENUS` ADD CONSTRAINT `TBL_MENUS_ELEMS_MENUS_ibfk_1` FOREIGN KEY (`idxm`) REFERENCES `TBL_MENUS` (`idx`) ON DELETE CASCADE ON UPDATE CASCADE;

	ALTER TABLE `TBL_MENUS_ELEMS_MENUS` ADD CONSTRAINT `TBL_MENUS_ELEMS_MENUS_ibfk_2` FOREIGN KEY (`idxem`) REFERENCES `TBL_ELEMS_MENUS` (`idx`) ON DELETE CASCADE ON UPDATE CASCADE;

	DROP VIEW IF EXISTS classes;
	CREATE VIEW classes AS
		SELECT u.uid AS uid, nom, prenom, 'pc' AS `classe`, MIN(beginning) AS `beginning`, MAX(end) AS `end`, `poids`, `actif`
		FROM TBL_AFFECTATION AS c, TBL_USERS AS u
		WHERE u.uid = c.uid
		AND (grade = 'pc' OR grade = 'dtch' OR grade = 'fmp')
		AND `validated` IS TRUE
		GROUP BY u.uid
		UNION
		SELECT u.uid AS uid, nom, prenom, 'dtch' AS `classe`, MIN(beginning) AS `beginning`, MAX(end) AS `end`, `poids`, `actif`
		FROM TBL_AFFECTATION AS c, TBL_USERS AS u
		WHERE u.uid = c.uid
		AND grade = 'dtch'
		AND `validated` IS TRUE
		GROUP BY u.uid
		UNION
		SELECT u.uid AS uid, nom, prenom, 'fmp' AS `classe`, MIN(beginning) AS `beginning`, MAX(end) AS `end`, `poids`, `actif`
		FROM TBL_AFFECTATION AS c, TBL_USERS AS u
		WHERE u.uid = c.uid 
		AND grade = 'fmp'
		AND `validated` IS TRUE
		GROUP BY u.uid
		UNION
		SELECT u.uid AS uid, nom, prenom, 'ce' AS `classe`, MIN(beginning) AS `beginning`, MAX(end) AS `end`, `poids`, `actif`
		FROM TBL_AFFECTATION AS c, TBL_USERS AS u
		WHERE u.uid = c.uid
		AND grade = 'ce'
		AND `validated` IS TRUE
		GROUP BY u.uid
		UNION
		SELECT u.uid AS uid, nom, prenom, 'c' AS `classe`, MIN(beginning) AS `beginning`, MAX(end) AS `end`, `poids`, `actif`
		FROM TBL_AFFECTATION AS c, TBL_USERS AS u
		WHERE u.uid = c.uid
		AND (grade = 'c' OR `grade` = 'theo')
		AND `validated` IS TRUE
		GROUP BY u.uid
		UNION
		SELECT u.uid AS uid, nom, prenom, 'cds' AS `classe`, MIN(beginning) AS `beginning`, MAX(end) AS `end`, `poids`, `actif`
		FROM TBL_AFFECTATION AS c, TBL_USERS AS u
		WHERE u.uid = c.uid
		AND grade = 'cds'
		AND `validated` IS TRUE
		GROUP BY u.uid;
END
|

DELIMITER ;

-- CALL post_2_1c();
