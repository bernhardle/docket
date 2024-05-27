--
--	(c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004
--
--
--	Die Benutzer anlegen: 'scw' ist zum Schreiben, 'scr' zum Lesen
--
--	Zur Erinnerung:
--	ü ~ CHAR(252)
--	ä ~ CHAR(228)
--	ö ~ CHAR(246)
--	Ä ~ CHAR(196)
--	Ö ~ CHAR(214)
--	Ü ~ CHAR(220)
--	ß ~ CHAR(223)
--
USE master
GO
--
IF NOT EXISTS (SELECT name FROM syslogins WHERE name='scw') EXEC sp_addlogin @loginame='scw', @passwd='lala', @defdb='schedule'
IF NOT EXISTS (SELECT name FROM syslogins WHERE name='scr') EXEC sp_addlogin @loginame='scr', @passwd='lala', @defdb='schedule'
GO
--
USE schedule
GO
--
IF NOT EXISTS (SELECT uid FROM sysusers WHERE name='scr') EXEC sp_adduser @loginame='scr', @name_in_db='scr'
IF NOT EXISTS (SELECT uid FROM sysusers WHERE name='scw') EXEC sp_adduser @loginame='scw', @name_in_db='scw'
GO
--
--
--	Alle Tabellen, die schon vorhanden sind, rauskegeln.
--
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'systemlogin') DROP TABLE systemlogin
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'seclog') DROP TABLE seclog
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'event') DROP TABLE event
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'etext')	DROP TABLE etext
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'etype') DROP TABLE etype
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'base') DROP TABLE base
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'detail') DROP TABLE detail
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'autotype') DROP TABLE autotype
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'cont') DROP TABLE cont
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'dtype') DROP TABLE dtype
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'autonotification') DROP TABLE autonotification
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'autoassigned') DROP TABLE autoassigned
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'autodeadline') DROP TABLE autodeadline
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'context') DROP TABLE context
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'assigned') DROP TABLE assigned
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'login') DROP TABLE login
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'shift') DROP TABLE shift
--
PRINT 'Alle Tabellen gelöscht.'
GO
--
--
--	Die Prozeduren ...
--
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getAssign' AND type = 'P') DROP PROCEDURE getAssign
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getContexts' AND type = 'P') DROP PROCEDURE getContexts
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getForms' AND type = 'P') DROP PROCEDURE getForms
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'autoDeadlinePreviewListA' AND type = 'P') DROP PROCEDURE autoDeadlinePreviewListA
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'autoDeadlinePreviewListB' AND type = 'P') DROP PROCEDURE autoDeadlinePreviewListB
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getAssignList' AND type = 'P') DROP PROCEDURE getAssignList
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getAutoAssignList' AND type = 'P') DROP PROCEDURE getAutoAssignList
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getAutodeadline' AND type = 'P') DROP PROCEDURE getAutodeadline
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getAutoNotificationList' AND type = 'P') DROP PROCEDURE getAutoNotificationList
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getTypeList' AND type = 'P') DROP PROCEDURE getTypeList
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getTypes' AND type = 'P') DROP PROCEDURE getTypes
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getContextList' AND type = 'P') DROP PROCEDURE getContextList
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getDateFromID' AND type = 'P') DROP PROCEDURE getDateFromID
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getDeadlineOV' AND type = 'P') DROP PROCEDURE getDeadlineOV
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getDeadlineOV_ID' AND type = 'P') DROP PROCEDURE getDeadlineOV_ID
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getDetail' AND type = 'P') DROP PROCEDURE getDetail
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getEventList' AND type = 'P') DROP PROCEDURE getEventList
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getLoginNames' AND type = 'P') DROP PROCEDURE getLoginNames
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getNotification' AND type = 'P') DROP PROCEDURE getNotification
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getNotificationList' AND type = 'P') DROP PROCEDURE getNotificationList
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getNotificationOV' AND type = 'P') DROP PROCEDURE getNotificationOV
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getPromoteForID' AND type = 'P') DROP PROCEDURE getPromoteForID
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getShiftBase' AND type = 'P') DROP PROCEDURE getShiftBase
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getUserTicket' AND type = 'P') DROP PROCEDURE getUserTicket
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'getWorkload' AND type = 'P') DROP PROCEDURE getWorkload
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'eventByDate' AND type = 'P') DROP PROCEDURE eventByDate
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'dailyReport' AND type = 'P') DROP PROCEDURE dailyReport
--
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'insertBaseEntry' AND type = 'P') DROP PROCEDURE insertBaseEntry
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'insertCommentForID' AND type = 'P') DROP PROCEDURE insertCommentForID
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'insertLogin' AND type = 'P') DROP PROCEDURE insertLogin
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'insertNotificationForID' AND type = 'P') DROP PROCEDURE insertNotificationForID
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'logins' AND type = 'P') DROP PROCEDURE logins
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'nextBefore' AND type = 'P') DROP PROCEDURE nextBefore
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'removeLoginForUID' AND type = 'P') DROP PROCEDURE removeLoginForUID
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'searchAny' AND type = 'P') DROP PROCEDURE searchAny
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'setDoneForID' AND type = 'P') DROP PROCEDURE setDoneForID
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'setPwdForUID' AND type = 'P') DROP PROCEDURE setPwdForUID
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'etextID' AND type = 'P') DROP PROCEDURE etextID
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'logInfo' AND type = 'P') DROP PROCEDURE logInfo
--
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'addAutoType' AND type = 'P') DROP PROCEDURE addAutoType
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'addAutoAssigned' AND type = 'P') DROP PROCEDURE addAutoAssigned
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'addType' AND type = 'P') DROP PROCEDURE addType
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'addAsd' AND type = 'P') DROP PROCEDURE addAsd
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'modifySettingsForUID' AND type = 'P') DROP PROCEDURE modifySettingsForUID
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'dump_schedule' AND type = 'P') DROP PROCEDURE dump_schedule
--
--
GO
--
PRINT 'Alle Prozeduren gelöscht.'
GO
--
IF EXISTS (SELECT DOMAIN_NAME FROM INFORMATION_SCHEMA.DOMAINS WHERE DOMAIN_NAME = 'DESCRIPTION') EXEC sp_droptype 'DESCRIPTION'
IF EXISTS (SELECT DOMAIN_NAME FROM INFORMATION_SCHEMA.DOMAINS WHERE DOMAIN_NAME = 'COMMENT') EXEC sp_droptype 'COMMENT'
IF EXISTS (SELECT DOMAIN_NAME FROM INFORMATION_SCHEMA.DOMAINS WHERE DOMAIN_NAME = 'LABEL') EXEC sp_droptype 'LABEL'
IF EXISTS (SELECT DOMAIN_NAME FROM INFORMATION_SCHEMA.DOMAINS WHERE DOMAIN_NAME = 'MINI') EXEC sp_droptype 'MINI'
IF EXISTS (SELECT DOMAIN_NAME FROM INFORMATION_SCHEMA.DOMAINS WHERE DOMAIN_NAME = 'LOGINAME') EXEC sp_droptype 'LOGINAME'
IF EXISTS (SELECT DOMAIN_NAME FROM INFORMATION_SCHEMA.DOMAINS WHERE DOMAIN_NAME = 'FILEKEY')
	BEGIN
		EXEC sp_unbindefault 'FILEKEY'
		EXEC sp_droptype 'FILEKEY'
	END
IF EXISTS (SELECT DOMAIN_NAME FROM INFORMATION_SCHEMA.DOMAINS WHERE DOMAIN_NAME = 'SUBJECT')
	BEGIN
		EXEC sp_unbindefault 'SUBJECT'
		EXEC sp_droptype 'SUBJECT'
	END
GO
--
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'FILENULL' AND type = 'D') DROP DEFAULT FILENULL
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'SUBJNULL' AND type = 'D') DROP DEFAULT SUBJNULL
GO
--
--	Defaultwert für das interne Aktenzeichen
CREATE DEFAULT FILENULL AS '0'
GO
--	Defaultwert für den Betreff (amtl. Zeichen)
CREATE DEFAULT SUBJNULL AS ' '
GO
--
--
--
EXEC sp_addtype @typename='DESCRIPTION', @phystype='VARCHAR(255)', @nulltype='NOT NULL'
EXEC sp_addtype @typename='COMMENT', @phystype='VARCHAR(50)', @nulltype='NOT NULL'
EXEC sp_addtype @typename='LABEL', @phystype='VARCHAR(15)', @nulltype='NOT NULL'
EXEC sp_addtype @typename='MINI', @phystype='VARCHAR(6)', @nulltype='NOT NULL'
--
--	Datentyp für das interne Aktenzeichen
--
EXEC sp_addtype @typename='FILEKEY', @phystype='VARCHAR (5)', @nulltype='NOT NULL'
EXEC sp_bindefault @defname='FILENULL', @objname='FILEKEY'
GO
--
--	Speicherung der Benutzernamen
--
EXEC sp_addtype @typename='LOGINAME', @phystype='VARCHAR(25)', @nulltype='NOT NULL'
GO
--
--	Der Betreff (amtl. Zeichen) für die Fristen
--
EXEC sp_addtype @typename='SUBJECT', @phystype='VARCHAR(15)', @nulltype='NOT NULL'
EXEC sp_bindefault @defname='SUBJNULL', @objname='SUBJECT'
--
PRINT N'Alle Defaults und Domains erstellt.'
GO
--
--
--	NEUE TABELLE: shift
--
	CREATE TABLE shift (
		id 			INT NOT NULL,
		val 			INT NOT NULL,
		fix			BIT DEFAULT 0 NOT NULL,
		description 		DESCRIPTION,
		CONSTRAINT shift_h1 CHECK (val IN ('1', '2', '5')),
		CONSTRAINT shift_pk PRIMARY KEY (id),
		CONSTRAINT shift_c1 UNIQUE (val),
		CONSTRAINT shift_c2 UNIQUE (description)
	) ;	
GO

CREATE TRIGGER shift_DTrig ON shift FOR DELETE AS
	--
	--	Der Trigger verhindert das Entfernen 
	--	der ursprünglichen Einträge, die durch
	--	dieses Skript eingetragen werden.
	--
	SET NOCOUNT ON
	IF EXISTS (SELECT id FROM deleted WHERE fix <> 0)
		BEGIN
			RAISERROR 44447 N'Die vordefinierten Zeitraeume können nicht aus der Datenbank entfernt werden.'
			ROLLBACK TRANSACTION
		END
GO
--
INSERT INTO shift (id, val, fix, description) VALUES ('1', '5', '1', N'Tag(e)')
INSERT INTO shift (id, val, fix, description) VALUES ('2', '2', '1', N'Monat(e)')
INSERT INTO shift (id, val, fix, description) VALUES ('3', '1', '1', N'Jahr(e)')
GO
--
PRINT N'Tabelle ''shift'' erstellt und gef' + CHAR(252) + 'llt.'
GO

