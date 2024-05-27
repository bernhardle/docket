PRINT N'Auf geht''s!'
GO
--
--	(c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004
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
--
USE master
GO
--
--	Den Benutzer anlegen: 'cfg' ist nur zum Lesen
--
IF NOT EXISTS (SELECT name FROM syslogins WHERE name='cfg') EXEC sp_addlogin @loginame='cfg', @passwd='lala', @defdb='config'
GO
--
--	Datenbank wechseln ...
--
USE config
GO
--
IF NOT EXISTS (SELECT uid FROM sysusers WHERE name='cfg') EXEC sp_adduser @loginame='cfg', @name_in_db='cfg'
GO
--
--	Alle Tabellen, die schon vorhanden sind, rauskegeln.
--
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutformlist') DROP TABLE pagelayoutformlist
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutautodeadline') DROP TABLE pagelayoutautodeadline
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'menuelayout') DROP TABLE menuelayout
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputdate') DROP TABLE inputdate
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputcheck') DROP TABLE inputcheck
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputarea') DROP TABLE inputarea
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'framelayout') DROP TABLE framelayout
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'template') DROP TABLE template
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutlist') DROP TABLE pagelayoutlist
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutframe') DROP TABLE pagelayoutframe
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutformbase') DROP TABLE pagelayoutformbase
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutcaption') DROP TABLE pagelayoutcaption
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutbody') DROP TABLE pagelayoutbody
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutbaseicon') DROP TABLE pagelayoutbaseicon
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutbaselstring') DROP TABLE pagelayoutbaselstring
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutbasestyle') DROP TABLE pagelayoutbasestyle
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutbasecolor') DROP TABLE pagelayoutbasecolor
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pagelayoutbase') DROP TABLE pagelayoutbase
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'navigator') DROP TABLE navigator
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputtext') DROP TABLE inputtext
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputsubmit') DROP TABLE inputsubmit
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputselect') DROP TABLE inputselect
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputimage') DROP TABLE inputimage
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'frameinnerargument') DROP TABLE frameinnerargument
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'frameinner') DROP TABLE frameinner
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'frameouterargument') DROP TABLE frameouterargument
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'frameouter') DROP TABLE frameouter
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'caption') DROP TABLE caption
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'style') DROP TABLE style
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'month') DROP TABLE month
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'menueitem') DROP TABLE menueitem
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'menue') DROP TABLE menue
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputdetail') DROP TABLE inputdetail
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputhidden') DROP TABLE inputhidden
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputformrowpos') DROP TABLE inputformrowpos
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputformrow') DROP TABLE inputformrow
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputformheader') DROP TABLE inputformheader
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputform') DROP TABLE inputform
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inputscript') DROP TABLE inputscript
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'image') DROP TABLE image
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'jump') DROP TABLE jump
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'url') DROP TABLE url
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'urlbase') DROP TABLE urlbase
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'font') DROP TABLE font
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'propertieslocal') DROP TABLE propertieslocal
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'stringlocal') DROP TABLE stringlocal
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'locale') DROP TABLE locale
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'color') DROP TABLE color
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'properties') DROP TABLE properties
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'setting') DROP TABLE setting
--
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'addLayoutStyle' AND type = 'P') DROP PROCEDURE addLayoutStyle
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'updateLayoutStyles' AND type = 'P') DROP PROCEDURE updateLayoutStyles
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'initializeLayoutStyles' AND type = 'P') DROP PROCEDURE initializeLayoutStyles
--
GO
PRINT N'Alle Tabellen gel' + CHAR(246) + 'scht.'



--
	CREATE TABLE setting (
         	id			INT NOT NULL,
          	name			VARCHAR (20) NOT NULL,
          	selected		BIT NOT NULL DEFAULT 0,
		CONSTRAINT setting_pk PRIMARY KEY (id),
		CONSTRAINT setting_c1 UNIQUE (name)
	) ;
GO
--
INSERT INTO setting (id,name,selected) VALUES ('0', 'All', '0') ;
INSERT INTO setting (id,name,selected) VALUES ('1', 'Fun', '0') ;
INSERT INTO setting (id,name,selected) VALUES ('2', 'Pro (IE4)', '1') ;
INSERT INTO setting (id,name,selected) VALUES ('3', 'Pro (Mozilla)', '0') ;
--
PRINT N'Tabelle ''setting'' erstellt und gef' + CHAR(252) + 'llt.'
GO



--
	CREATE TABLE properties (
          	id			INT IDENTITY (1,1),
          	servlet		VARCHAR (255) NOT NULL,
          	name			VARCHAR (255) NOT NULL,
          	setting		INT NOT NULL,
          	data			VARCHAR (255) NOT NULL,
		CONSTRAINT properties_pk PRIMARY KEY (id),
		CONSTRAINT properties_c1 FOREIGN KEY (setting) REFERENCES setting (id),
		CONSTRAINT properties_c2 UNIQUE (servlet, setting, name)
	) ;
GO
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('addasd', 'form.add', '0', 'addasd') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('addasd', 'form.mod', '0', 'modasd') ;
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('addformtypeshow', 'param__id', '0', 'fid') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('addformtypeshow', 'listfetch', '0', 'dynamic.listfetch.TypeUBformListFetch') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('addformtypeshow', 'forward', '0', '900') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('addformtypeshow', 'back', '0', '150') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('addformtypeshow', 'error', '0', '850') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('addformtypeshow', 'form', '0', 'addformtypeshow') ;
--
-- Anzahl der Zeilen im Ergebnisblatt der Suche nach Zeichenfolgen:
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('search', 'len', '0', '8') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('search', 'max', '0', '500') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('search', 'meta', '0', 'dynamic.meta.MetaImpl') ;
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('insert', 'checking', '0', 'true') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('insert', 'detailFontSize', '0', '12') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('insert', 'meta', '0', 'dynamic.meta.MetaImpl') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('insert', 'inputchecker', '0', 'dynamic.inputchecker.InputCheckerImpl') ;
-- 
-- Plausibilitätsprüfung von Datumeingaben:
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('basic', 'maxYear', '0', '2050') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('basic', 'minYear', '0', '1970') ;
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('delete', 'enableAutoInsertMode', '0', 'true') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delete', 'autoInsertType', '0', '2') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delete', 'autoInsertDelay', '0', '10') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delete', 'meta', '0', 'dynamic.meta.MetaImpl') ;
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('delformtypeshow', 'param__id', '0', 'fid') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delformtypeshow', 'listfetch', '0', 'dynamic.listfetch.TypeBformListFetch') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delformtypeshow', 'forward', '0', '1100') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delformtypeshow', 'back', '0', '150') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delformtypeshow', 'error', '0', '1050') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delformtypeshow', 'form', '0', 'delformtypeshow') ;
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('delusershow', 'param__id', '0', 'lgn') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delusershow', 'listfetch', '0', 'dynamic.listfetch.UserListFetch') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delusershow', 'forward', '0', '75') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delusershow', 'back', '0', '71') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delusershow', 'error', '0', '131') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('delusershow', 'form', '0', 'delusershow') ;
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('modusershow', 'param__id', '0', 'lgn') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modusershow', 'listfetch', '0', 'dynamic.listfetch.UserListFetch') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modusershow', 'forward', '0', '69') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modusershow', 'back', '0', '71') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modusershow', 'error', '0', '72') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modusershow', 'form', '0', 'modusershow') ;
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('modasdshow', 'param__id', '0', 'aid') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modasdshow', 'listfetch', '0', 'dynamic.listfetch.AsdListFetch') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modasdshow', 'forward', '0', '730') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modasdshow', 'back', '0', '150') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modasdshow', 'error', '0', '720') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modasdshow', 'form', '0', 'modasdshow') ;
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('modtypeshow', 'param__id', '0', 'tid') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modtypeshow', 'listfetch', '0', 'dynamic.listfetch.DTypeListFetch') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modtypeshow', 'forward', '0', '93') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modtypeshow', 'back', '0', '150') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modtypeshow', 'error', '0', '92') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('modtypeshow', 'form', '0', 'modtypeshow') ;
--
-- Boolsche Werte die angeben, ob:
--	bei leerer Tabelle die Kopfzeile angezeigt werden soll,
--	Fristeinträge in der Zukunft gelöscht werden dürfen
--	Wiedervorlagen in der Zukunft gelöscht werden dürfen
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'allowShowEmptyHeading', '0', 'true') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'allowDeleteFutureDeadline', '0', 'true') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'allowDeleteFutureNotification', '0', 'true') ;
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'reichelExtensionContext', '0', '3') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'reichelExtensionActivate', '0', 'true') ;
-- Zeilenhöhe der Tabelle der Übersicht:
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'rowHeight', '1', '20') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'rowHeight', '2', '20') ;
-- Anzahl der Buchstaben im Label in der linken/rechten Spalte der Tabelle der Übersicht:
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'labelCharsL', '1', '35') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'labelCharsL', '2', '35') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'labelCharsR', '1', '31') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'labelCharsR', '2', '31') ;
-- Farben für die Zeilen der Übersicht: Rahmen / ungerade / gerade Zeilennummer / Hervorhebung:
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'borderColor', '1', '57') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'borderColor', '2', '57') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'oddRowColor', '1', '4') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'oddRowColor', '2', '4') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'evenRowColor', '1', '5') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'evenRowColor', '2', '5') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'highlightColor', '1', '51') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'highlightColor', '2', '51') ;
--
-- Breite der einzelnen Einträge in den Zeilen der Tabelle derÜbersicht (alles in Prozent):
--	wTable :	Breite der Tabelle
--	wRowL:	Breite der linken Spalte 'Fristablauf'
--	wFile:		Breite des Aktenzeichen
--	wType:	Breite Fristtyp
--	wDate:	Breite Datum in der Spalte 'Wiedervorlage'
--	wSpace:	Breite Leerraum zwischen Aktenzeichen - Typ, Typ - Label
--	wCheck:	Breite des grünen Hakens rechts
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wTable', '1', '100') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wTable', '2', '100') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wRowL', '1', '50') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wRowL', '2', '50') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wFile', '1', '13') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wFile', '2', '13') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wType', '1', '12') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wType', '2', '12') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wDate', '1', '19') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wDate', '2', '19') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wSpace', '1', '1') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wSpace', '2', '1') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wCheck', '1', '6') ;
INSERT INTO properties (servlet,name,setting,data) VALUES ('overview', 'wCheck', '2', '6') ;
--
--	Sekunden, bis der Server das Cookie bei Inaktivität des Benutzers verfallen lässt.
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('schedule', 'maxInactiveInterval', '0', '600') ;
--
--	Die Login/Logout Aktivitäten verfolgen:
--
INSERT INTO properties (servlet,name,setting,data) VALUES ('schedule', 'tracelogin', '0', 'true') ;
--	Listenlänge
INSERT INTO properties (servlet,name,setting,data) VALUES ('workload', 'len', '0', '8') ;
--
PRINT N'Tabelle ''properties'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE color (
          	id			INT NOT NULL,
          	name			VARCHAR (50) NOT NULL,
          	red			SMALLINT NOT NULL,
          	green			SMALLINT NOT NULL,
          	blue			SMALLINT NOT NULL,
	  	CHECK (NOT red < 0 AND NOT red > 255 AND NOT green < 0 AND NOT green > 255 AND NOT blue < 0 AND NOT blue > 255),
		CONSTRAINT color_pk PRIMARY KEY (id),
		CONSTRAINT color_c1 UNIQUE (name),
	  	CONSTRAINT color_c2 UNIQUE (red, green, blue)
	) ;
GO
--
INSERT INTO color (id,name,red,green,blue) VALUES ('1', 'schwarz', '0', '0', '0') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('2', 'hellgelb', '255', '250', '180') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('3', 'dunkelgrau', '87', '87', '87') ;
-- Helle Zeile in der Tabelle der Übersicht:
INSERT INTO color (id,name,red,green,blue) VALUES ('4', 'weissgrau', '248', '248', '248') ;
-- Dunkle Zeile in der Taeblle der Übersicht:
INSERT INTO color (id,name,red,green,blue) VALUES ('5', 'hellgrau', '238', '238', '238') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('6', 'weissgelb', '255', '255', '240') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('7', 'dunkelblau', '41', '61', '126') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('8', 'mittelblau', '58', '85', '175') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('9', 'gelb', '255', '255', '0') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('10', 'dunkelmittelblau', '0', '102', '204') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('15', 'hellmittelblau', '116', '138', '214') ;
--	Zeilen 32-47 waren vormals die Zeilen 2-17 in der Datenbank 'schedule'
INSERT INTO color (id,name,red,green,blue) VALUES ('32', 'rot', '255', '0', '0') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('33', 'blau', '0', '0', '255') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('34', 'gr' + CHAR(252) + 'n', '0', '128', '0') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('35', 'dunkelrot', '128', '0', '65') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('36', 'orange', '255', '128', '64') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('37', 'stahlblau', '128', '128', '192') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('39', 'dunkelgr' + CHAR(252) + 'n', '64', '128', '128') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('40', 'grau', '110', '110', '110') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('43', 'pink', '255', '0', '255') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('44', 'umbra', '128', '128', '64') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('45', 'dunkelkirschrot', '128', '0', '0') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('46', 'hellblau', '0', '128', '255') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('47', 'dunkelviolett', '64', '0', '128') ;
--
INSERT INTO color (id,name,red,green,blue) VALUES ('49', 'dunkelblau II', '0', '0', '160') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('50', 'hellgelb II', '255', '255', '213') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('51', 'hellgelb III', '255', '255', '204') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('52', 'hellblau II', '102', '153', '153') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('53', 'grau II', '204', '204', '204') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('54', 'blau II (Rahmen)', '102', '128', '153') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('55', 'blau III (Login)', '169', '195', '220') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('56', 'weiss', '255', '255', '255') ;
INSERT INTO color (id,name,red,green,blue) VALUES ('57', 'dunkelgrau II', '30', '30', '30') ;
--
PRINT N'Tabelle ''color'' erstellt und gef' + CHAR(252) + 'llt.'
GO

CREATE TRIGGER color_DUTrig ON color FOR DELETE, UPDATE AS
	--
	--	Der Trigger verhindert das Entfernen oder Ändern der 
	--	ursprünglichen Einträge, die durch dieses Skript eingetragen werden.
	--
	SET NOCOUNT ON
	
	RAISERROR 44447 N'Die vordefinierten Farben können nicht geändert oder entfernt werden.'
	ROLLBACK TRANSACTION
	--
GO

--
	CREATE TABLE locale (
          	id		INT NOT NULL,
          	short		VARCHAR (2) NOT NULL,
          	name		VARCHAR (50) NOT NULL,
		CONSTRAINT locale_pk PRIMARY KEY (id),
		CONSTRAINT locale_c1 UNIQUE (short),
		CONSTRAINT locale_c2 UNIQUE (name)
	) ;
GO
--
INSERT INTO locale (id,short,name) VALUES ('1', 'DE', 'deutsch') ;
--
PRINT N'Tabelle ''locale'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE stringlocal (
		id			INT NOT NULL,
          	locale 		INT DEFAULT 1 NOT NULL,
		text			VARCHAR (255) NOT NULL,
		alt			BIT DEFAULT 0 NOT NULL,
		CONSTRAINT stringlocal_pk PRIMARY KEY (id),
		CONSTRAINT stringlocal_c1 FOREIGN KEY (locale) REFERENCES locale (id),
		CONSTRAINT stringlocal_c2 UNIQUE (locale, text)
	) ;
