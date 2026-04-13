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