--
--	NEUE TABELLE: login
--
	CREATE TABLE login (
		id 			INT IDENTITY (1,1),
		kurz	 		MINI,
		name 		VARCHAR (50) NOT NULL,
		passwd 		VARCHAR (50) DEFAULT '74215744' NOT NULL ,
		salt 			VARCHAR (10) DEFAULT 'initial' NOT NULL ,
		permlogin 		BIT DEFAULT 1,
		perminsert 		BIT DEFAULT 1,
		permdelete 	BIT DEFAULT 1,
		permadmin 		BIT DEFAULT 0,
		fix			BIT DEFAULT 0 NOT NULL,
		CONSTRAINT login_h1 CHECK (0 = permlogin ^ (perminsert | permdelete | permadmin)),
		CONSTRAINT login_pk PRIMARY KEY (id),
		CONSTRAINT login_c1 UNIQUE (kurz),
		CONSTRAINT login_c2 UNIQUE (name)
	) ;
GO

CREATE TRIGGER login_DTrig ON login FOR DELETE AS
	--
	--	Der Trigger verhindert das Entfernen der 
	--	ursprünglichen Einträge, die durch dieses
	--	Skript eingetragen werden.
	--
	SET NOCOUNT ON
	IF EXISTS (SELECT id FROM deleted WHERE deleted.fix <> 0)
		BEGIN
			RAISERROR 44447 N'Die vordefinierten Benutzer können nicht aus dem System entfernt werden.'
			ROLLBACK TRANSACTION
		END
GO

SET IDENTITY_INSERT login ON
INSERT INTO login (id, kurz, name, permlogin, perminsert, permdelete, permadmin, fix) VALUES ('1', N'Adm', N'Administrator', '1', '0', '0', '1','1')
INSERT INTO login (id, kurz, name, passwd, permlogin, perminsert, permdelete, permadmin, fix) VALUES ('2', N'N.N.', N'Unbekannter Benutzer', 'initial+','0', '0', '0', '0','1')
SET IDENTITY_INSERT login OFF
GO
--
PRINT N'Tabelle ''login'' erstellt und gef' + CHAR(252) + 'llt.'
GO


-- NEUE TABELLE: assigned
--
	CREATE TABLE assigned (
		id 			INT IDENTITY (1,1),
		label 			LABEL,
		login 			INT NOT NULL,
		fix			BIT DEFAULT 0 NOT NULL,
		description 		DESCRIPTION,
		CONSTRAINT assigned_pk PRIMARY KEY (id),
		CONSTRAINT assigned_c1 UNIQUE (label),
		CONSTRAINT assigned_c2 FOREIGN KEY (login) REFERENCES login (id)
	) ;
GO

SET IDENTITY_INSERT assigned ON
INSERT INTO assigned (id, label, login, fix, description) VALUES ('1', 'N.N.', '2', '1', 'Standardzuweisung') ;
SET IDENTITY_INSERT assigned OFF
GO

CREATE TRIGGER assigned_ITrig ON assigned FOR INSERT, UPDATE AS
	--
	--	Der Trigger verhindert Zuweisungen von 
	--	Bearbeiterkürzeln auf Systembenutzer (z.B. Adm, NN)
	--
	SET NOCOUNT ON
	IF EXISTS (SELECT id FROM inserted WHERE EXISTS 
			(SELECT l.id FROM login l, systemlogin s WHERE l.id = s.login AND l.id = inserted.login))
		BEGIN
			RAISERROR 44447 N'Zuweisungen koennen nicht auf Systembenutzer erfolgen.'
			ROLLBACK TRANSACTION
		END
GO

CREATE TRIGGER assigned_DTrig ON assigned FOR DELETE AS
	--
	--	Der Trigger verhindert das Entfernen der 
	--	ursprünglichen Einträge, die durch dieses
	--	Skript eingetragen werden.
	--
	SET NOCOUNT ON
	IF EXISTS (SELECT id FROM deleted WHERE deleted.fix <> 0)
		BEGIN
			RAISERROR 44447 N'Die vordefinierten Zuweisungen können nicht aus der Datenbank entfernt werden.'
			ROLLBACK TRANSACTION
		END
GO

--
PRINT N'Tabelle ''assigned'' erstellt.'
GO


-- NEUE TABELLE: context
--
	CREATE TABLE context (
		id 			INT IDENTITY (1,1),
		kurz	 		LABEL,
		color			INT NOT NULL,
		fix			BIT DEFAULT 0 NOT NULL,
		description		DESCRIPTION,
		CONSTRAINT context_pk PRIMARY KEY (id),
		CONSTRAINT context_c1 UNIQUE (kurz),
		CONSTRAINT context_c2 UNIQUE (description)
	) ;
GO

CREATE TRIGGER context_DTrig ON context FOR DELETE AS
	--
	--	Der Trigger verhindert das Entfernen
	--	der ursprünglichen Einträge, die durch
	--	dieses Skript eingetragen werden.
	--
	SET NOCOUNT ON
	IF EXISTS (SELECT id FROM deleted WHERE deleted.fix <> 0)
		BEGIN
			RAISERROR 44447 N'Die vordefinierten Kontexte können nicht aus der Datenbank entfernt werden.'
		END
GO

SET IDENTITY_INSERT context ON
--											ID	Label			Farbe, ID	Fix	Beschreibung
INSERT INTO context (id, kurz, color, fix, description) VALUES ('1', N'UNBEKANNT', 	'43', 	'1', 	N'Der Organisationszusammenhang ist unbekannt oder wurde gel' + CHAR(246) + 'scht.')
INSERT INTO context (id, kurz, color, fix, description) VALUES ('2', N'PRIVAT',         	'1', 		'1', 	N'Privater Grund.')
INSERT INTO context (id, kurz, color, fix, description) VALUES ('3', N'INTERN',         	'1', 		'1', 	N'Interner Ablauf.')
INSERT INTO context (id, kurz, color, fix, description) VALUES ('4', N'VERBINDLICH', 	'1', 		'1', 	N'Gesetzte vertragliche oder amtliche Fristen.')
INSERT INTO context (id, kurz, color, fix, description) VALUES ('5', N'OFFIZIELL',    	'1', 		'1', 	N'Notfristen.')
SET IDENTITY_INSERT context OFF
GO
--
PRINT N'Tabelle shift context und gef' + CHAR(252) + 'llt.'
GO


-- TABELLE: autodeadline
--
	CREATE TABLE autodeadline (
		id 			INT IDENTITY (1,1),
		label 			VARCHAR (50) NOT NULL,
		offset 		INT NOT NULL,
		shift	 		INT NOT NULL,
		rank 			INT DEFAULT 0 NOT NULL,
		context 		INT NOT NULL,
		description 		DESCRIPTION,
		CONSTRAINT autodeadline_h1 CHECK (offset > 0 AND id <> 0),
		CONSTRAINT autodeadline_pk PRIMARY KEY (id),
		CONSTRAINT autodeadline_c1 UNIQUE (label),
		CONSTRAINT autodeadline_c2 UNIQUE (description),
		CONSTRAINT autodeadline_c3 FOREIGN KEY (shift)  REFERENCES shift (id),
		CONSTRAINT autodeadline_c4 FOREIGN KEY (context) REFERENCES context (id)
	) ;
GO

SET IDENTITY_INSERT autodeadline ON
INSERT INTO autodeadline (id, label, offset, shift, rank, context, description) VALUES ('1',N'Nur den Endtermin','1','2','4','5',N'Standardfrist ohne Wiedervorlage')
INSERT INTO autodeadline (id, label, offset, shift, rank, context, description) VALUES ('2',N'Frist mit einer Wiedervorlage','1','2','4','5',N'Standardfrist mit einer Wiedervorlage')
INSERT INTO autodeadline (id, label, offset, shift, rank, context, description) VALUES ('3',N'Frist mit zwei Wiedervorlagen','1','2','4','5',N'Standardfrist mit zwei Wiedervorlagen')
INSERT INTO autodeadline (id, label, offset, shift, rank, context, description) VALUES ('4',N'Frist mit drei Wiedervorlagen','1','2','4','5',N'Standardfrist mit drei Wiedervorlagen')
INSERT INTO autodeadline (id, label, offset, shift, rank, context, description) VALUES ('5',N'Interne Frist','1','2','3','5',N'Interne Frist')
SET IDENTITY_INSERT autodeadline OFF
GO
--
PRINT N'Tabelle ''autodeadline'' erstellt und gef' + CHAR(252) + 'llt.'
GO


-- NEUE TABELLE: autoassigned
--
	CREATE TABLE autoassigned (
		autodeadline 	INT NOT NULL REFERENCES autodeadline (id),
		assigned 		INT NOT NULL REFERENCES assigned (id),
		rank 			INT DEFAULT 0 NOT NULL
		CONSTRAINT autoassigned_pk PRIMARY KEY (autodeadline, assigned)
	) ;
GO
--
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','1','1')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','1','1')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','1','1')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('4','1','1')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('5','1','1')

GO
--
PRINT N'Tabelle ''autoassigned'' erstellt und gef' + CHAR(252) + 'llt.'
GO



-- NEUE TABELLE: autonotification
--
	CREATE TABLE autonotification (
		autodeadline 	INT NOT NULL REFERENCES autodeadline (id),
		offset 		INT NOT NULL,
		shift			INT NOT NULL REFERENCES shift (id),
		mutable 		BIT DEFAULT 1 NOT NULL,
		CONSTRAINT autonotification_pk PRIMARY KEY (autodeadline, offset, shift),
		CONSTRAINT autonotification_h1 CHECK (offset > 0)
	) ;
GO
--
INSERT INTO autonotification (autodeadline, offset, shift) VALUES ('2','1','2')
INSERT INTO autonotification (autodeadline, offset, shift) VALUES ('3','1','2')
INSERT INTO autonotification (autodeadline, offset, shift) VALUES ('3','2','2')
INSERT INTO autonotification (autodeadline, offset, shift) VALUES ('4','1','2')
INSERT INTO autonotification (autodeadline, offset, shift) VALUES ('4','2','2')
INSERT INTO autonotification (autodeadline, offset, shift) VALUES ('4','3','2')
GO
--
PRINT N'Tabelle ''autonotification'' erstellt und gef' + CHAR(252) + 'llt.'
GO