GO
--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('1', '1', 'Diese Seite verwendet Frames. Frames werden von Ihrem Browser aber nicht unterst' + CHAR(252) + 'tzt.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('2', '1', 'Willkommen', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('3', '1', CHAR(220) + 'bersicht', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('4', '1', 'Detail', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('5', '1', 'Neuer Eintrag', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('6', '1', 'Suchergebnis', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('7', '1', 'Sonderfunktionen', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('8', '1', 'Erledigt', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('9', '1', 'Hilfe', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('10', '1', 'Angemeldet', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('11', '1', 'Abgemeldet', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('12', '1', 'Fehler', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('13', '1', 'Hilfefunktionen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('14', '1', 'Neuen Eintrag erstellen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('16', '1', 'Januar', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('17', '1', 'Februar', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('18', '1', 'M' + CHAR(228) + 'rz', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('19', '1', 'April', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('21', '1', 'Juni', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('22', '1', 'Juli', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('23', '1', 'August', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('24', '1', 'September', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('25', '1', 'Oktober', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('26', '1', 'November', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('27', '1', 'Dezember', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('28', '1', 'Terminkalender', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('29', '1', 'Standard', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('30', '1', 'Login', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('31', '1', 'Navigator', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('32', '1', 'Jan', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('33', '1', 'Feb', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('34', '1', 'Mrz', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('35', '1', 'Apr', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('36', '1', 'Mai', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('37', '1', 'Jun', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('38', '1', 'Jul', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('39', '1', 'Aug', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('40', '1', 'Sep', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('41', '1', 'Okt', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('42', '1', 'Nov', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('43', '1', 'Dez', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('44', '1', 'Auswahl', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('46', '1', 'Eventlog', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('47', '1', 'Fristende', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('49', '1', 'Akte', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('50', '1', 'Amtl. Zeichen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('51', '1', 'Vorgang', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('52', '1', 'Bearbeiter', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('53', '1', 'Bemerkung', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('54', '1', 'Erstellen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('55', '1', 'Termin', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('56', '1', 'Vorige Treffer anzeigen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('57', '1', 'Treffer anzeigen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('58', '1', 'Weitere Treffer anzeigen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('59', '1', 'Es wurde kein oder ein unzul' + CHAR(228) + 'ssiger Suchbegriff angegeben.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('60', '1', 'Die Suche brachte keine Treffer hervor', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('61', '1', 'Treffer ', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('64', '1', 'Weitere ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('65', '1', 'Vorige ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('66', '1', 'Volltextsuche nach "{0}"', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('67', '1', 'Suchen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('68', '1', 'Benutzer', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('69', '1', 'Kennwort', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('70', '1', 'Abmelden', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('71', '1', 'Auf geht''s ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('72', '1', 'Suche ausf' + CHAR(252) + 'hren ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('73', '1', 'Frist und alle Wiedervorlagen streichen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('74', '1', 'Wiedervorlage streichen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('75', '1', 'Fristablauf', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('76', '1', 'Wiedervorlage', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('77', '1', 'Zum Vortag wechseln ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('78', '1', 'Heute', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('79', '1', 'Zum Folgetag wechseln ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('80', '1', 'Anzeige aktualisieren', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('81', '1', 'Aktive Verbindungen zu Datenbanken', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('82', '1', 'SQL Statement ausf' + CHAR(252) + 'hren', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('83', '1', 'SQL Anfrageergebnis', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('84', '1', 'Ausf' + CHAR(252) + 'hren', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('85', '1', 'Datenbank', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('86', '1', 'SQL', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('87', '1', 'Ung' + CHAR(252) + 'ltige Anfrage oder unzul' + CHAR(228) + 'ssiger Datenbankbezeichner.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('88', '1', 'Die gew' + CHAR(228) + 'hlte Datenbank steht nicht zur Verf' + CHAR(252) + 'gung.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('89', '1', 'Wiedervorlagen am:', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('90', '1', CHAR(196) + 'nderungsgeschichte:', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('91', '1', 'Neue Wiedervorlage zu dieser Frist erstellen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('92', '1', 'Bearbeitervermerk zu dieser Frist hinzuf' + CHAR(252) + 'gen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('93', '1', 'Die Anmeldedaten sind nicht [mehr] g' + CHAR(252) + 'ltig.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('94', '1', 'Die Anfrage ist unzul' + CHAR(228) + 'ssig aufgebaut.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('95', '1', 'Es ist ein interner Fehler im Server aufgetreten.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('96', '1', 'Die Umwandlung einer Zeichenkette in ein Datum war nicht m' + CHAR(246) + 'glich:', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('97', '1', 'Zur ' + CHAR(220) + 'bersicht von heute wechseln ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('98', '1', 'Neuen Termin einf' + CHAR(252) + 'gen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('99', '1', 'Sonderfunktionen verwenden ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('100', '1', 'Auswahl Sonderfunktionen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('101', '1', 'Kennwort ' + CHAR(228) + 'ndern', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('102', '1', 'Unzul' + CHAR(228) + 'ssige Eingabe', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('103', '1', 'Die ' + CHAR(252) + 'bermittelten Daten verletzen eine oder mehrere der folgenden Bedignungen:', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('104', '1', 'Der Fristablauf muss ein g' + CHAR(252) + 'ltiger Kalendertag  in der Zukunft sein.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('105', '1', 'Jede Wiedervorlage muss ein Tag zwischen dem Fristablauf und dem heutigen Datum sein.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('106', '1', 'Alle Wiedervorlagen m' + CHAR(252) + 'ssen an paarweise verschiedenen Tagen liegen.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('107', '1', 'Zur' + CHAR(252) + 'ck zur leeren Eingabemaske', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('108', '1', 'Das Aktenzeichen muss entweder ''0'', eine Zahl oder eine Zahl mit Pr' + CHAR(228) + 'fix ''E'', ''R'' oder ''W'' sein.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('109', '1', 'Es muss ein Betreff (amtliches Aktenzeichen) angegeben werden.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('110', '1', 'Es muss ein Vorgang ausgew' + CHAR(228) + 'hlt werden.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('111', '1', 'Es muss ein Bearbeiter ausgew' + CHAR(228) + 'hlt werden.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('112', '1', 'Diese Frist und alle Wiedervorlagen streichen?', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('113', '1', 'Der Eintrag ist bereits ' + CHAR(252) + 'berf' + CHAR(228) + 'llig ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('114', '1', 'Formulare (allgemein)', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('115', '1', 'Diese Bedingung ist erf' + CHAR(252) + 'llt ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('116', '1', 'Diese Bedingung wird verletzt ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('117', '1', 'Cache flushed ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('118', '1', 'Zur ' + CHAR(220) + 'bersicht wechseln ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('119', '1', 'Hilfe aufsuchen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('121', '1', 'Zum heutigen Datum wechseln ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('123', '1', 'Zum Vortag mit ' + CHAR(252) + 'berf' + CHAR(228) + 'lligen Eintr' + CHAR(228) + 'gen wechseln ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('124', '1', 'Information', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('125', '1', 'Auswahl Benutzerverwaltung', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('126', '1', 'Benutzerverwaltung', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('127', '1', 'Benutzer und Einstellungen verwalten ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('128', '1', 'Es gibt weitere unbearbeitete Eintr' + CHAR(228) + 'ge in der Vergangenheit ...', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('129', '1', 'K' + CHAR(252) + 'rzel', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('130', '1', 'Name', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('132', '1', 'Kennwort best' + CHAR(228) + 'tigen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('133', '1', 'Administratorkennwort', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('134', '1', 'Treffer {1,number,integer} bis {2,number,integer} von {3,number,integer} (weitere Treffer unterdr' + CHAR(252) + 'ckt)', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('136', '1', '', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('137', '1', 'Diesen Eintrag streichen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('138', '1', 'Internen Termin erstellen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('139', '1', 'Frist mit einer Wiedervorlage erstellen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('140', '1', 'Frist erstellen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('141', '1', 'Frist mit zwei Wiedervorlagen erstellen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('142', '1', 'Frist mit mehreren Wiedervorlagen erstellen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('143', '1', 'Ereignisse', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('144', '1', 'Detail anzeigen ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('145', '1', 'Pers' + CHAR(246) + 'nliches Kennwort ' + CHAR(228) + 'ndern', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('149', '1', 'Vorschau der Fristen anzeigen', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('151', '1', 'Daten aus dem Cache entladen', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('152', '1', 'Neue Benutzerkennung eintragen', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('153', '1', 'Vorhandene Benutzerkennung l' + CHAR(246) + 'schen', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('154', '1', 'Benutzereinstellungen bearbeiten', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('155', '1', 'Es sind keine Verbindungen ge' + CHAR(246) + 'ffnet.', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('156', '1', 'Bernhard''s Terminkalender f' + CHAR(252) + 'r Patentanw' + CHAR(228) + 'lte (Beta Release)', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('157', '1', 'Dieses Ereignis ist von unbekanntem Typ ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('158', '1', 'Dieser Fristeintrag wurde erstellt ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('159', '1', 'Dieser Fristeintrag wurde gel' + CHAR(246) + 'scht ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('160', '1', 'Ein Kommentar wurde zu dieser Frist hinzugef' + CHAR(252) + 'gt ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('161', '1', 'Eine Wiedervorlage wurde zu dieser Frist hinzugef' + CHAR(252) + 'gt ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('162', '1', 'Eine Wiedervorlage zu dieser Frist wurde gel' + CHAR(246) + 'scht ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('163', '1', 'Die Systembenutzer werden im Formular nicht angezeigt, weil sie nicht gel' + CHAR(246) + 'scht werden k' + CHAR(246) + 'nnen.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('164', '1', 'Die Einstellungen der Systembenutzer sind vorgegeben und k' + CHAR(246) + 'nnen nicht bearbeitet werden.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('165', '1', 'Hinweis:', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('166', '1', 'L' + CHAR(246) + 'schen/Ausstreichen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('167', '1', 'Verwalten', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('168', '1', 'Anzeigen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('169', '1', 'Treffer {1,number,integer} bis {2,number,integer} von {3,number,integer}', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('170', '1', 'Benutzerhandbuch', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('171', '1', 'Wartungshandbuch', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('172', '1', 'Installationsanleitung', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('173', '1', 'Arbeitsmappe f' + CHAR(252) + 'r Datamining', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('174', '1', 'Zur' + CHAR(252) + 'ck ...', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('175', '1', 'Die Umwandlung einer Zeichenkette in eine ganze Zahl war nicht m' + CHAR(246) + 'glich:', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('176', '1', 'Die neue Wiedervorlage muss ein g' + CHAR(252) + 'ltiger Kalendertag sein.', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('177', '1', 'Dieser Frist k' + CHAR(246) + 'nnen keine weiteren Wiedervorlagen hinzugef' + CHAR(252) + 'gt werden.', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('178', '1', 'Es k' + CHAR(246) + 'nnen keine zwei Wiedervorlagen f' + CHAR(252) + 'r eine Frist am selben Tag eingesetzt werden.', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('179', '1', 'Die neue Wiedervorlage muss vor dem Fristende liegen.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('180', '1', 'Die neue Wiedervorlage muss in der Zukunft liegen.', '1') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('181', '1', 'Nur den Endtermin', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('182', '1', 'Frist mit einer Wiedervorlage', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('183', '1', 'Frist mit zwei Wiedervorlagen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('184', '1', 'Frist mit drei Wiedervorlagen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('185', '1', 'Interner Termin', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('186', '1', 'Geben Sie hier einen SQL Ausdruck ein.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('187', '1', 'Abmelden erfolgt. Gleich geht''s weiter ...', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('188', '1', 'Von', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('189', '1', 'Bis', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('190', '1', 'Erledigte einschlie' + CHAR(223) + 'en', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('193', '1', 'Neues Kennwort', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('194', '1', 'Neues Kennwort best' + CHAR(228) + 'tigen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('195', '1', 'Altes Kennwort', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('196', '1', 'Benutzername', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('197', '1', '{0}', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('198', '1', 'Aktuelle Einstellungen anzeigen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('199', '1', 'Erlauben: Anmelden', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('200', '1', 'Erlauben: Verwalten', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('201', '1', 'Erlauben: Eintr' + CHAR(228) + 'ge erstellen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('202', '1', 'Erlauben: Eintr' + CHAR(228) + 'ge streichen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('203', '1', 'Einstellungen ' + CHAR(252) + 'bernehmen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('204', '1', 'Benutzerkennung erstellen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('205', '1', 'Benutzerkennung l' + CHAR(246) + 'schen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('206', '1', 'Benutzereinstellungen ' + CHAR(228) + 'ndern', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('207', '1', 'Benutzereinstellungen anzeigen und ' + CHAR(228) + 'ndern', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('211', '1', 'Das Anfangsdatum muss ein Tag nach dem Kalender sein.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('212', '1', 'Das Enddatum muss ein Tag nach dem Kalender sein.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('213', '1', 'Das Anfangsdatum darf nicht nach dem Enddatum liegen.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('214', '1', 'Von {1,date,long} bis {2,date,long} (Treffer {3,number,integer} bis {4,number,integer} von {5,number,integer})', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('215', '1', 'Von {1,date,long} bis {2,date,long} (Treffer {3,number,integer} bis {4,number,integer} von {5,number,integer} weitere unterdr' + CHAR(252) + 'ckt)', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('216', '1', 'Im angegebenen Zeitraum gibt es keine Eintr' + CHAR(228) + 'ge f' + CHAR(252) + 'r diesen Bearbeiter', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('217', '1', 'Vorschau f' + CHAR(252) + 'r: "{0}"', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('218', '1', 'Frist am {0,date,long} streichen?', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('219', '1', 'Wiedervorlage am {0,date,long} streichen?', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('220', '1', 'Zur Frist:', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('221', '1', CHAR(220) + 'berwachen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('222', '1', 'Nicht ' + CHAR(252) + 'berwachen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('223', '1', 'Ab heute', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('224', '1', 'Ab Fristende', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('225', '1', 'Zur' + CHAR(252) + 'ck zum Formular ...', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('226', '1', 'Fristeintrag zul' + CHAR(228) + 'ssig/unzul' + CHAR(228) + 'ssig (interner Fehler).', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('228', '1', 'Zeitraum zul' + CHAR(228) + 'ssig/unzul' + CHAR(228) + 'ssig (interner Fehler).', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('229', '1', 'Anfangszeitpunkt zul' + CHAR(228) + 'ssig/unzul' + CHAR(228) + 'ssig (interner Fehler).', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('230', '1', 'Der Zeitabstand muss eine positive Zahl sein.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('231', '1', 'Fortsetzungseintrag zul' + CHAR(228) + 'ssig/unzul' + CHAR(228) + 'ssig (interner Fehler)..', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('232', '1', 'Der Kommentar darf nicht l' + CHAR(228) + 'nger als die vorgesehene Feldl' + CHAR(228) + 'nge in der Datenbank sein.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('233', '1', 'Zu dieser Frist einen Kommentar erstellen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('234', '1', 'Das g' + CHAR(252) + 'ltige Kennwort f' + CHAR(252) + 'r den Administrator muss angegeben werden.', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('235', '1', 'Zur' + CHAR(252) + 'ck zur Eingabemaske', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('236', '1', 'Es muss ein Eintrag aus der Liste ausgew' + CHAR(252) + 'hlt werden', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('237', '1', 'Die folgende Benutzerkennung aus der Datenbank endg' + CHAR(252) + 'ltig l' + CHAR(246) + 'schen', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('238', '1', 'Der angemeldete Benutzer hat keine Rechte zum Durchf' + CHAR(252) + 'hren dieses Vorgangs', '0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('239', '1', 'Das pers' + CHAR(246) + 'nliche Kennwort wurde ge' + CHAR(228) + 'ndert','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('240', '1', 'Das pers' + CHAR(246) + 'nliche Kennwort wurde nicht ge' + CHAR(228) + 'ndert','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('241', '1', 'Das aktuell g' + CHAR(252) + 'ltige pers' + CHAR(246) + 'nliche Kennwort muss angegeben werden','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('242', '1', 'Das angegebene neue Kennwort enth' + CHAR(228) + 'lt unzul' + CHAR(228) + 'ssige Zeichen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('243', '1', 'Die Eingaben f' + CHAR(252) + 'r das neue Kennwort und dessen Best' + CHAR(228) + 'tigung m' + CHAR(252) + 'ssen ' + CHAR(252) + 'bereinstimmen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('244', '1', 'Zum Men' + CHAR(252) + ' wechseln','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('245', '1', 'Vorgang abgeschlossen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('246', '1', 'Das K' + CHAR(252) + 'rzel darf nur Buchstaben und Ziffern enthalten','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('247', '1', 'Der Name darf nur Buchstaben, das Leerzeichen und ''.'' sowie ''-'' enthalten','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('248', '1', 'K' + CHAR(252) + 'rzel oder Name d' + CHAR(252) + 'rfen nicht f' + CHAR(252) + 'r einen anderen Benutzer bereits vergeben sein','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('249', '1', 'K' + CHAR(252) + 'rzel oder Name d' + CHAR(252) + 'rfen nicht leer sein','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('250', '1', 'Die Benutzerkennung wurde erstellt','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('251', '1', 'Vorgang/Bearbeiter','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('252', '1', 'Fristtyp erstellen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('253', '1', 'Der neue Fristtyp wurde erstellt','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('254', '1', 'Statische Daten verwalten','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('255', '1', 'Minilabel' + CHAR (185) + ' ('  + CHAR(220) + 'bersicht)','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('256', '1', 'Label' + CHAR (178) + ' (Formular)','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('257', '1', 'Bearbeitungszusammenhang','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('258', '1', 'Der Kommentar darf nicht leer sein','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('259', '1', 'Der angeforderte Vorgang wurde zur' + CHAR(252) + 'ckgewiesen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('260', '1', 'Der Vorgang setzt die Anmeldung voraus','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('261', '1', 'Der angemeldete Benutzer muss zum Erstellen von Eintr' + CHAR(228) + 'gen berechtigt sein','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('262', '1', 'Der angemeldete Benutzer muss  zum Streichen von Eintr' + CHAR(228) + 'gen berechtigt sein','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('263', '1', 'Der angemeldete Benutzer muss zum Verwalten des Terminkalenders berechtigt sein','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('264', '1', 'Zur Startseite ...','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('265', '1', 'Sicherheit','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('266', '1', 'Max. Anzahl WV','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('267', '1', 'Max. Anzahl Kommentare','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('268', '1', 'Farbe der Anzeige','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('269', '1', 'Beschreibung' + CHAR (179) + ' (Detail)','0') ;
--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('270', '1', 'Es muss eine Farbe ausgew' + CHAR(228) + 'hlt werden','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('271', '1', 'Minilabel' + CHAR(185) + ', Label' + CHAR(178) + ' und Beschreibung' + CHAR(179) + ' d' + CHAR(252) + 'rfen nur bestimmte Sonderzeichen enthalten','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('272', '1', 'Es muss ein Bearbeitungszusammenhang ausgew' + CHAR(228) + 'hlt werden','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('273', '1', 'Minilabel' + CHAR(185) + ', Label' + CHAR(178) + ' und Beschreibung' + CHAR(179) + ' d' + CHAR(252) + 'rfen nicht bereits in der Datenbank vorhanden sein','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('274', '1', 'Die Anzahl der h' + CHAR(246) + 'chstens zul' + CHAR(228) + 'ssigen Kommentare darf nur 0 oder gr' + CHAR(246) + CHAR(223) + 'er sein','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('275', '1', 'Die Anzahl der h' + CHAR(246) + 'chstens zul' + CHAR(228) + 'ssigen Wiedervorlagen darf nur 0 oder gr' + CHAR(246) + CHAR(223) + 'er sein','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('276', '1', 'Minilabel' + CHAR(185) + ', Label' + CHAR(178) + ' und Beschreibung' + CHAR(179) + ' d' + CHAR(252) + 'rfen nicht leer sein','0') ;--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('277', '1', 'Der Rang muss eine ganze Zahl sein','0') ;
--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('278', '1', 'Rang ('  + CHAR(220) + 'bersicht absteigend)','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('279', '1', 'Zur' + CHAR(252) + 'ck zum ' + CHAR(196) + 'ndern der Eingaben', '0') ;
--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('280', '1', 'Fristtyp bearbeiten','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('281', '1', 'Aktuelles Label','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('282', '1', CHAR(196) + 'nderungen gespeichert','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('283', '1', 'Bearbeiterk' + CHAR(252) + 'rzel erstellen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('284', '1', 'Akte/Amtl. Zeichen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('285', '1', '/','0') ;
--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('286', '1', 'Es muss ein Benutzer aus der Liste ausgew' + CHAR(228) + 'hlt werden','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('287', '1', 'Alle Bearbeiterk' + CHAR(252) + 'rzel zuweisen an','0') ;
--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('288', '1', 'Die Benutzerkennung wurde gel' + CHAR(246) + 'scht','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('289', '1', 'Bearbeiterk' + CHAR(252) + 'rzel ' + CHAR(228) + 'ndern','0') ;
--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('290', '1', 'Label' + CHAR(178) + ' und Beschreibung' + CHAR(179) + ' d' + CHAR(252) + 'rfen nicht leer sein','0') ;--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('291', '1', 'Label' + CHAR(178) + ' darf nicht bereits in der Datenbank vorhanden sein','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('292', '1', 'Bearbeiterk' + CHAR(252) + 'rzel','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('293', '1', 'Zuweisen an','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('294', '1', CHAR(196) + 'nderungen speichern','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('295', '1', 'Label' + CHAR(178) + ' und Beschreibung' + CHAR(179) + ' d' + CHAR(252) + 'rfen nur bestimmte Sonderzeichen enthalten','0') ;--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('296', '1', 'In allen Formularen zeigen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('297', '1', 'Fristtyp-Formular-Zuordnung erstellen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('298', '1', 'Fristtyp-Formular-Zuordnung l' + CHAR(246) + 'schen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('299', '1', 'Formular','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('300', '1', 'Bestehende Zuordnungen anzeigen','0') ;
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('301', '1', 'M' + CHAR(246) + 'gliche neue Zuordnungen anzeigen','0') ;
--
INSERT INTO stringlocal (id,locale,text,alt) VALUES ('302', '1', 'API Dokumentation', '0') ;
--
PRINT N'Tabelle ''stringlocal'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE propertieslocal (
          	id 			INT IDENTITY (1,1),
          	locale 		INT NOT NULL,
          	servlet		VARCHAR (255) NOT NULL,
          	name			VARCHAR (50) NOT NULL,
          	html			BIT DEFAULT 1 NOT NULL,
          	stringlocal 		INT NOT NULL,
		CONSTRAINT propertieslocal_pk PRIMARY KEY (id),
		CONSTRAINT propertieslocal_c1 FOREIGN KEY (locale) REFERENCES locale (id),
		CONSTRAINT propertieslocal_c2 FOREIGN KEY (stringlocal) REFERENCES stringlocal (id),
		CONSTRAINT propertieslocal_c3 UNIQUE (locale, servlet, name)
	) ;
GO
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasd', 'caption.new', '1', '283') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasd', 'caption.mod', '1', '289') ;
--	Bearbeiterkürzel erstellen ok (addasdok):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdok', 'caption', '1', '283') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdok', 'cond', '1', '245') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdok', 'condAll', '1', '283') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdok', 'trailer', '1', '244') ;
--	Bearbeiterkürzel erstellen gescheitert (addasdfailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdfailure', 'caption', '1', '283') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdfailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdfailure', 'condCst', '1', '295') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdfailure', 'condDub', '1', '291') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdfailure', 'condNul', '1', '290') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdfailure', 'condUid', '1', '286') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addasdfailure', 'trailer', '1', '279') ;
--	Kommentar erstellen:
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addcomment', 'caption', '1', '233') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addcomment', 'errmsg1', '1', '238') ;
--	Kommentar erstellen gescheitert:
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addcommentfailure', 'caption', '1', '102') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addcommentfailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addcommentfailure', 'condCmm', '1', '232') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addcommentfailure', 'condNul', '1', '258') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addcommentfailure', 'trailer', '1', '225') ;
--	Fristtyp-Formular-Zuordnung erstellen ok (addformtypeok):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypeok', 'caption', '1', '297') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypeok', 'cond', '1', '245') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypeok', 'condAll', '1', '136') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypeok', 'trailer', '1', '244') ;
--	Fristtyp-Formular-Zuordnung erstellen gescheitert (addformtypefailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypefailure', 'caption', '1', '297') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypefailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypefailure', 'condTid', '1', '236') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypefailure', 'trailer', '1', '235') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen (addformtypeshow):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypeshow', 'caption', '1', '297') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen gescheitert (addformtypeshowfailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypeshowfailure', 'caption', '1', '297') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypeshowfailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypeshowfailure', 'condFid', '1', '236') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addformtypeshowfailure', 'trailer', '1', '235') ;
--	WV erstellen:
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotification', 'caption', '1', '76') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotification', 'errmsg1', '1', '238') ;
--	WV erstellen gescheitert:
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotifailure', 'caption', '1', '102') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotifailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotifailure', 'trailer', '1', '107') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotifailure', 'condDue', '1', '179') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotifailure', 'condMax', '1', '177') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotifailure', 'condDst', '1', '178') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotifailure', 'condTdy', '1', '180') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotifailure', 'condAaa', '1', '176') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addnotifailure', 'condCmm', '1', '232') ;
--	Fristtyp erstellen (addtype):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtype', 'caption.new', '1', '252') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtype', 'caption.mod', '1', '280') ;
--	Fristtyp erstellen ok (addtypeok):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypeok', 'caption', '1', '252') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypeok', 'cond', '1', '245') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypeok', 'condAll', '1', '253') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypeok', 'trailer', '1', '244') ;
--	Fristtyp erstellen gescheitert (addtypefailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'caption', '1', '252') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'condCol', '1', '270') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'condCst', '1', '271') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'condCxt', '1', '272') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'condDub', '1', '273') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'condMxc', '1', '274') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'condMxn', '1', '275') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'condNul', '1', '276') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'condRnk', '1', '277') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'addtypefailure', 'trailer', '1', '279') ;
--	Benutzerkennung erstellen (adduser):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduser', 'caption', '1', '204') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduser', 'errmsg1', '1', '238') ;
--	Benutzerkennung erstellen ok (adduserok):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserok', 'caption', '1', '204') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserok', 'cond', '1', '245') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserok', 'condAll', '1', '250') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserok', 'trailer', '1', '244') ;
--	Benutzerkennung erstellen gescheitert (adduserfailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserfailure', 'caption', '1', '102') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserfailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserfailure', 'condNul', '1', '249') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserfailure', 'condShd', '1', '246') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserfailure', 'condDub', '1', '248') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserfailure', 'condNam', '1', '247') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserfailure', 'condCnf', '1', '243') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserfailure', 'condAdm', '1', '234') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'adduserfailure', 'trailer', '1', '107') ;
--
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'basic', 'invalidticket', '1', '93') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'basic', 'invalidrequest', '1', '94') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'basic', 'internalerror', '1', '95') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'basic', 'parseDateError', '1', '96') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'basic', 'parseIntError', '1', '175') ;
--	Persönliches Kennwort ändern (changepassword):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepassword', 'caption', '1', '145') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepassword', 'errmsg1', '1', '238') ;
--	Persönliches Kennwort ändern ok (changepassword):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepasswordok', 'caption', '1', '145') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepasswordok', 'cond', '1', '245') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepasswordok', 'condAll', '1', '239') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepasswordok', 'trailer', '1', '244') ;
--	Persönliches Kennwort ändern gescheitert (changepasswordfailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepasswordfailure', 'caption', '1', '145') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepasswordfailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepasswordfailure', 'condOld', '1', '241') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepasswordfailure', 'condNew', '1', '242') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepasswordfailure', 'condCnf', '1', '243') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'changepasswordfailure', 'trailer', '1', '107') ;
--	Aktive Verbindungen anzeigen (connections):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'connections', 'refreshLoc', '1', '80') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'connections', 'captionLoc', '1', '81') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'connections', 'messageLoc', '1', '155') ;
--	Frist erstellen gescheitert (creatfailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'condNor', '1', '105') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'condNox', '1', '106') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'condFil', '1', '108') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'condSub', '1', '109') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'condTyp', '1', '110') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'condAsd', '1', '111') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'infoCondOK', '0', '115') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'infoCondXX', '0', '116') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'condDue', '1', '104') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'trailer', '1', '279') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'createfailure', 'caption', '1', '102') ;
--	Frist/WV löschen (delete):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delete', 'caption.deadline', '1', '218') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delete', 'caption.notification', '1', '219') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delete', 'option.base.1', '1', '222') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delete', 'option.base.2', '1', '223') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delete', 'option.base.3', '1', '224') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delete', 'captionDoneDeadline', '1', '112') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delete', 'errmsg1', '1', '238') ;
--	Frist/WV löschen gescheitert (deletefailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deletefailure', 'caption', '1', '102') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deletefailure', 'trailer', '1', '225') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deletefailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deletefailure', 'condGid', '1', '226') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deletefailure', 'condRef', '1', '229') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deletefailure', 'condBas', '1', '228') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deletefailure', 'condOff', '1', '230') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deletefailure', 'condPro', '1', '231') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deletefailure', 'condDue', '1', '104') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deletefailure', 'condCmm', '1', '232') ;
--	Fristtyp-Formular-Zuordnung löschen ok (delformtypeok):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypeok', 'caption', '1', '298') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypeok', 'cond', '1', '245') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypeok', 'condAll', '1', '236') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypeok', 'trailer', '1', '244') ;
--	Fristtyp-Formular-Zuordnung löschen gescheitert (delformtypefailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypefailure', 'caption', '1', '298') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypefailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypefailure', 'condTid', '1', '236') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypefailure', 'trailer', '1', '235') ;
--	Fristtyp-Formular-Zuordnung zum Löschen anzeigen (delformtypeshow):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypeshow', 'caption', '1', '298') ;
--	Fristtyp-Formular-Zuordnung zum Löschen anzeigen gescheitert (delformtypeshowfailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypeshowfailure', 'caption', '1', '298') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypeshowfailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypeshowfailure', 'condFid', '1', '236') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delformtypeshowfailure', 'trailer', '1', '235') ;
--	Benutzerkennung löschen (deluser):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deluser', 'caption.del', '1', '205') ;
--	Benutzerkennung löschen ok (deluserok):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deluserok', 'caption', '1', '205') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deluserok', 'cond', '1', '245') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deluserok', 'condAll', '1', '288') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deluserok', 'trailer', '1', '244') ;
--	Benutzerkennung löschen gescheitert (deluserfailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deluserfailure', 'caption', '1', '205') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deluserfailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deluserfailure', 'condAdm', '1', '234') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deluserfailure', 'condAsd', '1', '286') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'deluserfailure', 'trailer', '1', '235') ;
--	Benutzerkennung zum Löschen anzeigen (delusershow):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'delusershow', 'caption', '1', '205') ;
--	Detail zur Frist (detail):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'detail', 'nHeading', '1', '89') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'detail', 'eHeading', '1', '90') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'detail', 'addNotiLoc', '1', '91') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'detail', 'addCommLoc', '1', '92') ;
--	
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'forms', 'choiceCaption', '1', '114') ;
--
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'insert', 'errmsg1', '1', '238') ;
--
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'list', 'nextLoc', '0', '64') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'list', 'prevLoc', '0', '65') ;
--
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'login', 'userLoc', '1', '68') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'login', 'passLoc', '1', '69') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'login', 'logoLoc', '1', '70') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'login', 'infoSub', '0', '71') ;
--
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'loginfailure', 'caption', '0', '265') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'loginfailure', 'cond', '0', '259') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'loginfailure', 'condNul', '0', '286') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'loginfailure', 'condPsw', '0', '241') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'loginfailure', 'trailer', '0', '264') ;
--	Abmelden (logout):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'logout', 'caption', '1', '11') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'logout', 'contents', '1', '187') ;
--	Bearbeiterkürzel zum ändern anzeigen (modasdshow):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modasdshow', 'caption', '1', '289') ;
--	Bearbeiterkürzel ändern ok (modasdok):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modasdok', 'caption', '1', '283') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modasdok', 'cond', '1', '245') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modasdok', 'condAll', '1', '282') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modasdok', 'trailer', '1', '244') ;
--	Fristtyp bearbeiten ok (modtypeok):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypeok', 'caption', '1', '280') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypeok', 'cond', '1', '245') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypeok', 'condAll', '1', '282') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypeok', 'trailer', '1', '244') ;
--	Fristtyp bearbeiten gescheitert (modtypefailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'caption', '1', '280') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'condCol', '1', '270') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'condCst', '1', '271') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'condCxt', '1', '272') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'condDub', '1', '273') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'condMxc', '1', '274') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'condMxn', '1', '275') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'condNul', '1', '276') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'condRnk', '1', '277') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypefailure', 'trailer', '1', '279') ;
--	Benutzereinstellungen bearbeiten (moduser):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'moduser', 'caption', '1', '206') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'moduser', 'errmsg1', '1', '238') ;
--	Benutzereinstellungen bearbeiten gescheitert (moduserfailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'moduserfailure', 'caption', '1', '102') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'moduserfailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'moduserfailure', 'condAdm', '1', '234') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'moduserfailure', 'condUid', '1', '236') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'moduserfailure', 'trailer', '1', '235') ;
--	Benutzereinstellungen zum Bearbeiten anzeigen (modusershow):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modusershow', 'caption', '1', '207') ;
--	Fristtypen zum Bearbeiten anzeigen (modtypeshow):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'modtypeshow', 'caption', '1', '280') ;
--	Navigationsleiste (navigator):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'navigator', 'srchLoc', '1', '67') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'navigator', 'infoSubmitLoc', '0', '72') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'navigator', 'infoOverviewLoc', '0', '97') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'navigator', 'infoInsertLoc', '0', '98') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'navigator', 'infoServiceInfo', '0', '99') ;
--
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'notallowed', 'caption', '0', '265') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'notallowed', 'cond', '0', '259') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'notallowed', 'condLgn', '0', '260') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'notallowed', 'condCrt', '0', '261') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'notallowed', 'condDel', '0', '262') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'notallowed', 'condAdm', '0', '263') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'notallowed', 'trailer', '0', '264') ;
--
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'overview', 'infoDelD', '0', '73') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'overview', 'infoDelN', '0', '74') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'overview', 'deadlineLoc', '1', '75') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'overview', 'notificationLoc', '1', '76') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'overview', 'infoLeft', '0', '77') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'overview', 'infoBall', '0', '78') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'overview', 'infoRight', '0', '79') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'overview', 'infoPrevAtt', '1', '128') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'overview', 'infoWarn', '0', '113') ;
--
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'search', 'truncLoc', '1', '134') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'search', 'infoprev', '1', '56') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'search', 'infohit', '1', '57') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'search', 'infonext', '1', '58') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'search', 'ilTokLoc', '1', '59') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'search', 'noHitLoc', '1', '60') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'search', 'hitLoc', '1', '169') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'search', 'srchLoc', '1', '66') ;
--	
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'service', 'passwd', '1', '101') ;
--
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'serviceforms', 'caption.sql', '1', '82') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'serviceforms', 'caption.workload', '1', '149') ;
--	Fristtyp zum Bearbeiten anzeigen gescheitert (showtypefailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'showtypefailure', 'caption', '1', '280') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'showtypefailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'showtypefailure', 'condTid', '1', '236') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'showtypefailure', 'trailer', '1', '235') ;
--	SQL ausführen (sql):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'sql', 'caption.1', '1', '86') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'sql', 'caption.2', '1', '83') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'sql', 'errmsg1', '1', '238') ;
--	Begrüßungsseite (wellcome):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'wellcome', 'caption', '1', '124') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'wellcome', 'contents', '1', '71') ;
--	Vorschau für Benutzer anzeigen (workload):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workload', 'caption.result', '1', '217') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workload', 'body.result.hits', '1', '214') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workload', 'body.result.trunc', '1', '215') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workload', 'body.result.none', '1', '216') ;
--	Vorschau für Benutzer anzeigen gescheitert (workloadfailure):
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workloadfailure', 'condAsd', '1', '111') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workloadfailure', 'condBegDate', '1', '211') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workloadfailure', 'condEndDate', '1', '212') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workloadfailure', 'cond', '1', '103') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workloadfailure', 'caption', '1', '102') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workloadfailure', 'trailer', '1', '107') ;
INSERT INTO propertieslocal (locale,servlet,name,html,stringlocal) VALUES ('1', 'workloadfailure', 'condOrder', '1', '213') ;
--
PRINT N'Tabelle ''propertieslocal'' erstellt und gef' + CHAR(252) + 'llt.'
GO
--

--
	CREATE TABLE month (
          	id			INT NOT NULL,
          	mini			INT NOT NULL,
          	label			INT NOT NULL,
		CHECK (id > 0 AND id < 13),
		CONSTRAINT month_pk PRIMARY KEY (id),
		CONSTRAINT month_c1 FOREIGN KEY (mini) REFERENCES stringlocal (id),
		CONSTRAINT month_c2 FOREIGN KEY (label) REFERENCES stringlocal (id),
		CONSTRAINT month_c3 UNIQUE (mini),
		CONSTRAINT month_c4 UNIQUE (label)
	) ;
GO
--
INSERT INTO month (id,mini,label) VALUES ('1', '32', '16') ;
INSERT INTO month (id,mini,label) VALUES ('2', '33', '17') ;
INSERT INTO month (id,mini,label) VALUES ('3', '34', '18') ;
INSERT INTO month (id,mini,label) VALUES ('4', '35', '19') ;
INSERT INTO month (id,mini,label) VALUES ('5', '36', '36') ;
INSERT INTO month (id,mini,label) VALUES ('6', '37', '21') ;
INSERT INTO month (id,mini,label) VALUES ('7', '38', '22') ;
INSERT INTO month (id,mini,label) VALUES ('8', '39', '23') ;
INSERT INTO month (id,mini,label) VALUES ('9', '40', '24') ;
INSERT INTO month (id,mini,label) VALUES ('10', '41', '25') ;
INSERT INTO month (id,mini,label) VALUES ('11', '42', '26') ;
INSERT INTO month (id,mini,label) VALUES ('12', '43', '27') ;
--
PRINT N'Tabelle ''month'' erstellt und gef' + CHAR(252) + 'llt.'
GO



--
	CREATE TABLE font (
          	id 			INT NOT NULL,
          	name			VARCHAR (50) NOT NULL,
		CONSTRAINT font_pk PRIMARY KEY (id),
		CONSTRAINT font_c1 UNIQUE (name)
	) ;
GO
--
INSERT INTO font (id,name) VALUES ('1', 'Verdana') ;
--
PRINT N'Tabelle ''font'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE style (
        	id			INT IDENTITY (1,1),
          	font			INT DEFAULT 1 NOT NULL,
          	fsize			INT DEFAULT 16 NOT NULL,	
          	line			INT DEFAULT 0 NOT NULL,
          	bold			BIT DEFAULT 0 NOT NULL,
          	slanted		BIT DEFAULT 0 NOT NULL,
		strike			BIT DEFAULT 0 NOT NULL,
		underline		BIT DEFAULT 0 NOT NULL,
          	color			INT DEFAULT 1 NOT NULL,
          	padding		INT DEFAULT 0 NOT NULL,
		CONSTRAINT style_pk PRIMARY KEY (id),
		CONSTRAINT style_c1 FOREIGN KEY (font) REFERENCES font (id),
		CONSTRAINT style_c2 FOREIGN KEY (color) REFERENCES color (id),
		CHECK (NOT line < 0 AND fsize > 6 AND NOT padding < 0)
	)  ;
