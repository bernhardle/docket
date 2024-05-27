USE schedule
GO
--
DELETE FROM autoassigned WHERE assigned IN ('2','3','4','5','6','7','8','9','10','11','12')
DELETE FROM assigned WHERE id IN ('2','3','4','5','6','7','8','9','10','11','12')
DELETE FROM login WHERE id IN ('3','4','5')
GO
--
SET IDENTITY_INSERT login ON
INSERT INTO login (id, kurz, name, permlogin, perminsert, permdelete, permadmin, fix) VALUES ('3', 'HH', 'Dipl.-Ing. Hans Haller', '1', '0', '0', '1','0')
INSERT INTO login (id, kurz, name, permlogin, perminsert, permdelete, permadmin, fix) VALUES ('4', 'Mei', 'Dr. rer. nat. Max Meier', '1', '1', '1', '0','0')
INSERT INTO login (id, kurz, name, permlogin, perminsert, permdelete, permadmin, fix) VALUES ('5', 'NoJe', 'Noch Jemand', '1', '1', '1', '0','0')
SET IDENTITY_INSERT login OFF
GO
--
SET IDENTITY_INSERT assigned ON
INSERT INTO assigned (id, label, login, fix, description) VALUES ('2', 'HH-xa', '3', '0', 'Hans Haller.')
INSERT INTO assigned (id, label, login, fix, description) VALUES ('3', 'HH-ff', '3', '0', 'Hans Haller f&uuml;r Freunde.')
INSERT INTO assigned (id, label, login, fix, description) VALUES ('4', 'HH-pr', '3', '0', 'Hans Haller privat.')
INSERT INTO assigned (id, label, login, fix, description) VALUES ('5', 'HH-gg', '3', '0', 'Hans Haller etc.')
INSERT INTO assigned (id, label, login, fix, description) VALUES ('6', 'MM-01', '4', '0', 'Max Meier Inland.')
INSERT INTO assigned (id, label, login, fix, description) VALUES ('7', 'MM-02', '4', '0', 'Max Meier Ausland.')
INSERT INTO assigned (id, label, login, fix, description) VALUES ('8', 'MM-03', '4', '0', 'Max Meier Fremdarbeit.')
INSERT INTO assigned (id, label, login, fix, description) VALUES ('9', 'MM-04', '4', '0', 'Max Meier Stammtisch.')
INSERT INTO assigned (id, label, login, fix, description) VALUES ('10', 'a-NoJe', '5', '0', 'Noch Jemand.')
INSERT INTO assigned (id, label, login, fix, description) VALUES ('11', 'b-NoJe', '5', '0', 'Noch noch Jemand.')
INSERT INTO assigned (id, label, login, fix, description) VALUES ('12', 'c-NoJe', '5', '0', 'Wer auch immer das macht.')
SET IDENTITY_INSERT assigned OFF
GO

INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','2','20')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','3','30')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','4','40')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','5','50')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','6','60')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','7','70')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','8','80')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','9','90')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','10','100')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','11','110')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('1','12','120')

INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','2','20')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','3','30')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','4','40')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','5','50')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','6','60')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','7','70')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','8','80')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','9','90')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','10','100')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','11','110')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('2','12','120')

INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','2','20')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','3','30')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','4','40')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','5','50')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','6','60')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','7','70')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','8','80')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','9','90')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','10','100')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','11','110')
INSERT INTO autoassigned (autodeadline, assigned, rank) VALUES ('3','12','120')
GO