--	Die Tabelle 'dtype' enthält die Typen, nach denen sich die Fristen klassifizieren lassen
--	Bedeutung der Felder:
--		mini		Kurzlabel zur Anzeige in der Übersicht
--		label		Label, das im Formular zum Erstellen der Frist angezeigt wird
--		rank		Rang für die Ordnung der Einträge in der Übersicht
--		color		Farbe in allen Anzeigen (Übersicht, Detail, etc.)
--		maxn		Max. Anzahl der möglichen WV
--		maxc		Max. Anzahl der möglichen Kommentare
--		predel		???
--		context	Kontext, dem der Typ angehört
--		fix		'true', falls unveränderlich
--		description	Beschreibung (Detail)
--
	CREATE TABLE dtype (
		id 			INT IDENTITY (1,1),
		mini 			MINI,
		label 			LABEL,
		rank 			INT DEFAULT 10 NOT NULL,
		color 			INT DEFAULT 1 NOT NULL,
		maxn 		INT DEFAULT 20 NOT NULL,
		maxc 		INT DEFAULT 100 NOT NULL,
		predel 		BIT DEFAULT 1,
		context 		INT DEFAULT 1 NOT NULL,
		fix			BIT DEFAULT 0 NOT NULL,
		description 		DESCRIPTION,
		CONSTRAINT dtype_h1 CHECK (NOT maxc < 0 AND NOT maxn < 0 AND id <> 0),
		CONSTRAINT dtype_pk PRIMARY KEY (id),
		CONSTRAINT dtype_c1 UNIQUE (mini),
		CONSTRAINT dtype_c2 UNIQUE (label),
		CONSTRAINT dtype_c3 UNIQUE (description),
		CONSTRAINT dtype_c4 FOREIGN KEY (context) REFERENCES context (id)
	) ;
GO

CREATE TRIGGER dtype_DTrig ON dtype FOR DELETE, UPDATE AS
	--
	--	Der Trigger verhindert das Entfernen
	--	der ursprünglichen Einträge, die durch
	--	dieses Skript eingetragen werden.
	--
	SET NOCOUNT ON
	IF EXISTS (SELECT id FROM deleted WHERE fix <> 0)
		BEGIN
			RAISERROR 44447 N'Die vordefinierten Fristtypen koennen weder geaendert noch aus der Datenbank entfernt werden.'
			ROLLBACK TRANSACTION
		END
GO

SET IDENTITY_INSERT dtype ON
INSERT INTO dtype (id, mini, label, rank, color, maxn, maxc, predel, context, fix, description) VALUES ('1', N'???', N'Unbekannt','15','43','20', '100','1','1','1',N'Der Typ ist unbekannt oder wurde gel' + CHAR(246) + N'scht.')
INSERT INTO dtype (id, mini, label, rank, color, maxn, maxc, predel, context, fix, description) VALUES ('2', N'INT', N'Intern','20','34','0', '100','1','3','1',N'Interner Termin / Erinnerung.')
INSERT INTO dtype (id, mini, label, rank, color, maxn, maxc, predel, context, fix, description) VALUES ('3', N'', N'Normal','10','1','10', '100','1','4','1',N'Standardfrist.')
INSERT INTO dtype (id, mini, label, rank, color, maxn, maxc, predel, context, fix, description) VALUES ('4', N'U.V.', N'U.V.','20','32','20', '100','1','5','1',N'Unverl' + CHAR(228) + 'ngerbare Frist (Rechtsverlust).')
INSERT INTO dtype (id, mini, label, rank, color, maxn, maxc, predel, context, fix, description) VALUES ('5', N'U.V.S.', N'U.V.S.','5','32','20', '100','1','5','1',N'Unverl' + CHAR(228) + 'ngerbare Zahlungsfrist f' + CHAR(252) + N'r Selbstzahler.')
INSERT INTO dtype (id, mini, label, rank, color, maxn, maxc, predel, context, fix, description) VALUES ('6', N'L.FR.', N'L.FR.','27','2','32', '100','1','5','1',N'Unverl' + CHAR(228) + 'ngerbare gesetzliche Frist (Rechtsverlust).')
INSERT INTO dtype (id, mini, label, rank, color, maxn, maxc, predel, context, fix, description) VALUES ('7', N'CHECK', N'Empfangsbest.','5','47','0', '100','1','3','1',N'Nachhalten der Empfangsbest' + CHAR(228) + 'tigung nach Versand eines Schriftsatzes.')
SET IDENTITY_INSERT dtype OFF
GO
--
PRINT N'Tabelle ''dtype'' erstellt und gef' + CHAR(252) + 'llt.'
GO



--	Die Tabelle 'cont' enthält Einträge, die angeben, ob beim Löschen einer Frist eines
--	bestimmten Typs ein Fortsetzungseintrag eines anderen bestimmten Typs erstellt
--	werden kann (im Formular zur Bestätigung des Löschvorgangs).
--	Bedeutung der Felder:
--		bind		Typ der zu löschenden Frist, für die die Funktion aktiviert wird
--		type		Typ der optional zu erstellenden Frist
--		shift		Vorlaufdauer in Tagen, Wochen, Monaten
--		offset 	Anzahl derselben s.o.
--		mutable	Vorlaufdauer/Aktion kann vom Benutzer geändert werden
--
	CREATE TABLE cont (
		bind 			INT NOT NULL REFERENCES dtype (id),
		type 			INT NOT NULL REFERENCES dtype (id),
		shift 			INT NOT NULL REFERENCES shift (id),
		offset 		INT DEFAULT 1 NOT NULL,
		mutable 		BIT DEFAULT 1 NOT NULL,
		CONSTRAINT cont_h1 CHECK (offset > 0),
		CONSTRAINT cont_pk PRIMARY KEY (bind)
	)  ;
GO

INSERT INTO cont (bind, type, shift, offset, mutable) VALUES ('3','7','1','10','1')
GO
--
PRINT N'Tabelle ''cont'' erstellt und gef' + CHAR(252) + 'llt.'
GO



--	Die Tabelle 'autotype' bindet einen Fristtyp aus der Tabelle 'dtype' an ein Formular
--	aus der Tabelle 'autodeadline'. Es werden in der Auswahl der möglichen Typen in den
--	Formularen nur die gebundenen Typen angezeigt.
--	Bedeutung der Felder:
--		autodeadline	Das betreffende Formular
--		type		Der zu bindende Fristtyp
--		rank		Ordnung der Anzeige im Formular
--
	CREATE TABLE autotype (
		autodeadline 	INT NOT NULL,
		type 			INT NOT NULL,
		rank 			INT DEFAULT 0 NOT NULL,
		CONSTRAINT autotype_pk PRIMARY KEY (autodeadline, type),
		CONSTRAINT autotype_c1 FOREIGN KEY (autodeadline) REFERENCES autodeadline (id),
		CONSTRAINT autotype_c2 FOREIGN KEY (type) REFERENCES dtype (id)
	) ;
GO
--	Frist ohne WV
INSERT INTO autotype (autodeadline, type, rank) VALUES ('1','3','0')
INSERT INTO autotype (autodeadline, type, rank) VALUES ('1','4','1')
INSERT INTO autotype (autodeadline, type, rank) VALUES ('1','5','-1')
INSERT INTO autotype (autodeadline, type, rank) VALUES ('1','6','2')
--	Frist mit einer WV
INSERT INTO autotype (autodeadline, type, rank) VALUES ('2','3','0')
INSERT INTO autotype (autodeadline, type, rank) VALUES ('2','4','1')
INSERT INTO autotype (autodeadline, type, rank) VALUES ('2','5','-1')
INSERT INTO autotype (autodeadline, type, rank) VALUES ('2','6','2')
--	Frist mit zwei WV
INSERT INTO autotype (autodeadline, type, rank) VALUES ('3','3','0')
INSERT INTO autotype (autodeadline, type, rank) VALUES ('3','4','1')
INSERT INTO autotype (autodeadline, type, rank) VALUES ('3','5','-1')
INSERT INTO autotype (autodeadline, type, rank) VALUES ('3','6','2')
--	Frist mit drei WV
INSERT INTO autotype (autodeadline, type, rank) VALUES ('4','6','2')
--	Interne Frist:
INSERT INTO autotype (autodeadline, type, rank) VALUES ('5','2','0')
GO
--
PRINT N'Tabelle ''autotype'' erstellt und gef' + CHAR(252) + 'llt.'
GO



-- NEUE TABELLE: detail
--
	CREATE Table detail (
		id 			INT IDENTITY (1,1),
		assigned 		INT DEFAULT 1 NOT NULL,
		type 			INT NOT NULL,
		akte 			FILEKEY,
		subject 		SUBJECT,
		description 		COMMENT DEFAULT ' ',
		meta 		VARCHAR (15) DEFAULT ' ' NOT NULL,
		CONSTRAINT detail_pk PRIMARY KEY (id),
		CONSTRAINT detail_c1 FOREIGN KEY (assigned) REFERENCES assigned (id),
		CONSTRAINT detail_c2 FOREIGN KEY (type) REFERENCES dtype (id)
	) ;
GO

CREATE TRIGGER detail_UTrig ON detail FOR UPDATE AS
	SET NOCOUNT ON
		RAISERROR 44447 N'Datensaetze in der Tabelle ''detail'' können nicht geaendert werden'
		ROLLBACK TRANSACTION
GO
--
SET IDENTITY_INSERT detail ON
INSERT INTO detail (id, type, subject, description) VALUES ('1', '1', N'Hurra!', N'Die Datenbank wurde richtig aufgesetzt.')
SET IDENTITY_INSERT detail OFF
GO
--
PRINT N'Tabelle ''detail'' erstellt und gef' + CHAR(252) + 'llt.'
GO




--	Die Tabelle 'base' enthält die gemeinsamen Rumpfdaten der Fristen/WV.
--	Bedeutung der Felder:
--		id	Global über alle Fristen und WV's eindeutige Nummer
--		datum	Datum
--		done	'true' falls gestrichen/erledigt
--		detail	ID des zugehörigen Detaileintrags
--		noti	'true' falls WV
--
	CREATE TABLE base (
		id 			INT IDENTITY (1,1),
		datum 		DATETIME NOT NULL, 
		done 			BIT DEFAULT 0, 
		detail 		INT NOT NULL,
		noti 			BIT DEFAULT 0,
		CONSTRAINT base_h1 CHECK (NOT datum < CURRENT_TIMESTAMP),
		CONSTRAINT base_pk PRIMARY KEY (id),
		CONSTRAINT base_c1 FOREIGN KEY (detail) REFERENCES detail (id)
	) ;
GO
--
CREATE TRIGGER base_DTrig On base For Delete As
	--	
	--	1. Alle weiteren Basiseinträge Frist/Wiedervorlagen
	--	mit Verweis auf den gelöschten Basiseintrag löschen.
	--	2. Alle zugehörigen Ereignisse mit Verweis auf die
	--	gelöschten Basiseinträge löschen.
	--	3. Alle Details, auf die die gelöschten Basiseinträge
	--	verweisen, löschen. 
	--
	SET NOCOUNT ON
	DELETE base FROM base, deleted WHERE base.detail = deleted.detail AND deleted.noti = 0
	DELETE event FROM deleted, event WHERE event.base = deleted.id 
	DELETE detail FROM deleted, detail WHERE deleted.detail = detail.id AND  deleted.noti = 0
