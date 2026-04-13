CREATE DATABASE puhtejevTriger;
use puhtejevTriger;

-- linnad
CREATE TABLE linnad(
linnID int primary key identity(1,1),
linnanimi varchar(50) unique,
rahvaarv int NOT NULL
);

-- logi
CREATE TABLE logi(
logiID int primary key identity(1,1),
kuupaev DATETIME,
andmed TEXT
);

CREATE TRIGGER linnaLisamine 
ON linnad
FOR INSERT
AS
INSERT INTO logi(kuupaev, andmed)
SELECT getdate(), inserted.linnanimi
FROM inserted;

-- kontrollimiseks tuleb lisada uus linn tabelisse linnad
INSERT INTO linnad (linnanimi, rahvaarv)
VALUES ('Narva', 100000);
SELECT * FROM linnad;
SELECT * FROM logi;

--kustutame triger
drop trigger linnaUuendamine;

CREATE TRIGGER linnaLisamine 
ON linnad
FOR INSERT
AS
INSERT INTO logi(kuupaev, andmed)
SELECT
getdate(), 
CONCAT('lisatud linn: ', inserted.linnanimi,
', rahvaarv: ', inserted.rahvaarv, ', id: ', inserted.linnID)
FROM inserted;

CREATE TRIGGER linnaKustutamine
ON linnad
for DELETE
as
insert into logi(kuupaev, andmed)
select
getdate(),
CONCAT('kustutatud linn: ', deleted.linnanimi,
', rahvaarv: ', deleted.rahvaarv, ', id: ', deleted.linnID)
FROM deleted;

delete from linnad where linnId=5;
SELECT * FROM linnad;
SELECT * FROM logi;

--UPDATE TRIGGER
CREATE TRIGGER linnaUuendamine
on linnad
FOR update
AS
insert into logi(kuupaev, andmed)
select
getdate(),
CONCAT('Vana linna andmed: ', d.linnanimi,
', rahvaarv: ', d.rahvaarv, ', id: ', d.linnID,
', uued linna andmed: ', i.linnanimi, ', ', i.rahvaarv, ', ', i.linnID)
FROM deleted d INNER JOIN inserted i
ON d.linnID = i.linnID;

UPDATE linnad SET rahvaarv = 200000 where linnID = 2;
SELECT * FROM linnad;
SELECT * FROM logi;

ALTER TABLE logi ADD kasutaja varchar(40);

--INSERT, DELETE trigger
CREATE TRIGGER linnaLisamineKustutamine 
ON linnad
FOR INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;

	INSERT INTO logi(kuupaev, andmed, kasutaja)
	SELECT 
	getdate(),
	CONCAT('lisatud linn: ', inserted.linnanimi,
	', rahvaarv: ', inserted.rahvaarv, ', id: ', inserted.linnID),
	SYSTEM_USER
	FROM inserted

	UNION ALL 

	select
	getdate(),
	CONCAT('kustutatud linn: ', deleted.linnanimi,
	', rahvaarv: ', deleted.rahvaarv, ', id: ', deleted.linnID),
	SYSTEM_USER
	FROM deleted;
END;

--deaktiveerime linnalisamine ja linnaKustu
DISABLE TRIGGER linnaLisamine on linnad;
DISABLE TRIGGER linnaKustutamine on linnad;


CREATE TABLE autod (
    autoid INT IDENTITY(1,1) PRIMARY KEY,
    autoNR VARCHAR(30) NOT NULL,
    omanik VARCHAR(100) NOT NULL,
    mark VARCHAR(40) NOT NULL,
    aasta INT CHECK (aasta BETWEEN 1800 AND 2040)
);
-- LISA AUTO TRIGGER
CREATE TRIGGER autoLisamine 
ON autod
FOR INSERT
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT
getdate(), 
CONCAT('lisatud Auto Number ', inserted.autoNR,
' / Omanik: ', inserted.omanik, ' / Mark: ', inserted.mark, ' / Aasta: ', inserted.aasta),
SYSTEM_USER
FROM inserted;

INSERT INTO autod (autoNR, omanik, mark, aasta) VALUES
('123ABC', 'Ivan Ivanov', 'Toyota Corolla', 2018),
('456DEF', 'Petr Petrov', 'BMW X5', 2020);
SELECT * FROM autod;
SELECT * FROM logi;

-- DELETE AUTOD TRIGGER
CREATE TRIGGER autoKustutamine
ON autod
for DELETE
as
insert into logi(kuupaev, andmed, kasutaja)
select
getdate(),
CONCAT('Kustutatud Auto Number ', deleted.autoNR,
' / Omanik: ', deleted.omanik, ' / Mark: ', deleted.mark, ' / Aasta: ', deleted.aasta),
SYSTEM_USER
FROM deleted;

delete from autod where autoID=2;
SELECT * FROM autod;
SELECT * FROM logi;

--UPDATE AUTOD TRIGGER
CREATE TRIGGER autoUuendamine
on autod
FOR update
AS
insert into logi(kuupaev, andmed, kasutaja)
select
getdate(),
CONCAT('Vana auto andmed: auto number: ', d.autoNR,
' / omanik: ', d.omanik, ' / mark: ', d.mark, ' / aasta: ', d.aasta,
', uued linna andmed: auto number: ', i.autoNR,
' / omanik: ', i.omanik, ' / mark: ', i.mark, ' / aasta: ', i.aasta),
SYSTEM_USER
FROM deleted d INNER JOIN inserted i
ON d.autoID = i.autoID;

UPDATE autod SET autoNR = '323CBA' where autoID = 1;
SELECT * FROM autod;
SELECT * FROM logi;
