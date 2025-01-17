--
--	(c) Bernhard Schupp; Frankfurt-M�nchen; 2001-2004
--
--
--	Zur Erinnerung:
--	� ~ CHAR(252)
--	� ~ CHAR(228)
--	� ~ CHAR(246)
--	� ~ CHAR(196)
--	� ~ CHAR(214)
--	� ~ CHAR(220)
--	� ~ CHAR(223)
--

USE schedule
GO

IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'annBaseDE') DROP TABLE annBaseDE
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'annies' AND type = 'P') DROP PROCEDURE annies
--
GO

CREATE TABLE annBaseDE (
		id 		INT IDENTITY (1,1),
		akte 		VARCHAR (10) NOT NULL,
		atag 		DATETIME NOT NULL,
		erste		INTEGER NOT NULL DEFAULT 3,
		CHECK (NOT atag > CURRENT_TIMESTAMP),
		CHECK (NOT erste < 2 AND NOT erste > 21),
		CONSTRAINT pk PRIMARY KEY (id),
		CONSTRAINT c1 UNIQUE (akte)
	) ;
GO

GRANT SELECT ON annBaseDE TO scr, scw
GO

INSERT INTO annBaseDE (akte,erste,atag) VALUES (1, 10, CONVERT(DATETIME,'2002-04-02',121))
INSERT INTO annBaseDE (akte,erste,atag) VALUES (2, 4, CONVERT(DATETIME,'2000-09-30',121))
INSERT INTO annBaseDE (akte,atag) VALUES (3, CONVERT(DATETIME,'2001-12-01',121))
INSERT INTO annBaseDE (akte,atag) VALUES (4, CONVERT(DATETIME,'1987-02-28',121))
INSERT INTO annBaseDE (akte,atag) VALUES (5, CONVERT(DATETIME,'2000-02-28',121))
INSERT INTO annBaseDE (akte,atag) VALUES (6, CONVERT(DATETIME,'2001-01-01',121))
INSERT INTO annBaseDE (akte,atag) VALUES (7, CONVERT(DATETIME,'2002-08-01',121))
INSERT INTO annBaseDE (akte,atag) VALUES (8, CONVERT(DATETIME,'2003-03-23',121))
GO

CREATE PROCEDURE annies (@laa VARCHAR(10)) AS
	--
	DECLARE @dat DATETIME
	SET @dat = CONVERT (DATETIME, @laa, 121) 
	--
	SELECT 
		id AS [id], 
		@dat AS [due],
		akte AS [file],
		CONVERT (varchar(2), (DATEDIFF (yyyy, atag, @dat) + 1)) + '. Jgeb.' AS [subject],
		'Titel, AT, usw.' AS [description],
		0 AS [done],
		type = 
		CASE (DATEDIFF(mm, atag,@dat)) 
			WHEN  26 THEN 3
			WHEN  38 THEN 3
			WHEN  50 THEN 3
			WHEN  62 THEN 3
			WHEN  74 THEN 3
			WHEN  86 THEN 3
			WHEN  98 THEN 3
			WHEN 110 THEN 3
			WHEN 122 THEN 3
			WHEN 134 THEN 3
			WHEN 146 THEN 3
			WHEN 158 THEN 3
			WHEN 170 THEN 3
			WHEN 182 THEN 3
			WHEN 194 THEN 3
			WHEN 206 THEN 3
			WHEN 218 THEN 3
			WHEN 230 THEN 3
			WHEN  30 THEN 4
			WHEN  42 THEN 4
			WHEN  54 THEN 4
			WHEN  66 THEN 4
			WHEN  78 THEN 4
			WHEN  90 THEN 4
			WHEN 102 THEN 4
			WHEN 114 THEN 4
			WHEN 126 THEN 4
			WHEN 138 THEN 4
			WHEN 150 THEN 4
			WHEN 162 THEN 4
			WHEN 174 THEN 4
			WHEN 186 THEN 4
			WHEN 198 THEN 4
			WHEN 210 THEN 4
			WHEN 222 THEN 4
			WHEN 234 THEN 4
		END, 
		atag, 
		DATEDIFF (mm, atag, @dat)
		FROM annBaseDE  
		WHERE DATEDIFF(mm, atag,@dat) IN (26,30,38,42,50,54,62,66,74,78,86,90,98,102,110,114,122,126,134,138,146,150,158,162,170,174,182,186,194,198,206,210,218,222,230,234)
			AND MONTH (DATEADD(dd,1,@dat)) <> MONTH (@dat)
			AND NOT (DATEDIFF (yyyy, atag, @dat) + 1) < erste
		GROUP BY id, akte, atag, DATEDIFF(mm, atag, @dat), (DATEDIFF (yyyy, atag, @dat) + 1) 
		ORDER BY 2, 5 
	RETURN
GO

GRANT EXECUTE ON annies TO scw,scr