GO
--
CREATE TRIGGER base_ITrig On base FOR Insert AS 
	--
	-- 	1. Testen, ob zu der neuen Wiedervorlage auch ein Fristeintrag besteht.
	--	Dazu erst testen, ob es sich um eine Wiedervorlage handelt (noti = 1).
	--	2. Testen, ob das Datum der bestehenden Frist als Basis für die
	--	Wiedervorlage vor dem der neuen Wiedervorlage ist.
	--	3 Testen, ob es an dem betreffenden Datum bereits eine Wiedervorlage
	--	zu dem Detail gibt.
	--	4. Testen, ob es bereits eine Frist mit demselben Detail gibt (wäre verboten).
	--	Der Fall sollte eigentlich nie vorkommen.
	--
	IF (SELECT COUNT (*) FROM inserted WHERE inserted.noti = 1) > 0
	    IF (SELECT COUNT(*) FROM base, inserted WHERE base.detail = inserted.detail AND inserted.noti = 1 AND base.noti = 0) = 0
		BEGIN
		    RAISERROR 44445 N'Der Datensatz kann nicht erstellt werden: Zu jeder Wiedervorlage muss es eine Frist geben.'
		    ROLLBACK TRANSACTION
		END
	IF (SELECT COUNT(*) FROM base b, base x WHERE b.detail = x.detail AND b.noti = 0 AND x.noti = 1 AND NOT b.datum > x.datum) > 0
	    BEGIN
		RAISERROR 44445 N'Der Datensatz kann nicht erstellt werden: Das Fristende muss immer zeitlich nach allen Wiedervorlagen liegen.'
		ROLLBACK TRANSACTION
	    END
	IF (SELECT COUNT (*) FROM inserted, base WHERE inserted.id <> base.id AND inserted.detail = base.detail AND base.noti <> 0 AND inserted.datum = base.datum) > 0
	    BEGIN
		RAISERROR 44445 N'Der Datensatz kann nicht erstellt werden: Zu einem Detaileintrag koennen keine zwei Wiedervorlagen mit dem gleichen Datum erstellt werden.'
		ROLLBACK TRANSACTION
	    END
	IF (SELECT COUNT (*) FROM inserted, base WHERE inserted.id <> base.id AND inserted.detail = base.detail AND inserted.noti = 0 AND base.noti = 0) > 0
	    BEGIN
		RAISERROR 44445 N'Der Datensatz kann nicht erstellt werden: Zu einem Detaileintrag koennen keine zwei Eintraege mit noti = 0 erstellt werden.'
		ROLLBACK TRANSACTION
	    END
GO
--
CREATE TRIGGER base_UTrig On base For Update As
	--
	SET NOCOUNT ON
	IF UPDATE (done)
	  IF (SELECT COUNT(*) FROM deleted, base WHERE deleted.noti = 0 AND deleted.detail = base.detail AND base.noti = 1 AND base.done = 0) > 0
	  BEGIN
		RAISERROR 44445 N'Die Frist kann nicht als erledigt gekennzeichnet werden, solange es nicht erledigte Wiedervorlagen dazu gibt.'
		ROLLBACK TRANSACTION
	  END
	-- Datum, Detail und der Typ dürfen nachträglich nicht mehr geändert werden.
	IF UPDATE (datum) OR UPDATE (detail) OR UPDATE (noti)
	    BEGIN
		RAISERROR 44445 N'Der Datum, Detail und Noti dürfen in der Tabelle detail nicht veraendert werden'
		ROLLBACK TRANSACTION
	    END
GO
--
SET IDENTITY_INSERT base ON
INSERT INTO base (id, datum, detail) VALUES ('1', CURRENT_TIMESTAMP, '1')
SET IDENTITY_INSERT base OFF
GO
--
PRINT N'Tabelle ''base'' erstellt und gef' + CHAR(252) + 'llt.'
GO



--	Die Tabelle 'etype' enthält die Typen, nach denen die Vorgänge klassifiziert werden.
--	Bedeutung der Felder:
--		id		Surrogatschlüssel
--		label		Kurze Anzeige der Bedeutung
--		description	Lange Beschreibung
--		fix		'true' falls der Ereignistyp nicht gelöscht oder geändert werden darf
--
	Create TABLE etype (
		id 			INT IDENTITY (1,1),
		label 			MINI,
		description 		DESCRIPTION,
		fix			BIT DEFAULT 0 NOT NULL,
		CONSTRAINT etype_pk PRIMARY KEY (id),
		CONSTRAINT etype_c1 UNIQUE (label),
		CONSTRAINT etype_c2 UNIQUE (description)
	) ;
GO
--
CREATE TRIGGER etype_DTrig ON etype FOR DELETE AS
	SET NOCOUNT ON
	IF EXISTS (SELECT id FROM deleted WHERE fix <> 0)
		BEGIN
			RAISERROR 44447 N'Vordefinierte Ereignistypen koennen nicht aus der Datenbank entfernt werden.'
			ROLLBACK TRANSACTION
		END
GO
--
SET IDENTITY_INSERT etype ON
INSERT INTO etype (id, label, description, fix) VALUES ('1', N'???', N'Das Ereignis ist nicht klassifiziert oder der urspr' + CHAR(252) + N'ngliche Ereignistyp wurde gelöscht.','1')
INSERT INTO etype (id, label, description, fix) VALUES ('2', N'NEU', N'Die Frist wurde erstellt.','1')
INSERT INTO etype (id, label, description, fix) VALUES ('3', N'+WV', N'Eine Wiedervorlage wurde hinzugef' + CHAR(252) + N'gt.','1')
INSERT INTO etype (id, label, description, fix) VALUES ('4', N'DEL', N'Die Frist wurde als erledigt gekennzeichnet.','1')
INSERT INTO etype (id, label, description, fix) VALUES ('5', N'-WV', N'Eine Wiedervorlage wurde als erledigt gekennzeichnet.','1')
INSERT INTO etype (id, label, description, fix) VALUES ('6', N'+COMM', N'Ein Bearbeiterhinweis wurde zu der Frist hinzugef' + CHAR(252) + N'gt.','1')
SET IDENTITY_INSERT etype OFF
GO
--
PRINT N'Tabelle ''etype'' erstellt und gef' + CHAR(252) + 'llt.'
GO



-- NEUE TABELLE: etext
--
	CREATE TABLE etext (
		id 			INT IDENTITY (1,1),
		fix			BIT DEFAULT 0 NOT NULL,
		description		DESCRIPTION,
		CONSTRAINT etext_c1 UNIQUE (description),
		CONSTRAINT etext_pk PRIMARY KEY (id)
	) ;
GO
--
CREATE TRIGGER etext_DTrig ON etext FOR DELETE AS
	SET NOCOUNT ON
	IF EXISTS (SELECT id FROM deleted WHERE deleted.fix <> 0)
		BEGIN
			RAISERROR 44447 N'Die vordefinierten Ereignistexte können nicht aus der Datenbank entfernt werden.'
			ROLLBACK TRANSACTION
		END
GO
--
SET IDENTITY_INSERT etext ON
INSERT INTO etext (id, fix, description) VALUES ('1','1','')
SET IDENTITY_INSERT etext OFF
GO
--
PRINT N'Tabelle ''etext'' erstellt und gef' + CHAR(252) + 'llt.'
GO



-- NEUE TABELLE: event
--
	CREATE TABLE event (
		id 			INT IDENTITY (1,1),
		base 			INT NOT NULL,
		type 			INT NOT NULL,
		login	 		INT NOT NULL,
		datum	 	DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
		etext			INT NOT NULL DEFAULT 1,
		CONSTRAINT event_h1 CHECK (NOT datum < CURRENT_TIMESTAMP),
		CONSTRAINT event_pk PRIMARY KEY (id),
		CONSTRAINT event_c1 FOREIGN KEY (base) REFERENCES base (id),
		CONSTRAINT event_c2 FOREIGN KEY (type) REFERENCES etype (id),
		CONSTRAINT event_c3 FOREIGN KEY (login) REFERENCES login (id),
		CONSTRAINT event_c4 FOREIGN KEY (etext) REFERENCES etext (id)
	) ;
GO
--
INSERT INTO event (base, type, login, etext) VALUES ('1', '2', '1', '1')
GO
--
PRINT N'Tabelle ''event'' erstellt und gef' + CHAR(252) + 'llt.'
GO




-- NEUE TABELLE: seclog
--
	CREATE TABLE seclog (
		id 			INT IDENTITY (1,1),
		category 		INT DEFAULT 1 NOT NULL,
		datum 		DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
		message 		DESCRIPTION,
		CONSTRAINT seclog_h1 CHECK (category IN ('1','2','3')),
		CONSTRAINT seclog_h2 CHECK (NOT datum < CURRENT_TIMESTAMP),
		CONSTRAINT seclog_pk PRIMARY KEY (id)
	) ;
GO
--
INSERT INTO seclog (category, message) VALUES ('1', N'INFO: Datenbankschema wurde geladen.')
GO
--
PRINT N'Tabelle seclog erstellt und gef' + CHAR(252) + 'llt.'
GO




-- NEUE TABELLE: systemlogin
--
	CREATE TABLE systemlogin (
		login 			INT NOT NULL,
		permlogin 		BIT DEFAULT 1 NOT NULL,
		perminsert 		BIT DEFAULT 0 NOT NULL,
		permdelete 	BIT DEFAULT 0 NOT NULL,
		permadmin 		BIT DEFAULT 0 NOT NULL,
		defuser 		BIT DEFAULT 0 NOT NULL,
		CONSTRAINT systemlogin_pk PRIMARY KEY (login),
		CONSTRAINT systemlogin_c1 FOREIGN KEY (login) REFERENCES login(id),
		CONSTRAINT systemlogin_h1 CHECK (0 = permlogin ^ (perminsert | permdelete | permadmin))
	) ;
GO
--
INSERT INTO systemlogin (login, permlogin, perminsert, permdelete, permadmin, defuser) VALUES ('1','1','0','0', '1','0')
INSERT INTO systemlogin (login, permlogin, perminsert, permdelete, permadmin, defuser) VALUES ('2','0','0','0', '0','1')
GO
--
--
GRANT SELECT ON assigned TO scr, scw
GRANT SELECT ON base TO scr, scw
GRANT SELECT ON event TO scr, scw
GRANT SELECT ON etext TO scr, scw 
GRANT SELECT (kurz, name, fix) ON login TO scr, scw
GRANT SELECT ON seclog TO scr, scw
GO