GO
--
SET IDENTITY_INSERT style ON
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('1', '1', '22', '28', '0', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('2', '1', '14', '0', '0', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('5', '1', '16', '0', '0', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('8', '1', '64', '0', '0', '0', '3', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('9', '1', '12', '0', '0', '0', '9', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('12', '1', '12', '16', '0', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('13', '1', '12', '0', '1', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('15', '1', '14', '22', '0', '0', '1', '0') ;
-- Benutzername im Loginfenster
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('19', '1', '12', '0', '1', '0', '55', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('21', '1', '12', '0', '0', '0', '53', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('22', '1', '17', '19', '1', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('28', '1', '32', '0', '0', '0', '51', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('30', '1', '15', '28', '1', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('33', '1', '12', '0', '1', '0', '9', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('34', '1', '10', '11', '0', '0', '56', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('35', '1', '14', '32', '1', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('36', '1', '10', '12', '1', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('37', '1', '16', '20', '1', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('38', '1', '16', '20', '0', '0', '32', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('39', '1', '16', '20', '0', '0', '33', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('40', '1', '16', '20', '0', '0', '34', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('41', '1', '14', '20', '0', '0', '33', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('42', '1', '14', '20', '0', '0', '32', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('43', '1', '14', '20', '0', '0', '34', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('44', '1', '14', '20', '1', '0', '1', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('45', '1', '14', '20', '1', '0', '39', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('46', '1', '14', '20', '1', '0', '7', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('48', '1', '12', '16', '0', '0', '2', '0') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('49', '1', '12', '16', '0', '0', '1', '4') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('50', '1', '12', '16', '1', '0', '1', '4') ;
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('51', '1', '12', '16', '0', '0', '1', '1') ;
-- Go! Button im Login
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('52', '1', '10', '0', '1', '0', '1', '0') ;
-- '.detail' in den Formularen confirm, confirmX, confirmP
INSERT INTO style (id,font,fsize,line,bold,slanted,color,padding) VALUES ('53', '1', '12', '0', '0', '0', '1', '0') ;
--
SET IDENTITY_INSERT style OFF
--
PRINT N'Tabelle ''style'' erstellt und gef' + CHAR(252) + 'llt.'
GO




--
	CREATE TABLE urlbase (
          	id 		INT NOT NULL,
          	name		VARCHAR (50) NOT NULL,
          	url		VARCHAR (255) NOT NULL,
		CONSTRAINT urlbase_pk PRIMARY KEY (id),
		CONSTRAINT urlbase_c1 UNIQUE (name),
		CONSTRAINT urlbase_c2 UNIQUE (url)
	) ;
GO
--
INSERT INTO urlbase (id,name,url) VALUES ('1', 'ServletBase', 		'/terminebeta/servlet/') ;
INSERT INTO urlbase (id,name,url) VALUES ('2', 'ImageBase (A)', 		'/terminebeta/images/A/') ;
INSERT INTO urlbase (id,name,url) VALUES ('3', 'TemplateBase', 		'file://C:\Programme\Apache-Group\jakarta-tomcat-3.3.1a\webapps\terminebeta\templates\') ;
INSERT INTO urlbase (id,name,url) VALUES ('5', 'DefaultBase', 		'http://bernhardle.orgdns.org') ;
INSERT INTO urlbase (id,name,url) VALUES ('6', 'ScriptBase', 		'/terminebeta/javascript/') ;
INSERT INTO urlbase (id,name,url) VALUES ('7', 'ImageBase (B)', 		'/terminebeta/images/B/') ;
INSERT INTO urlbase (id,name,url) VALUES ('8', 'ImageBase', 		'/terminebeta/images/') ;
INSERT INTO urlbase (id,name,url) VALUES ('9', 'TemplateBase (A)', 	'file://C:\Programme\Apache-Group\jakarta-tomcat-3.3.1a\webapps\terminebeta\templates\A\') ;
INSERT INTO urlbase (id,name,url) VALUES ('10', 'TemplateBase (B)', 	'file://C:\Programme\Apache-Group\jakarta-tomcat-3.3.1a\webapps\terminebeta\templates\B\') ;
INSERT INTO urlbase (id,name,url) VALUES ('11', 'DocBase', 			'/terminebeta/doc/') ;
INSERT INTO urlbase (id,name,url) VALUES ('12', 'ImageBase (X)', 	'/terminebeta/images/X/') ;
INSERT INTO urlbase (id,name,url) VALUES ('13', 'API-DocBase',		'/terminebeta/doc/api/') ;
--
PRINT N'Tabelle ''urlbase'' erstellt und gef' + CHAR(252) + 'llt.'
GO

--
	CREATE TABLE url (
          	id 		INT NOT NULL,
          	name		VARCHAR (100) NOT NULL,
		base		INT NOT NULL,
          	url		VARCHAR (255) NOT NULL,
		CONSTRAINT url_pk PRIMARY KEY (id),
		CONSTRAINT url_c1 UNIQUE (base,url)
	) ;
GO
--
--	INSERT INTO url (id, name, base, url) VALUES ('1','lalq','1','inner?action=addasd') ;                                                                                                                                                                                    
--
PRINT N'Tabelle ''url'' erstellt und gef' + CHAR(252) + 'llt.'
GO

--
	CREATE TABLE jump (
          	id			INT NOT NULL,
          	name			VARCHAR (100) NOT NULL,
          	base			INT DEFAULT 1 NOT NULL,
          	url			VARCHAR (255) NOT NULL,
          	target		VARCHAR (7) NOT NULL,
		CHECK (target IN ('_parent', '_self', '_top', '_blank',  'Body')),
		CONSTRAINT jump_pk PRIMARY KEY (id),
		CONSTRAINT jump_c1 UNIQUE (base, url, target),
		CONSTRAINT jump_c2 FOREIGN KEY (base) REFERENCES urlbase (id)
	) ;
GO
--
INSERT INTO jump (id,name,base,url,target) VALUES ('1', 'Eintrag erstellen (POST)', '1', 'insert', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('2', 'Eintrag l' + CHAR(246) + 'schen (POST,1)', '1', 'delete', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('3', 'Benutzerkennung l' + CHAR(246) + 'schen (POST,1)', '1', 'deluser', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('4', 'Vorschau anzeigen (POST,0)', '1', 'workload', '_self') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('5', 'Kennwort ' + CHAR(228) + 'ndern (POST,1)', '1', 'changepassword', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('6', 'Aktive Verbindungen anzeigen (0)', '1', 'connections', '_self') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('8', 'SQL Ausführen (POST)', '1', 'sql', '_self') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('9', 'Cache leeren (2)', '1', 'schedule?action=flush', '_top') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('10', 'Formular ''Benutzerkennung erstellen''', '1', 'inner?action=adduser', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('11', 'Formular ''Benutzerkennung zum L' + CHAR(246) + 'schen ausw' + CHAR(228) + 'hlen''', '1', 'inner?action=delusershow', '_parent') ;
--
INSERT INTO jump (id,name,base,url,target) VALUES ('13', 'API Dokumentation', '13', 'index.html', '_blank') ;
--
INSERT INTO jump (id,name,base,url,target) VALUES ('14', 'Dokumentation f' + CHAR(252) + 'r Benutzer', '11', 'manual.pdf', '_blank') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('15', 'Dokumentation f' + CHAR(252) + 'r Administratoren', '11', 'admin.pdf', '_blank') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('16', 'Dokumentation f' + CHAR(252) + 'r Installation (0)', '11', 'install.pdf', '_blank') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('17', 'Anmelden/Abmelden (POST,2)', '1', 'schedule', '_top') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('18', 'Schnellsuche (0)', '1', 'inner', 'Body') ;
--
INSERT INTO jump (id,name,base,url,target) VALUES ('20', 'Formular ''Fristeintrag ohne Wiedervorlagen erstellen''', '1', 'inner?action=insert&key=1', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('21', 'Formular ''Fristeintrag mit einer Wiedervorlage erstellen''', '1', 'inner?action=insert&key=2', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('22', 'Formular ''Fristeintrag mit zwei Wiedervorlagen erstellen''', '1', 'inner?action=insert&key=3', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('23', 'Formular ''Fristeintrag mit mehreren Wiedervorlagen erstellen''', '1', 'inner?action=insert&key=4', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('24', 'Formular ''Fristeintrag (intern) erstellen''', '1', 'inner?action=insert&key=5', '_parent') ;
--
INSERT INTO jump (id,name,base,url,target) VALUES ('26', 'Vorschau anzeigen gescheitert', '1', 'workloadfailure?condBegDate={0}&condEndDate={1}&condAsd={2}&condOrder={3}&backurl={4}&bck1={5}', '_self') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('27', 'Detail des Eintrags', '1', 'inner?action=detail&id={0}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('29', 'Formular ''Vorschau anzeigen'' (1)', '1', 'inner?action=serviceforms&key=1', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('30', 'Formular ''Frist erstellen'' (1)', '1', 'inner?action=insert&key={0}&asd={1}&fil={2}&sub={3}&cmm={4}&typ={5}&1={6}&2={7}&3={8}&4={9}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('31', 'Frist erstellen gescheitert ohne WV (1)', '1', 'inner?action=createfailure&condDue={0}&condFil={1}&condSub={2}&condTyp={3}&condAsd={4}&backurl=30&bck01={5}&bck02={6}&bck03={7}&bck04={8}&bck05={9}&bck06={10}&bck07={11}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('32', 'Frist erstellen gescheitert mit WV (1)', '1', 'inner?action=createfailure&condDue={0}&condNor={1}&condNox={2}&condFil={3}&condSub={4}&condTyp={5}&condAsd={6}&backurl=30&bck01={7}&bck02={8}&bck03={9}&bck04={10}&bck05={11}&bck06={12}&bck07={13}&bck08={14}&bck09={15}&bck10={16}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('34', CHAR(220) + 'bersicht zum Datum (1)', '1', 'inner?action=overview&date={0}', 'Body') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('35', CHAR(220) + 'berschrift (0)', '1', 'caption?action={0}', 'Body') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('36', 'Detail des Eintrags mit R' + CHAR(252) + 'cksprung (1)', '1', 'inner?action=detail&id={0}&back={1}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('37', 'Suche', '1', 'search?token={0}&cut={1}', '_self') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('39', 'Liste', '1', 'list?ids={0}&prv={1}&nxt={2}&tst={3}', '_self') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('43', 'Liste', '1', 'inner?action=list&ids={0}&prv={1}&nxt={2}&tst={3}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('44',  CHAR(220) + 'bersicht nach ID (1)', '1', 'inner?action=overview&id={0}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('45', 'Formular ''Wiedervorlage erstellen''', '1', 'inner?action=addnotification&id={0}&back={1}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('46', 'Formular ''Kommentar erstellen''', '1', 'inner?action=addcomment&id={0}&back={1}&cmm=', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('48', 'Wiedervorlage erstellen gescheitert (1)', '1', 'inner?action=addnotifailure&condAaa={0}&condCmm={1}&condDue={2}&condTdy={3}&condDst={4}&condMax={5}&backurl=45&bck1={6}&bck2={7}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('49', 'Wiedervorlage kurz erstellen gescheitert (1)', '1', 'inner?action=addnotifailure&condAaa={0}&condCmm={1}&condMax={2}&backurl=45&bck1={3}&bck2={4}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('50', 'Formular ''Vorschau anzeigen'' mit Defaults (0)', '1',  'workload?dd1={0}&mm1={1}&yyyy1={2}&dd2={3}&mm2={4}&yyyy2={5}&asd={6}&all={7}&cut={8}&go=true', '_self') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('51', 'Men' + CHAR(252) + ': Sonderfunktionen (0)', '1', 'servicemenue', '_self') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('52', 'Formular ''SQL'' (1)', '1', 'inner?action=sql', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('53', 'Formular ''Eintrag l' + CHAR(246) + 'schen''', '1', 'inner?action=delete&id={0}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('55', 'Formular ''Frist l' + CHAR(246) + 'schen'' erweitern (0)', '1', 'serviceforms&key=31', '_self') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('56', 'Formular ''Wiedervorlage l' + CHAR(246) + 'schen'' erweitern (0)', '1', 'serviceforms&key=41', '_self') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('57', 'L' + CHAR(246) + 'schen gescheitert (1)', '1', 'inner?action=deletefailure&condGid={0}&condRef={1}&condBas={2}&condOff={3}&condDue={4}&condCmm={5}&condPro={6}&backurl=44&bck1={7}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('59', 'L' + CHAR(246) + 'schen gescheitert kurz (1)', '1', 'inner?action=deletefailure&condOff={0}&condDue={1}&condCmm={2}&backurl=44&bck1={3}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('60', 'Formular ''Eintrag l' + CHAR(246) + 'schen mit Fortsetzung'' (1)', '1', 'inner?action=delete&id={0}&extend=true', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('61', 'Kommentar erstellen (POST,1)', '1', 'addcomment', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('62', 'Kommentar erstellen gescheitert (1)', '1', 'inner?action=addcommentfailure&condGid=false', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('63', 'Kommentar erstellen gescheitert zur' + CHAR(252) + 'ck (1)', '1', 'inner?action=addcommentfailure&condNul={0}&condCmm={1}&backurl=65&bck1={2}&bck2={3}&bck3={4}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('64', 'L' + CHAR(246) + 'schen gescheitert ohne back (1)', '1', 'inner?action=deletefailure&condGid={0}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('65', 'Formular ''Kommentar erstellen'' mit Defaults (1)', '1', 'inner?action=addcomment&id={0}&back={1}&cmm={2}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('66',  CHAR(220) + 'bersicht nach Tag (0)', '1', 'overview?date={0}', '_self') ;
--	Benutzereinstellungen ändern (moduser):
INSERT INTO jump (id,name,base,url,target) VALUES ('67', 'Formular ''Benutzereinstellungen ausw' + CHAR(228) + 'hlen'' (1)', '1', 'inner?action=modusershow', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('68', 'Benutzereinstellungen ' + CHAR(228) + 'ndern gescheitert (1)', '1', 'inner?action=moduserfailure&condAdm={0}&backurl=69&bck1={1}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('69', 'Formular ''Benutzereinstellungen ' + CHAR(228) + 'ndern'' (1)', '1', 'inner?action=moduser&lgn={0}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('70', 'Benutzereinstellungen ' + CHAR(228) + 'ndern (POST,1)', '1', 'moduser', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('71', 'Menue ''Benutzerverwaltung'' (1)', '1', 'inner?action=user', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('72', 'Benutzereinstellungen anzeigen gescheitert (0)', '1', 'inner?action=moduserfailure&condUid={0}&backurl=67', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('73', 'Innenrahmen (1)', '1', 'inner', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('74', 'Benutzereinstellungen zum Bearbeiten ausw' + CHAR(228) + 'hlen (POST,0)', '1', 'modusershow', '_parent') ;
--	Benutzerkennung löschen (deluser):
INSERT INTO jump (id,name,base,url,target) VALUES ('75', 'Formular ''Benutzerkennung l' + CHAR(246) + 'schen''', '1', 'inner?action=deluser&lgn={0}', '_parent') ;
--	Benutzerkennung erstellen (adduser):
INSERT INTO jump (id,name,base,url,target) VALUES ('76', 'Benutzerkennung erstellen (POST,0)', '1', 'adduser', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('77', 'Formular ''Vorschau anzeigen'' (1)', '1', 'inner&action=workload', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('78', 'Formular ''Kennwort ' + CHAR(228) + 'ndern'' (1)', '1', 'inner?action=changepassword', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('79', 'Formular ''Aktive Verbindungen anzeigen'' (1)', '1', 'inner?action=connections', '_parent') ;
--
INSERT INTO jump (id,name,base,url,target) VALUES ('80', 'Kennwort ' + CHAR(228) + 'ndern ok (1)', '1', 'inner?action=changepasswordok&condAll=true&backurl=82', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('81', 'Kennwort ' + CHAR(228) + 'ndern gescheitert (1)', '1', 'inner?action=changepasswordfailure&condOld={0}&condNew={1}&condCnf={2}&backurl=78', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('82', 'Zur' + CHAR(252) + 'ck zu den Sonderfunktionen (1)', '1', 'inner?action=service', '_parent') ;
--
INSERT INTO jump (id,name,base,url,target) VALUES ('83', 'Fristtyp erstellen (POST,1)', '1', 'addtype', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('84', 'Formular ''Fristtyp erstellen'' (1)', '1', 'inner?action=addtype&init=false&tid=-1', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('85', 'Fristtyp erstellen ok (1)', '1', 'inner?action=addtypeok&condAll=true&backurl=150', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('86', 'Fristtyp erstellen gescheitert (1)', '1', 'inner?action=addtypefailure&condCol={0}&condCst={1}&condCxt={2}&condMxc={3}&condMxn={4}&condNul={5}&condRnk={6}&backurl=88&bck1={7}&bck2={8}&bck3={9}&bck4={10}&bck5={11}&bck6={12}&bck7={13}&bck8={14}&bck9={15}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('87', 'Fristtyp erstellen gescheitert wg. Dublette (1)', '1', 'inner?action=addtypefailure&condDub=false&backurl=88&bck1={0}&bck2={1}&bck3={2}&bck4={3}&bck5={4}&bck6={5}&bck7={6}&bck8={7}&bck9={8}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('88', 'Formular ''Fristtyp erstellen'' mit Defaults (1)', '1', 'inner?action=addtype&init=false&col={0}&cxt={1}&desc={2}&long={3}&mini={4}&maxc={5}&maxn={6}&rank={7}&tid={8}', '_parent') ;
--	Fristtyp bearbeiten (addtype):
INSERT INTO jump (id,name,base,url,target) VALUES ('90', 'Formular ''Fristtyp zum Ausw' + CHAR(228) + 'hlen''(1)', '1', 'inner?action=modtypeshow', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('91', 'Fristtyp Ausw' + CHAR(228) + 'hlen (POST,1)', '1', 'modtypeshow', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('92', 'Fristtyp Ausw' + CHAR(228) + 'hlen gescheitert (1)', '1', 'inner?action=showtypefailure&condTid=false&backurl=90', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('93', 'Formular ''Fristtyp bearbeiten'' (1)', '1', 'inner?action=addtype&tid={0}&init=true', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('94', 'Fristtyp bearbeiten ok (1)', '1', 'inner?action=modtypeok&condAll=true&backurl=150', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('95', 'Fristtyp bearbeiten gescheitert (1)', '1', 'inner?action=modtypefailure&condCol={0}&condCst={1}&condCxt={2}&condMxc={3}&condMxn={4}&condNul={5}&condRnk={6}&backurl=88&bck1={7}&bck2={8}&bck3={9}&bck4={10}&bck5={11}&bck6={12}&bck7={13}&bck8={14}&bck9={15}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('96', 'Fristtyp bearbeiten gescheitert wg. Dublette (1)', '1', 'inner?action=modtypefailure&condDub=false&backurl=88&bck1={0}&bck2={1}&bck3={2}&bck4={3}&bck5={4}&bck6={5}&bck7={6}&bck8={7}&bck9={8}', '_parent') ;
--	Alles für den Navigator:
INSERT INTO jump (id,name,base,url,target) VALUES ('100', 'Zur ' + CHAR(220) + 'bersicht von heute', '1', 'inner?action=overview&date=today', 'Body') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('101', 'Men' + CHAR(252) + ' ''Eintr' + CHAR(228) + 'ge erstellen''', '1', 'inner?action=forms', 'Body') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('102', 'Men' + CHAR(252) + ' ''Sonderfunktionen''', '1', 'inner?action=service', 'Body') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('103', 'Men' + CHAR(252) + ' ''Benutzerverwaltung''', '1', 'inner?action=user', 'Body') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('104', 'Men' + CHAR(252) + ' ''Hilfe''', '1', 'inner?action=help', 'Body') ;
--
INSERT INTO jump (id,name,base,url,target) VALUES ('120', 'Frist ohne WV erstellen mit Defaults (1)', '1', 'inner?action=insert&key=1&asd={0}&cmm={1}&fil={2}&typ={3}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('121', 'Frist mit einer WV erstellen mit Defaults (1)', '1', 'inner?action=insert&key=2&asd={0}&cmm={1}&fil={2}&typ={3}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('122', 'Frist mit zwei WV erstellen mit Defaults (1)', '1', 'inner?action=insert&key=3&asd={0}&cmm={1}&fil={2}&typ={3}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('123', 'Frist mit drei WV erstellen mit Defaults (1)', '1', 'inner?action=insert&key=4&asd={0}&cmm={1}&fil={2}&typ={3}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('124', 'Interne Frist erstellen mit Defaults (1)', '1', 'inner?action=insert&key=5&asd={0}&cmm={1}&typ={3}', '_parent') ;
--
INSERT INTO jump (id,name,base,url,target) VALUES ('130', 'Benutzereinstellungen zum L' + CHAR(246) + 'schen ausw' + CHAR(228) + 'hlen (POST,0)', '1', 'delusershow', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('131', 'Benutzereinstellungen zum L' + CHAR(246) + 'schen ausw' + CHAR(228) + 'hlen gescheitert (0)', '1', 'inner?action=moduserfailure&condUid={0}&backurl=11', '_parent') ;
--
INSERT INTO jump (id,name,base,url,target) VALUES ('150', 'Men' + CHAR(252) + ' ''Statische Daten''', '1', 'inner?action=staticdatamenue', '_parent') ;
--	WV hinzufügen (addnotification):
INSERT INTO jump (id,name,base,url,target) VALUES ('200', 'WV hinzuf' + CHAR(252) + 'gen (POST,1)', '1', 'addnotification', '_parent') ;
--	Div. Fehlerbedingungen:
INSERT INTO jump (id,name,base,url,target) VALUES ('300', 'Anmeldefehler kurz (0)', '1', 'notallowed?condLgn=false&backurl=17', '_top') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('301', 'Berechtigung ''Verwalten'' fehlt (0)', '1', 'notallowed?condAdm=false&backurl=17', '_top') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('302', 'Berechtigung ''Erstellen'' fehlt (0)', '1', 'notallowed?condCrt=false&backurl=17', '_top') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('303', 'Berechtigung ''L' + CHAR(246) + 'schen'' fehlt (0)', '1', 'notallowed?condDel=false&backurl=17', '_top') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('310', 'Anmeldefehler kurz (1)', '1', 'inner?action=notallowed&condLgn=false&backurl=17', '_top') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('311', 'Berechtigung ''Verwalten'' fehlt (1)', '1', 'inner?action=notallowed&condAdm=false&backurl=17', '_top') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('312', 'Berechtigung ''Erstellen'' fehlt (1)', '1', 'inner?action=notallowed&condCrt=false&backurl=17', '_top') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('313', 'Berechtigung ''L' + CHAR(246) + 'schen'' fehlt (1)', '1', 'inner?action=notallowed&condDel=false&backurl=17', '_top') ;
--
INSERT INTO jump (id,name,base,url,target) VALUES ('400', 'Benutzerkennung erstellen gescheitert (1)', '1', 'inner?action=adduserfailure&condNul={0}&condShd={1}&condNam={2}&condDub={3}&condCnf={4}&condAdm={5}&backurl=10', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('401', 'Benutzerkennung erstellen ok (1)', '1', 'inner?action=adduserok&condAll=true&backurl=71', '_parent') ;
--	Benutzerkennung löschen (deluser):
INSERT INTO jump (id,name,base,url,target) VALUES ('441', 'Benutzerkennung l' + CHAR(246) + 'schen ok (1)', '1', 'inner?action=deluserok&condAll=true&backurl=71', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('442', 'Benutzerkennung l' + CHAR(246) + 'schen gescheitert (1)', '1', 'inner?action=deluserfailure&condAdm=false&backurl=75&bck1={0}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('443', 'Benutzerkennung l' + CHAR(246) + 'schen gescheitert mit Defaults (1)', '1', 'inner?action=deluserfailure&condAsd={0}&condAdm={1}&backurl=444&bck1={2}&bck2={3}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('444', 'Formular ''Benutzerkennung l' + CHAR(246) + 'schen''', '1', 'inner?action=deluser&lgn={0}&asd={1}', '_parent') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO jump (id,name,base,url,target) VALUES ('600', 'Bearbeiterk' + CHAR(252) + 'rzel erstellen (POST,1)', '1', 'addasd', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('610', 'Formular ''Bearbeiterk' + CHAR(252) + 'rzel erstellen'' (1)', '1', 'inner?action=addasd&init=false&aid=-1', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('620', 'Bearbeiterk' + CHAR(252) + 'rzel erstellen ok (1)', '1', 'inner?action=addasdok&condAll=true&backurl=150', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('630', 'Bearbeiterk' + CHAR(252) + 'rzel erstellen gescheitert (1)', '1', 'inner?action=addasdfailure&condCst={0}&condNul={1}&condUid={2}&backurl=650&bck1={3}&bck2={4}&bck3={5}&bck4={6}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('640', 'Bearbeiterk' + CHAR(252) + 'rzel erstellen gescheitert wg. Dublette (1)', '1', 'inner?action=addasdfailure&condDub=false&backurl=650&bck1={0}&bck2={1}&bck3={2}&bck4={3}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('650', 'Formular ''Bearbeiterk' + CHAR(252) + 'rzel erstellen'' mit Defaults (1)', '1', 'inner?action=addasd&init=false&aid={0}&desc={1}&long={2}&lgn={3}', '_parent') ;
--	Benutzerkürzel tzum Bearbeiten anzeigen (modasdshow):
INSERT INTO jump (id,name,base,url,target) VALUES ('700', 'Formular ''Bearbeiterk' + CHAR(252) + 'rzel zum Ausw' + CHAR(228) + 'hlen''(1)', '1', 'inner?action=modasdshow', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('710', 'Bearbeiterk' + CHAR(252) + 'rzel zum Bearbeiten Ausw' + CHAR(228) + 'hlen (POST,1)', '1', 'modasdshow', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('720', 'Bearbeiterk' + CHAR(252) + 'rzel zum Bearbeiten Ausw' + CHAR(228) + 'hlen gescheitert (1)', '1', 'inner?action=showasdfailure&condTid=false&backurl=90', '_parent') ;
--	Benutzerkürzel bearbeiten (modasd):
INSERT INTO jump (id,name,base,url,target) VALUES ('730', 'Formular ''Bearbeiterk' + CHAR(252) + 'rzel bearbeiten'' (1)', '1', 'inner?action=addasd&aid={0}&init=true', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('740', 'Bearbeiterk' + CHAR(252) + 'rzel bearbeiten ok (1)', '1', 'inner?action=modasdok&condAll=true&backurl=150', '_parent') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen (addformtypeshow):
INSERT INTO jump (id,name,base,url,target) VALUES ('800', 'Formular ''Fristtyp-Formular-Zuordnung zum Erstellen anzeigen'' anzeigen (1)', '1', 'inner?action=addformtypeshow', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('810', 'Fristtyp-Formular-Zuordnung zum Erstellen anzeigen (POST,1)', '1', 'addformtypeshow', '_parent') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen gescheitert (addformtypeshowfailure):
INSERT INTO jump (id,name,base,url,target) VALUES ('850', 'Fristtyp-Formular-Zuordnung zum Erstellen anzeigen gescheitert (1)', '1', 'inner?action=addformtypeshowfailure&condFid=true&backurl=800', '_parent') ;
--	Fristtyp-Formular-Zuordnung erstellen (addformtype):
INSERT INTO jump (id,name,base,url,target) VALUES ('900', 'Formular ''Fristtyp-Formular-Zuordnung erstellen'' anzeigen (1)', '1', 'inner?action=addformtype&form={0}&type=0', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('910', 'Formular ''Fristtyp-Formular-Zuordnung erstellen'' mit Voreinstellungen anzeigen (1)', '1', 'inner?action=addformtype&form={0}&type={1}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('920', 'Fristtyp-Formular-Zuordnung erstellen (POST,1)', '1', 'addformtype', '_parent') ;
--	Fristtyp-Formular-Zuordnung erstellen ok (addformtypeok):
INSERT INTO jump (id,name,base,url,target) VALUES ('940', 'Fristtyp-Formular-Zuordnung erstellen ok (1)', '1', 'inner?action=addformtypeok&condAll=true&backurl=150', '_parent') ;
--	Fristtyp-Formular-Zuordnung erstellen gescheitert (addformtypefailure):
INSERT INTO jump (id,name,base,url,target) VALUES ('950', 'Fristtyp-Formular-Zuordnung erstellen gescheitert (1)', '1', 'inner?action=addformtypefailure&condTid=true&backurl=805&bck1={0}&bck2={1}', '_parent') ;
--	Fristtyp-Formular-Zuordnung zum Aufheben anzeigen (delformtypeshow):
INSERT INTO jump (id,name,base,url,target) VALUES ('1000', 'Formular ''Fristtyp-Formular-Zuordnung zum L' + CHAR(246) + 'schen anzeigen'' mit Defaults anzeigen (1)', '1', 'inner?action=delformtypeshow', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('1010', 'Fristtyp-Formular-Zuordnung zum L' + CHAR(246) + 'schen anzeigen (POST,1)', '1', 'delformtypeshow', '_parent') ;
--	Fristtyp-Formular-Zuordnung zum Aufheben anzeigen gescheitert (delformtypeshowfailure):
INSERT INTO jump (id,name,base,url,target) VALUES ('1050', 'Fristtyp-Formular-Zuordnung zum L' + CHAR(246) + 'schen anzeigen gescheitert (1)', '1', 'inner?action=delformtypeshowfailure&condFid=true&backurl=1000', '_parent') ;
--	Fristtyp-Formular-Zuordnung aufheben (delformtype):
INSERT INTO jump (id,name,base,url,target) VALUES ('1100', 'Formular ''Fristtyp-Formular-Zuordnung l' + CHAR(246) + 'schen'' anzeigen (1)', '1', 'inner?action=delformtype&form={0}&type=0', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('1110', 'Formular ''Fristtyp-Formular-Zuordnung l' + CHAR(246) + 'schen'' mit Voreinstellungen anzeigen (1)', '1', 'inner?action=delformtype&form={0}&type={1}', '_parent') ;
INSERT INTO jump (id,name,base,url,target) VALUES ('1120', 'Fristtyp-Formular-Zuordnung l' + CHAR(246) + 'schen (POST,1)', '1', 'delformtype', '_parent') ;
--	Fristtyp-Formular-Zuordnung aufheben ok:
INSERT INTO jump (id,name,base,url,target) VALUES ('1150', 'Fristtyp-Formular-Zuordnung l' + CHAR(246) + 'schen ok (1)', '1', 'inner?action=delformtypeok&condAll=true&backurl=150', '_parent') ;
--	Fristtyp-Formular-Zuordnung aufheben gescheitert:
INSERT INTO jump (id,name,base,url,target) VALUES ('1160', 'Fristtyp-Formular-Zuordnung l' + CHAR(246) + 'schen gescheitert (1)', '1', 'inner?action=delformtypefailure&condTid=false&backurl=1100', '_parent') ;
--
PRINT N'Tabelle ''jump'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE image (
          	id 			INT NOT NULL,
          	description		VARCHAR (100) NOT NULL,
          	base 			INT NOT NULL,
          	url			VARCHAR (255) NOT NULL,
          	xsize			INT NOT NULL,
          	ysize			INT NOT NULL,
          	border		INT NOT NULL,
		CHECK (xsize > 0 AND ysize > 0 AND NOT border < 0),
		CONSTRAINT image_pk PRIMARY KEY (id),
		CONSTRAINT image_c1 UNIQUE (description),
		CONSTRAINT image_c2 FOREIGN KEY (base)  REFERENCES urlbase (id),
		CONSTRAINT image_c3 UNIQUE (base, url, xsize, ysize, border)
	) ;
GO
--
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('1', 'Eintrag erstellen (A) gro' + CHAR(223) + '', '2', 'create100x100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('2', 'Akte (A) gro' + CHAR(223) + '', '2', 'file100x100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('3', 'Detail (A) gro' + CHAR(223) + '', '2', 'detail100x100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('4', 'Anmeldefehler (A) gro' + CHAR(223) + '', '2', 'error100x100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('5', 'Service (A) gro&szlig', '2', 'gear100x100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('6', 'Suche (A) gro' + CHAR(223) + '', '2', 'globe100x100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('7', 'Hilfe (A) gro' + CHAR(223) + '', '2', 'help100x100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('8', 'Abmelden (A) gro' + CHAR(223) + '', '2', 'lock100x100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('9',  CHAR(220) + 'bersicht (A) gro' + CHAR(223) + '', '2', 'overview100x100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('12', 'Eintrag l' + CHAR(246) + 'schen (A) gro' + CHAR(223) + '', '2', 'trash100x100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('15', 'Suche ausf' + CHAR(252) + 'hren (A)', '2', 'go.gif', '25', '25', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('16', 'Leer 100 x 100', '8', 'null.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('19', 'Fadenkreuz, blau', '2', 'hitblue.gif', '23', '23', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('20', 'Ausrufezeichen, rot', '8', 'uv.gif', '11', '14', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('21', 'Haken, gr' + CHAR(252) + 'n, klein', '8', 'checked.gif', '17', '13', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('23',  CHAR(220) + 'bersicht: Folgetag (A)', '2', 'rechts.gif', '32', '32', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('24',  CHAR(220) + 'bersicht: Vortag (A)', '2', 'links.gif', '32', '32', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('25',  CHAR(220) + 'bersicht: Heute (A)', '2', 'ball.gif', '32', '32', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('26', 'Liste, vorige Eintr' + CHAR(228) + 'ge (B)', '7', 'prev.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('27', 'Liste, n' + CHAR(228) + 'chste Eintr' + CHAR(228) + 'ge (B)', '7', 'next.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('30', 'Kreuz, klein, blau 22 x 20', '8', 'nadel.gif', '22', '20', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('31', 'Dreieck, blau 24 x 24', '8', 'item2.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('32', 'M' + CHAR(252) + 'lleimer, klein, grau', '2', 'trashcan.gif', '11', '15', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('33', 'Kreuz, rot (l' + CHAR(246) + 'schen)', '8', 'delete.gif', '14', '13', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('34', 'Notiz, blau', '2', 'note.gif', '26', '26', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('35', 'M' + CHAR(252) + 'lleimer (A) ' + CHAR(220) + 'bersicht', '2', 'trashcanb.gif', '11', '15', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('49', 'Leer 30 x 32', '8', 'null.gif', '30', '32', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('51',  CHAR(220) + 'bersicht: Vortag+ (A)', '2', 'linksatt.gif', '32', '32', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('52', 'Neuer Fristeintrag', '8', 'newd.gif', '84', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('53', 'Neue Frist und 1 WV', '8', 'newnd.gif', '84', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('54', 'Neue Frist und 2 WV', '8', 'newnnd.gif', '84', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('55', 'Neue Frist und >2 WV', '8', 'newnxnd.gif', '84', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('56', 'Neue interne Frist (nur Reichel)', '8', 'newi.gif', '84', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('57', 'Ereignisse (A) gro' + CHAR(223) + '', '2', 'eventG100.gif', '98', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('58', 'Ereignisse (A) klein', '2', 'eventG50.gif', '49', '50', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('59', 'Verkehrszeichen ''Keine Einfahrt''', '8', 'blocked.gif', '15', '15', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('60', 'Ereignis: Neuer Kommentar', '8', 'evnewc.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('61', 'Ereignis: Neue Frist', '8', 'evnewd.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('62', 'Ereignis: Neue Wiedervorlage', '8', 'evnewn.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('63', 'Ereignis: Unbekannt', '8', 'evunkn.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('64', 'Ereignis: Frist gel' + CHAR(246) + 'scht', '8', 'evdeld.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('65', 'Ereignis: Wiedervorlage gel' + CHAR(246) + 'scht', '8', 'evdeln.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('67', 'Treffer', '8', 'hitx.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('68', 'Flushed (A) gro' + CHAR(223) + '', '2', 'flushG100.gif', '100', '100', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('69',  CHAR(220) + 'bersicht (B) gro' + CHAR(223) + '', '7', 'uebersichtH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('70',  CHAR(220) + 'bersicht (B) klein', '7', 'uebersichtH40.gif', '72', '40', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('71', 'BG Titel (B)', '7', 'back01.gif', '1', '2', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('72', 'BG Seitenk' + CHAR(246) + 'rper (B)', '7', 'back04.gif', '1200', '54', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('73', 'BG Navigator (B)', '7', 'back02.gif', '121', '1', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('74', 'BG Login (B)', '7', 'back03.gif', '121', '1', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('75', 'Eintrag erstellen (B) klein', '7', 'neueintragH40.gif', '72', '40', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('76', 'Eintrag erstellen (B) gro' + CHAR(223) + '', '7', 'neueintragH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('78',  CHAR(220) + 'bersicht: Vortag+ (B)', '7', 'links02.gif', '24', '22', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('79',  CHAR(220) + 'bersicht: Heute (B)', '7', 'dot01.gif', '24', '22', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('80',  CHAR(220) + 'bersicht: Folgetag (B)', '7', 'next01.gif', '24', '22', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('82', 'Leer 40 x 80', '8', 'null.gif', '40', '80', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('83', 'Leer 59 x 60', '8', 'null.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('84', 'Service (B) gro' + CHAR(223) + '', '7', 'einstellungenH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('85', 'Service (B) klein', '7', 'einstellungenH40.gif', '72', '40', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('86', 'Blanko (B) gro' + CHAR(223) + '', '7', 'blankoH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('87', 'Blanko (B) klein', '7', 'blankoH40.gif', '72', '40', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('88', 'Leer 2 x 2', '8', 'null.gif', '2', '2', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('89', 'Suche ausf' + CHAR(252) + 'hren (B)', '7', 'go01.gif', '24', '22', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('93', 'M' + CHAR(252) + 'lleimer (B) ' + CHAR(220) + 'bersicht', '7', 'trash01.gif', '11', '15', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('94', 'Willkommen (B) gro' + CHAR(223) + '', '7', 'willkommenH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('95', 'Willkommen (B) klein', '7', 'willkommenH40.gif', '72', '40', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('96', 'Detail (B) gro' + CHAR(223) + '', '7', 'detailsH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('97', 'Detail (B) klein', '7', 'detailsH40.gif', '72', '40', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('98', 'Abmelden (B) gro' + CHAR(223) + '', '7', 'abmeldenH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('99', 'Abmelden (B) klein', '7', 'abmeldenH40.gif', '72', '40', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('100', 'Anmeldefehler (B) gro' + CHAR(223) + '', '7', 'anmeldefehlerH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('101', 'Suchen (B) gro' + CHAR(223) + '', '7', 'suchenH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('102', 'Eintrag l' + CHAR(246) + 'schen (B) gro' + CHAR(223) + '', '7', 'eintragloeschenH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('103', 'Ereignisse (B) gro' + CHAR(223) + '', '7', 'ereignislogH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('104', 'Ereignisse (B) klein', '7', 'ereignislogH40.gif', '72', '40', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('105', 'Flushed (B) gro' + CHAR(223) , '7', 'cacheloeschenH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('106', 'Eintrag erstellen (A) klein', '2', 'create50x50.gif', '50', '50', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('107',  CHAR(220) + 'bersicht (A) klein', '2', 'overview50x50.gif', '50', '50', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('109', 'Service (A) klein', '2', 'gear50x50.gif', '50', '50', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('110',  CHAR(220) + 'bersicht: Vortag (B)', '7', 'prev01.gif', '24', '22', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('111', 'Abmelden (A) klein', '2', 'lock50x50.gif', '50', '50', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('112', 'Suche (A) klein', '2', 'globe50x50.gif', '50', '50', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('113', 'Hilfe (A) klein', '2', 'help50x50.gif', '50', '50', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('114', 'Leer 11 x 15', '8', 'null.gif', '11', '15', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('115', 'Leer 24 x 24', '8', 'null.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('116', 'Liste, Eintrag (B)', '7', 'hitatt.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('117', 'Liste, Eintrag erledigt (B)', '7', 'hooked.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('118', 'Fadenkreuz, rot', '2', 'hitred.gif', '23', '23', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('119', 'Fadenkreuz, gr' + CHAR(252) + 'n', '2', 'hitgreen.gif', '23', '23', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('120', 'Liste, n' + CHAR(228) + 'chste Eintr' + CHAR(228) + 'ge (A)', '2', 'next.gif', '15', '32', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('121', 'Liste, vorige Eintr' + CHAR(228) + 'ge (A)', '2', 'prev.gif', '15', '32', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('122', 'Zur Wiedervorlage in der ' + CHAR(220) + 'bersicht', '8', 'noti2.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('123', 'Zur Frist in der ' + CHAR(220) + 'bersicht', '8', 'frist2.gif', '24', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('124', 'M' + CHAR(252) + 'lleimer, Ausruf (alle)', '8', 'trashatt.gif', '11', '15', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('125', 'Detail verlassen (B)', '7', 'back05.gif', '22', '24', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('126', 'Datenbank', '8', 'db 34x40.gif', '34', '40', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('127', 'Detail verlassen (A)', '8', 'exit.gif', '32', '32', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('128', 'Strichlinie, senkrecht', '7', 'vdotted8x4.gif', '4', '8', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('129', 'Leer 9 x 9', '8', 'uv0.gif', '9', '9', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('130', 'PDF', '12', 'pdf.gif', '32', '20', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('131', 'MDB', '12', 'mdb.gif', '32', '20', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('132', 'DOC', '12', 'doc.gif', '32', '20', '0') ;
--	2004-04-23
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('133', 'Akte', '8', 'file.gif', '32', '32', '0') ;
--	Gerald's neue Symbole
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('200', 'Hilfe (B) klein', '7', 'hilfeH40.gif', '72', '40', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('201', 'Hilfe (B) gro' + CHAR(223), '7', 'hilfeH60.gif', '59', '60', '0') ;
INSERT INTO image (id,description,base,url,xsize,ysize,border) VALUES ('202', 'Cachel' + CHAR(246) + 'schen (B) klein', '7', 'cacheloeschenH40.gif', '72', '40', '0') ;
--
PRINT N'Tabelle ''image'' erstellt und gef' + CHAR(252) + 'llt.'
GO
--
	CREATE TABLE caption (
		id			INT NOT NULL,
		name			VARCHAR (50) NOT NULL,
        	title			INT DEFAULT 136 NOT NULL,
		icon 			VARCHAR (50) NOT NULL,
		CONSTRAINT caption_pk PRIMARY KEY (id),
		CONSTRAINT caption_c1 UNIQUE (name),
		CONSTRAINT caption_c2 UNIQUE (name, title, icon),
		CONSTRAINT caption_c3 FOREIGN KEY (title) REFERENCES stringlocal (id)
	) ;
GO
--
INSERT INTO caption (id,name,title,icon) VALUES ('1', 'default', 	'2', 		'empty') ;
INSERT INTO caption (id,name,title,icon) VALUES ('2', 'overview', 	'3', 		'overview') ;
INSERT INTO caption (id,name,title,icon) VALUES ('3', 'delete', 	'8', 		'delete') ;
INSERT INTO caption (id,name,title,icon) VALUES ('4', 'detail', 	'4', 		'detail') ;
INSERT INTO caption (id,name,title,icon) VALUES ('5', 'error',	'12', 	'error') ;
INSERT INTO caption (id,name,title,icon) VALUES ('6', 'help', 	'9', 		'help') ;
INSERT INTO caption (id,name,title,icon) VALUES ('7', 'login', 	'10', 	'logout') ;
INSERT INTO caption (id,name,title,icon) VALUES ('9', 'logout', 	'11', 	'logout') ;
INSERT INTO caption (id,name,title,icon) VALUES ('10', 'search', 	'6', 		'search') ;
INSERT INTO caption (id,name,title,icon) VALUES ('11', 'service', 	'7', 		'service') ;
INSERT INTO caption (id,name,title,icon) VALUES ('12', 'welcome', 	'2', 		'empty') ;
INSERT INTO caption (id,name,title,icon) VALUES ('13', 'insert', 	'5', 		'insert') ;
INSERT INTO caption (id,name,title,icon) VALUES ('14', 'events', 	'46', 	'empty') ;
INSERT INTO caption (id,name,title,icon) VALUES ('15', 'flush', 	'117', 	'flushed') ;
INSERT INTO caption (id,name,title,icon) VALUES ('16', 'user', 	'126', 	'empty') ;
--
PRINT N'Tabelle ''caption'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE template (
          	id 			INT IDENTITY (1,1),
          	name			VARCHAR (50) NOT NULL,
          	locale 		INT NOT NULL,
          	setting		INT NOT NULL,
          	base 			INT NOT NULL,
          	url			VARCHAR (255) NOT NULL,
		CONSTRAINT template_pk PRIMARY KEY (id),
		CONSTRAINT template_c1 UNIQUE (name, locale, setting),
		CONSTRAINT template_c2 FOREIGN KEY (locale) REFERENCES locale (id),
		CONSTRAINT template_c3 FOREIGN KEY (setting) REFERENCES setting (id),
		CONSTRAINT template_c4 FOREIGN KEY (base) REFERENCES urlbase (id)
	) ;
GO
--
INSERT INTO template (name,locale,setting,base,url) VALUES ('flush', '1', '1', '9', 'flush.html') ;
INSERT INTO template (name,locale,setting,base,url) VALUES ('flush', '1', '2', '10', 'flush.html') ;
--
PRINT N'Tabelle ''template'' erstellt und gef' + CHAR(252) + 'llt.'
GO



--
	CREATE TABLE frameouter (
          	id 			INT,
          	name			VARCHAR (20) NOT NULL,
          	loginbase		INT NOT NULL,
          	login			VARCHAR (255) NOT NULL,
          	navigatorbase	INT NOT NULL,
          	navigator		VARCHAR (255) NOT NULL,
		innerdriverbase	INT NOT NULL,
		innerdriver		VARCHAR (255) NOT NULL,
          	meta			VARCHAR (255) DEFAULT "" NOT NULL,
          	title			INT NOT NULL,
		CONSTRAINT frameouter_pk PRIMARY KEY (id),
		-- CONSTRAINT frameouter_c1 UNIQUE (loginbase, login, navigatorbase, navigator, meta, title),
		CONSTRAINT frameouter_c2 UNIQUE (name),
		CONSTRAINT frameouter_c3 FOREIGN KEY (loginbase) REFERENCES urlbase (id),
		CONSTRAINT frameouter_c4 FOREIGN KEY (navigatorbase) REFERENCES urlbase (id),
		CONSTRAINT frameouter_c5 FOREIGN KEY (innerdriverbase) REFERENCES urlbase (id),
		CONSTRAINT frameouter_c6 FOREIGN KEY (title) REFERENCES stringlocal (id)
	) ;
GO
--
INSERT INTO frameouter (id,name,loginbase,login,navigatorbase,navigator,innerdriverbase,innerdriver,meta,title) VALUES ('1', 'default', '1', 'login', '1', 'navigator', '1', 'inner', '', '156') ;
INSERT INTO frameouter (id,name,loginbase,login,navigatorbase,navigator,innerdriverbase,innerdriver,meta,title) VALUES ('2', 'help', '1', 'login', '1', 'navigator', '1', 'inner', '', '156') ;
INSERT INTO frameouter (id,name,loginbase,login,navigatorbase,navigator,innerdriverbase,innerdriver,meta,title) VALUES ('3', 'notallowed', '1', 'login', '1', 'navigator', '1', 'inner', '', '156') ;
--
PRINT N'Tabelle ''frameouter'' erstellt und gef' + CHAR(252) + 'llt.'
GO

--
	CREATE TABLE frameouterargument (
          	id 			INT IDENTITY (1,1),
          	frameouter		INT NOT NULL,
          	argument		VARCHAR (255) NOT NULL,
          	defval		VARCHAR (255),
          	optional		BIT DEFAULT 0 NOT NULL,
		CONSTRAINT frameouterargument_pk PRIMARY KEY (id),
		CONSTRAINT frameouterargument_c1 UNIQUE (frameouter, argument),
		CONSTRAINT frameouterargument_c2 FOREIGN KEY (frameouter) REFERENCES frameouter (id)
	) ;
GO

INSERT INTO frameouterargument (frameouter,argument,defval,optional) VALUES ('3', 'condLgn', NULL, '1') ;
INSERT INTO frameouterargument (frameouter,argument,defval,optional) VALUES ('3', 'condCrt', NULL, '1') ;
INSERT INTO frameouterargument (frameouter,argument,defval,optional) VALUES ('3', 'condDel', NULL, '1') ;
INSERT INTO frameouterargument (frameouter,argument,defval,optional) VALUES ('3', 'condAdm', NULL, '1') ;
INSERT INTO frameouterargument (frameouter,argument,defval,optional) VALUES ('3', 'backurl', NULL, '0') ;
--
PRINT N'Tabelle ''frameinnerargument'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE frameinner (
		id				INT NOT NULL,
		name				VARCHAR (50) NOT NULL,
        	frameouter			INT NOT NULL,
		captiondriverbase		INT NOT NULL,
		captiondriver		VARCHAR (255) NOT NULL,
		caption 			INT NOT NULL,
		bodybase			INT NOT NULL,
		body				VARCHAR (255) NOT NULL,
		meta				VARCHAR (255),
		CONSTRAINT frameinner_pk PRIMARY KEY (id),
		CONSTRAINT frameinner_c1 UNIQUE (name),
		CONSTRAINT frameinner_c2 FOREIGN KEY (frameouter) REFERENCES frameouter (id),
		CONSTRAINT frameinner_c3 FOREIGN KEY (captiondriverbase) REFERENCES urlbase (id),
		CONSTRAINT frameinner_c4 FOREIGN KEY (caption) REFERENCES caption (id),
		CONSTRAINT frameinner_c5 FOREIGN KEY (bodybase) REFERENCES urlbase (id)
	) ;
GO
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('1', 'default', '1', '1', 'caption', '2', '1', 'overview?date=today', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('2', 'overview', '1', '1', 'caption', '2', '1', 'overview', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('3', 'invaliduid', '1', '1', 'caption', '5', '1', 'loginfailure?condNul=false&condPsw=false&backurl=17', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('4', 'help', '2', '1', 'caption', '6', '1', 'docmenue', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('5', 'invalidpassword', '1', '1', 'caption', '5', '1', 'loginfailure?condNul=true&condPsw=false&backurl=17', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('6', 'login', '1', '1', 'caption', '2', '1', 'overview?date=today', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('7', 'insert', '1', '1', 'caption', '13', '1', 'insert', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('8', 'search', '1', '1', 'caption', '10', '1', 'search', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('9', 'delete', '1', '1', 'caption', '3', '1', 'delete', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('10', 'service', '1', '1', 'caption', '11', '1', 'servicemenue', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('13', 'logout', '1', '1', 'caption', '9', '1', 'logout', '<meta http-equiv="refresh" content="2; url=inner?action=default">') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('14', 'detail', '1', '1', 'caption', '4', '1', 'detail', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('15', 'forms', '1', '1', 'caption', '13', '1', 'insertmenue', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('16', 'events', '1', '1', 'caption', '14', '1', 'wellcome', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('17', 'flush', '1', '1', 'caption', '15', '1', 'flush', '<meta http-equiv="refresh" content="2; url=inner?action=service">') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('18', 'user', '1', '1', 'caption', '16', '1', 'usermenue', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('19', 'createfailure', '1', '1', 'caption', '5', '1', 'createfailure', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('22', 'addnotifailure', '1', '1', 'caption', '5', '1', 'addnotifailure', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('23', 'addnotification', '1', '1', 'caption', '13', '1', 'addnotification', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('24', 'addcomment', '1', '1', 'caption', '13', '1', 'addcomment', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('28', 'serviceforms', '1', '1', 'caption', '11', '1', 'serviceforms', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('29', 'list', '1', '1', 'caption', '10', '1', 'list', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('30', 'deletefailure', '1', '1', 'caption', '10', '1', 'deletefailure', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('31', 'addcommentfailure', '1', '1', 'caption', '5', '1', 'addcommentfailure', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('32', 'moduser', '1', '1', 'caption', '16', '1', 'moduser', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('33', 'moduserfailure', '1', '1', 'caption', '5', '1', 'moduserfailure', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('34', 'modusershow', '1', '1', 'caption', '16', '1', 'modusershow', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('35', 'adduser', '1', '1', 'caption', '16', '1', 'adduser', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('36', 'adduserfailure', '1', '1', 'caption', '5', '1', 'adduserfailure', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('37', 'adduserok', '1', '1', 'caption', '16', '1', 'adduserok', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('38', 'addtype', '1', '1', 'caption', '11', '1', 'addtype', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('39', 'addtypeok', '1', '1', 'caption', '11', '1', 'addtypeok', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('40', 'addtypefailure', '1', '1', 'caption', '5', '1', 'addtypefailure', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('41', 'modtypeok', '1', '1', 'caption', '11', '1', 'modtypeok', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('42', 'modtypefailure', '1', '1', 'caption', '5', '1', 'modtypefailure', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('44', 'modtypeshow', '1', '1', 'caption', '11', '1', 'modtypeshow', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('45', 'showtypefailure', '1', '1', 'caption', '5', '1', 'showtypefailure', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('50', 'sql', '1', '1', 'caption', '11', '1', 'sql', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('51', 'changepassword', '1', '1', 'caption', '11', '1', 'changepassword', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('52', 'connections', '1', '1', 'caption', '11', '1', 'connections', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('53', 'changepasswordok', '1', '1', 'caption', '11', '1', 'changepasswordok', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('54', 'changepasswordfailure', '1', '1', 'caption', '5', '1', 'changepasswordfailure', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('60', 'staticdatamenue', '1', '1', 'caption', '11', '1', 'staticdatamenue', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('100', 'notallowed', '3', '1', 'caption', '5', '1', 'notallowed', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('120', 'deluser', '1', '1', 'caption', '16', '1', 'deluser', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('121', 'deluserok', '1', '1', 'caption', '16', '1', 'deluserok', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('122', 'deluserfailure', '1', '1', 'caption', '5', '1', 'deluserfailure', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('125', 'delusershow', '1', '1', 'caption', '16', '1', 'delusershow', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('150', 'addasd', '1', '1', 'caption', '11', '1', 'addasd', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('151', 'addasdok', '1', '1', 'caption', '11', '1', 'addasdok', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('152', 'addasdfailure', '1', '1', 'caption', '5', '1', 'addasdfailure', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('153', 'modasdok', '1', '1', 'caption', '11', '1', 'modasdok', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('154', 'modasdfailure', '1', '1', 'caption', '5', '1', 'modasdfailure', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('155', 'modasdshow', '1', '1', 'caption', '11', '1', 'modasdshow', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('200', 'addformtypeshow', '1', '1', 'caption', '11', '1', 'addformtypeshow', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('210', 'addformtypeshowfailure', '1', '1', 'caption', '5', '1', 'addformtypeshowfailure', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('300', 'addformtype', '1', '1', 'caption', '11', '1', 'addformtype', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('310', 'addformtypeok', '1', '1', 'caption', '11', '1', 'addformtypeok', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('320', 'addformtypefailure', '1', '1', 'caption', '5', '1', 'addformtypefailure', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('400', 'delformtypeshow', '1', '1', 'caption', '11', '1', 'delformtypeshow', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('410', 'delformtypeshowfailure', '1', '1', 'caption', '5', '1', 'delformtypeshowfailure', '') ;
--
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('500', 'delformtype', '1', '1', 'caption', '11', '1', 'delformtype', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('510', 'delformtypeok', '1', '1', 'caption', '11', '1', 'delformtypeok', '') ;
INSERT INTO frameinner (id,name,frameouter,captiondriverbase,captiondriver,caption,bodybase,body,meta) VALUES ('520', 'delformtypefailure', '1', '1', 'caption', '5', '1', 'delformtypefailure', '') ;
--
PRINT N'Tabelle ''frameinner'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE frameinnerargument (
          	id 			INT IDENTITY (1,1),
          	frameinner 		INT NOT NULL,
          	argument		VARCHAR (255) NOT NULL,
          	defval		VARCHAR (255),
          	optional		BIT DEFAULT 0 NOT NULL,
		CONSTRAINT frameinnerargument_pk PRIMARY KEY (id),
		CONSTRAINT frameinnerargument_c1 UNIQUE (frameinner, argument),
		CONSTRAINT frameinnerargument_c2 FOREIGN KEY (frameinner) REFERENCES frameinner (id)
	) ;
GO
--	Übersicht (overview):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('2', 'date', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('2', 'highlight', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('2', 'id', NULL, '1') ;
--	Formular zum Erstellen (insert):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('7', 'key', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('7', 'asd', '0', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('7', 'typ', '0', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('7', 'fil', '', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('7', 'sub', '', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('7', 'cmm', '', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('7', '1', '', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('7', '2', '', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('7', '3', '', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('7', '4', '', '1') ;
--	Suche (search):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('8', 'token', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('8', 'cut', NULL, '1') ;
--	Formular zum Löschen (delete)
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('9', 'id', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('9', 'cancel', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('9', 'extend', NULL, '1') ;
--	Detail der Frist (detail):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('14', 'id', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('14', 'back', NULL, '1') ;
--	Fehler beim Erstellen einer Frist (createfailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'condDue', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'condNor', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'condNox', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'condSub', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'condTyp', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'condAsd', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'condFil', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'backurl', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'bck01', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'bck02', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'bck03', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'bck04', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'bck05', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'bck06', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'bck07', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'bck08', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'bck09', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('19', 'bck10', NULL, '1') ;
--	Fehler beim Hinzufügen einer Wiedervorlage (addnotifailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('22', 'condAaa', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('22', 'condCmm', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('22', 'condDst', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('22', 'condDue', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('22', 'condMax', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('22', 'condTdy', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('22', 'backurl', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('22', 'bck1', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('22', 'bck2', NULL, '0') ;
--	Formular zum Hinzufügen einer Wiedervorlage (addnotification):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('23', 'id', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('23', 'back', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('23', 'bck1', NULL, '1') ;
--	Formular zum Hinzufügen eines Kommentars (addcomment):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('24', 'cmm', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('24', 'id', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('24', 'back', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('24', 'bck1', NULL, '1') ;
--	
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('28', 'key', NULL, '0') ;
--	
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('29', 'ids', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('29', 'nxt', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('29', 'prv', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('29', 'tst', NULL, '0') ;
--	Fehlerblatt nach Löschen mit/ohne Kommentar und/oder mit Fortsetzungseintrag ():
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('30', 'condGid', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('30', 'condRef', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('30', 'condBas', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('30', 'condOff', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('30', 'condPro', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('30', 'backurl', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('30', 'bck1', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('30', 'condDue', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('30', 'condCmm', NULL, '1') ;
--	Fehlerblatt Kommentar (addcommentfailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('31', 'condCmm', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('31', 'condNul', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('31', 'backurl', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('31', 'bck1', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('31', 'bck2', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('31', 'bck3', NULL, '1') ;
--	Benutzereinstellungen bearbeiten (moduser):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('32', 'lgn', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('32', 'adm', NULL, '1') ;
--	Fehler beim Bearbeiten der Benutzereinstellungen (moduserfailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('33', 'condAdm', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('33', 'condUid', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('33', 'backurl', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('33', 'bck1', NULL, '1') ;
--	Fehler beim erstellen einer Benutzerkennung (adduserfailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('36', 'condNul', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('36', 'condShd', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('36', 'condNam', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('36', 'condDub', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('36', 'condCnf', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('36', 'condAdm', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('36', 'backurl', NULL, '1') ;
--	Benutzer erstellen ok (adduserok):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('37', 'condAll', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('37', 'backurl', NULL, '1') ;
--	Fristtyp erstellen - Formular laden (addtype):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'auto', 'false', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'col', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'cxt', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'desc', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'long', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'mini', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'maxc', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'maxn', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'rank', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'tid', '-1', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('38', 'init', 'true', '0') ;
--	Fristtyp erstellen ok (addtypeok):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('39', 'condAll', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('39', 'backurl', NULL, '0') ;
--	Fristtyp erstellen gescheitert (addtypefailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'condCol', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'condCst', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'condCxt', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'condDub', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'condMxc', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'condMxn', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'condNul', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'condRnk', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'backurl', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'bck1', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'bck2', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'bck3', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'bck4', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'bck5', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'bck6', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'bck7', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'bck8', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('40', 'bck9', NULL, '1') ;
--	Fristtyp bearbeiten ok (modtypeok):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('41', 'condAll', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('41', 'backurl', NULL, '0') ;
--	Fristtyp bearbeiten gescheitert (modtypefailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'condCol', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'condCst', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'condCxt', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'condDub', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'condMxc', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'condMxn', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'condNul', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'condRnk', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'backurl', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'bck1', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'bck2', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'bck3', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'bck4', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'bck5', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'bck6', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'bck7', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'bck8', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('42', 'bck9', NULL, '1') ;
--	Fristtype anzeigen zum Bearbeiten (modtypeshow):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('44', 'tid', NULL, '1') ;
--	Fristtyp anzeigen gescheitert (showtypefailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('45', 'condTid', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('45', 'backurl', NULL, '0') ;
--	Kennwort ändern ok (changepasswordok):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('53', 'condAll', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('53', 'backurl', NULL, '1') ;
--	Kennwort ändern gescheitert (changepasswordfailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('54', 'condOld', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('54', 'condNew', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('54', 'condCnf', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('54', 'backurl', NULL, '1') ;
--	Sicherheitsüberprüfung gescheitert (notallowed):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('100', 'condLgn', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('100', 'condCrt', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('100', 'condDel', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('100', 'condAdm', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('100', 'backurl', NULL, '1') ;
--	Benutzerkennung löschen (deluser):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('120', 'lgn', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('120', 'asd', NULL, '1') ;
--	Benutzerkennung löschen erfolgreich (deluserok):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('121', 'condAll', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('121', 'backurl', NULL, '0') ;
--	Benutzerkennung löschen gescheitert (deluserfailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('122', 'condAdm', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('122', 'condAsd', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('122', 'backurl', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('122', 'bck1', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('122', 'bck2', NULL, '1') ;
--	Bearbeiterkürzel erstellen/bearbeiten (addasd):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('150', 'aid', '-1', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('150', 'auto', 'false', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('150', 'desc', '', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('150', 'long', '', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('150', 'lgn', '-1', '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('150', 'init', 'true', '0') ;
--	Bearbeiterkürzel erstellen ok (addasdok):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('151', 'condAll', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('151', 'backurl', NULL, '0') ;
--	Bearbeioterkürzel erstellen gescheitert (addasdfailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('152', 'condCst', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('152', 'condDub', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('152', 'condNul', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('152', 'condUid', NULL, '1') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('152', 'backurl', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('152', 'bck1', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('152', 'bck2', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('152', 'bck3', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('152', 'bck4', NULL, '0') ;
--	Bearbeiterkürzel bearbeiten ok (modasdok):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('153', 'condAll', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('153', 'backurl', NULL, '0') ;
--	Bearbeiterkürzel bearbeiten gescheitert (modasdfailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('154', 'condUid', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('154', 'backurl', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('154', 'bck1', NULL, '0') ;
--	Bearbeiterkürzel zum Bearbeiten anzeigen (modasdshow):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('155', 'aid', NULL, '1') ;
--	Formular-Fristtyp-Zuordnung zum Erstellen anzeigen gescheitert (addformtypeshowfailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('210', 'condFid', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('210', 'backurl', NULL, '0') ;
--	Formular-Fristtyp-Zuordnung erstellen ok (addformtypeok):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('310', 'condAll', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('310', 'backurl', NULL, '0') ;
--	Formular-Fristtyp-Zuordnung erstellen gescheitert (addformtypefailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('320', 'condTid', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('320', 'backurl', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('320', 'bck1', NULL, '0') ;
--	Formular-Fristtyp-Zuordnung zum Löschen anzeigen gescheitert (delformtypeshowfailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('410', 'condFid', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('410', 'backurl', NULL, '0') ;
--	Formular-Fristtyp-Zuordnung löschen gescheitert (delformtypefailure):
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('520', 'condTid', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('520', 'backurl', NULL, '0') ;
INSERT INTO frameinnerargument (frameinner,argument,defval,optional) VALUES ('520', 'bck1', NULL, '0') ;
--
PRINT N'Tabelle ''frameinnerargument'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE navigator (
          	id			INT NOT NULL,
          	icon			VARCHAR (50) NOT NULL,
          	info 			INT NOT NULL,
          	link 			INT NOT NULL,
          	permlogin		BIT NOT NULL,
          	perminsert		BIT NOT NULL,
          	permadmin		BIT NOT NULL,
		CONSTRAINT navigator_pk PRIMARY KEY (id),
		CONSTRAINT navigator_c1 UNIQUE (icon, info, link),
		CONSTRAINT navigator_c2 FOREIGN KEY (info) REFERENCES stringlocal (id),
		CONSTRAINT navigator_c3 FOREIGN KEY (link) REFERENCES jump (id)
	) ;
GO
--
INSERT INTO navigator (id,icon,info,link,permlogin,perminsert,permadmin) VALUES ('1', 'overview', '97', '100', '0', '0', '0') ;
INSERT INTO navigator (id,icon,info,link,permlogin,perminsert,permadmin) VALUES ('2', 'insert', '98', '101', '1', '1', '0') ;
INSERT INTO navigator (id,icon,info,link,permlogin,perminsert,permadmin) VALUES ('3', 'service', '99', '102', '1', '0', '0') ;
INSERT INTO navigator (id,icon,info,link,permlogin,perminsert,permadmin) VALUES ('4', 'user', '127', '103', '1', '0', '1') ;
INSERT INTO navigator (id,icon,info,link,permlogin,perminsert,permadmin) VALUES ('5', 'help', '13', '104', '0', '0', '0') ;
--
PRINT N'Tabelle ''navigator'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE menue (
          	id		INT NOT NULL,
          	name		VARCHAR (50) NOT NULL,
		title		INT NOT NULL,
		CONSTRAINT menue_pk PRIMARY KEY (id),
		CONSTRAINT menue_c1 UNIQUE (name),
		CONSTRAINT menue_c2 FOREIGN KEY (title) REFERENCES stringlocal (id)
	) ;
GO
--
INSERT INTO menue (id,name,title) VALUES ('1', 'servicemenue', '100') ;
INSERT INTO menue (id,name,title) VALUES ('5', 'usermenue', '125') ;
INSERT INTO menue (id,name,title) VALUES ('10', 'docmenue', '124') ;
INSERT INTO menue (id,name,title) VALUES ('15', 'insertmenue', '114') ;
INSERT INTO menue (id,name,title) VALUES ('20', 'staticdatamenue', '254') ;
--
PRINT N'Tabelle ''menue'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE menueitem (
		id			INT IDENTITY (1,1),
        	menue 		INT NOT NULL,
		link			INT NOT NULL,
		icon			VARCHAR (50) NOT NULL,
		label			VARCHAR (50) NOT NULL,
		plogin		BIT DEFAULT 0 NOT NULL,
		pinsert		BIT DEFAULT 0 NOT NULL,
		pdelete		BIT DEFAULT 0 NOT NULL,
		padmin		BIT DEFAULT 0 NOT NULL,
		rank			INT NOT NULL,
		CHECK (NOT rank < 0),
		CONSTRAINT menueitem_pk PRIMARY KEY (id),
		CONSTRAINT menueitem_c1 UNIQUE (menue, rank),
		CONSTRAINT menueitem_c2 FOREIGN KEY (menue) REFERENCES menue (id),
		CONSTRAINT menueitem_c3 FOREIGN KEY (link) REFERENCES jump (id)
	) ;
GO
--
--	Servicemenue:
--	'78'	Kennwort ändern
--	'79'	Aktive Verbindungen anzeigen
--	'52'	SQL Abfrage
--	'29'	Workload anzeigen
--	'9'	Cache neu laden
--	'150'	Statische Daten verwalten
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('1', '78', 'triangle', '145', '1', '0', '0', '0', '6') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('1', '29', 'triangle', '149', '1', '0', '0', '0', '5') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('1', '52', 'triangle', '82', '1', '0', '0', '1', '4') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('1', '79', 'triangle', '81', '1', '0', '0', '0', '3') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('1', '9', 'triangle', '151', '1', '0', '0', '1', '2') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('1', '150', 'triangle', '254', '1', '0', '0', '1', '1') ;
--
--	Benutzereinstellungen ändern deaktiviert für Tests:
--	'10'	Benutzerkennung erstellen
--	'11'	Benutzerkennung löschen
--	'67'	Benutzereinstellungen ändern
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('5', '10', 'triangle', '152', '1', '0', '0', '1', '1') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('5', '11', 'triangle', '153', '1', '0', '0', '1', '2') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('5', '67', 'triangle', '154', '1', '0', '0', '1', '3') ;
--
--	Dokumentation Wartung/Installation/Datamining ausblenden für Tests
--	'14'	Benutzerdoku
--	'15'	Admindoku
--	'16'	Installationsdoku
--	'13'	API Dokumentation
--	'19'	Arbeitsmappe für Datamining
--
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('10', '14', 'pdf', '170', '0', '0', '0', '0', '50') ;
-- INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('10', '15', 'triangle', '171', '1', '0', '0', '0', '40') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('10', '16', 'pdf', '172', '1', '0', '0', '1', '30') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('10', '13', 'triangle', '302', '1', '0', '0', '1', '20') ;
-- INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('10', '19', 'triangle', '173', '1', '0', '0', '1', '10') ;
--
--	Fristeinträge erstellen:
--	'20'	Frist erstellen
--	'21'	Frist mit einer WV erstellen
--	'22'	Frist mit zwie WV erstellen
--	'23'	Frist mit drei WV erstellen
--	'24'	Interne Frist erstellen ohne WV
--
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('15', '20', 'insert.icon___d', '181', '1', '1', '0', '0', '5') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('15', '21', 'insert.icon__nd', '182', '1', '1', '0', '0', '4') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('15', '22', 'insert.icon_nnd', '183', '1', '1', '0', '0', '3') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('15', '23', 'insert.iconnxnd', '184', '1', '1', '0', '0', '2') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('15', '24', 'insert.icon___i', '138', '1', '1', '0', '0', '1') ;
--
--	Statische Daten bearbeiten:
--	'84' 	Fristtyp erstellen
--	'90' 	Fristtyp bearbeiten
--	'610' 	Bearbeiterkürzel erstellen
--	'700' 	Bearbeiterkürzel zum Bearbeiten auswählen
--	'800'	Fristtyp-Formular-Zuordnung erstellen
--	'1100'	Fristtyp-Formular-Zuordnung löschen
--	'82' 	Zurück ins Tools-Menue
--
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('20', '84', 'triangle', '252', '1', '0', '0', '1', '60') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('20', '90', 'triangle', '280', '1', '0', '0', '1', '50') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('20', '610', 'triangle', '283', '1', '0', '0', '1', '40') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('20', '700', 'triangle', '289', '1', '0', '0', '1', '30') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('20', '800', 'triangle', '297', '1', '0', '0', '1', '20') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('20', '1000', 'triangle', '298', '1', '0', '0', '1', '10') ;
INSERT INTO menueitem (menue,link,icon,label,plogin,pinsert,pdelete,padmin,rank) VALUES ('20', '82', 'triangle', '174', '1', '0', '0', '0', '0') ;
--
PRINT N'Tabelle ''menueitem'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputscript (
        	id 			INT NOT NULL,
          	base			INT NOT NULL,
          	name			VARCHAR (255) NOT NULL,
		CONSTRAINT inputscript_pk PRIMARY KEY (id),
		CONSTRAINT inputscript_c1 UNIQUE (base,name),
		CONSTRAINT inputscript_c2 FOREIGN KEY (base) REFERENCES urlbase (id)
	) ;
GO
--
INSERT INTO inputscript (id,base,name) VALUES ('1', '6', 'addusr.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('2', '6', 'delusr.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('3', '6', 'showusr.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('4', '6', 'modusr.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('5', '6', 'inserta.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('6', '6', 'insertb.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('7', '6', 'insertc.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('8', '6', 'true.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('9', '6', 'inserti.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('10', '6', 'noti.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('11', '6', 'comm.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('12', '6', 'login.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('13', '6', 'quicksearch.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('14', '6', 'workload.js') ;
INSERT INTO inputscript (id,base,name) VALUES ('15', '6', 'passwd.js') ;
--
PRINT N'Tabelle ''inputscript'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputform (
          	id 			INT NOT NULL,
          	name			VARCHAR (50) NOT NULL,
          	target 		INT NOT NULL,
          	script 		INT NOT NULL,
          	type			VARCHAR (4) NOT NULL,
		CHECK (type IN ('POST', 'GET')),
		CONSTRAINT inputform_pk PRIMARY KEY (id),
		CONSTRAINT inputform_c1 UNIQUE (name),
		CONSTRAINT inputform_c2 FOREIGN KEY (target) REFERENCES jump (id),
		CONSTRAINT inputform_c3 FOREIGN KEY (script) REFERENCES inputscript (id)
	) ;
GO
--	Benutzerkennung erstellen:
INSERT INTO inputform (id,name,target,script,type) VALUES ( '1', 'adduser', '76', '1', 'POST') ;
--	SQL ausführen:
INSERT INTO inputform (id,name,target,script,type) VALUES ( '3', 'sql', '8', '8', 'POST') ;
--	Workload anzeigen:
INSERT INTO inputform (id,name,target,script,type) VALUES ( '4', 'workload', '4', '14', 'GET') ;
--	Frist erstellen:
INSERT INTO inputform (id,name,target,script,type) VALUES ( '5', 'inserta', '1', '5', 'POST') ;
--	Frist mit einer WV erstellen:
INSERT INTO inputform (id,name,target,script,type) VALUES ( '6', 'insertb', '1', '6', 'POST') ;
--	Frist mit zwei WV erstellen:
INSERT INTO inputform (id,name,target,script,type) VALUES ( '7', 'insertc', '1', '7', 'POST') ;
--	Frist mit drei WV erstellen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('25', 'insertd', '1', '8', 'POST') ;
--	Interne Frist erstellen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('8', 'inserti', '1', '9', 'POST') ;
--	Benutzereinstellungen anzeigen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('12', 'modusershow', '74', '8', 'POST') ;
--	Benutzereinstellungen ändern:
INSERT INTO inputform (id,name,target,script,type) VALUES ('13', 'moduser', '70', '8', 'POST') ;
--	Anmeldemaske:
INSERT INTO inputform (id,name,target,script,type) VALUES ('14', 'loginfield', '17', '12', 'POST') ;
--	Abmeldemaske:
INSERT INTO inputform (id,name,target,script,type) VALUES ('15', 'logoutfield', '17', '8', 'GET') ;
--	Navigationsleiste:
INSERT INTO inputform (id,name,target,script,type) VALUES ('17', 'navigator', '18', '13', 'GET') ;
--	Kennwort ändern:
INSERT INTO inputform (id,name,target,script,type) VALUES ('19', 'password', '5', '15', 'POST') ;
--	Frist streichen bestätigen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('20', 'confirm', '2', '8', 'POST') ;
--	Frist streichen bestätigen mit Kommentar:
INSERT INTO inputform (id,name,target,script,type) VALUES ('21', 'confirmX', '2', '8', 'POST') ;
--	Frist streichen bestätigen mit Kommentar und Fortsetzung:
INSERT INTO inputform (id,name,target,script,type) VALUES ('22', 'confirmPX', '2', '8', 'POST') ;
--	Kommentar erstellen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('23', 'addcomment', '61', '8', 'POST') ;
--	Benutzerkennung löschen bestätigen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('24', 'confirmU', '75', '8', 'POST') ;
--	WV hinzufügen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('26', 'addnotification', '200', '8', 'POST') ;
--	Fristtyp hinzufügen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('27', 'addtype', '83', '8', 'POST') ;
--	Fristtyp hinzufügen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('28', 'modtypeshow', '91', '8', 'POST') ;
--	Bearbeiterkürzel erstellen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('29', 'addAsd', '600', '8', 'POST') ;
--	Benutzerkennungen zum Löschen anzeigen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('30', 'delusershow', '130', '8', 'POST') ;
--	Benutzerkennung löschen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('31', 'deluser', '3', '8', 'POST') ;
--	Benutzerkennung löschen mit Neuzuweisung:
INSERT INTO inputform (id,name,target,script,type) VALUES ('32', 'deluserX', '3', '8', 'POST') ;
--	Bearbeiterkürzel zum Bearbeiten anzeigen (modasdshow):
INSERT INTO inputform (id,name,target,script,type) VALUES ('33', 'modasdshow', '710', '8', 'POST') ;
--	Bearbeiterkürzel bearbeiten (modasd):
INSERT INTO inputform (id,name,target,script,type) VALUES ('34', 'modasd', '600', '8', 'POST') ;
--	Fristtyp bearbeiten:
INSERT INTO inputform (id,name,target,script,type) VALUES ('35', 'modtype', '83', '8', 'POST') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('36', 'addformtypeshow', '810', '8', 'POST') ;
--	Fristtyp-Formular-Zuordnung erstellen:
INSERT INTO inputform (id,name,target,script,type) VALUES ('37', 'addformtype', '910', '8', 'POST') ;
--	Fristtyp-Formular-Zuordnung zum Löschen anzeigen (delformtypeshow):
INSERT INTO inputform (id,name,target,script,type) VALUES ('38', 'delformtypeshow', '1010', '8', 'POST') ;
--	Fristtyp-Formular-Zuordnung löschen (delformtype):
INSERT INTO inputform (id,name,target,script,type) VALUES ('39', 'delformtype', '1110', '8', 'POST') ;
--
PRINT N'Tabelle ''inputform'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputformheader (
          	inputform		INT NOT NULL,
          	label			INT DEFAULT 136 NOT NULL,
          	text			INT DEFAULT 136 NOT NULL,
		CONSTRAINT inputformheader_pk PRIMARY KEY (inputform, label, text),
		CONSTRAINT inputformheader_c1 FOREIGN KEY (inputform) REFERENCES inputform (id),
		CONSTRAINT inputformheader_c2 FOREIGN KEY (label) REFERENCES stringlocal (id),
		CONSTRAINT inputformheader_c3 FOREIGN KEY (text) REFERENCES stringlocal (id)
	) ;
GO
--
-- Benutzereinstellungen anzeigen (modusershow):
INSERT INTO inputformheader (inputform,label,text) VALUES ('12', '165', '164') ;
-- Benutzerkennung löschen (deluser):
INSERT INTO inputformheader (inputform,label,text) VALUES ('31', '165', '163') ;
-- Benutzerkennung löschen mit Neuzuweisung (deluserX):
INSERT INTO inputformheader (inputform,label,text) VALUES ('32', '165', '163') ;
--
PRINT N'Tabelle ''inputformheader'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputformrow (
          	id 			INT NOT NULL,
          	inputform 		INT NOT NULL,
          	rank			INT NOT NULL,
		CHECK (NOT rank < 0),
		CONSTRAINT inputformrow_pk PRIMARY KEY (id),
		CONSTRAINT inputformrow_c1 UNIQUE (inputform, rank),
		CONSTRAINT inputformrow_c2 FOREIGN KEY (inputform) REFERENCES inputform (id)
	) ;
GO
--
--	Benutzerkennung erstellen (adduser):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('1', '1', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('2', '1', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('3', '1', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('4', '1', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('5', '1', '5') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('6', '1', '6') ;
--	SQL ausführen (sql):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('10', '3', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('11', '3', '2') ;
--	Falls das Adminkennwort abgefragt werden soll:
--	INSERT INTO inputformrow (id,inputform,rank) VALUES ('52', '3', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('12', '3', '4') ;
--	Workload anzeigen (workload):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('53', '4', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('54', '4', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('55', '4', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('56', '4', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('57', '4', '5') ;
--	Frist erstellen (inserta):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('13', '5', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('14', '5', '2') ;
--	Zusammenlegung der Zeilen 14+15->14 
--	INSERT INTO inputformrow (id,inputform,rank) VALUES ('15', '5', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('16', '5', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('17', '5', '5') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('18', '5', '6') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('19', '5', '7') ;
--	Frist mit einer Wiedervorlage ertsellen (insertb):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('20', '6', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('21', '6', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('22', '6', '3') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen' 22+23->22
--	INSERT INTO inputformrow (id,inputform,rank) VALUES ('23', '6', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('24', '6', '5') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('25', '6', '6') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('26', '6', '7') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('27', '6', '8') ;
--	Frist mit zwei Wiedervorlagen erstellen (insertc):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('28', '7', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('29', '7', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('30', '7', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('31', '7', '4') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen' 31+32->31
--	INSERT INTO inputformrow (id,inputform,rank) VALUES ('32', '7', '5') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('33', '7', '6') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('34', '7', '7') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('35', '7', '8') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('36', '7', '9') ;
--	Frist mit drei Wiedervorlagen erstellen (insertd):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('86', '25', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('87', '25', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('88', '25', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('89', '25', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('90', '25', '5') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen' 90+91->90
--	INSERT INTO inputformrow (id,inputform,rank) VALUES ('91', '25', '6') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('92', '25', '7') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('93', '25', '8') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('94', '25', '9') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('95', '25', '10') ;
--	Frist intern erstellen (inserti):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('37', '8', '1') ;
-- INSERT INTO inputformrow (id,inputform,rank) VALUES ('38', '8', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('39', '8', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('40', '8', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('41', '8', '5') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('42', '8', '6') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('71', '8', '7') ;
--	Benutzereinstellungen zum Bearbeiten anzeigen (modusershow);
INSERT INTO inputformrow (id,inputform,rank) VALUES ('46', '12', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('49', '12', '2') ;
--	Benutzereinstellungen bearbeiten (moduser);
INSERT INTO inputformrow (id,inputform,rank) VALUES ('64', '13', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('65', '13', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('66', '13', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('67', '13', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('68', '13', '5') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('69', '13', '6') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('70', '13', '7') ;
--	Kennwort ändern (passwrd):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('58', '19', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('59', '19', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('60', '19', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('61', '19', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('62', '19', '5') ;
--	Löschen ohne und mit Kommentar bestätigen (confirm (20) und confirmX (21)):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('72', '20', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('75', '20', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('73', '21', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('74', '21', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('76', '21', '1') ;
--	Löschen mit Fortsetzung bestätigen (confirmPX):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('79', '22', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('80', '22', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('81', '22', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('82', '22', '4') ;
--	Kommentar erstellen (addcomment):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('83', '23', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('84', '23', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('85', '23', '3') ;
--	WV erstellen (addnotification):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('96', '26', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('97', '26', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('98', '26', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('99', '26', '4') ;
--	Fristtyp erstellen (addtype):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('100', '27', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('101', '27', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('102', '27', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('103', '27', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('104', '27', '5') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('105', '27', '6') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('106', '27', '7') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('107', '27', '8') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('108', '27', '9') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('109', '27', '10') ;
--	Fristtyp zum Bearbeiten anzeigen (showtrype):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('110', '28', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('111', '28', '2') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('112', '29', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('113', '29', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('114', '29', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('115', '29', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('130', '29', '5') ;
--	Benutzereinstellungen zum Löschen anzeigen (modusershow);
INSERT INTO inputformrow (id,inputform,rank) VALUES ('116', '30', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('117', '30', '2') ;
--	Benutzerkennung löschen (deluser):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('118', '31', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('119', '31', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('120', '31', '3') ;
--	Benutzerkennung löschen mit Neuzuweisung (deluserX):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('121', '32', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('122', '32', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('123', '32', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('124', '32', '4') ;
--	Bearbeiterkürzel zum Bearbeiten anzeigen (modasdshow):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('125', '33', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('126', '33', '2') ;
--	Bearbeiterkürzel bearbeiten (modasd):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('127', '34', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('128', '34', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('129', '34', '3') ;
--	Fristtyp bearbeiten (modtype):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('141', '35', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('142', '35', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('143', '35', '3') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('144', '35', '4') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('145', '35', '5') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('146', '35', '6') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('147', '35', '7') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('148', '35', '8') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('149', '35', '9') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen (addformtypeshow):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('160', '36', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('161', '36', '2') ;
--	Fristtyp-Formular-Zuordnung erstellen (addformtype):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('170', '37', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('171', '37', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('172', '37', '3') ;
--	Fristtyp-Formular-Zuordnung zum Löschen anzeigen (delformtypeshow):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('180', '38', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('181', '38', '2') ;
--	Fristtyp-Formular-Zuordnung löschen (delformtype):
INSERT INTO inputformrow (id,inputform,rank) VALUES ('190', '39', '1') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('191', '39', '2') ;
INSERT INTO inputformrow (id,inputform,rank) VALUES ('192', '39', '3') ;
--
--	Letzter Primärschlüssel: 192
--
PRINT N'Tabelle ''inputformrow'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputformrowpos (
          	inputformrow	INT NOT NULL REFERENCES inputformrow (id),
          	pos			INT NOT NULL,	
          	iname		VARCHAR (20) NOT NULL,
		CHECK (NOT pos < 0),
		CONSTRAINT inputformrowpos_pk PRIMARY KEY (inputformrow,pos)
	) ;
GO
-- Benutzerkennung erstellen (adduser):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('1', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('1', '2', 'lgn') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('2', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('2', '2', 'nme') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('3', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('3', '2', 'psa') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('4', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('4', '2', 'psb') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('5', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('5', '2', 'adm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('6', '1', 'label6') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('6', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('6', '3', 'cancel') ;
--	SQL ausführen (sql):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('10', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('10', '2', 'sql') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('11', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('11', '2', 'dbe') ;
--	Falls das Adminkennwort abgefragt werden soll:
-- INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('52', '1', 'label4') ;
-- INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('52', '2', 'adm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('12', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('12', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('12', '3', 'cancel') ;
--	Frist erstellen (inserta):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('13', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('13', '2', '1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('14', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('14', '2', 'fil') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen':
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('14', '3', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('14', '4', 'sub') ;
--	INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('15', '1', 'label3') ;
--	INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('15', '2', 'sub') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('16', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('16', '2', 'typ') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('17', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('17', '2', 'asd') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('18', '1', 'label6') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('18', '2', 'cmm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('19', '1', 'label7') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('19', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('19', '3', 'cancel') ;
--	Frist mit einer Wiedervorlage ertsellen (insertb):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('20', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('20', '2', '1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('21', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('21', '2', '2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('22', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('22', '2', 'fil') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('22', '3', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('22', '4', 'sub') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen'
--	INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('23', '1', 'label4') ;
--	INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('23', '2', 'sub') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('24', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('24', '2', 'typ') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('25', '1', 'label6') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('25', '2', 'asd') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('26', '1', 'label7') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('26', '2', 'cmm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('27', '1', 'label8') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('27', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('27', '3', 'cancel') ;
--	Frist mit zwei Wiedervorlagen erstellen (insertc):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('28', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('28', '2', '1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('29', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('29', '2', '2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('30', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('30', '2', '3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('31', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('31', '2', 'fil') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('31', '3', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('31', '4', 'sub') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen'
--	INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('32', '1', 'label5') ;
--	INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('32', '2', 'sub') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('33', '1', 'label6') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('33', '2', 'typ') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('34', '1', 'label7') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('34', '2', 'asd') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('35', '1', 'label8') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('35', '2', 'cmm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('36', '1', 'label9') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('36', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('36', '3', 'cancel') ;
--	Frist mit drei Wiedervorlagen erstellen (insertd):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('86', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('86', '2', '1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('87', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('87', '2', '2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('88', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('88', '2', '3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('89', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('89', '2', '4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('90', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('90', '2', 'fil') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('90', '3', 'label6') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('90', '4', 'sub') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen'
--	INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('91', '1', 'label6') ;
--	INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('91', '2', 'sub') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('92', '1', 'label7') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('92', '2', 'typ') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('93', '1', 'label8') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('93', '2', 'asd') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('94', '1', 'label9') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('94', '2', 'cmm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('95', '1', 'label10') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('95', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('95', '3', 'cancel') ;
--	Frist intern erstellen (inserti):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('37', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('37', '2', '1') ;
--INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('38', '1', 'label2') ;
--INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('38', '2', 'fil') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('39', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('39', '2', 'sub') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('40', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('40', '2', 'typ') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('41', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('41', '2', 'asd') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('42', '1', 'label6') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('42', '2', 'cmm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('71', '1', 'label7') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('71', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('71', '3', 'cancel') ;
--	Workload anzeigen (workload):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('53', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('53', '2', '1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('54', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('54', '2', '2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('55', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('55', '2', 'asd') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('56', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('56', '2', 'all') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('57', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('57', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('57', '5', 'cancel') ;
--	Kennwort ändern (passwrd):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('58', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('58', '2', 'nme') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('59', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('59', '2', 'psa') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('60', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('60', '2', 'psb') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('61', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('61', '2', 'pso') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('62', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('62', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('62', '3', 'cancel') ;
-- Benutzereinstellungen anzeigen/bearbeiten (moduser);
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('64', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('64', '2', 'nme') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('65', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('65', '2', 'permlgn') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('66', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('66', '2', 'permadm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('67', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('67', '2', 'permcrt') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('68', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('68', '2', 'permdel') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('69', '1', 'label6') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('69', '2', 'adm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('70', '1', 'label7') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('70', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('70', '3', 'cancel') ;
-- INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('70', '4', 'option') ;
-- Löschen ohne und mit Kommentar bestätigen (confirm (20) und confirmX (21)):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('72', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('72', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('73', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('73', '2', 'cmm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('72', '3', 'cancel') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('72', '4', 'extend') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('74', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('74', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('74', '3', 'cancel') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('75', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('76', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('75', '2', 'detail') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('76', '2', 'detail') ;
-- Löschen mit Fortsetzung bestätigen (confirmPX):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('79', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('79', '2', 'detail') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('80', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('80', '3', 'off') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('80', '4', 'bas') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('80', '5', 'ref') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('81', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('81', '2', 'cmm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('82', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('82', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('82', '3', 'cancel') ;
-- Kommentar erstellen (addcomment):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('83', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('83', '2', 'detail') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('84', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('84', '2', 'cmm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('85', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('85', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('85', '3', 'cancel') ;
--	Benutzereinstellungen zum Bearbeiten anzeigen (modusershow):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('46', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('46', '2', 'lgn') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('49', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('49', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('49', '3', 'cancel') ;
--	WV erstellen (addnotification):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('96', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('96', '2', 'det') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('97', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('97', '2', '1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('98', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('98', '2', 'cmm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('99', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('99', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('99', '3', 'cancel') ;
--	Fristtyp erstellen (addtype):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('100', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('100', '2', 'mini') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('101', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('101', '2', 'long') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('102', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('102', '2', 'maxn') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('103', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('103', '2', 'maxc') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('104', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('104', '2', 'rank') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('105', '1', 'label6') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('105', '2', 'cxt') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('106', '1', 'label7') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('106', '2', 'col') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('107', '1', 'label8') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('107', '2', 'desc') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('108', '1', 'label9') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('108', '2', 'auto') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('109', '1', 'label10') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('109', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('109', '3', 'cancel') ;
--	Fristtyp zum Bearbeiten anzeigen (modtypeshow):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('110', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('110', '2', 'tid') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('111', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('111', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('111', '3', 'cancel') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('112', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('112', '2', 'lgn') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('113', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('113', '2', 'long') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('114', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('114', '2', 'desc') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('115', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('115', '2', 'auto') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('130', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('130', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('130', '3', 'cancel') ;
--	Benutzereinstellungen zum Löschen anzeigen (delusershow):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('116', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('116', '2', 'lgn') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('117', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('117', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('117', '3', 'cancel') ;
--	Benutzerkennung löschen (deluser):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('118', '1', 'label0') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('118', '2', 'nme') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('119', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('119', '2', 'adm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('120', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('120', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('120', '3', 'cancel') ;
--	Benutzerkennung löschen mit Neuzuweisung (deluserX):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('121', '1', 'label0') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('121', '2', 'nme') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('122', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('122', '2', 'adm') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('123', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('123', '2', 'asd') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('124', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('124', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('124', '3', 'cancel') ;
--	Bearbeiterkürzel zum Bearbeiten anzeigen (modasdshow):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('125', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('125', '2', 'aid') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('126', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('126', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('126', '3', 'cancel') ;
--	Bearbeiterkürzel bearbeiten (modasd):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('127', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('127', '2', 'long') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('128', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('128', '2', 'lgn') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('129', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('129', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('129', '3', 'cancel') ;
--	Fristtyp bearbeiten (modtype):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('141', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('141', '2', 'mini') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('142', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('142', '2', 'long') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('143', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('143', '2', 'maxn') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('144', '1', 'label4') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('144', '2', 'maxc') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('145', '1', 'label5') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('145', '2', 'rank') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('146', '1', 'label6') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('146', '2', 'cxt') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('147', '1', 'label7') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('147', '2', 'col') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('148', '1', 'label8') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('148', '2', 'desc') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('149', '1', 'label9') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('149', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('149', '3', 'cancel') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen (addformtypeshow):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('160', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('160', '2', 'fid') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('161', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('161', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('161', '3', 'cancel') ;
--	Fristtyp-Formular-Zuordnung erstellen (addformtype):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('170', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('170', '2', 'form') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('171', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('171', '2', 'tid') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('172', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('172', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('172', '3', 'cancel') ;
--	Fristtyp-Formular-Zuordnung zum Löschen anzeigen (delformtypeshow):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('180', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('180', '2', 'fid') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('181', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('181', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('181', '3', 'cancel') ;
--	Fristtyp-Formular-Zuordnung löschen (delformtype):
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('190', '1', 'label1') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('190', '2', 'form') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('191', '1', 'label2') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('191', '2', 'tid') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('192', '1', 'label3') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('192', '2', 'go') ;
INSERT INTO inputformrowpos (inputformrow,pos,iname) VALUES ('192', '3', 'cancel') ;
--
PRINT N'Tabelle ''inputformrowpos'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputhidden (
          	inputform		INT NOT NULL REFERENCES inputform (id),
         	name			VARCHAR (50) NOT NULL,
          	defval		VARCHAR (255) DEFAULT '',
		CONSTRAINT inputhidden_pk PRIMARY KEY (inputform, name)
	) ;
GO
--	Benutzerkennung erstellen (adduser):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('1', 'option', 'addusr') ;
--	Workload anzeigen:
INSERT INTO inputhidden (inputform,name,defval) VALUES ('4', 'action', 'workload') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('4', 'cut', '0') ;
--	Frist erstellen (inserta):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('5', 'key', '-1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('5', 'ddn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('5', 'mmn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('5', 'yyyyn', '1973') ;
--	Frist mit einer Wiedervorlage ertsellen (insertb):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('6', 'key', '-1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('6', 'ddn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('6', 'mmn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('6', 'yyyyn', '1973') ;
--	Frist mit zwei Wiedervorlagen erstellen (insertc):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('7', 'key', '-1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('7', 'ddn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('7', 'mmn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('7', 'yyyyn', '1973') ;
--	Frist mit drei Wiedervorlagen erstellen (insertd):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('25', 'key', '-1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('25', 'ddn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('25', 'mmn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('25', 'yyyyn', '1973') ;
--	Frist intern erstellen (inserti):
--	Das Aktenzeichen ist fest auf '0' eingestellt.
INSERT INTO inputhidden (inputform,name,defval) VALUES ('8', 'key', '-1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('8', 'fil', '0') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('8', 'ddn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('8', 'mmn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('8', 'yyyyn', '1973') ;
--	Benutzereinstellungen anzeigen (modusershow):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('12', 'action', 'moduser') ;
--	Benutzereinstellungen bearbeiten (moduser):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('13', 'lgn', '-1') ;
--	Navigationsleiste:
INSERT INTO inputhidden (inputform,name,defval) VALUES ('17', 'action', 'search') ;
--	Kennwort ändern:
INSERT INTO inputhidden (inputform,name,defval) VALUES ('19', 'lgn', '-1') ;
--	Löschen bestätigen (confirm):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('20', 'id', '-1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('20', 'ref', '0') ;
--	Löschen bestätigen mit Kommentar (confirmX):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('21', 'id', '-1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('21', 'ref', '0') ;
--	Löschen bestätigen mit Fortsetzung (confirmPX):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('22', 'id', '-1') ;
--	Kommentar erstellen (addcomment):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('23', 'id', '-1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('23', 'back', '') ;
--	WV erstellen (addnotification):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('26', 'ddn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('26', 'mmn', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('26', 'yyyyn', '1973') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('26', 'ddx', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('26', 'mmx', '1') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('26', 'yyyyx', '1973') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('26', 'back', '') ;
INSERT INTO inputhidden (inputform,name,defval) VALUES ('26', 'id', '-1') ;
--	Fristtyp erstellen (addtype):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('27', 'tid', '-1') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('29', 'aid', '-1') ;
--	Benutzerkennung löschen:
INSERT INTO inputhidden (inputform,name,defval) VALUES ('31', 'lgn', '-1') ;
--	Benutzerkennung löschen mit Neuzuweisung:
INSERT INTO inputhidden (inputform,name,defval) VALUES ('32', 'lgn', '-1') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('33', 'aid', '-1') ;
--	Bearbeiterkürzel bearbeiten (modasd):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('34', 'aid', '-1') ;
--	Fristtyp ändern (modtype):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('35', 'tid', '-1') ;
--	Fristtyp-Formular-Zuordnung erstellen (addformtype):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('37', 'fid', '-1') ;
--	Fristtyp-Formular-Zuordnung löschen (delformtype):
INSERT INTO inputhidden (inputform,name,defval) VALUES ('39', 'fid', '-1') ;
--
PRINT N'Tabelle ''inputhidden'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputarea (
          	inputform		INT NOT NULL REFERENCES inputform (id),
          	name			VARCHAR (50) NOT NULL,
          	nrows		INT DEFAULT 62 NOT NULL,
          	ncols			INT DEFAULT 4 NOT NULL,
          	style 			INT NOT NULL REFERENCES style (id),
          	defval		INT DEFAULT 136 NOT NULL REFERENCES stringlocal (id),
		CHECK (nrows > 10 AND nrows < 101 AND ncols > 1 AND ncols < 101),
		CONSTRAINT inputarea_pk PRIMARY KEY (inputform, name)
	) ;
GO
--	SQL ausführen ():
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('3', 'sql', '65', '4', '2', '186') ;
--	Frist erstellen (inserta):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('5', 'cmm', '62', '3', '2', '136') ;
--	Frist mit einer Wiedervorlage erstellen (insertb):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('6', 'cmm', '62', '3', '2', '136') ;
--	Frist mit zwei Wiedervorlagen erstellen (insertc):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('7', 'cmm', '62', '3', '2', '136') ;
--	Frist mit drei Wiedervorlagen erstellen (insertd):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('25', 'cmm', '62', '3', '2', '136') ;
--	Frist intern erstellen (inserti):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('8', 'cmm', '62', '3', '2', '136') ;
--	Frist/WV streichen bestätigen mit Kommentar (confirmX):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('21', 'cmm', '62', '4', '2', '136') ;
--	Frist/WV streichen bestätigen mit Kommentar und Fortsetzung (confirmPX):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('22', 'cmm', '62', '4', '2', '136') ;
--	Kommentar hinzufügen (addcomment):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('23', 'cmm', '62', '4', '2', '136') ;
--	WV erstellen (addnotification):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('26', 'cmm', '62', '4', '2', '136') ;
--	Fristtyp erstellen (addtype):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('27', 'desc', '62', '2', '2', '136') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('29', 'desc', '62', '2', '2', '136') ;
--	Fristtyp bearbeiten (modtype):
INSERT INTO inputarea (inputform,name,nrows,ncols,style,defval) VALUES ('35', 'desc', '62', '2', '2', '136') ;
--
PRINT N'Tabelle ''inputarea'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputcheck (
          	inputform 		INT NOT NULL REFERENCES inputform (id),
          	name			VARCHAR (50) NOT NULL,
          	defval		VARCHAR (3) DEFAULT 'ON' NOT NULL,
		CHECK (defval IN ('ON', 'OFF')),
		CONSTRAINT inputcheck_pk PRIMARY KEY (inputform, name)
	) ;
GO
--	Workload anzeigen (workload):
INSERT INTO inputcheck (inputform,name,defval) VALUES ('4', 'all', 'ON') ;
--	Benutzereinstellungen ändern (moduser):
INSERT INTO inputcheck (inputform,name,defval) VALUES ('13', 'permadm', 'ON') ;
INSERT INTO inputcheck (inputform,name,defval) VALUES ('13', 'permcrt', 'ON') ;
INSERT INTO inputcheck (inputform,name,defval) VALUES ('13', 'permdel', 'ON') ;
INSERT INTO inputcheck (inputform,name,defval) VALUES ('13', 'permlgn', 'ON') ;
--	Fristtyp erstellen (addtype):
INSERT INTO inputcheck (inputform,name,defval) VALUES ('27', 'auto', 'ON') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO inputcheck (inputform,name,defval) VALUES ('29', 'auto', 'ON') ;
--
PRINT N'Tabelle ''inputcheck'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputdate (
          	inputform 		INT NOT NULL REFERENCES inputform (id),
          	name			VARCHAR (50) NOT NULL,
          	style 			INT DEFAULT 2 NOT NULL REFERENCES style (id),
		CONSTRAINT inputdate_pk PRIMARY KEY (inputform, name)
	) ;
GO
--
INSERT INTO inputdate (inputform,name,style) VALUES ('4', '1', '2') ;
INSERT INTO inputdate (inputform,name,style) VALUES ('4', '2', '2') ;
--	Frist erstellen (inserta):
INSERT INTO inputdate (inputform,name,style) VALUES ('5', '1', '2') ;
--	Frist mit einer Wiedervorlage erstellen (insertb):
INSERT INTO inputdate (inputform,name,style) VALUES ('6', '1', '2') ;
INSERT INTO inputdate (inputform,name,style) VALUES ('6', '2', '2') ;
--	Frist mit zwei Wiedervorlagen erstellen (insertc):
INSERT INTO inputdate (inputform,name,style) VALUES ('7', '1', '2') ;
INSERT INTO inputdate (inputform,name,style) VALUES ('7', '2', '2') ;
INSERT INTO inputdate (inputform,name,style) VALUES ('7', '3', '2') ;
--	Frist mit drei Wiedervorlagen erstellen (insertd):
INSERT INTO inputdate (inputform,name,style) VALUES ('25', '1', '2') ;
INSERT INTO inputdate (inputform,name,style) VALUES ('25', '2', '2') ;
INSERT INTO inputdate (inputform,name,style) VALUES ('25', '3', '2') ;
INSERT INTO inputdate (inputform,name,style) VALUES ('25', '4', '2') ;
--	Frist intern erstellen (inserti):
INSERT INTO inputdate (inputform,name,style) VALUES ('8', '1', '2') ;
--	WV erstellen (addnotification):
INSERT INTO inputdate (inputform,name,style) VALUES ('26', '1', '2') ;
--
PRINT N'Tabelle ''inputdate'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputdetail (
          	inputform		INT NOT NULL,
          	name			VARCHAR (50) NOT NULL,
          	style			VARCHAR (50),
		CONSTRAINT inputdetail_pk PRIMARY KEY (inputform, name),
		CONSTRAINT inputdetail_c1 FOREIGN KEY (inputform) REFERENCES inputform (id)
	) ;
GO
--	Frist/WV streichen bestätigen (confirm):
INSERT INTO inputdetail (inputform,name,style) VALUES ('20', 'detail', 'detail') ;
--	Frist/WV streichen bestätigen mit Kommentar (confirmX):
INSERT INTO inputdetail (inputform,name,style) VALUES ('21', 'detail', 'detail') ;
--	Frist/WV streichen bestätigen mit Kommentar und Fortsetzung (confirmPX):
INSERT INTO inputdetail (inputform,name,style) VALUES ('22', 'detail', 'detail') ;
--	Kommentar hinzufügen (addcomment):
INSERT INTO inputdetail (inputform,name,style) VALUES ('23', 'detail', 'detail') ;
--	WV erstellen (addnotification):
INSERT INTO inputdetail (inputform,name,style) VALUES ('26', 'det', 'detail') ;
--
PRINT N'Tabelle ''inputdetail'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputimage (
          	inputform 		INT NOT NULL,
          	name			VARCHAR (50) NOT NULL,
          	icon			INT NOT NULL,
          	defval		VARCHAR (255) NOT NULL,
          	alt			INT DEFAULT 136 NOT NULL,
		CONSTRAINT inputimage_pk PRIMARY KEY (inputform, name),
		CONSTRAINT inputimage_c1 UNIQUE (inputform, icon, defval, alt),
		CONSTRAINT inputimage_c2 FOREIGN KEY (inputform) REFERENCES inputform (id),
		CONSTRAINT inputimage_c3 FOREIGN KEY (icon) REFERENCES image (id)
	) ;
GO
--
INSERT INTO inputimage (inputform,name,icon,defval,alt) VALUES ('17', 'search', '89', 'Go', '72') ;
--
PRINT N'Tabelle ''inputimage'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputselect (
          	inputform 		INT NOT NULL REFERENCES inputform (id),
          	name			VARCHAR (50) NOT NULL,
          	void			BIT DEFAULT 0 NOT NULL,
          	style 			INT NOT NULL REFERENCES style (id),
		CONSTRAINT inputselect_pk PRIMARY KEY (inputform, name)
	) ;
GO
--	SQL ausführen (sql):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('3', 'dbe', '0', '2') ;
--	Workload anzeigen (workload):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('4', 'asd', '1', '2') ;
--	Frist erstellen (inserta):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('5', 'asd', '1', '2') ;
INSERT INTO inputselect (inputform,name,void,style) VALUES ('5', 'typ', '1', '2') ;
--	Frist mit einer Wiedervorlage erstellen (insertb):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('6', 'asd', '1', '2') ;
INSERT INTO inputselect (inputform,name,void,style) VALUES ('6', 'typ', '1', '2') ;
--	Frist mit zwei Wiedervorlagen erstellen (insertc):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('7', 'asd', '1', '2') ;
INSERT INTO inputselect (inputform,name,void,style) VALUES ('7', 'typ', '1', '2') ;
--	Frist mit drei Wiedervorlagen erstellen (insertd):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('25', 'asd', '1', '2') ;
INSERT INTO inputselect (inputform,name,void,style) VALUES ('25', 'typ', '1', '2') ;
--	Frist intern erstellen (inserti):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('8', 'asd', '1', '2') ;
INSERT INTO inputselect (inputform,name,void,style) VALUES ('8', 'typ', '0', '2') ;
--	Benutzer zum Bearbeiten anzeigen (modusershow):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('12', 'lgn', '1', '2') ;
--	
INSERT INTO inputselect (inputform,name,void,style) VALUES ('14', 'login', '1', '12') ;
--	Frist/WV streichen bestätigen mit Kommentar und Fortsetzung (confirmPX):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('22', 'ref', '0', '2') ;
INSERT INTO inputselect (inputform,name,void,style) VALUES ('22', 'bas', '0', '2') ;
--	Neuen Fristtyp erstellen (addtype):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('27', 'cxt', '1', '2') ;
INSERT INTO inputselect (inputform,name,void,style) VALUES ('27', 'col', '1', '2') ;
--	Fristtyp zum Bearbeiten anzeigen (modtypeshow):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('28', 'tid', '1', '2') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('29', 'lgn', '1', '2') ;
--	Benutzer zum Löschen anzeigen (delusershow):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('30', 'lgn', '1', '2') ;
--	Benutzer löschen mit Neuzuweisung (deluserX):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('32', 'asd', '1', '2') ;
--	Bearbeiterkürzel zum Bearbeiten anzeigen (modasdshow):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('33', 'aid', '1', '2') ;
--	Bearbeiterkürzel bearbeiten (modasd):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('34', 'lgn', '0', '2') ;
--	Fristtyp bearbeiten (modtype):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('35', 'cxt', '1', '2') ;
INSERT INTO inputselect (inputform,name,void,style) VALUES ('35', 'col', '1', '2') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen (addformtypeshow):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('36', 'fid', '1', '2') ;
--	Fristtyp-Formular-Zuordnung erstellen anzeigen (addformtype):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('37', 'tid', '1', '2') ;
--	Fristtyp-Formular-Zuordnung zum Löschen anzeigen (delformtypeshow):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('38', 'fid', '1', '2') ;
--	Fristtyp-Formular-Zuordnung löschen (delformtype):
INSERT INTO inputselect (inputform,name,void,style) VALUES ('39', 'tid', '1', '2') ;
--
PRINT N'Tabelle ''inputselect'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputsubmit (
          	inputform 		INT NOT NULL REFERENCES inputform (id),
          	name			VARCHAR (50) NOT NULL,
          	type			INT DEFAULT 1 NOT NULL,
          	style 			INT NOT NULL REFERENCES style (id),
          	defval		VARCHAR (255) NOT NULL,
		CHECK (type IN ('0','1','2')),
		CONSTRAINT inputsubmit_pk PRIMARY KEY (inputform, name)
	) ;
GO
--	Benutzerkennung erstellen (adduser):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('1', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('1', 'cancel', '1', '12', 'Abbrechen') ;
--	SQL ausführen (sql):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('3', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('3', 'cancel', '1', '12', 'Abbrechen') ;
--	Workload anzeigen (workload):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('4', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('4', 'cancel', '1', '12', 'Abbrechen') ;
--	Frist erstellen (inserta):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('5', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('5', 'cancel', '1', '12', 'Abbrechen') ;
--	Frist mit einer WV erstellen (insertb):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('6', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('6', 'cancel', '1', '12', 'Abbrechen') ;
--	Frist mit zwei WV erstellen (insertc):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('7', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('7', 'cancel', '1', '12', 'Abbrechen') ;
--	Frist mit drei WV erstellen (insertd):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('25', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('25', 'cancel', '1', '12', 'Abbrechen') ;
--	Interne Frist erstellen (inserti):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('8', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('8', 'cancel', '1', '12', 'Abbrechen') ;
--	Benutzereinstellungen zum Bearbeiten anzeigen (modusershow):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('12', 'go', '1', '13', 'Anzeigen') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('12', 'cancel', '1', '12', 'Abbrechen') ;
--	Benutzereinstellungen ändern (moduser):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('13', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('13', 'cancel', '1', '12', 'Abbrechen') ;
--	Anmeldemaske (login):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('14', 'go', '1', '52', 'Go!') ;
--	Abmeldemaske (logout):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('15', 'go', '1', '52', 'Go!') ;
--	Kennwort ändern:
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('19', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('19', 'cancel', '1', '12', 'Abbrechen') ;
--	Frist streichen bestätigen (confirm):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('20', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('20', 'cancel', '1', '12', 'Abbrechen') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('20', 'extend', '1', '12', 'Erweitern') ;
--	Frist streichen bestätigen mit Kommentar (confirmX):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('21', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('21', 'cancel', '1', '12', 'Abbrechen') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('21', 'extend', '1', '12', 'Erweitern') ;
--	Frist streichen bestätigen mit Kommentar und Fortsetzung (confirmPX):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('22', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('22', 'cancel', '1', '12', 'Abbrechen') ;
--	Kommentar erstellen (addcomment):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('23', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('23', 'cancel', '1', '12', 'Abbrechen') ;
--	WV erstellen (addnotification):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('26', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('26', 'cancel', '1', '12', 'Abbrechen') ;
--	Fristtyp erstellen (addtype):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('27', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('27', 'cancel', '1', '12', 'Abbrechen') ;
--	Fristtyp zum Bearbeiten anzeigen (modtypeshow):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('28', 'go', '1', '13', 'Anzeigen') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('28', 'cancel', '1', '12', 'Abbrechen') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('29', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('29', 'cancel', '1', '12', 'Abbrechen') ;
--	Benutzer zum Löschen anzeigen (delusershow):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('30', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('30', 'cancel', '1', '12', 'Abbrechen') ;
--	Benutzerkennung löschen (deluser):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('31', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('31', 'cancel', '1', '12', 'Abbrechen') ;
--	Benutzerkennung löschen mit Neuzuweisung (deluserX):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('32', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('32', 'cancel', '1', '12', 'Abbrechen') ;
--	Bearbeiterkürzel zum Bearbeiten anzeigen (modasdshow):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('33', 'go', '1', '13', 'Anzeigen') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('33', 'cancel', '1', '12', 'Abbrechen') ;
--	Bearbeiterkürzel bearbeiten (modasd):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('34', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('34', 'cancel', '1', '12', 'Abbrechen') ;
--	Fristtyp bearbeiten (modtype):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('35', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('35', 'cancel', '1', '12', 'Abbrechen') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen (addformtypeshow):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('36', 'go', '1', '13', 'Anzeigen') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('36', 'cancel', '1', '12', 'Abbrechen') ;
--	Fristtyp-Formular-Zuordnung erstellen (addformtype):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('37', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('37', 'cancel', '1', '12', 'Abbrechen') ;
--	Fristtyp-Formular-Zuordnung zum Löschen anzeigen (delformtypeshow):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('38', 'go', '1', '13', 'Anzeigen') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('38', 'cancel', '1', '12', 'Abbrechen') ;
--	Fristtyp-Formular-Zuordnung löschen (delformtype):
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('39', 'go', '1', '13', 'Ausf' + CHAR(252) + 'hren') ;
INSERT INTO inputsubmit (inputform,name,type,style,defval) VALUES ('39', 'cancel', '1', '12', 'Abbrechen') ;
--
PRINT N'Tabelle ''inputsubmit'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE inputtext (
          	inputform 		INT NOT NULL REFERENCES inputform (id),
          	name			VARCHAR (50) NOT NULL,
          	len			INT DEFAULT 20 NOT NULL,
          	maxlen		INT DEFAULT 20 NOT NULL,
          	type			INT NOT NULL,
          	style 			INT NOT NULL REFERENCES style (id),
          	defval		VARCHAR (255) NOT NULL,
		CHECK (len > 0 AND NOT maxlen < len),
		CHECK (type IN ('1','2','3','4')),
		CONSTRAINT inputtext_pk PRIMARY KEY (inputform, name)
	) ;
GO
--	Benutzerkennung erstellen (adduser):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'adm', '8', '8', '2', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'label1', '20', '20', '4', '41', '129') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'label2', '20', '20', '4', '2', '130') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'label3', '20', '20', '4', '2', '69') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'label4', '20', '20', '4', '2', '132') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'label5', '20', '20', '4', '42', '133') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'label6', '20', '20', '4', '2', '54') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'lgn', '4', '4', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'nme', '20', '50', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'psa', '8', '8', '2', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('1', 'psb', '8', '8', '2', '2', '136') ;
--	SQL ausführen (sql):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('3', 'label1', '20', '20', '4', '2', '86') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('3', 'label2', '20', '20', '4', '2', '85') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('3', 'label3', '20', '20', '4', '2', '136') ;
--	Falls das Adminkennwort gelesen werden soll:
--	INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('3', 'label4', '8', '8', '4', '42', '133') ;
--	INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('3', 'adm', '8', '8', '2', '2', '136') ;
--	Workload anzeigen (workload):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('4', 'label1', '20', '20', '4', '2', '188') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('4', 'label2', '20', '20', '4', '2', '189') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('4', 'label3', '20', '20', '4', '2', '52') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('4', 'label4', '20', '20', '4', '2', '190') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('4', 'label5', '20', '20', '4', '2', '168') ;
--	Frist erstellen (inserta):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('5', 'fil', '5', '5', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('5', 'label1', '20', '20', '4', '42', '47') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen' Text 49 -> 284; 50->285
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('5', 'label2', '20', '20', '4', '2', '284') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('5', 'label3', '20', '20', '4', '2', '285') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('5', 'label4', '20', '20', '4', '2', '51') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('5', 'label5', '20', '20', '4', '2', '52') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('5', 'label6', '20', '20', '4', '2', '53') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('5', 'label7', '20', '20', '4', '2', '54') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('5', 'sub', '15', '15', '1', '2', '136') ;
--	Frist mit einer Wiedervorlage ertsellen (insertb):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('6', 'fil', '5', '5', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('6', 'label1', '20', '20', '4', '42', '47') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('6', 'label2', '20', '20', '4', '41', '76') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen' Text 49 -> 284; 50->285
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('6', 'label3', '20', '20', '4', '2', '284') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('6', 'label4', '20', '20', '4', '2', '285') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('6', 'label5', '20', '20', '4', '2', '51') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('6', 'label6', '20', '20', '4', '2', '52') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('6', 'label7', '20', '20', '4', '2', '53') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('6', 'label8', '20', '20', '4', '2', '54') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('6', 'sub', '15', '15', '1', '2', '136') ;
--	Frist mit zwei Wiedervorlagen erstellen (insertc):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'fil', '5', '5', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'label1', '20', '20', '4', '42', '47') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'label2', '20', '20', '4', '41', '76') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'label3', '20', '20', '4', '41', '76') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen' Text 49 -> 284; 50->285
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'label4', '20', '20', '4', '2', '284') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'label5', '20', '20', '4', '2', '285') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'label6', '20', '20', '4', '2', '51') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'label7', '20', '20', '4', '2', '52') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'label8', '20', '20', '4', '2', '53') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'label9', '20', '20', '4', '2', '54') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('7', 'sub', '15', '15', '1', '2', '136') ;
--	Frist mit drei Wiedervorlagen erstellen (insertd):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'sub', '15', '15', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'fil', '5', '5', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'label1', '20', '20', '4', '42', '47') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'label2', '20', '20', '4', '41', '76') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'label3', '20', '20', '4', '41', '76') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'label4', '20', '20', '4', '41', '76') ;
--	Zusammenlegung der Zeilen 'Akte' und 'Amtl. Zeichen' Text 49 -> 284; 50->285
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'label5', '20', '20', '4', '2', '284') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'label6', '20', '20', '4', '2', '285') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'label7', '20', '20', '4', '2', '51') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'label8', '20', '20', '4', '2', '52') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'label9', '20', '20', '4', '2', '53') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('25', 'label10', '20', '20', '4', '2', '54') ;
--	Frist intern erstellen (inserti):
--	Das Aktenzeichen ist ein verstecktes Feld mit dem Wert '0'
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('8', 'label1', '20', '20', '4', '43', '47') ;
--	INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('8', 'label2', '20', '20', '4', '2', '49') ;
--	INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('8', 'fil', '5', '5', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('8', 'label3', '20', '20', '4', '2', '50') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('8', 'sub', '15', '15', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('8', 'label4', '20', '20', '4', '2', '51') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('8', 'label5', '20', '20', '4', '2', '52') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('8', 'label6', '20', '20', '4', '2', '53') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('8', 'label7', '20', '20', '4', '2', '54') ;
--	Benutzereinstellungen anzeigen (modusershow):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('12', 'label1', '20', '20', '4', '41', '129') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('12', 'label3', '20', '20', '4', '2', '198') ;
--	Benutzereinstellungen ändern (moduser):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('13', 'adm', '8', '8', '2', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('13', 'label1', '20', '20', '4', '41', '196') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('13', 'label2', '20', '20', '4', '2', '199') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('13', 'label3', '20', '20', '4', '2', '200') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('13', 'label4', '20', '20', '4', '2', '201') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('13', 'label5', '20', '20', '4', '2', '202') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('13', 'label6', '20', '20', '4', '42', '133') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('13', 'label7', '20', '20', '4', '2', '203') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('13', 'nme', '30', '50', '4', '44', '197') ;
--	Login (login):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('14', 'passwd', '7', '10', '2', '51', '136') ;
--	Navigator (navigator):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('17', 'token', '12', '30', '1', '51', '136') ;
--	Persönliches Kennwort ändern (changepassword):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('19', 'label1', '20', '20', '4', '41', '196') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('19', 'label2', '20', '20', '4', '2', '193') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('19', 'label3', '20', '20', '4', '2', '194') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('19', 'label4', '20', '20', '4', '2', '195') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('19', 'label5', '20', '20', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('19', 'nme', '30', '50', '4', '44', '197') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('19', 'psa', '8', '8', '2', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('19', 'psb', '8', '8', '2', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('19', 'pso', '8', '8', '2', '2', '136') ;
--	Frist streichen bestätigen (confirm):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('20', 'label1', '20', '20', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('20', 'label2', '20', '20', '4', '2', '136') ;
--	Frist streichen bestätigen mit Kommentar (confirmX):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('21', 'label1', '20', '20', '4', '2', '53') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('21', 'label2', '20', '20', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('21', 'label3', '20', '20', '4', '2', '136') ;
--	Frist streichen bestätigen mit Kommentar und Fortsetzung (confirmPX):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('22', 'label1', '20', '20', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('22', 'label2', '20', '20', '4', '2', '221') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('22', 'label3', '20', '20', '4', '2', '53') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('22', 'label4', '20', '20', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('22', 'off', '2', '2', '1', '2', '136') ;
--	Kommentar erstellen (addcomment):
--	1. Zeile:	Detail
--	2. Zeile:	Kommentar
--	3. Zeile:	Knöpfe
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('23', 'label1', '20', '20', '4', '2', '220') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('23', 'label2', '20', '20', '4', '2', '53') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('23', 'label3', '20', '20', '4', '2', '136') ;
--	WV erstellen (addnotification):
--	1. Zeile: 	Detail
--	2. Zeile:	Datumeingabe
--	3. Zeile:	Kommentar
--	4. Zeile:	Knöpfe
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('26', 'label1', '20', '20', '4', '2', '220') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('26', 'label2', '20', '20', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('26', 'label3', '20', '20', '4', '2', '53') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('26', 'label4', '20', '20', '4', '2', '136') ;
--	Fristtyp erstellen (addtype):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'label1', '20', '20', '4', '2', '255') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'mini', '6', '6', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'label2', '20', '20', '4', '2', '256') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'long', '15', '15', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'label3', '20', '20', '4', '2', '266') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'maxn', '2', '4', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'label4', '20', '20', '4', '2', '267') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'maxc', '2', '4', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'rank', '2', '4', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'label5', '20', '20', '4', '2', '278') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'label6', '20', '20', '4', '2', '257') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'label7', '20', '20', '4', '2', '268') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'label8', '20', '20', '4', '2', '269') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'label9', '20', '20', '4', '2', '296') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('27', 'label10', '20', '20', '4', '2', '54') ;
--	Fristtyp zum Bearbeiten anzeigen (modtypeshow):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('28', 'label1', '20', '20', '4', '2', '281') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('28', 'label2', '20', '20', '4', '2', '198') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('29', 'label1', '20', '20', '4', '41', '68') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('29', 'label2', '20', '20', '4', '2', '256') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('29', 'long', '15', '15', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('29', 'label3', '20', '20', '4', '2', '269') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('29', 'label4', '20', '20', '4', '2', '296') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('29', 'label5', '20', '20', '4', '2', '54') ;
--	Benutzer zum Löschen anzeigen (delusershow):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('30', 'label1', '20', '20', '4', '41', '129') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('30', 'label3', '20', '20', '4', '2', '205') ;
--	Benutzerkennung löschen (deluser):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('31', 'label0', '20', '20', '4', '41', '196') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('31', 'nme', '30', '50', '4', '44', '197') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('31', 'label1', '20', '20', '4', '42', '133') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('31', 'adm', '8', '8', '2', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('31', 'label2', '20', '20', '4', '2', '205') ;
--	Benutzerkennung löschen mit Neuzuweisung (deluserX):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('32', 'label0', '20', '20', '4', '41', '196') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('32', 'nme', '30', '50', '4', '44', '197') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('32', 'label1', '20', '20', '4', '42', '133') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('32', 'adm', '8', '8', '2', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('32', 'label2', '20', '20', '4', '2', '287') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('32', 'label3', '20', '20', '4', '2', '205') ;
--	Bearbeiterkürzel zum Bearbeiten anzeigen (modasdshow):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('33', 'label1', '20', '20', '4', '41', '292') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('33', 'label2', '20', '20', '4', '2', '198') ;
--	Bearbeiterkürzel bearbeiten (modasd):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('34', 'label1', '20', '20', '4', '41', '292') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('34', 'long', '15', '15', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('34', 'label2', '20', '20', '4', '2', '293') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('34', 'label3', '20', '20', '4', '2', '294') ;
--	Fristtyp erstellen (addtype):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'label1', '20', '20', '4', '2', '255') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'mini', '6', '6', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'label2', '20', '20', '4', '2', '256') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'long', '15', '15', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'label3', '20', '20', '4', '2', '266') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'maxn', '2', '4', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'label4', '20', '20', '4', '2', '267') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'maxc', '2', '4', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'rank', '2', '4', '1', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'label5', '20', '20', '4', '2', '278') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'label6', '20', '20', '4', '2', '257') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'label7', '20', '20', '4', '2', '268') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'label8', '20', '20', '4', '2', '269') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('35', 'label9', '20', '20', '4', '2', '54') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen (addfromtypeshow):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('36', 'label1', '20', '20', '4', '41', '299') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('36', 'label2', '20', '20', '4', '2', '301') ;
--	Fristtyp-Formular-Zuordnung erstellen (addfromtype):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('37', 'label1', '20', '20', '4', '41', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('37', 'form', '15', '15', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('37', 'label2', '20', '20', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('37', 'label3', '20', '20', '4', '2', '136') ;
--	Fristtyp-Formular-Zuordnung zum Löschen anzeigen (delfromtypeshow):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('38', 'label1', '20', '20', '4', '41', '299') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('38', 'label2', '20', '20', '4', '2', '300') ;
--	Fristtyp-Formular-Zuordnung löschen (delfromtype):
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('39', 'label1', '20', '20', '4', '41', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('39', 'form', '15', '15', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('39', 'label2', '20', '20', '4', '2', '136') ;
INSERT INTO inputtext (inputform,name,len,maxlen,type,style,defval) VALUES ('39', 'label3', '20', '20', '4', '2', '136') ;
--
PRINT N'Tabelle ''inputtext'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE pagelayoutbase (
          	id 			INT,
          	description		VARCHAR (255) NOT NULL,
          	name			VARCHAR (50) NOT NULL,
          	setting 		INT NOT NULL,
          	bgcolor 		INT NOT NULL,
          	bgimage		INT NOT NULL,
          	link 			INT NOT NULL,
          	vlink 			INT NOT NULL,
          	topMargin		INT NOT NULL,
          	leftMargin		INT NOT NULL,
          	title 			INT NOT NULL,
          	meta			VARCHAR (255) NOT NULL,
		CHECK (NOT topmargin < 0 AND NOT leftmargin < 0),
		CONSTRAINT pagelayoutbase_pk PRIMARY KEY (id),
		CONSTRAINT pagelayoutbase_c1 UNIQUE (name, setting),
		CONSTRAINT pagelayoutbase_c2 FOREIGN KEY (setting) REFERENCES setting (id),
		CONSTRAINT pagelayoutbase_c3 FOREIGN KEY (bgcolor) REFERENCES color (id),
		CONSTRAINT pagelayoutbase_c4 FOREIGN KEY (bgimage) REFERENCES image (id),
		CONSTRAINT pagelayoutbase_c5 FOREIGN KEY (link) REFERENCES color (id),
		CONSTRAINT pagelayoutbase_c6 FOREIGN KEY (vlink) REFERENCES color (id),
		CONSTRAINT pagelayoutbase_c7 FOREIGN KEY (title) REFERENCES stringlocal (id)
	) ;
GO
--
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('1', 'Standard (Fun)', 'default', '1', '5', '88', '1', '1', '4', '10', '28', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('2',  CHAR(220) + 'bersicht (Fun)', 'overview', '1', '5', '88', '1', '1', '4', '10', '3', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('3', 'Titel (Fun)', 'caption', '1', '2', '88', '1', '1', '2', '8', '28', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('4', 'Login (Fun)', 'login', '1', '7', '88', '1', '1', '6', '5', '30', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('5', 'Navigator (Fun)', 'navigator', '1', '8', '88', '1', '1', '4', '5', '31', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('6', 'Menue (Fun)', 'menue', '1', '5', '88', '1', '1', '4', '10', '44', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('8', 'Navigator (Pro)', 'navigator', '2', '53', '73', '1', '1', '4', '4', '31', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('9', 'Login (Pro)', 'login', '2', '54', '74', '1', '1', '2', '4', '30', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('10', 'Standard (Pro)', 'default', '2', '53', '72', '1', '1', '4', '10', '28', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('11', 'Menue (Pro)', 'menue', '2', '53', '72', '1', '1', '4', '10', '100', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('12', 'Titel (Pro)', 'caption', '2', '52', '71', '1', '1', '6', '10', '28', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('13',  CHAR(220) + 'bersicht (Pro)', 'overview', '2', '53', '72', '1', '1', '4', '10', '28', '') ;
--	2004-05-02: Eingefügt	/B
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('14', 'Detail (Fun)', 'detail', '1',  '5', '88', '1', '1', '4', '10', '28', '') ;
INSERT INTO pagelayoutbase (id,description,name,setting,bgcolor,bgimage,link,vlink,topMargin,leftMargin,title,meta) VALUES ('15', 'Detail (Pro)', 'detail', '2', '53', '72', '1', '1', '4', '10', '28', '') ;
--
PRINT N'Tabelle ''pagelayoutbase'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE pagelayoutbasecolor (
        	layout		INT NOT NULL,
          	color			INT DEFAULT 1 NOT NULL,
          	name			VARCHAR (50) NOT NULL,
		CONSTRAINT pagelayoutbasecolor_pk PRIMARY KEY (layout, color),
		CONSTRAINT pagelayoutbasecolor_c1 UNIQUE (layout, name),
		CONSTRAINT pagelayoutbasecolor_c2 FOREIGN KEY (layout)  REFERENCES pagelayoutbase (id),
		CONSTRAINT pagelayoutbasecolor_c3 FOREIGN KEY (color)  REFERENCES color (id)
	) ;
GO

--
--	Layout: Übersicht (Fun)
--
INSERT INTO pagelayoutbasecolor (layout,color,name) VALUES ('2', '6', 'highlight') ;
--
--	Layout: Übersicht (Pro)
--
INSERT INTO pagelayoutbasecolor (layout,color,name) VALUES ('13', '6', 'highlight') ;
--
PRINT N'Tabelle ''pagelayoutbasecolor'' erstellt und gef' + CHAR(252) + 'llt.'
--
--	2004-04-23	/B
GO
--
	CREATE TABLE pagelayoutbaselstring (
        	layout		INT NOT NULL,
          	string			INT DEFAULT 136 NOT NULL,
          	locale		INT DEFAULT 1 NOT NULL,
		name			VARCHAR (50) NOT NULL,
		CONSTRAINT pagelayoutbaselstring_pk PRIMARY KEY (layout, string, locale),
		CONSTRAINT pagelayoutbaselstring_c1 UNIQUE (layout, locale, name),
		CONSTRAINT pagelayoutbaselstring_c2 FOREIGN KEY (string)  REFERENCES stringlocal (id),
		CONSTRAINT pagelayoutbaselstring_c3 FOREIGN KEY (locale)  REFERENCES locale (id)
	) ;
GO 
--
--	Den leeren String bei allen unter dem Namen 'leer' einhängen
INSERT INTO pagelayoutbaselstring (layout, locale, name) SELECT p.id, l.id, 'leer' FROM pagelayoutbase AS p, locale AS l ;
GO
--
--
	CREATE TABLE pagelayoutbasestyle (
          	id 			INT IDENTITY (1,1),
          	layout 		INT NOT NULL,
          	style 			INT NOT NULL,
          	name			VARCHAR (50) NOT NULL,
		CONSTRAINT pagelayoutbasestyle_pk PRIMARY KEY (id),
		CONSTRAINT pagelayoutbasestyle_c1 UNIQUE (layout, name),
		CONSTRAINT pagelayoutbasestyle_c2 FOREIGN KEY (layout) REFERENCES pagelayoutbase (id),
		CONSTRAINT pagelayoutbasestyle_c3 FOREIGN KEY (style) REFERENCES style (id)
	) ;
GO
--
--	Layout: Standard (Fun)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('1', '1', '.head') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('1', '2', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('1', '2', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('1', '2', '.ecomment') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('1', '2', '.edescription') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('1', '12', '.button') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('1', '35', '.caption') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('1', '45', '.etimestamp') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('1', '46', '.ndate') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('1', '53', '.detail') ;
--
--	Layout: Übersicht (Fun)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('2', '1', '.date') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('2', '5', '.head') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('2', '12', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('2', '12', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('2', '13', '.typ01') ;
--
--	Layout: Titel (Fun)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('3', '8', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('3', '8', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('3', '8', '.caption') ;
--
--	Layout: Login (Fun)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('4', '9', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('4', '9', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('4', '9', '.user') ;
--	
--	Layout: Navigator (Fun)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('5', '12', '.input') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('5', '33', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('5', '33', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('5', '34', '.note') ;
--
--	Layout: Menü (Fun)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('6', '1', '.head') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('6', '5', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('6', '5', 'table') ;
--
--	Layout: Navigator (Pro)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('8', '12', '.input') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('8', '13', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('8', '13', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('8', '34', '.note') ;
--
--	Layout: Login (Pro)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('9', '19', '.user') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('9', '21', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('9', '21', 'table') ;
--
--	Layout: Standard (Pro)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('10', '2', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('10', '2', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('10', '2', '.edescription') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('10', '2', '.ecomment') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('10', '12', '.button') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('10', '22', '.head') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('10', '35', '.caption') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('10', '45', '.etimestamp') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('10', '46', '.ndate') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('10', '53', '.detail') ;
--
--	Layout: Menü (Pro)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('11', '5', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('11', '5', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('11', '22', '.head') ;
--
--	Layout: Titel (Pro)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('12', '28', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('12', '28', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('12', '28', '.caption') ;
--
--	Layout: Übersicht (Pro)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('13', '12', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('13', '12', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('13', '13', '.typ01') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('13', '22', '.date') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('13', '30', '.head') ;
--
--	Layout: Detail (Fun)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('14',  '1', '.head') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('14',  '2', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('14',  '2', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('14',  '2', '.ecomment') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('14',  '2', '.edescription') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('14', '45', '.etimestamp') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('14', '46', '.ndate') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('14', '53', '.detail') ;
--
--	Layout: Detail (Pro)
--
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('15',  '2', 'body') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('15',  '2', 'table') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('15',  '2', '.edescription') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('15',  '2', '.ecomment') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('15', '22', '.head') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('15', '45', '.etimestamp') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('15', '46', '.ndate') ;
INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES ('15', '53', '.detail') ;
--
PRINT N'Tabelle ''pagelayoutbasestyle'' erstellt und gef' + CHAR(252) + 'llt.'
GO

--
	CREATE TABLE pagelayoutbaseicon (
          	layout 		INT NOT NULL,
          	image 		INT NOT NULL,
          	name			VARCHAR (255) NOT NULL,
          	info			INT NOT NULL,
		CONSTRAINT pagelayoutbaseicon_pk PRIMARY KEY (layout, name),
		CONSTRAINT pagelayoutbaseicon_c1 FOREIGN KEY (layout)  REFERENCES pagelayoutbase (id),
		CONSTRAINT pagelayoutbaseicon_c2 FOREIGN KEY (image) REFERENCES image (id),
		CONSTRAINT pagelayoutbaseicon_c3 FOREIGN KEY (info) REFERENCES stringlocal (id)
	) ;
GO
--
--	Layout: Default (A):
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '21', 'cond.ok', '115') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '30', 'detail.cross', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '59', 'cond.fail', '116') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '60', 'detail.comm', '92') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '60', 'eventlog.newc', '160') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '61', 'eventlog.newd', '158') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '62', 'detail.noti', '91') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '62', 'eventlog.newn', '161') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '63', 'eventlog.void', '157') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '64', 'eventlog.deld', '159') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '65', 'eventlog.deln', '162') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '115', 'detail.blank', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '117', 'list.done', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '118', 'list.hit', '144') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '119', 'list.hitdone', '144') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '120', 'list.next', '64') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '121', 'list.prev', '65') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '122', 'detail.triangle', '118') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '123', 'detail.back', '174') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '125', 'detail.exit', '174') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '126', 'database', '136') ;
--	2004-04-23	/B
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('1', '127', 'detail.file', '133') ;
--
--	Layout: Übersicht (Fun)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('2', '20', 'att', '113') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('2', '129', 'att0', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('2', '21', 'att1', '113') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('2', '23', 'next', '79') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('2', '24', 'prev', '77') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('2', '25', 'today', '97') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('2', '35', 'delete', '137') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('2', '51', 'prevatt', '123') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('2', '114', 'blank', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('2', '124', 'delatt', '137') ;
--
--	Layout: Titel (Fun)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '1', 'insert', '98') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '3', 'detail', '4') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '4', 'error', '12') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '5', 'service', '7') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '6', 'search', '6') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '7', 'help', '9') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '8', 'logout', '11') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '9', 'overview', '3') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '12', 'delete', '8') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '16', 'empty', '2') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '57', 'events', '143') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('3', '68', 'flushed', '117') ;
--
--	Login (A):
--
--	?
--
--	Layout: Navigator (Fun)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('5', '15', 'submit', '72') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('5', '106', 'insert', '98') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('5', '107', 'overview', '97') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('5', '109', 'service', '99') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('5', '111', 'user', '127') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('5', '113', 'help', '119') ;
--
--	Layout: Menue (Fun)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('6', '19', 'hit', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('6', '130', 'pdf', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('6', '30', 'cross', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('6', '31', 'triangle', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('6', '52', 'insert.icon___d', '140') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('6', '53', 'insert.icon__nd', '139') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('6', '54', 'insert.icon_nnd', '141') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('6', '55', 'insert.iconnxnd', '142') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('6', '56', 'insert.icon___i', '138') ;
--
--	Layout: Navigator (Pro)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('8', '70', 'overview', '97') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('8', '75', 'insert', '98') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('8', '85', 'service', '99') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('8', '200', 'help', '119') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('8', '89', 'submit', '72') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('8', '95', 'user', '127') ;
--
--	Layout: Login (Pro)
--
--	?
--
--	Layout: Standard (Pro)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '21', 'cond.ok', '115') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '26', 'list.prev', '65') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '27', 'list.next', '64') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '30', 'detail.cross', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '59', 'cond.fail', '116') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '60', 'detail.comm', '92') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '60', 'eventlog.newc', '160') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '61', 'eventlog.newd', '158') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '62', 'detail.noti', '91') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '62', 'eventlog.newn', '161') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '63', 'eventlog.void', '157') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '64', 'eventlog.deld', '159') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '65', 'eventlog.deln', '159') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '115', 'detail.blank', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '116', 'list.hit', '144') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '117', 'list.done', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '117', 'list.hitdone', '144') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '122', 'detail.triangle', '118') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '123', 'detail.back', '174') ;
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '125', 'detail.exit', '174') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '126', 'database', '136') ;
--	2004-04-23
--INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('10', '127', 'detail.file', '133') ;
--
--	Layout: Menue (Pro)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('11', '19', 'hit', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('11', '130', 'pdf', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('11', '30', 'cross', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('11', '31', 'triangle', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('11', '52', 'insert.icon___d', '140') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('11', '53', 'insert.icon__nd', '139') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('11', '54', 'insert.icon_nnd', '141') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('11', '55', 'insert.iconnxnd', '142') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('11', '56', 'insert.icon___i', '138') ;
--
--	Layout: Titel (Pro)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '69', 'overview', '3') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '76', 'insert', '98') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '84', 'service', '7') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '201', 'help', '9') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '94', 'empty', '2') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '96', 'detail', '4') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '98', 'logout', '11') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '100', 'error', '12') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '101', 'search', '6') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '102', 'delete', '8') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '103', 'events', '143') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('12', '105', 'flushed', '117') ;
--
--	Layout: Übersicht (Pro)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('13', '78', 'prevatt', '123') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('13', '79', 'today', '97') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('13', '80', 'next', '79') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('13', '93', 'delete', '137') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('13', '110', 'prev', '77') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('13', '124', 'delatt', '137') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('13', '20', 'att', '113') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('13', '129', 'att0', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('13', '21', 'att1', '136') ;
--
--	Layout: Detail (Fun)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14',  '60', 'detail.comm', '92') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14',  '60', 'eventlog.newc', '160') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14',  '61', 'eventlog.newd', '158') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14',  '62', 'detail.noti', '91') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14',  '62', 'eventlog.newn', '161') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14',  '63', 'eventlog.void', '157') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14',  '64', 'eventlog.deld', '159') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14',  '65', 'eventlog.deln', '162') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14', '115', 'detail.blank', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14', '122', 'detail.triangle', '118') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14', '123', 'detail.back', '174') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14', '125', 'detail.exit', '174') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('14', '127', 'detail.file', '133') ;
--
--	Layout: Detail (Pro)
--
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15',  '60', 'detail.comm', '92') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15',  '60', 'eventlog.newc', '160') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15',  '61', 'eventlog.newd', '158') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15',  '62', 'detail.noti', '91') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15',  '62', 'eventlog.newn', '161') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15',  '63', 'eventlog.void', '157') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15',  '64', 'eventlog.deld', '159') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15',  '65', 'eventlog.deln', '162') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15', '115', 'detail.blank', '136') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15', '122', 'detail.triangle', '118') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15', '123', 'detail.back', '174') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15', '125', 'detail.exit', '174') ;
INSERT INTO pagelayoutbaseicon (layout,image,name,info) VALUES ('15', '127', 'detail.file', '133') ;
--
--
PRINT N'Tabelle ''pagelayoutbaseicon'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE pagelayoutbody (
          	id 			INT NOT NULL,
          	description		VARCHAR (255) NOT NULL,
          	name			VARCHAR (50) NOT NULL,
          	base 			INT NOT NULL,
          	linecolor 		INT NOT NULL,
          	boxcolor 		INT NOT NULL,
          	width			INT NOT NULL,
          	height		INT NOT NULL,
          	padding		INT NOT NULL,
          	borderwidth	INT NOT NULL,
          	captionwidth	INT NOT NULL,
          	headheight		INT NOT NULL,
		CHECK (NOT width < 0 AND NOT height < 0 AND NOT padding < 0 AND NOT borderwidth < 0 AND NOT captionwidth < 0 AND NOT headheight < 0),
		CONSTRAINT pagelayoutbody_pk PRIMARY KEY (id),
		CONSTRAINT pagelayoutbody_c1 UNIQUE (name, base),
		CONSTRAINT pagelayoutbody_c2 FOREIGN KEY (base) REFERENCES pagelayoutbase (id),
		CONSTRAINT pagelayoutbody_c3 FOREIGN KEY (linecolor) REFERENCES color (id),
		CONSTRAINT pagelayoutbody_c4 FOREIGN KEY (boxcolor) REFERENCES color (id)
	) ;
GO
--	Layout: Standard (Fun)
INSERT INTO pagelayoutbody (id,description,name,base,linecolor,boxcolor,width,height,padding,borderwidth,captionwidth,headheight) VALUES ('1', 'Standard (Fun)',  'default', '1',  '3', '4', '790', '60', '10', '1', '70', '60') ;
--	Layout: Detail (Fun)
INSERT INTO pagelayoutbody (id,description,name,base,linecolor,boxcolor,width,height,padding,borderwidth,captionwidth,headheight) VALUES ('2', 'Detail (Fun)',     'detail',  '14',  '3', '4', '790', '60', '10', '1', '70', '60') ;
--	Layout: Menü (Fun)
INSERT INTO pagelayoutbody (id,description,name,base,linecolor,boxcolor,width,height,padding,borderwidth,captionwidth,headheight) VALUES ('3', 'Menue (Fun)',      'menue',      '6',  '3', '4', '790', '60', '10', '1', '70', '60') ;
--	Layout: Standard (Pro)
INSERT INTO pagelayoutbody (id,description,name,base,linecolor,boxcolor,width,height,padding,borderwidth,captionwidth,headheight) VALUES ('4', 'Standard (Pro)', 'default', '10', '54', '4', '790', '60', '10', '1', '70', '60') ;
--	Layout: Detail (Pro)
INSERT INTO pagelayoutbody (id,description,name,base,linecolor,boxcolor,width,height,padding,borderwidth,captionwidth,headheight) VALUES ('5', 'Detail (Pro)',    'detail',   '15', '54', '4', '790', '60', '10', '1', '70', '60') ;
--	Layout: Menü (Pro)
INSERT INTO pagelayoutbody (id,description,name,base,linecolor,boxcolor,width,height,padding,borderwidth,captionwidth,headheight) VALUES ('6', 'Menue (Pro)',      'menue',    '11', '54', '4', '790', '60', '10', '1', '70', '60') ;
--
PRINT N'Tabelle ''pagelayoutbody'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE pagelayoutcaption (
          	id 			INT NOT NULL,
          	base 			INT NOT NULL,
          	height		INT NOT NULL,
          	wspacea		INT NOT NULL,
          	wicon		INT NOT NULL,
          	wspaceb		INT NOT NULL,
          	wcaption		INT NOT NULL,
          	wborder		INT NOT NULL,
          	name			VARCHAR (50) NOT NULL,
		CHECK (NOT height < 0 AND NOT wspacea < 0 AND NOT wicon < 0 AND NOT wspaceb < 0 AND NOT wcaption < 0 AND NOT wborder < 0),
		CONSTRAINT pagelayoutcaption_pk PRIMARY KEY (id),
		CONSTRAINT pagelayoutcaption_c1 UNIQUE (base,name),
		CONSTRAINT pagelayoutcaption_c2 FOREIGN KEY (base) REFERENCES pagelayoutbase (id)
	) ;
GO
--
--	Layout: Überschrift (Fun)
--
INSERT INTO pagelayoutcaption (id,base,height,wspacea,wicon,wspaceb,wcaption,wborder,name) VALUES ('1', '3', '100', '10', '59', '27', '700', '0', 'default') ;
--
--	Layout: Überschrift (Pro)
--
INSERT INTO pagelayoutcaption (id,base,height,wspacea,wicon,wspaceb,wcaption,wborder,name) VALUES ('2', '12', '80', '40', '59', '27', '576', '0', 'default') ;
--
PRINT N'Tabelle ''pagelayoutcaption'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE pagelayoutformbase (
          	id 		INT NOT NULL,
          	baselayout 	INT NOT NULL,
          	inputform 	INT NOT NULL,
		CONSTRAINT pagelayoutformbase_pk  PRIMARY KEY (id),
		CONSTRAINT pagelayoutformbase_c1 UNIQUE (baselayout, inputform),
		CONSTRAINT pagelayoutformbase_c2 FOREIGN KEY (baselayout) REFERENCES pagelayoutbase (id),
		CONSTRAINT pagelayoutformbase_c3 FOREIGN KEY (inputform) REFERENCES inputform (id)
	) ;
GO
--
--	Layout: Standard (Fun)
--
INSERT INTO pagelayoutformbase (id,baselayout,inputform) VALUES ('7', '1', '3') ;
INSERT INTO pagelayoutformbase (id,baselayout,inputform) VALUES ('9', '4', '14') ;
INSERT INTO pagelayoutformbase (id,baselayout,inputform) VALUES ('10', '9', '14') ;
INSERT INTO pagelayoutformbase (id,baselayout,inputform) VALUES ('11', '4', '15') ;
INSERT INTO pagelayoutformbase (id,baselayout,inputform) VALUES ('12', '9', '15') ;
INSERT INTO pagelayoutformbase (id,baselayout,inputform) VALUES ('13', '8', '17') ;
INSERT INTO pagelayoutformbase (id,baselayout,inputform) VALUES ('14', '5', '17') ;
--
--	Layout: Standard (Pro)
--
INSERT INTO pagelayoutformbase (id,baselayout,inputform) VALUES ('15', '10', '3') ;
--
PRINT N'Tabelle ''pagelayoutformbase'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE pagelayoutframe (
          	id 			INT NOT NULL,
          	name			VARCHAR (50) NOT NULL,
          	setting 		INT NOT NULL,
          	nrows		INT NOT NULL,
          	ncols			INT NOT NULL,
          	border		INT NOT NULL,
          	margin		INT NOT NULL,
          	base			INT NOT NULL,
          	message 		INT NOT NULL,
		CHECK (NOT nrows < 0 AND NOT ncols < 0 AND NOT border < 0 AND NOT margin < 0),
		CONSTRAINT pagelayoutframe_pk PRIMARY KEY (id),
		CONSTRAINT pagelayoutframe_c1 UNIQUE (name, setting),
		CONSTRAINT pagelayoutframe_c2 UNIQUE (setting, nrows, ncols, border, margin, base, message),
		CONSTRAINT pagelayoutframe_c3 FOREIGN KEY (setting)  REFERENCES setting (id),
		CONSTRAINT pagelayoutframe_c4 FOREIGN KEY (base) REFERENCES urlbase (id),
		CONSTRAINT pagelayoutframe_c5 FOREIGN KEY (message) REFERENCES stringlocal (id)
	) ;
GO
--
INSERT INTO pagelayoutframe (id,name,setting,nrows,ncols,border,margin,base,message) VALUES ('1', 'default', '1', '112', '112', '0', '4', '5', '1') ;
INSERT INTO pagelayoutframe (id,name,setting,nrows,ncols,border,margin,base,message) VALUES ('3', 'default', '2', '90', '112', '0', '4', '5', '1') ;
--
PRINT N'Tabelle ''pagelayoutframe'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE pagelayoutlist (
          	id 			INT NOT NULL,
          	base 			INT NOT NULL,
          	name			VARCHAR (50) NOT NULL,
          	border		INT DEFAULT 0 NOT NULL,
          	padding		INT DEFAULT 5 NOT NULL,
          	spacing		INT DEFAULT 5 NOT NULL,
          	leftrow		INT DEFAULT 35 NOT NULL,
         	height		INT DEFAULT 35 NOT NULL,
		CHECK (NOT border < 0 AND NOT padding < 0 AND NOT spacing < 0 AND NOT leftrow < 0 AND NOT height < 0),
		CONSTRAINT pagelayoutlist_pk PRIMARY KEY (id),
		CONSTRAINT pagelayoutlist_c1 UNIQUE (base,name),
		CONSTRAINT pagelayoutlist_c2 FOREIGN KEY (base) REFERENCES pagelayoutbody (id)
	) ;
GO
--	Einstellungen für die meisten Menülisten, Ausnahmen s.u.:
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ( '1', '3', 'menue', '0', '5', '5', '30', '35') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ( '2', '6', 'menue', '0', '5', '5', '30', '35') ;
--	Einstellungen für die Menüs, von denen aus die Formulare zum Erstellen der neuen Fristen aufgerufen werden:
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ( '3', '3', 'insert.mnu', '0', '5', '5', '30', '45') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ( '4', '6', 'insert.mnu', '0', '5', '5', '30', '45') ;
--
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ( '5', '1', 'list', '0', '1', '5', '24', '24') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ( '6', '4', 'list', '0', '1', '5', '24', '24') ;
--	Einstellungen für die Listen der Fehlerblätter:
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ( '7', '1', 'errorlist', '0', '5', '5', '30', '30') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ( '8', '4', 'errorlist', '0', '5', '5', '30', '30') ;
--	Einstellungen für die Liste der aktiven Verbindungen:
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ( '9', '1', 'connections', '0', '5', '5', '30', '30') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('10', '4', 'connections', '0', '5', '5', '30', '30') ;
--	Einstellungen für die Formulare zum Erstellen der Fristen:
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('11', '1', 'form', '0', '5', '10', '80', '30') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('12', '4', 'form', '0', '5', '10', '80', '30') ;
--
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('13', '1', 'workload', '0', '5', '10', '160', '30') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('14', '4', 'workload', '0', '5', '10', '160', '30') ;
--
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('15', '1', 'users', '0', '5', '10', '210', '30') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('16', '4', 'users', '0', '5', '10', '210', '30') ;
--
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('17', '1', 'users.show', '0', '5', '10', '240', '30') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('18', '4', 'users.show', '0', '5', '10', '240', '30') ;
--
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('19', '1', 'insert.frm', '0', '5', '5', '160', '30') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('20', '4', 'insert.frm', '0', '5', '5', '160', '30') ;
--
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('21', '1', 'addtype', '0', '5', '10', '200', '30') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('22', '4', 'addtype', '0', '5', '10', '200', '30') ;
--
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('23', '1', 'formtype', '0', '5', '10', '280', '30') ;
INSERT INTO pagelayoutlist (id,base,name,border,padding,spacing,leftrow,height) VALUES ('24', '4', 'formtype', '0', '5', '10', '280', '30') ;
--
PRINT N'Tabelle ''pagelayoutlist'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE pagelayoutformlist (
          	baselayout 		INT NOT NULL,
          	inputform 		INT NOT NULL,
		CONSTRAINT pagelayoutformlist_pk PRIMARY KEY (baselayout, inputform),
		CONSTRAINT pagelayoutformlist_c1 FOREIGN KEY (baselayout) REFERENCES pagelayoutlist (id),
		CONSTRAINT pagelayoutformlist_c2 FOREIGN KEY (inputform) REFERENCES inputform (id)
	) ;
GO
--
--	Benutzerkennung erstellen (adduser):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('15', '1') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('16', '1') ;
--	SQL ausführen (sql):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('11', '3') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('12', '3') ;
--	Workload anzeigen (workload):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('13', '4') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('14', '4') ;
--	Kennwort ändern (passwrd):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('15', '19') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('16', '19') ;
--	Benutzereinstellungen anzeigen (modusershow):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('17', '12') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('18', '12') ;
--	Benutzereinstellungen ändern (moduser):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('15', '13') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('16', '13') ;
--	Frist erstellen (inserta):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('19', '5') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('20', '5') ;
--	Frist mit einer WV erstellen (insertb):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('19', '6') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('20', '6') ;
--	Frist mit zwei WV erstellen (insertc):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('19', '7') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('20', '7') ;
--	Frist mit drei WV erstellen (insertd):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('19', '25') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('20', '25') ;
--	Interne Frist erstellen (inserti):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('19', '8') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('20', '8') ;
--	Frist/WV streichen bestätigen (confirm):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('11', '20') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('12', '20') ;
--	Frist/WV streichen bestätigen mit Kommentar (confirmX):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('11', '21') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('12', '21') ;
--	Frist/WV streichen bestätigen mit Kommentar und Fortsetzung (confirmPX):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('11', '22') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('12', '22') ;
--	Kommentar erstellen (addcomment):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('11', '23') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('12', '23') ;
--	WV erstellen (addnotification):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('11', '26') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('12', '26') ;
--	Fristtyp erstellen (addtype):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('21', '27') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('22', '27') ;
--	Fristtyp zum Bearbeiten anzeigen (modtypeshow):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('17', '28') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('18', '28') ;
--	Bearbeiterkürzel erstellen (addasd):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('21', '29') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('22', '29') ;
--	Benutzer zum Löschen anzeigen (delusershow):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('17', '30') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('18', '30') ;
--	Benutzerkennung löschen (deluser):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('17', '31') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('18', '31') ;
--	Benutzerkennung löschen mit Neuzuweisung (deluserX):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('17', '32') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('18', '32') ;
--	Bearbeiterkürzel zum Bearbeiten anzeigen (modasdshow):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('17', '33') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('18', '33') ;
--	Bearbeiterkürzelbearbeiten (modasd):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('17', '34') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('18', '34') ;
--	Fristtyp bearbeiten (modtype):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('21', '35') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('22', '35') ;
--	Fristtyp-Formular-Zuordnung zum Erstellen anzeigen (addformtypeshow):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('23', '36') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('24', '36') ;
--	Fristtyp-Formular-Zuordnung erstellen (addformtype):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('17', '37') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('18', '37') ;
--	Fristtyp-Formular-Zuordnung zum Löschen anzeigen (delformtypeshow):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('23', '38') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('24', '38') ;
--	Fristtyp-Formular-Zuordnung löschen (delformtype):
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('17', '39') ;
INSERT INTO pagelayoutformlist (baselayout,inputform) VALUES ('18', '39') ;
--
PRINT N'Tabelle ''pagelayoutformlist'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE framelayout (
          	frame 		INT NOT NULL,
          	layout 		INT NOT NULL,
          	setting		INT NOT NULL,
		CONSTRAINT framelayout_pk PRIMARY KEY (frame, layout, setting),
		CONSTRAINT framelayout_c1 FOREIGN KEY (frame) REFERENCES frameouter (id),
		CONSTRAINT framelayout_c2 FOREIGN KEY (layout) REFERENCES pagelayoutframe (id),
		CONSTRAINT framelayout_c3 FOREIGN KEY (setting) REFERENCES setting (id)
	) ;
GO
--	Schedule
INSERT INTO framelayout (frame,layout,setting) VALUES ('1', '1', '1') ;
INSERT INTO framelayout (frame,layout,setting) VALUES ('1', '3', '2') ;
--	Help
INSERT INTO framelayout (frame,layout,setting) VALUES ('2', '1', '1') ;
INSERT INTO framelayout (frame,layout,setting) VALUES ('2', '3', '2') ;
--	Notallowed
INSERT INTO framelayout (frame,layout,setting) VALUES ('3', '1', '1') ;
INSERT INTO framelayout (frame,layout,setting) VALUES ('3', '3', '2') ;
--
PRINT N'Tabelle ''framelayout'' erstellt und gef' + CHAR(252) + 'llt.'
GO


--
	CREATE TABLE menuelayout (
          	layout 		INT NOT NULL,
          	menue 		INT NOT NULL,
		CONSTRAINT menuelayout_pk PRIMARY KEY (layout, menue),
		CONSTRAINT menuelayout_c1 FOREIGN KEY (layout) REFERENCES pagelayoutlist (id),
		CONSTRAINT menuelayout_c2 FOREIGN KEY (menue) REFERENCES menue (id)
	) ;
GO
--
INSERT INTO menuelayout (layout,menue) VALUES ('3', '15') ;
INSERT INTO menuelayout (layout,menue) VALUES ('1', '10') ;
INSERT INTO menuelayout (layout,menue) VALUES ('1', '5') ;
INSERT INTO menuelayout (layout,menue) VALUES ('1', '1') ;
--
PRINT N'Tabelle ''menuelayout'' erstellt und gef' + CHAR(252) + 'llt.'
GO

--
--	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--
--	Prozeduren, die keine Trigger sind, ab hier:
--
--	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--
CREATE PROCEDURE addLayoutStyle (@lid INTEGER, @cid INTEGER, @font INTEGER = 1, @fsize INTEGER = 12, @line INTEGER = 16, @bold BIT = 0, @strike BIT = 0, @padding INTEGER = 0, @name VARCHAR (12) = 'detail') AS
	--
	--	Argumente sind:
	--		1.	Layoutnummer
	--		2.	Farbnummer
	--	
	--	2004-05-01: Erstellt	/B
	--
	DECLARE @sid INTEGER
	DECLARE @ret INTEGER
	DECLARE @snam VARCHAR (50)
	DECLARE @cnam VARCHAR (50)
	--
	SET @ret = 0 
	--
	IF EXISTS (SELECT c.id FROM color AS c WHERE c.id = @cid) AND EXISTS (SELECT l.id FROM pagelayoutbase AS l WHERE l.id = @lid)
		BEGIN
			--
			PRINT 'Bearbeite Farbe: ' + @cnam
			--
			IF EXISTS (SELECT s.id FROM style AS s 
				WHERE s.font = @font
				AND s.fsize = @fsize
				AND s.line = @line 
				AND s.bold = @bold 
				AND s.slanted = 0
				AND s.strike = @strike
				AND s.underline = 0 
				AND s.color = @cid 
				AND s.padding = @padding)
				BEGIN
					SELECT @sid = s.id FROM style AS s 
					WHERE s.font = @font
					AND s.fsize = @fsize
					AND s.line = @line 
					AND s.bold = @bold 
					AND s.slanted = 0
					AND s.strike = @strike
					AND s.underline = 0 
					AND s.color = @cid 
					AND s.padding = @padding 
				END
			ELSE
				BEGIN
					INSERT INTO style (font, fsize, line, bold, slanted, strike, underline, color, padding) VALUES (@font, @fsize, @line, @bold, '0', @strike, '0', @cid, @padding) 
					SET @sid = @@IDENTITY
				END
			--
			--	Der Name der Zuordnung wird durch Markierungen für 'bold' und 'strike' sowie die ID der Farbe ergänzt ...
			--
			SET @snam = '.' + @name + CAST (@bold AS VARCHAR(1)) + 'x' + CAST (@strike AS VARCHAR (1)) + 'x' + CAST (@cid AS VARCHAR (32))
			--
			PRINT 'Bearbeitet wird der Style zur id ''' + CAST (@sid AS VARCHAR(8)) + ''' und Name ''' + @snam + ''''
			--
			IF NOT EXISTS (SELECT x.id FROM pagelayoutbasestyle AS x WHERE x.layout = @lid AND x.style = @sid AND x.name = @snam)
				BEGIN
					INSERT INTO pagelayoutbasestyle (layout,style,name) VALUES (@lid, @sid, @snam) 
					SET @ret = @@ROWCOUNT
					PRINT 'Zuordnung für Layout ''' + CAST (@lid AS VARCHAR(8)) + ''', Style ''' + CAST (@sid AS VARCHAR(8)) + ''' und Name ''' + @snam + ''' erstellt.'
				END
			ELSE 
				PRINT 'Zuordnung für Layout ''' + CAST (@lid AS VARCHAR(8)) + ''', Style ''' + CAST (@sid AS VARCHAR(8)) + ''' und Name ''' + @snam + ''' besteht schon.'
			--
			--
		END
	--
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Gespeicherte Prozedur ''addLayoutStyle'' mit Fehler abgebrochen.'
			ROLLBACK
		END
	--
	RETURN @ret
GO
--
PRINT 'Prozedur ''addLayoutStyle'' erstellt.'
GO

CREATE PROCEDURE updateLayoutStyles (@cid INTEGER) AS 
	DECLARE layoutCursor CURSOR FOR SELECT p.id FROM pagelayoutbase AS p FOR READ ONLY
	--
	DECLARE @lid INTEGER
	DECLARE @ret INTEGER
	DECLARE @tmp INTEGER
	--
	SET @ret = 0
	--
	OPEN layoutCursor
	FETCH NEXT FROM layoutCursor INTO @lid
	--
	WHILE @@FETCH_STATUS = 0
		BEGIN
			--
			--	Die Styles in die Layouts 'Übersicht (Fun)' und 'Übersicht (Pro)' einsetzen
			--	Schriftgrad ist default (12px)
			--
			IF @lid IN (2, 13)  
				BEGIN
					--
					--	Für die Farbe 'schwarz' werden in den Übersicht Layouts alle 
					--	vier Styles erzeugt, nämlich 'standard', 'bold', 'strike' und 'bold-strike'.
					--
					IF @cid IN (1)
						BEGIN
							EXEC @tmp = addLayoutStyle @lid=@lid, @cid=@cid 
							SET @ret = @ret + @tmp
							EXEC @tmp = addLayoutStyle @lid=@lid, @cid=@cid, @strike=1
							SET @ret = @ret + @tmp
						END
					EXEC @tmp = addLayoutStyle @lid=@lid, @cid=@cid, @bold=1
					SET @ret = @ret + @tmp
					EXEC @tmp = addLayoutStyle @lid=@lid, @cid=@cid, @bold=1, @strike=1
					SET @ret = @ret + @tmp
				END
			--
			--	Die Styles in die Layouts 'Detail (Fun)' und 'Detail (Pro)' einsetzen
			--	Schriftgrad ist 14px, Linienweite 16px
			--
			IF @lid IN (1, 10, 14, 15)
				BEGIN
					--
					--	In den Detail und Standard Layouts werden für alle Farben, 
					--	alle vier Styles erzeugt, d.h. 
					--	'standard', 'bold', 'strike' und 'bold-strike'.
					--
					EXEC @tmp = addLayoutStyle @lid=@lid, @cid=@cid, @fsize=14, @line=16 
					SET @ret = @ret + @tmp
					EXEC @tmp = addLayoutStyle @lid=@lid, @cid=@cid, @fsize=14, @line=16, @strike=1
					SET @ret = @ret + @tmp
					EXEC @tmp = addLayoutStyle @lid=@lid, @cid=@cid, @fsize=14, @line=16, @bold=1
					SET @ret = @ret + @tmp
					EXEC @tmp = addLayoutStyle @lid=@lid, @cid=@cid, @fsize=14, @line=16, @bold=1, @strike=1
					SET @ret = @ret + @tmp
				END
			FETCH NEXT FROM layoutCursor INTO @lid
		END
	--
	CLOSE layoutCursor
	DEALLOCATE layoutCursor
	--
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Gespeicherte Prozedur ''updateLayoutStyles'' mit Fehler abgebrochen.'
			ROLLBACK
		END
	--
	RETURN @ret
GO

CREATE PROCEDURE initializeLayoutStyles AS
	--
	DECLARE layoutCursor CURSOR FOR SELECT p.id FROM pagelayoutbase AS p FOR READ ONLY
	DECLARE colorCursor CURSOR FOR SELECT c.id FROM color AS c FOR READ ONLY
	--
	DECLARE @tmp INTEGER
	DECLARE @ret INTEGER
	DECLARE @cid INTEGER
	DECLARE @lid INTEGER
	--
	SET @ret = 0
	--
	--
	--
	OPEN colorCursor
	FETCH NEXT FROM colorCursor INTO @cid
	WHILE @@FETCH_STATUS = 0
		BEGIN
			--	
			--	Die Liste enthält die Nummern der Farben, die Standard für die
			--	Fristtypen und Kontexte der Termindatenbank sind. Weitere
			--	Zuordnungen werden erstellt, sobald neue Fristtypen auf
			--	andere, in der Liste nicht enthaltene Farbnummern verweisen.
			--
			IF EXISTS (SELECT c.color FROM schedule.dbo.context AS c WHERE c.color = @cid)
				OR EXISTS (SELECT t.color FROM schedule.dbo.dtype AS t WHERE t.color = @cid) 
				OR @cid = 1
				BEGIN
					EXEC @tmp = updateLayoutStyles @cid = @cid
					SET @ret = @ret + @tmp
				END
			FETCH NEXT FROM colorCursor INTO @cid
		END
	CLOSE colorCursor
	DEALLOCATE colorCursor
	--
	IF @@ERROR <> 0
		BEGIN
			RAISERROR 44445 N'Gespeicherte Prozedur ''initializeLayoutStyles'' mit Fehler abgebrochen.'
			ROLLBACK
		END
	--
	RETURN @ret
GO
--
DECLARE @ret INTEGER
EXEC @ret = initializeLayoutStyles
PRINT N'Soeben habe ich ' + CAST (@ret AS VARCHAR(10)) + N' neue Layoutverknüpfungen erstellt.'
GO

--
GRANT SELECT ON color TO cfg
GRANT SELECT ON font TO cfg
GRANT SELECT ON frameouter TO cfg
GRANT SELECT ON inputformheader TO cfg
GRANT SELECT ON inputformrowpos TO cfg
GRANT SELECT ON inputhidden TO cfg
GRANT SELECT ON inputscript TO cfg
GRANT SELECT ON jump TO cfg
GRANT SELECT ON locale TO cfg
GRANT SELECT ON menue TO cfg
GRANT SELECT ON menueitem TO cfg
GRANT SELECT ON month TO cfg
GRANT SELECT ON pagelayoutbasecolor TO cfg
GRANT SELECT ON properties TO cfg
GRANT SELECT ON setting TO cfg
GRANT SELECT ON stringlocal TO cfg
GRANT SELECT ON style TO cfg
GRANT SELECT ON url TO cfg
GRANT SELECT ON urlbase TO cfg
GRANT SELECT ON inputdetail TO cfg
GRANT SELECT ON caption TO cfg
GRANT SELECT ON frameinner TO cfg
GRANT SELECT ON frameinnerargument TO cfg
GRANT SELECT ON image TO cfg
GRANT SELECT ON inputform TO cfg
GRANT SELECT ON inputformrow TO cfg
GRANT SELECT ON inputimage TO cfg
GRANT SELECT ON inputselect TO cfg
GRANT SELECT ON inputsubmit TO cfg
GRANT SELECT ON inputtext TO cfg
GRANT SELECT ON navigator TO cfg
GRANT SELECT ON pagelayoutbase TO cfg
GRANT SELECT ON pagelayoutbaselstring TO cfg
GRANT SELECT ON pagelayoutbasestyle TO cfg
GRANT SELECT ON pagelayoutbaseicon TO cfg
GRANT SELECT ON pagelayoutbody TO cfg
GRANT SELECT ON pagelayoutcaption TO cfg
GRANT SELECT ON pagelayoutformbase TO cfg
GRANT SELECT ON pagelayoutframe TO cfg
GRANT SELECT ON pagelayoutlist TO cfg
GRANT SELECT ON propertieslocal TO cfg
GRANT SELECT ON template TO cfg
GRANT SELECT ON framelayout TO cfg
GRANT SELECT ON inputarea TO cfg
GRANT SELECT ON inputcheck TO cfg
GRANT SELECT ON inputdate TO cfg
GRANT SELECT ON menuelayout TO cfg
GRANT SELECT ON pagelayoutformlist TO cfg
--
GRANT EXECUTE ON addLayoutStyle TO cfg
GRANT EXECUTE ON updateLayoutStyles TO cfg
GRANT EXECUTE ON initializeLayoutStyles TO cfg
--
PRINT N'Fertig'