CREATE PROCEDURE getAssign (@aid INTEGER) AS
	--
	--	Bearbeiterkürzel abfragen
	--
	SELECT a.login, a.label, a.description
	FROM assigned a 
	WHERE a.id = @aid 
	--
	RETURN @@ROWCOUNT
GO

CREATE PROCEDURE getContexts AS 
	--
	--
	--
	SELECT id, kurz, description, color FROM context ORDER BY 3 ASC
	--
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE getForms (@mode BIT = 0) AS
	--
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	IF @mode = 0
		BEGIN
			SELECT a.id, a.label 
			FROM autodeadline a 
			WHERE
				(SELECT COUNT (*) FROM autotype t WHERE t.autodeadline = a.id) <> 
				(SELECT COUNT (*) FROM dtype)
			ORDER BY 2 ASC
		END
	ELSE
		BEGIN
			SELECT a.id, a.label 
			FROM autodeadline a 
			WHERE EXISTS (SELECT t.autodeadline FROM autotype t WHERE t.autodeadline = a.id)
			ORDER BY 2 ASC
		END
	--
	RETURN @@ROWCOUNT
GO

CREATE PROCEDURE autoDeadlinePreviewListA (@cxt INTEGER) AS 
	--
	--	Kurze Liste der verfügbaren Vorlagen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT t1.id, count (*) 
	FROM autodeadline AS t1, autonotification AS t2 
	WHERE t1.id = t2.autodeadline AND t1.context = @cxt 
	GROUP BY t1.id 
	--
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE autoDeadlinePreviewListB (@cxt INTEGER) AS 
	--
	--	Lange Liste der verfügbaren Vorlagen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT id, label FROM autodeadline WHERE context = @cxt ORDER BY rank DESC 
	--
	RETURN @@ROWCOUNT
GO



CREATE PROCEDURE getAssignList AS 
	--
	--	Liste der Bearbeiter.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT DISTINCT a.id, a.label 
	FROM assigned a 
	ORDER BY a.label ASC
	--
	RETURN @@ROWCOUNT
GO

CREATE PROCEDURE getAutoAssignList (@aid INTEGER) AS
	--
	--	Liste der Bearbeiter zu einer Vorlage holen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT a.id, a.label 
	FROM assigned AS a, autoassigned AS b 
	WHERE a.id = b.assigned AND b.autodeadline = @aid 
	ORDER BY b.rank DESC
	--
	RETURN @@ROWCOUNT
GO

CREATE PROCEDURE getAutodeadline (@aid INTEGER) AS 
	--
	--	Einzelheiten zu einer Vorlage holen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT label, description FROM autodeadline WHERE id = @aid
	--
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE getAutoNotificationList (@aid INTEGER) AS 
	--
	--	Liste der Wiedervorlagen zu einer Vorlage.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT offset, shift, mutable 
	FROM autonotification 
	WHERE autodeadline = @aid
	--
	RETURN @@ROWCOUNT
GO

CREATE PROCEDURE getTypeList (@aid INTEGER = -1) AS 
	--
	--	Liste der Fristtypen zu einer Vorlage bzw. alle für Parameter '-1'
	--	2004-03-07: @@rowcount Rückgabewert hinzugefügt
	--	2004-05-01: Color Problem 
	--
	SELECT DISTINCT t.id, t.label, t.color, t.rank  
	FROM autodeadline a, autotype b, dtype t  
	WHERE (b.type = t.id OR @aid = -1)
	AND a.id = b.autodeadline 
	AND (a.id = @aid OR @aid = -1)
	ORDER by t.rank DESC
	--
	RETURN @@ROWCOUNT
GO

CREATE PROCEDURE getTypes AS
	--
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT t.id, t.mini, t.label, t.rank, t.color, t.maxn, t.maxc, t.predel, t.context, t.description, t.fix  
	FROM dtype t
	ORDER BY 1 ASC
	--
	RETURN @@ROWCOUNT
	--
GO


CREATE PROCEDURE getDateFromID (@bid INTEGER) AS 
	--
	--	Datum zu einer 'id'.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT datum FROM base WHERE id = @bid
	--
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE getDeadlineOV_ID (@gid INTEGER) AS
	--
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT b.id, b.datum, d.akte, d.subject, d.description, b.done, d.type
	FROM base b, base x, detail d, dtype t 
	WHERE b.detail = d.id 
	AND b.noti = 0 
	AND d.type = t.id 
	AND DATEPART (yyyy, b.datum) = DATEPART (yyyy, x.datum)
	AND DATEPART (mm, b.datum) = DATEPART (mm, x.datum)
	AND DATEPART (dd, b.datum) = DATEPART (dd, x.datum)
	AND x.id = @gid
	ORDER by t.rank DESC, d.akte ASC 
	--
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE getDeadlineOV (@due DATETIME) AS 
	--
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT b.id, b.datum, d.akte, d.subject, d.description, b.done, d.type 
	FROM base AS b, detail AS d, dtype AS t 
	WHERE b.detail = d.id 
	AND b.noti = 0 
	AND d.type = t.id 
	AND ABS (DATEDIFF (d, b.datum, @due)) < 1
	ORDER by t.rank DESC, d.akte ASC 
	--
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE getNotificationOV (@due DATETIME) AS  
	--
	--	Übersichtsliste der Wiedervorlagen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT b.id, b.datum, b.done, x.id, x.datum, d.akte, d.subject, d.description, x.done, d.type
	FROM base b, base x, detail d, dtype t  
	WHERE x.noti = 0 
	AND b.noti = 1 
	AND x.detail = b.detail  
	AND b.detail = d.id 
	AND t.id = d.type 
	AND ABS (DATEDIFF (d, b.datum, @due)) < 1
	ORDER by t.rank DESC, d.akte ASC
	--	
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE getDetail (@bid INTEGER) AS 
	-- 
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT b2.datum, d.akte, d.subject, d.description, d.type, b2.done, a.label, l.name, b2.id 
	FROM base AS b1, base AS b2, detail AS d, assigned AS a, login AS l 
	WHERE b1.detail = d.id 
	AND a.id = d.assigned
	AND l.id = a.login
	AND b1.detail = b2.detail
	AND b2.noti <> 1
	AND b1.id = @bid
	--
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE getEventList (@bid INTEGER) AS 
	--
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT e.id, e.datum, s.description, t.description, l.name, t.label, e.type  
	FROM etext s, event e, login l, etype t, base b, base x
	WHERE e.login = l.id AND e.type = t.id AND e.etext = s.id 
	AND e.base = b.id AND b.detail = x.detail AND x.id = @bid
	ORDER by e.datum DESC 
	--
	RETURN @@ROWCOUNT
GO



CREATE PROCEDURE eventByDate (@beg DATETIME, @end DATETIME, @mxn INTEGER = 1001) AS
	--
	--	2003-04-11, Neu: Ereignisse nach Datum anzeigen:
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--	
	SET ROWCOUNT @mxn
	--
        SELECT e.base, e.datum, e.type, t.label, t.description, l.name 
	FROM event e, login l, etype t
	WHERE e.login = l.id 
	AND e.type = t.id
	AND (e.datum BETWEEN @beg AND @end 
		OR ABS (DATEDIFF (d, e.datum, @beg)) < 1
		OR ABS (DATEDIFF (d, e.datum, @end)) < 1)
	ORDER by e.datum ASC
	--
	RETURN @@ROWCOUNT
GO



CREATE PROCEDURE getLoginNames AS 
	--
	--	Anmeldenamen für die Liste holen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT l.kurz, l.name, s.login, s.permlogin, l.permlogin, l.id 
	FROM login AS l 
	LEFT JOIN systemlogin AS s ON l.id = s.login 
	ORDER by l.kurz ASC 
	--
	RETURN @@ROWCOUNT
GO

CREATE PROCEDURE getNotification (@bid INTEGER) AS 
	--
	--	Einzelheiten zu einer Wiedervorlage holen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT b.id, b.datum, b.done, x.id, x.datum, d.akte, d.subject, d.description, x.done, d.type  
	FROM base b, base x, detail d 
	WHERE b.noti = 1 AND x.noti = 0 AND b.detail = x.detail AND b.detail = d.id AND b.id = @bid
	
	RETURN @@ROWCOUNT
GO

CREATE PROCEDURE getNotificationList (@bid INTEGER) AS 
	--
	--	Liste der Widervorlagen zu einem Fristeintrag holen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT b.id, b.datum, b.done, d.id, x.datum, d.akte, d.subject, d.description, x.done, d.type
	FROM base b, base x, detail d 
	WHERE b.noti = 1 
	AND x.noti = 0 
	AND b.detail = x.detail 
	AND b.detail = d.id 
	AND x.id = @bid 
	ORDER by b.datum 
	--
	RETURN @@ROWCOUNT
GO



CREATE PROCEDURE getPromoteForID (@bid INTEGER) AS
	--
	--	Fortsetzungstype für einen Fristeintrag holen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT c.offset, s.val, s.description, t.id, t.label, c.mutable 
	FROM base b, detail d, shift s, cont c, dtype t 
	WHERE t.id = c.type 
	AND c.shift = s.id 
	AND d.type = c.bind 
	AND d.id = b.detail 
	AND b.id = @bid 
	--
	RETURN @@ROWCOUNT
GO

CREATE PROCEDURE getShiftBase As 
	--
	--	Lesezugriff auf Tabelle 'shift'
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT val, description FROM shift ORDER by id ASC
	--
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE getUserTicket (@uid INTEGER) AS 
	--
	--	Zugriff auf Benutzereinstellungen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT LTRIM(RTRIM(l.kurz)), LTRIM(RTRIM(l.name)), l.permlogin, l.perminsert, l.permdelete, s.login, s.permlogin, s.perminsert, s.permdelete, s.permadmin, l.salt, l.passwd, l.id, l.permadmin, (SELECT COUNT (*) FROM assigned a WHERE a.login = l.id) 
	FROM login AS l 
	LEFT JOIN systemlogin AS s ON l.id = s.login 
	WHERE l.id = @uid 
	--
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE getWorkload (@beg DATETIME, @end DATETIME, @all INTEGER = 0, @lgn INTEGER) AS 
	--
	--	Übersicht über das Pensum an
	--	Fristen für einen Benutzer.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	SELECT b.id FROM base b, detail d, assigned a 
	WHERE b.detail = d.id
	AND b.noti = 0
	AND d.assigned = a.id
	AND a.login = @lgn
	AND (b.done = 0 OR @all > 0) 
	AND (b.datum BETWEEN @beg AND @end 
		OR ABS (DATEDIFF (d, b.datum, @beg)) < 1
		OR ABS (DATEDIFF (d, b.datum, @end)) < 1)
	ORDER by b.datum ASC
	--
	RETURN @@ROWCOUNT
GO



CREATE PROCEDURE nextBefore (@due DATETIME, @notis BIT = 0) AS
	--
	--	Datum des vorangehenden unerledigten Eintrags suchen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt.
	--
	SET ROWCOUNT 1
	--
	SELECT b.datum 
	FROM base b 
	WHERE b.done = 0 
	AND (b.noti = 0 OR @notis <> 0) 
	AND b.datum < @due 
	AND DATEPART (dd,b.datum) <> DATEPART (dd,@due)
	ORDER BY 1 DESC
	--
	RETURN @@ROWCOUNT
GO



CREATE PROCEDURE searchAny (@tok VARCHAR(253), @mta VARCHAR(253) = 'nix', @mxn INTEGER = 1001)  AS
	--
	--	Zeichenkette in allen Feldern suchen.
	--
	DECLARE @etok VARCHAR(255) 
	DECLARE @emta VARCHAR(255)  
	--
	SET @etok = '%' + RTRIM(LTRIM(@tok)) + '%' 
	SET @emta= '%' + RTRIM(LTRIM(@mta)) + '%' 
	--
	SET ROWCOUNT @mxn
	--	
	SELECT DISTINCT b.id, b.done, b.datum  
	FROM base b, base x, detail t1, event t2, etext t3 
	WHERE b.detail = t1.id 
	AND b.detail = x.detail
	AND b.noti = 0 
	AND t2.etext = t3.id 
	AND x.id = t2.base 
	AND (
		CONVERT(VARCHAR(255), t1.akte) LIKE @etok 
		OR t1.subject LIKE @etok OR t1.description LIKE @etok 
		OR t3.description LIKE @etok 
		OR t1.meta LIKE @emta) 
	ORDER by b.done DESC, b.datum DESC 
	--
	RETURN @@ROWCOUNT
GO


CREATE PROCEDURE dailyReport (@ofs INTEGER = 1, @exc INTEGER = 3, @alen INTEGER = 5, @slen INTEGER = 15, @dlen INTEGER = 60) AS
	--
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt.				/B
	--	2004-04-26, Abschneiden des Aktenzeichens, Kommentars, Betreffs eingefügt	/B
	--
	DECLARE @beg AS DATETIME
	DECLARE @end AS DATETIME
	--
	--	Argumente:
	--	'ofs' gibt die Anzahl von Tagen an, die betrachtet werden soll, der Wert kann auch negativ sein.
	--	'exc' ist die ID eines aus der Liste der Fristen auszugliedernden Kontexts.
	--	'dlen' bezeichnet die Anzahl der Buchstaben, auf die derKommentar gekürzt wird
	--	'slen' dito für das Subject/Betreff
	--	'alen' dito für das interne Aktenzeichen
	--
	--
	IF @ofs > 0 
		SET @beg = DATEADD(day, 1, CURRENT_TIMESTAMP)
	ELSE
		SET @beg = CURRENT_TIMESTAMP
	--
	SET @end = DATEADD (day, @ofs, @beg)  
	--
		SELECT '1', '', 'ok', 'Ablauf', 'Vorgang', 0, 'Akte', 'Betreff', 'Bemerkung'
		UNION ALL
		SELECT '2', 'FRI', CAST (ba.[done] AS VARCHAR (2)), CONVERT (VARCHAR (11), ba.[datum], 121), ta.[mini], CAST (ta.[rank] AS SMALLINT), SUBSTRING(da.[akte], 1, @alen), SUBSTRING(da.[subject], 1, @slen), SUBSTRING (da.[description], 1, @dlen) 
		FROM base AS ba 
		INNER JOIN (detail AS da 
		INNER JOIN (dtype AS ta 
		INNER JOIN context AS ca 
		ON ta.[context] = ca.[id])
		ON da.[type] = ta.[id])
		ON ba.[detail] = da.[id] 
		WHERE ta.[context] <> @exc 
		AND ba.noti = 0
		AND (ba.datum BETWEEN @beg AND @end 
			OR ABS (DATEDIFF (d, ba.datum, @beg)) < 1
			OR ABS (DATEDIFF (d, ba.datum, @end)) < 1)
		UNION ALL
		SELECT '3','','','','','','','',''
		UNION ALL
		SELECT '4', '', 'ok', 'Ablauf', 'Frist', 0, 'Akte', 'Betreff', 'Bemerkung'
		UNION ALL
		SELECT '5', 'WV', CAST (b1.[done] AS VARCHAR (2)), CONVERT (VARCHAR (11), b1.[datum], 121), CONVERT (VARCHAR (10), b2.[datum], 121), CAST(t.[rank] AS SMALLINT), SUBSTRING(d.[akte], 1, @alen), SUBSTRING(d.[subject], 1, @slen), SUBSTRING (d.[description], 1, @dlen)
		FROM base AS b1
		INNER JOIN (base AS b2
		INNER JOIN (detail AS d
		INNER JOIN (dtype AS t
		INNER JOIN context AS c
		ON t.[context] = c.[id])
		ON d.[type] = t.[id])
		ON d.[id] = b2.[detail])
		ON b1.detail = b2.detail
		WHERE b1.noti <> 0
		AND b2.noti = 0
		AND (b1.datum BETWEEN @beg AND @end 
			OR ABS (DATEDIFF (d, b1.datum, @beg)) < 1
			OR ABS (DATEDIFF (d, b1.datum, @end)) < 1)
		UNION ALL
		SELECT '6','','','','','','','',''
		UNION ALL
		SELECT '7','','ok','Ablauf','Vorgang', 0, 'Akte','Betreff','Bemerkung'
		UNION ALL
		SELECT '8','INT', CAST (b.[done] AS VARCHAR(2)), CONVERT (VARCHAR (11), b.[datum], 121), t.[mini], CAST(t.[rank] AS SMALLINT), SUBSTRING(d.[akte], 1, @alen), SUBSTRING (d.[subject], 1, @slen), SUBSTRING (d.[description], 1, @dlen)
		FROM base AS b
		INNER JOIN (detail AS d
		INNER JOIN (dtype AS t
		INNER JOIN context AS c 
		ON t.[context] = c.[id])
		ON d.[type] = t.[id])
		ON d.[id] = b.[detail]
		WHERE t.[context] = @exc 
		AND (b.datum BETWEEN @beg AND @end 
			OR ABS (DATEDIFF (d, b.datum, @beg)) < 1
			OR ABS (DATEDIFF (d, b.datum, @end)) < 1)
		ORDER BY 1 ASC, 4 ASC, 6 DESC ;
	--
	PRINT N'Terminkalender fuer Patentanwaelte (c) Bernhard Schupp; Frankfurt-Muenchen-Frankfurt; 2001-2004'
	--
	RETURN @@ROWCOUNT
GO

--	+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--
--	Ab hier: Funktionen zum Erstellen / Bearbeiten der Fristeinträge.
--
--	+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

CREATE PROCEDURE etextID (@txt AS TEXT = NULL) AS
	--
	--	Hilfsprocedur zum Erstellen der Kommentareinträge
	--	zu den Ereigniseinträgen
	--
	DECLARE @tid INTEGER
	DECLARE @com VARCHAR (255)
	--
	--
	SET @tid = -1
	--
	IF @txt IS NOT NULL
		BEGIN
			SET @com = LTRIM(RTRIM(CAST (@txt AS VARCHAR (255))))
			IF DATALENGTH (@com) > 0
				BEGIN
					SELECT @tid = e1.id FROM etext AS e1 WHERE e1.description = @com
					IF @tid = -1
						BEGIN
							INSERT INTO etext (description) VALUES (@com) 
							SET @tid = @@IDENTITY
						END
				END
			ELSE
				SET @tid = 1
		END
	ELSE
		SET @tid = 1
	--
	RETURN @tid
GO


CREATE PROCEDURE insertBaseEntry (@due DATETIME, @uid INTEGER, @typ INTEGER, @asd INTEGER, @fil FILEKEY, @sub SUBJECT, @com VARCHAR(255), @mta VARCHAR(15)) AS 
	--
	--	Prozedur zum Erstellen des ersten Fristzusammenhangs 
	--	aus Einträgen in 'base', 'detail', 'event' und
	-- 	ggf. 'etext'
	--
	DECLARE @tid INTEGER
	DECLARE @bid INTEGER
	DECLARE @did INTEGER
	DECLARE @eid INTEGER
	DECLARE @c50 COMMENT
	--
	SET @tid = -1
	SET @bid = -1
	SET @did = -1
	SET @eid = -1
	SET @c50 = LEFT (LTRIM(RTRIM(@com)), 50)
	--
	--
	--	Detaileintrag erstellen.
	INSERT INTO detail (type, assigned, akte, subject, description, meta) VALUES (@typ, @asd, LTRIM(RTRIM(@fil)), LTRIM(RTRIM(@sub)), @c50, LTRIM(RTRIM(@mta))) 
	SET @did = @@IDENTITY
	--
	--	Basiseintrag erstellen,
	INSERT INTO base (datum, detail) VALUES (@due, @did) 
	SET @bid = @@IDENTITY
	--
	--	Ereigniseintrag erstellen: Falls der Kommentar länger als das im Detail enthaltene Feld ist,
	--	wird der vollständige Text dem Ereignis hinzugefügt.
	IF DATALENGTH (LTRIM(RTRIM(@com))) > DATALENGTH (@c50)
		EXEC @tid = etextID @txt=@com
	ELSE
		EXEC @tid = etextID 
	--
	INSERT INTO event (base, type, login, etext) VALUES (@bid, '2', @uid, @tid)
	SET @eid = @@IDENTITY
	--
	-- Fehlerbehandlung: Rollback.
	IF @@ERROR <> 0 
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR 44445 N'Gespeicherte Prozedur ''insertBaseEntry'' mit Fehler abgebrochen'
			SET @bid = -1
		END
	--
	RETURN @bid
GO


CREATE PROCEDURE insertCommentForID (@bid INTEGER, @uid INTEGER, @txt TEXT = NULL) AS 
	--
	--	Kommentar für die Frist mit der angegebenen 'id' einsetzen.
	--	2004-03-07, Rückgabewert @eid hinzugefügt.
	--
	DECLARE @tid INTEGER
	DECLARE @eid INTEGER
	--
	SET @eid = -1
	--
	EXEC @tid = etextID @txt=@txt
	
	IF @tid <> -1
		BEGIN
			INSERT INTO event (base,type,login,datum,etext) VALUES (@bid, '6', @uid, CURRENT_TIMESTAMP, @tid)
			SET @eid = @@IDENTITY
		END
	-- Fehlerbehandlung: Rollback.
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Gespeicherte Prozedur ''insertCommentForID'' mit Fehler abgebrochen.'
			ROLLBACK
		END
	--
	RETURN @eid
GO


CREATE PROCEDURE insertNotificationForID (@bid INTEGER, @due DATETIME, @uid INTEGER = -1, @txt TEXT = NULL) AS 
	--
	--	Die Prozedur setzt eine Widervorlage zu einer Frist  
	--	ein, auch wenn auf diese nur über die ID einer anderen
	--	Wiedervorlage Bezug genommen wird. 
	--	2004-03-07, Rückgabewert @eid hinzugefügt.
	--
	DECLARE @det INTEGER
	DECLARE @xxx INTEGER 
	DECLARE @tid INTEGER
	DECLARE @eid INTEGER
	DECLARE @num INTEGER
	DECLARE @max INTEGER
	--
	SET @det = NULL
	SET @xxx = NULL
	SET @tid = NULL
	SET @eid = -1
	--
	SELECT @max = t1.maxn FROM dtype AS t1, base AS b1, detail AS d1 WHERE b1.id = @bid AND b1.detail = d1.id AND d1.type = t1.id
	SELECT @num = COUNT(*) FROM base b, base x WHERE @bid = x.id AND x.detail = b.detail AND b.noti <> 0
	SELECT @det = b.detail FROM base b, base x WHERE @bid = x.id AND x.detail = b.detail AND b.noti = 0 
	--
	IF @num < @max AND @det IS NOT NULL
		BEGIN
			EXEC @tid = etextID @txt=@txt
			INSERT INTO base (datum, detail, noti) VALUES (@due, @det, '1') 
			SET @xxx = @@IDENTITY
			--	Falls die Benutzerkennung nicht existiert, wird die Wiedervorlage ohne Ereignis eingetragen.
			IF EXISTS (SELECT l1.id FROM login AS l1 WHERE l1.id = @uid)
				BEGIN
					INSERT INTO event (base, type, login, etext) VALUES (@xxx, '3', @uid, @tid)
					SET @eid = @@IDENTITY
				END
		END
	ELSE
		BEGIN
			RAISERROR 44445 N'Falscher Basiseintrag / falsche Benutzerkennung / zuviele Wiedervorlagen beim Erstellen einer Wiedervorlage'
			ROLLBACK TRANSACTION
		END
	-- Fehlerbehandlung: Rollback.
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Gespeicherte Prozedur insertNotificationForID wurde mit Fehler abgebrochen'
			ROLLBACK TRANSACTION
		END
	--
	RETURN @eid
GO


CREATE Procedure setDoneForID (@bid INTEGER, @uid INTEGER, @txt TEXT = NULL) AS 
	--
	--	Nur ändern usw. wenn nicht schon WAHR in der Spalte 'done' steht.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt.
	--
	DECLARE @ret INTEGER
	DECLARE @tid INTEGER
	--
	SET @ret = 0
	--
	IF EXISTS (SELECT b.id FROM base b WHERE b.id = @bid AND b.done = 0)
		BEGIN
			IF EXISTS (SELECT b.id FROM base b WHERE b.id = @bid AND b.noti <> 0)
				BEGIN
					--	Änderung an der betreffenden Wiedervorlage durchführen
					UPDATE base SET done = 1 WHERE id = @bid
					--
					SET @ret = @@ROWCOUNT
					IF @ret > 0
						BEGIN
							EXEC @tid = etextID @txt=@txt
							IF @tid <> -1
								INSERT INTO event (base, type, login, etext) VALUES (@bid, '5', @uid, @tid) 
							ELSE
								INSERT INTO event (base, type, login) VALUES (@bid, '5', @uid)
						END
				END
			ELSE
				BEGIN
					--	Änderung zuerst an den Wiedervorlagen und dann an der Frist durchführen;
					--	andernfalls gibt es Probleme mit dem Integritätstrigger der Tabelle 'base'
					UPDATE base SET done = 1 WHERE noti <> 0 AND detail IN (SELECT x.detail FROM base x WHERE x.id = @bid)
					UPDATE base SET done = 1 WHERE id = @bid 
					--
					SET @ret = @@ROWCOUNT
					IF @ret > 0
						BEGIN 
							EXEC @tid = etextID @txt=@txt
							IF @tid <> -1
								INSERT INTO event (base, type, login, etext) VALUES (@bid, '4', @uid, @tid) 
							ELSE
								INSERT INTO event (base, type, login) VALUES (@bid, '4', @uid)
						END
				END
		END
	--
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Gespeicherte Prozedur ''setDoneForID'' mit Fehler abgebrochen'
			ROLLBACK TRANSACTION
		END
	--
	RETURN @ret
GO



CREATE PROCEDURE logInfo (@typ INTEGER = 1, @txt TEXT) AS
	--
	DECLARE @cmm VARCHAR (255)
	--
	SET @cmm = LTRIM (RTRIM (CAST (@txt AS VARCHAR (255))))
	--
	INSERT INTO seclog (category, message) VALUES (@typ, @cmm)
	--
	RETURN @@IDENTITY
GO

--	+++++++++++++++++++++++++++++++++++++++++++
--
--	Ab hier: Funktionen zur Benutzerverwaltung.
--
--	+++++++++++++++++++++++++++++++++++++++++++

CREATE PROCEDURE setPwdForUID (@slt VARCHAR (10) = NULL, @pwd VARCHAR (50) = NULL, @uid INTEGER) AS
	--
	--	Passwort für den Benutzer mit der Nummer 'uid' setzen.
	--	2004-03-07, @@rowcount Rückgabewert hinzugefügt
	--
	DECLARE @okmsg VARCHAR (255)
	DECLARE @errmsg VARCHAR (255)
	--
	SET @errmsg = 'unsuccessful attempt to change password for uid: ' + CONVERT (nvarchar, @uid)
	-- 
	UPDATE login SET salt = (
		CASE
			WHEN @slt IS NULL THEN 'initial'
			ELSE LTRIM(RTRIM(@slt))
		END)
	, passwd = (
		CASE
			WHEN @pwd IS NULL THEN '74215744'
			ELSE LTRIM(RTRIM(@pwd))
		END)
	WHERE id = @uid 
	--
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Die Ausführung der gespeicherten Prozedur ''setPwdForUID'' wurde fehlerhaft beendet'
			EXEC logInfo 3, @errmsg
		END
	ELSE
		BEGIN
			SET @okmsg = 'password changed for uid ' + CONVERT(VARCHAR, @uid)
			EXEC logInfo 1, @okmsg
		END
	RETURN @@ROWCOUNT
GO

CREATE PROCEDURE insertLogin (@sht VARCHAR(4), @nam LOGINAME, @slt VARCHAR (10) = NULL, @pwd VARCHAR(50) = NULL) AS 
	--
	--	Benutzerkennung erstellen.
	--
	DECLARE @uid INTEGER
	DECLARE @okmsg VARCHAR (255)
	DECLARE @errmsg VARCHAR (255)
	--
	--
	INSERT INTO login (kurz, name) VALUES (LTRIM(RTRIM(@sht)),LTRIM(RTRIM(@nam)))
	SET @uid  = @@IDENTITY
	-- Das Passwort auf die Vorgabe setzen.
	EXEC setPwdForUID @slt = @slt, @pwd = @pwd, @uid = @uid
	-- Fehlerbehandlung: Rollback.
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'FATAL ERROR IN ''insertLogin'''
			ROLLBACK TRANSACTION
			SET @errmsg = N'Erfolgloser Versuch das Login zum Kuerzel ' + @sht + ' zu erstellen.'
			EXEC logInfo 3, @errmsg
			SET @uid = -1
		END
	ELSE
		BEGIN
			SET @okmsg = N'Neue Kennung erstellt fuer: ' + CONVERT (VARCHAR, @uid) + ' - ' + @sht
			EXEC logInfo 1, @okmsg
		END
	--
	RETURN @uid
GO

CREATE PROCEDURE removeLoginForUID (@uid INTEGER, @rea INTEGER) AS
	--
	--	Benutzerkennung entfernen, falls es kein Systembenutzer ist.
	--
	DECLARE @def INTEGER
	DECLARE @ret INTEGER
	DECLARE @tmp INTEGER
	DECLARE @okmsg VARCHAR (255)
	DECLARE @errmsg VARCHAR (255)
	--
	SET @ret = 0
	--
	IF NOT EXISTS (SELECT s.login FROM systemlogin s WHERE s.login = @uid) 
		BEGIN
			SELECT TOP 1 @def = s.login FROM systemlogin s WHERE s.defuser <> 0 
			IF @def IS NOT NULL
				BEGIN
					UPDATE event SET login = @def WHERE login = @uid
					UPDATE assigned SET login = @rea WHERE login = @uid
					DELETE FROM login WHERE id = @uid
					SET @ret = @@ROWCOUNT
					IF @ret > 0
						BEGIN
							SET @okmsg = N''
							EXEC logInfo 1, @okmsg
						END
				END
		END
	--
	SET @tmp = @@ERROR
	IF @tmp <> 0
		BEGIN
			RAISERROR 44445 N'FATAL ERROR IN ''removeLoginForUID'''
			ROLLBACK TRANSACTION
			SET @errmsg = N'Entfernen von : ' + CONVERT (VARCHAR, @uid) + ' mit Fehlercode ' + CONVERT (VARCHAR, @tmp) + ' abgebrochen.'
			EXEC logInfo 3, @errmsg
		END
	--
	RETURN @ret
GO

CREATE PROCEDURE modifySettingsForUID (@uid INTEGER, @lgn BIT, @adm BIT, @crt BIT, @del BIT) AS 
	--
	--	Ändern der Benutzereinstellungen:
	--
	DECLARE @ret AS INTEGER
	DECLARE @okmsg AS VARCHAR (255)
	DECLARE @errmsg AS VARCHAR (255)
	--
	SET @ret = 0 
	--
	--	Vorübergehende Lösung, wobei das Login-Bit auf FALSCH gesetzt wird,
	--	wenn alle anderen nicht vorhanden sind.
	--
	SET @lgn = @adm | @crt | @del
	--
	IF (0  = @lgn ^ (@adm | @crt | @del)) 
	AND NOT EXISTS (
				SELECT x.id 
				FROM login AS x 
				WHERE x.id = @uid 
				AND x.permlogin = @lgn 
				AND x.permadmin = @adm 
				AND x.perminsert = @crt 
				AND x.permdelete = @del)
		BEGIN
			UPDATE login
			SET permlogin = @lgn, permadmin=@adm, perminsert=@crt, permdelete=@del
			WHERE id = @uid
			SET @ret = @@ROWCOUNT
		END
	--
	IF @@error <> 0
		BEGIN
			RAISERROR 44445 N'FATAL ERROR IN ''modifySettingsForUID'''
			ROLLBACK TRANSACTION
			SET @errmsg = N'Aendern der Einstellungen fuer ' + CONVERT (VARCHAR, @uid) + ' fehlgeschlagen.'
			EXEC logInfo 3, @errmsg
		END
	--
	RETURN @ret
GO

--	+++++++++++++++++++++++++++++++++++++++++++
--
--	Ab hier: Funktionen zur SD-Verwaltung.
--
--	+++++++++++++++++++++++++++++++++++++++++++

CREATE PROCEDURE addAutoType (@afm INTEGER, @tid INTEGER) AS
	--
	--	2004-03-07, @@rowcount vom insert als Rückgabewert hinzugefügt.
	--
	DECLARE @ret INTEGER
	DECLARE @tmp VARCHAR (255)
	DECLARE @s1 VARCHAR (255)
	DECLARE @s2 VARCHAR (255)
	--
	INSERT INTO autotype (autodeadline, type) VALUES (@afm, @tid)
	SET @ret = @@ROWCOUNT
	--
	SELECT @s1 = t.label FROM dtype t WHERE t.id = @tid
	SELECT @s2 = f.label FROM autodeadline f WHERE f.id = @afm
	--
	SET @tmp = 'Typ ''' + @s1 + ''' zum Formular ''' + @s2 + ''' hinzugefuegt.'
	EXEC logInfo 1, @tmp
	--
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Die Ausfuehrung der gespeicherten Prozedur ''addAutoType'' wurde fehlerhaft beendet'
			ROLLBACK TRANSACTION
			SET @tmp = N'Fehler beim Erstellen der Zuordnung: ' + CAST (@tid AS VARCHAR (10)) + '->' + CAST (@afm AS VARCHAR (10))
			EXEC logInfo 3, @tmp
		END
		
	RETURN @ret
GO

CREATE PROCEDURE addAutoAssigned (@afm INTEGER, @aid INTEGER) AS
	--
	--	2004-03-07, @@rowcount als Rückgabewert hinzugefügt
	--
	DECLARE @ret INTEGER
	DECLARE @tmp VARCHAR (255)
	DECLARE @s1 VARCHAR (255)
	DECLARE @s2 VARCHAR (255)
	--
	INSERT INTO autoassigned (autodeadline, assigned) VALUES (@afm, @aid)
	SET @ret = @@ROWCOUNT
	--
	SELECT @s1 = a.label FROM assigned a WHERE a.id = @aid
	SELECT @s2 = f.label FROM autodeadline f WHERE f.id = @afm
	--
	SET @tmp = 'Bearbeiterkuerzel ''' + @s1 + ''' zum Formular ''' + @s2 + ''' hinzugefuegt.'
	EXEC logInfo 1, @tmp
	--
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Die Ausfuehrung der gespeicherten Prozedur ''addAutoAssigned'' wurde fehlerhaft beendet'
			ROLLBACK TRANSACTION
			SET @tmp = N'Fehler beim Erstellen der Zuordnung: ' + CAST (@aid AS VARCHAR (10)) + '->' + CAST (@afm AS VARCHAR (10))
			EXEC logInfo 3, @tmp
		END
		
	RETURN @ret
GO

CREATE PROCEDURE addType (@tid INTEGER = -1, @mni MINI, @lbl LABEL, @rnk INTEGER, @col INTEGER, @mxn INTEGER, @mxc INTEGER, @cxt INTEGER, @dsc DESCRIPTION, @neu BIT = 0) AS
	--
	--	Neuen Typ erstellen.
	--
	DECLARE @tmp VARCHAR (255)
	--
	DECLARE @s1 MINI
	DECLARE @s2 LABEL
	DECLARE @s3 DESCRIPTION
	--
	SET @s1 = LTRIM(RTRIM(@mni))
	SET @s2 = LTRIM(RTRIM(@lbl))
	SET @s3 = LTRIM(RTRIM(@dsc))
	--
	IF NOT EXISTS (SELECT t.id FROM dtype t WHERE (mini = @s1 OR label = @s2 OR description = @s3) AND id <> @tid)
		BEGIN
			IF @tid = -1 
				BEGIN
					INSERT INTO dtype (mini, label, rank, color, maxn, maxc, context, description) VALUES (@s1, @s2, @rnk, @col, @mxn, @mxc, @cxt, @s3)
					--
					SET @tid = @@IDENTITY
					SET @tmp = N'Fristtyp ' + @s2 + ' erstellt'
					EXEC logInfo 1, @tmp
					--
					IF @neu <> 0
					BEGIN
						DECLARE aform_cursor CURSOR FOR SELECT a.id FROM autodeadline a ORDER BY 1 ASC
						DECLARE @afm INTEGER
						OPEN aform_cursor
						FETCH NEXT FROM aform_cursor INTO @afm
						WHILE @@FETCH_STATUS = 0
							BEGIN
								EXEC addAutoType @afm, @tid
								FETCH NEXT FROM aform_cursor INTO @afm
							END
						CLOSE aform_cursor
						DEALLOCATE aform_cursor
					END
					--
				END
			ELSE
				BEGIN
					UPDATE dtype SET mini=@s1, label=@s2, rank=@rnk, color=@col, maxn=@mxn, maxc=@mxc, context=@cxt, description=@s3 WHERE id=@tid
					SET @tmp = N'Fristtyp mit der ID ''' + CAST (@tid AS VARCHAR (20)) + ''' bearbeitet'
					EXEC logInfo 1, @tmp
				END
		END
	ELSE
		SET @tid = -1
	--
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Die Ausfuehrung der gespeicherten Prozedur ''addType'' wurde fehlerhaft beendet'
			ROLLBACK TRANSACTION
			SET @tmp = N'Fehler beim Erstellen/Bearbeiten des Fristtyps' + @s2
			EXEC logInfo 3, @tmp
		END
	--
	RETURN @tid
GO


CREATE PROCEDURE addAsd (@aid INTEGER = -1, @uid INTEGER, @lbl LABEL, @dsc DESCRIPTION, @neu BIT = 0) AS
	--
	DECLARE @t1 VARCHAR (255)
	DECLARE @s1 LABEL
	DECLARE @s2 DESCRIPTION
	--
	SET @s1 = LTRIM(RTRIM(@lbl))
	SET @s2 = LTRIM(RTRIM(@dsc))
	--
	IF NOT EXISTS (SELECT a.id FROM assigned a WHERE a.label = @s1 AND id <> @aid)
		BEGIN
			if @aid = -1
				BEGIN
					INSERT INTO assigned (login, label, description) VALUES (@uid, @s1, @s2)
					SET @aid = @@IDENTITY
					SET @t1 = N'Bearbeiterkuerzel ' + @s1 + ' erstellt'
					EXEC logInfo 1, @t1
					
					IF @neu <> 0
					BEGIN
						DECLARE aform_cursor CURSOR FOR SELECT a.id FROM autodeadline a ORDER BY 1 ASC
						DECLARE @afm INTEGER
						OPEN aform_cursor
						FETCH NEXT FROM aform_cursor INTO @afm
						WHILE @@FETCH_STATUS = 0
							BEGIN
								EXEC addAutoAssigned @afm, @aid
								FETCH NEXT FROM aform_cursor INTO @afm
							END
						CLOSE aform_cursor
						DEALLOCATE aform_cursor
					END
				END
			ELSE
				BEGIN
					UPDATE assigned SET login = @uid WHERE id = @aid
					SET @t1 = N'Bearbeiterkuerzel ''' + CAST (@aid AS VARCHAR (20)) + ''' bearbeitet'
					EXEC logInfo 1, @t1
				END
		END
	ELSE
		SET @aid = -1
	--
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Die Ausfuehrung der gespeicherten Prozedur ''addAsd'' wurde fehlerhaft beendet'
			ROLLBACK TRANSACTION
			SET @t1 = N'Fehler beim Erstellen/Bearbeiten des Bearbeiterkuerzels' + @s1
			EXEC logInfo 3, @t1
		END
	--
	RETURN @aid
GO
--
CREATE PROCEDURE dump_schedule (@num INTEGER = 0) AS
	--	Datenbank dumpen an den vorgesehenen Platz
	BACKUP DATABASE schedule TO schedule WITH RETAINDAYS=@num
	--
GO
--
GRANT EXECUTE ON getAssign TO scr, scw
GRANT EXECUTE ON getContexts TO scr, scw
GRANT EXECUTE ON getForms TO scr, scw
GRANT EXECUTE ON autoDeadlinePreviewListA TO scr, scw
GRANT EXECUTE ON autoDeadlinePreviewListB TO scr, scw
GRANT EXECUTE ON getAssignList TO scr, scw
GRANT EXECUTE ON getAutoAssignList TO scr, scw
GRANT EXECUTE ON getAutodeadline TO scr, scw
GRANT EXECUTE ON getAutoNotificationList TO scr, scw
GRANT EXECUTE ON getTypes TO scr, scw
GRANT EXECUTE ON getTypeList TO scr, scw
GRANT EXECUTE ON getDateFromID TO scr, scw
GRANT EXECUTE ON getDeadlineOV TO scr, scw
GRANT EXECUTE ON getDetail TO scr, scw
GRANT EXECUTE ON getEventList TO scr, scw
GRANT EXECUTE ON getLoginNames TO scr, scw
GRANT EXECUTE ON getNotification TO scr, scw
GRANT EXECUTE ON getNotificationList TO scr, scw
GRANT EXECUTE ON getNotificationOV TO scr, scw
GRANT EXECUTE ON getPromoteForID TO scr, scw
GRANT EXECUTE ON getShiftBase TO scr, scw
GRANT EXECUTE ON getUserTicket TO scr, scw
GRANT EXECUTE ON getWorkload TO scr, scw
GRANT EXECUTE ON nextBefore TO scr, scw
GRANT EXECUTE ON searchAny TO scr, scw
GRANT EXECUTE ON eventByDate TO scr, scw
GRANT EXECUTE ON dailyReport TO scr, scw
--
GRANT EXECUTE ON etextID TO scw
GRANT EXECUTE ON insertBaseEntry TO scw
GRANT EXECUTE ON insertCommentForID TO scw
GRANT EXECUTE ON insertNotificationForID TO scw
GRANT EXECUTE ON setDoneForID TO scw
--
GRANT EXECUTE ON logInfo TO scw,scr
--
GRANT EXECUTE ON insertLogin TO scw
GRANT EXECUTE ON removeLoginForUID TO scw
GRANT EXECUTE ON setPwdForUID TO scw
GRANT EXECUTE ON modifySettingsForUID TO scw
--
GRANT EXECUTE ON addAutoType TO scw
GRANT EXECUTE ON addAutoAssigned TO scw
GRANT EXECUTE ON addType TO scw
GRANT EXECUTE ON addAsd TO scw
--
GRANT EXECUTE ON dump_schedule TO scw, scr
--
PRINT N'Fertig.'
GO
